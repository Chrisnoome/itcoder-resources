"""The site's nginx hardening, made sure of on every publish (28 September 2026,
security review): server_tokens off and per-address rate limits on sign-in and
/api/ (conf.d/itcoder.conf + snippets/itcoder-limits.conf, both from
AIPascalCourse/deploy/templates - the install kit writes the same), and the
security headers repeated in each /assets/ location (an add_header there
replaces the server block's).

publish-test.py calls it for the test block, deploy-live.py for itcoder and
bestlessons. Safe to run again: a block that already has it is left alone.
Every changed file is copied aside first (<file>.bak-<date>), nginx -t runs
before the reload, and on failure every file goes back as it was.
"""
import os
import time

HTTP_CONF = '/etc/nginx/conf.d/itcoder.conf'
SNIPPET   = '/etc/nginx/snippets/itcoder-limits.conf'
INCLUDE   = '    # Per-address limits on sign-in and /api/ (tools/nginx_hardening.py, 28 September 2026).\n' \
            '    include snippets/itcoder-limits.conf;\n\n'
HEADERS   = '        # An add_header here replaces the server\'s, so they are repeated (28 Sep 2026).\n' \
            '        add_header X-Content-Type-Options nosniff;\n' \
            '        add_header X-Frame-Options SAMEORIGIN;\n' \
            '        add_header Referrer-Policy same-origin;\n'
PHP_LOC   = '    location ~ \\.php$ {\n'
CACHE     = '        add_header Cache-Control "public";\n'


def hardened(block):
    """The site block with the include (before each .php location) and the
    /assets/ headers, or None if it does not look like one of ours."""
    if PHP_LOC not in block or CACHE not in block:
        return None
    if 'itcoder-limits.conf' not in block:
        block = block.replace(PHP_LOC, INCLUDE + PHP_LOC)
    if 'X-Content-Type-Options nosniff;\n        add_header X-Frame-Options' not in block:
        block = block.replace(CACHE, CACHE + HEADERS)
    return block


def apply(vps, step, local, sites):
    """step: the publish script's Step(label, cmd). sites: nginx site files."""
    stamp = time.strftime('%Y-%m-%d-%H%M%S')
    templates = local + '/deploy/templates'
    temp = os.environ.get('TEMP', '.')
    changed = []

    vps.put(templates + '/nginx-itcoder-http.conf', HTTP_CONF + '.new')
    vps.put(templates + '/nginx-itcoder-limits.conf', SNIPPET + '.new')

    for site in sites:
        code, block = vps.run('cat %s' % site)
        if code != 0:
            print('[FAIL] nginx hardening: cannot read %s' % site)
            return step('nginx hardening', 'false')
        new = hardened(block + '\n')     # run() strips the last newline
        if new is None:
            print('[FAIL] nginx hardening: %s does not look like an itcoder site block - left alone' % site)
            return step('nginx hardening', 'false')
        if new != block + '\n':
            path = os.path.join(temp, 'nginx-hardening-' + os.path.basename(site))
            open(path, 'w', encoding='utf-8', newline='\n').write(new)
            vps.put(path, site + '.new')
            os.remove(path)
            changed.append(site)

    # Each file whose .new differs goes in (the old one copied aside); unchanged
    # ones are left exactly as they are. Only what changed is put back on failure.
    script = '''
set -u
S=%(stamp)s
changed=""
for f in %(files)s; do
    if [ -e "$f" ] && cmp -s "$f.new" "$f"; then rm -f "$f.new"; continue; fi
    [ -e "$f" ] && cp -a "$f" "$f.bak-$S"
    mv "$f.new" "$f" && chmod 644 "$f"
    changed="$changed $f"
done
if [ -z "$changed" ]; then echo "already in place"; exit 0; fi
if nginx -t 2>&1; then
    systemctl reload nginx && echo "changed:$changed"
else
    echo "nginx -t failed - putting back:$changed"
    for f in $changed; do
        if [ -e "$f.bak-$S" ]; then cp -a "$f.bak-$S" "$f"; else rm -f "$f"; fi
    done
    nginx -t 2>&1 && systemctl reload nginx
    exit 1
fi
''' % {'stamp': stamp, 'files': ' '.join([HTTP_CONF, SNIPPET] + changed)}
    return step('nginx hardening (server_tokens off, rate limits, /assets/ headers)',
                'bash -c ' + "'" + script.replace("'", "'\\''") + "'")
