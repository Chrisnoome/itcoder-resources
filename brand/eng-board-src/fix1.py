t=open('board.tpl.html',encoding='utf8').read()
R=[('<text x="168" y="76" font-family="Cormorant Garamond, serif" font-weight="600" font-size="22" fill="#4a3423">7 points in 90 words</text>','<text x="196" y="76" font-family="Cormorant Garamond, serif" font-weight="600" font-size="22" fill="#4a3423">7 points in 90 words</text>'),
('Source: "Why your phone wakes you at 2 a.m.", a Loop explainer (350 words)','Source: a Loop explainer, 350 words'),
('font-family="Syne, sans-serif" font-weight="800" font-size="25" fill="#fff">NEVER</text><text x="322" y="172" text-anchor="middle" font-family="Syne, sans-serif" font-weight="800" font-size="25" fill="#fff">LOG OFF.</text><path d="M276 182h92"','font-family="Syne, sans-serif" font-weight="800" font-size="19" fill="#fff">NEVER</text><text x="322" y="166" text-anchor="middle" font-family="Syne, sans-serif" font-weight="800" font-size="19" fill="#fff">LOG OFF.</text><path d="M284 176h76"'),
('<text x="26" y="68" font-family="Instrument Serif, serif" font-style="italic" font-size="34" fill="#16181d">The discursive</text>\n<text x="26" y="102" font-family="Instrument Serif, serif" font-style="italic" font-size="34" fill="#16181d">essay</text>','<text x="26" y="66" font-family="Instrument Serif, serif" font-style="italic" font-size="29" fill="#16181d">The discursive</text>\n<text x="26" y="98" font-family="Instrument Serif, serif" font-style="italic" font-size="29" fill="#16181d">essay</text>'),
('<g font-family="Kalam, cursive" font-size="13" fill="#8c2f39"><text x="40" y="146">Who\'s it for? The one</text><text x="40" y="164">person you name, and</text><text x="40" y="182">everyone else reading.</text></g>\n<g transform="translate(150 262) rotate(-18)">','<g font-family="Kalam, cursive" font-size="13" fill="#8c2f39"><text x="40" y="140">Who\'s it for? The one</text><text x="40" y="158">person you name, and</text><text x="40" y="176">everyone else reading.</text></g>\n<g transform="translate(56 266) rotate(62) scale(.72)">'),
('<rect x="100" y="198" width="54" height="14" fill="#efe3bf" opacity=".8" transform="rotate(14 127 205)"/><rect x="128" y="244" width="50" height="14" fill="#efe3bf" opacity=".8" transform="rotate(-10 153 251)"/>','<rect x="74" y="246" width="40" height="12" fill="#efe3bf" opacity=".85" transform="rotate(-20 94 252)"/><rect x="150" y="198" width="44" height="12" fill="#efe3bf" opacity=".85" transform="rotate(30 172 204)"/>'),
('<text x="280" y="62" font-weight="600" font-size="12.5">An open letter to</text><text x="280" y="80" font-weight="700" font-size="15">everyone who films fights</text>','<text x="280" y="60" font-weight="600" font-size="12.5">An open letter to</text><text x="280" y="78" font-weight="700" font-size="15">everyone who</text><text x="280" y="94" font-weight="700" font-size="15">films fights</text>'),
('<path d="M444 74c-10 0-20 0-26 2"/><path d="M412 76l6-4M412 76l6 4"/>','<path d="M410 72c-6 0-14 2-20 6"/><path d="M390 78l4-6M390 78l7 1"/>'),
('<path d="M420 112c-6 0-14 0-18 0"/><path d="M402 112l5-4M402 112l5 4"/>','<path d="M410 112c-8 0-14 0-18 0"/><path d="M392 112l5-4M392 112l5 4"/>'),
('<path d="M420 170c-6 2-12 4-16 4"/><path d="M404 174l6-5M404 174l5 3"/>','<path d="M410 170c-6 2-10 4-14 4"/><path d="M396 174l6-5M396 174l5 3"/>'),
('<path d="M420 240c-12 0-24 0-30 0"/><path d="M390 240l5-4M390 240l5 4"/>','<path d="M410 240c-10 0-20 0-24 0"/><path d="M386 240l5-4M386 240l5 4"/>'),
('<text x="424" y="62">public</text><text x="424" y="76">heading</text><text x="424" y="104">a group,</text><text x="424" y="117">not one name</text><text x="424" y="160">firm, but</text><text x="424" y="173">never rude</text><text x="424" y="236">sign-off</text><text x="424" y="249">+ name</text>','<text x="414" y="68">public</text><text x="414" y="81">heading</text><text x="414" y="108">a group,</text><text x="414" y="121">not a name</text><text x="414" y="166">firm, not</text><text x="414" y="179">rude</text><text x="414" y="236">sign-off</text><text x="414" y="249">+ name</text>'),
]
for a,b in R:
    assert a in t, a[:60]
    t=t.replace(a,b)
open('board.tpl.html','w',encoding='utf8').write(t)
p=open('m-ratel-poses.html',encoding='utf8').read()
a='<text x="-6" y="8" text-anchor="end">late,</text><text x="4" y="8">we ran</text></g>\n<ellipse cx="-8" cy="7"'
assert a in p
p=p.replace(a,'<text x="-12" y="8" text-anchor="end">late,</text><text x="-3" y="8">we ran</text></g>\n<ellipse cx="-14" cy="7"')
open('m-ratel-poses.html','w',encoding='utf8').write(p)
