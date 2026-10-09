# Flat OPC (Word's WordOpenXML) -> .docx, keeping each part's XML text as Word wrote it.
#     python ref-flat2docx.py in.xml out.docx
import sys, re, zipfile, base64
raw = open(sys.argv[1], encoding='utf-8-sig').read()
types = {}
with zipfile.ZipFile(sys.argv[2], 'w', zipfile.ZIP_DEFLATED) as z:
    for m in re.finditer(r'<pkg:part\s+([^>]*)>(.*?)</pkg:part>', raw, re.S):
        attrs = dict(re.findall(r'pkg:(\w+)="([^"]*)"', m.group(1)))
        name = attrs['name'].lstrip('/'); types['/' + name] = attrs['contentType']
        body = m.group(2)
        x = re.search(r'<pkg:xmlData[^>]*>(.*)</pkg:xmlData>', body, re.S)
        if x:
            z.writestr(name, '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\r\n' + x.group(1).strip())
        else:
            b = re.search(r'<pkg:binaryData>(.*)</pkg:binaryData>', body, re.S)
            z.writestr(name, base64.b64decode(re.sub(r'\s', '', b.group(1))))
    z.writestr('[Content_Types].xml', '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">'
               + ''.join('<Override PartName="%s" ContentType="%s"/>' % (k, v) for k, v in types.items()) + '</Types>')
print('ok', len(types), 'parts')
