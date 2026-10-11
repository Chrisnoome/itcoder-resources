import sys
name=sys.argv[1]
d=open(f'm-{name}-defs.svg',encoding='utf8').read()
p=open(f'm-{name}-poses.html',encoding='utf8').read()
open(f'test-{name}.html','w',encoding='utf8').write(f'''<!doctype html><meta charset=utf-8><style>body{{margin:0;background:#f4efe6}}.r{{display:grid;grid-template-columns:repeat(3,1fr);gap:8px;padding:8px}}.r svg{{width:100%;height:auto;background:#ece4d4;border-radius:8px}}</style>
<svg width="0" height="0" style="position:absolute"><defs>{d}</defs></svg><div class=r>{p}</div>''')
