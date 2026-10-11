import re
t=open('board.tpl.html',encoding='utf8').read()
caps={'ratel':['Hello: visor on, pencil ready','A comma splice: bristling','Celebrating: punctuation confetti'],
      'folio':['Hello: book open, glasses on','A 120-word summary: aghast','88 words: celebrating'],
      'quill':['Hello: a wing raised','A cliché: stamped on','Celebrating: wings and crest fanned']}
defs=''
for n in ['ratel','folio','quill']:
    defs+=open(f'm-{n}-defs.svg',encoding='utf8').read()+'\n'
    p=open(f'm-{n}-poses.html',encoding='utf8').read()
    svgs=[s.strip()+'\n</svg>' for s in p.split('</svg>') if s.strip()]
    assert len(svgs)==3,n
    t=t.replace('{{'+n.upper()+'}}','\n'.join(f'<figure>{s}<figcaption>{c}</figcaption></figure>' for s,c in zip(svgs,caps[n])))
t=t.replace('{{DEFS}}',defs)
assert '{{' not in t
out=r'D:\DB Sync\Dropbox\Projects\AIResources\brand\eng-strands-art-board.html'
open(out,'w',encoding='utf8').write(t)
open('board.html','w',encoding='utf8').write(t)
print(len(t.encode('utf8')))
ids=re.findall(r'id="([^"]+)"',t)
import collections
print([i for i,c in collections.Counter(ids).items() if c>1])
