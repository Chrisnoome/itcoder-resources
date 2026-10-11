import math
th=math.radians(-16); c,s=math.cos(th),math.sin(th)
CX,CY,RX,RY=128,142,40,62
def W(lx,ly): return CX+lx*c-ly*s, CY+lx*s+ly*c
out=[]
A=out.append
# gradients and scale symbols
A('<linearGradient id="fo-gL" x1="0" y1="0" x2=".6" y2="1"><stop offset="0" stop-color="#e7c48c"/><stop offset=".6" stop-color="#b98a52"/><stop offset="1" stop-color="#7d5630"/></linearGradient>')
A('<linearGradient id="fo-gM" x1="0" y1="0" x2=".6" y2="1"><stop offset="0" stop-color="#c99d63"/><stop offset=".6" stop-color="#9a6d3d"/><stop offset="1" stop-color="#5e3f22"/></linearGradient>')
A('<linearGradient id="fo-gD" x1="0" y1="0" x2=".6" y2="1"><stop offset="0" stop-color="#9c7144"/><stop offset=".6" stop-color="#6e4b29"/><stop offset="1" stop-color="#412a16"/></linearGradient>')
A('<linearGradient id="fo-skin" x1="0" y1="0" x2="1" y2="1"><stop offset="0" stop-color="#ead0c2"/><stop offset="1" stop-color="#b98f80"/></linearGradient>')
A('<radialGradient id="fo-bg" cx=".42" cy=".38" r=".7"><stop offset="0" stop-color="#eef6ea"/><stop offset="1" stop-color="#cfe2cf"/></radialGradient>')
sp='M0-9C6-9 10-4 9.5 2C9 7 4 11 0 13.5C-4 11-9 7-9.5 2C-10-4-6-9 0-9Z'
for k in 'LMD':
    A(f'<g id="fo-s{k}"><path d="{sp}" fill="url(#fo-g{k})"/><path d="M0-6V8" stroke="#ffffff" stroke-opacity=".18" stroke-width="1.2"/><path d="M-8.5 3C-6 9-2 12 0 13.5C2 12 6 9 8.5 3" stroke="#3a2412" stroke-opacity=".45" stroke-width="1.1" fill="none"/></g>')
def scale(x,y,rot,sz,k):
    return f'<use href="#fo-s{k}" transform="translate({x:.1f} {y:.1f}) rotate({rot:.0f}) scale({sz:.2f})"/>'
# ---- body group
B=[]
# tail: quadratic bezier P0->P1->P2
P0,P1,P2=(146,168),(196,180),(230,238)
def q(t):
    x=(1-t)**2*P0[0]+2*(1-t)*t*P1[0]+t*t*P2[0]; y=(1-t)**2*P0[1]+2*(1-t)*t*P1[1]+t*t*P2[1]
    dx=2*(1-t)*(P1[0]-P0[0])+2*t*(P2[0]-P1[0]); dy=2*(1-t)*(P1[1]-P0[1])+2*t*(P2[1]-P1[1]); L=math.hypot(dx,dy)
    return x,y,dx/L,dy/L
# tail base shape
pts=[];pts2=[]
for i in range(0,21):
    t=i/20; x,y,dx,dy=q(t); w=24*(1-t)+4
    nx,ny=-dy,dx
    pts.append((x+nx*w,y+ny*w)); pts2.append((x-nx*w,y-ny*w))
poly=pts+pts2[::-1]
B.append('<path d="M'+' '.join(f'{x:.0f} {y:.0f}' for x,y in poly)+'Z" fill="#4e331b"/>')
ts=[]
for i in range(15,-1,-1):
    t=i/16; x,y,dx,dy=q(t); w=24*(1-t)+4; nx,ny=-dy,dx
    ang=math.degrees(math.atan2(dy,dx))-90
    sz=0.55+0.75*(1-t)
    offs=[-0.55,0.55] if w>12 else [0]
    if i%2: offs=[o*0.9+0.0 for o in offs]
    for o in offs:
        k='D' if o>0 else ('M' if t<.6 else 'D')
        if o<0 and t<.35: k='L'
        ts.append(scale(x+nx*o*w,y+ny*o*w,ang,sz,k))
B+=ts
# hind legs (behind body)
B.append('<path d="M112 186C104 204 102 222 106 236H124C128 222 128 204 126 188Z" fill="#7a5a4c"/>')
B.append('<path d="M138 190C140 206 142 222 146 236H164C164 222 160 204 152 186Z" fill="#5f443a"/>')
B.append('<path d="M98 240C98 232 106 228 116 228C126 228 130 234 130 240Z" fill="#8a6858"/>')
B.append('<path d="M138 240C138 232 146 228 156 228C166 228 170 234 170 240Z" fill="#6b4d41"/>')
for x in (98,104,110,138,144,150):
    B.append(f'<path d="M{x+2} 236C{x-4} 236 {x-9} 239 {x-11} 242C{x-6} 241 {x-1} 240 {x+3} 240Z" fill="#3b2a20"/>')
# body base
B.append(f'<ellipse cx="{CX}" cy="{CY}" rx="{RX+2}" ry="{RY+2}" transform="rotate(-16 {CX} {CY})" fill="#4e331b"/>')
# belly skin on front-left lower
B.append('<path d="M92 120C84 140 84 170 96 190C104 200 116 204 124 202C112 190 104 168 104 140C104 128 100 120 92 120Z" fill="url(#fo-skin)"/>')
rows=[]
ly=58
while ly>=-54:
    rows.append(ly); ly-=10.5
for ri,ly in enumerate(rows):
    w=RX*math.sqrt(max(0,1-(ly/RY)**2))
    start=-w*0.42 if ly>-20 else -w*0.85
    lx=start+(6 if ri%2 else 0)
    sz=0.78+0.42*(ly+RY)/(2*RY)
    while lx<w+2:
        u=lx/max(w,1); v=ly/RY
        sc=-0.65*u-0.45*v
        k='L' if sc>0.22 else ('D' if sc<-0.32 else 'M')
        x,y=W(lx,ly)
        rows_rot=-16+18*u
        B.append(scale(x,y,rows_rot,sz,k))
        lx+=12.5*sz
# rim light on back
A('<g id="fo-body">'+''.join(B)+'</g>')
# ---- head
H=[]
H.append('<path d="M124 78C120 60 100 52 86 58C73 64 63 80 52 97C49 103 53 107 60 105C74 101 92 99 105 97C118 95 128 88 124 78Z" fill="url(#fo-skin)"/>')
H.append('<path d="M60 105C74 101 92 99 105 97C116 95 124 90 125 82C116 92 96 94 76 96C66 98 60 101 56 104Z" fill="#9c7466" opacity=".55"/>')
hs=[(112,64,0.62,'M'),(100,62,0.58,'L'),(122,72,0.66,'D'),(110,73,0.6,'M'),(88,64,0.5,'L'),(98,71,0.52,'L'),(78,70,0.42,'L')]
for x,y,sz,k in hs: H.append(scale(x,y,60,sz,k))
H.append('<path d="M52 97C50 101 52 104 56 104" stroke="#5a3a33" stroke-width="2" fill="none" stroke-linecap="round"/>')
H.append('<ellipse cx="53.5" cy="99.5" rx="2.6" ry="2" fill="#3b2420"/>')
H.append('<path d="M60 92C68 90 76 91 82 94" stroke="#fff" stroke-opacity=".35" stroke-width="1.6" fill="none" stroke-linecap="round"/>')
A('<g id="fo-head">'+''.join(H)+'</g>')
# glasses (drawn over eyes) : near lens at 88,80, far lens 70,86
A('<g id="fo-specs"><path d="M114 74L97 78" stroke="#a9781f" stroke-width="2" stroke-linecap="round"/><ellipse cx="72" cy="86" rx="5.5" ry="8.5" fill="#dff1ff" fill-opacity=".25" stroke="#c9952e" stroke-width="2"/><path d="M77.5 85L80 84" stroke="#c9952e" stroke-width="2"/><circle cx="89" cy="81" r="9.5" fill="#dff1ff" fill-opacity=".22" stroke="#c9952e" stroke-width="2.4"/><path d="M83 75A8 8 0 0 1 92 73.5" stroke="#fff" stroke-width="1.6" fill="none" opacity=".85" stroke-linecap="round"/></g>')
A('<g id="fo-claw"><path d="M0 0C4 2 6 7 5 12C3 9 0 6-3 5Z" fill="#3b2a20"/></g>')
open('m-folio-defs.svg','w',encoding='utf8').write('\n'.join(out))
print(len('\n'.join(out)))
