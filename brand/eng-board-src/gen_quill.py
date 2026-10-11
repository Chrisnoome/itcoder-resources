import math
O=[];A=O.append
A('<linearGradient id="qu-grey" x1="0" y1="0" x2=".7" y2="1"><stop offset="0" stop-color="#f1f3f5"/><stop offset=".55" stop-color="#c3c9d0"/><stop offset="1" stop-color="#868e98"/></linearGradient>')
A('<linearGradient id="qu-cov" x1="0" y1="0" x2=".5" y2="1"><stop offset="0" stop-color="#d5dae0"/><stop offset="1" stop-color="#8d96a1"/></linearGradient>')
A('<linearGradient id="qu-blk" x1="0" y1="0" x2="1" y2="1"><stop offset="0" stop-color="#3a3d45"/><stop offset="1" stop-color="#121317"/></linearGradient>')
A('<linearGradient id="qu-face" x1="0" y1="0" x2="1" y2="1"><stop offset="0" stop-color="#ffb24a"/><stop offset="1" stop-color="#e2582a"/></linearGradient>')
A('<radialGradient id="qu-bg" cx=".42" cy=".38" r=".7"><stop offset="0" stop-color="#eaf1fb"/><stop offset="1" stop-color="#c9d8ee"/></radialGradient>')
A('<path id="qu-bodyp" d="M94 104C96 82 120 72 146 82C166 90 180 110 178 132C175 150 152 160 130 158C110 156 94 142 93 122Z"/>')
A('<clipPath id="qu-bodyc"><use href="#qu-bodyp"/></clipPath>')
# tail
A('<g id="qu-tail"><path d="M150 140C170 168 190 204 206 244L196 246C180 210 162 178 142 148Z" fill="#6c727b"/><path d="M160 138C178 168 196 200 214 238L205 241C188 206 170 176 150 146Z" fill="#7d838c"/>'
  '<path d="M190 214L200 211 209 228 199 232Z" fill="#17181c"/><path d="M182 218L192 216 199 234 190 237Z" fill="#17181c"/><path d="M209 228L214 238 205 241 199 232Z" fill="#f4f5f7"/><path d="M199 234L206 244 196 246 190 237Z" fill="#e4e6ea"/></g>')
# legs standing: near and far
def leg(x0,y0,x1,y1,col,dark):
    s=f'<path d="M{x0} {y0}L{x1} {y1}" stroke="{col}" stroke-width="6.5" stroke-linecap="round"/><path d="M{x0+2.2} {y0}L{x1+2.2} {y1}" stroke="{dark}" stroke-width="2" stroke-linecap="round" opacity=".6"/>'
    n=9
    for i in range(1,n):
        t=i/n; x=x0+(x1-x0)*t; y=y0+(y1-y0)*t
        s+=f'<path d="M{x-2.5:.1f} {y:.1f}h5" stroke="{dark}" stroke-width=".9" opacity=".7"/>'
    return s
def foot(x,y,col,flip=1):
    return (f'<path d="M{x} {y}L{x-16*flip} {y+3}M{x} {y}L{x-11*flip} {y+5}M{x} {y}L{x-4*flip} {y+5}M{x} {y}L{x+6*flip} {y+3}" stroke="{col}" stroke-width="3.6" stroke-linecap="round"/>'
            f'<path d="M{x-16*flip} {y+3}l-3 1M{x-11*flip} {y+5}l-3 1M{x-4*flip} {y+5}l-2 2" stroke="#2a2b30" stroke-width="2" stroke-linecap="round"/>')
A('<g id="qu-legfar">'+leg(140,170,146,238,'#d9a690','#9b6b58')+foot(146,238,'#cf9a84')+'</g>')
A('<g id="qu-legnear">'+leg(120,172,114,238,'#efc0a8','#a87562')+foot(114,238,'#e6b29b')+'</g>')
A('<g id="qu-thighfar"><path d="M134 134C128 148 128 164 134 178L137 172 140 179 143 172 147 178C152 162 152 146 146 136Z" fill="#141519"/></g>')
A('<g id="qu-thighnear"><path d="M112 136C105 150 105 166 111 182L115 176 118 184 121 176 125 183 128 175 131 181C136 164 134 148 128 138Z" fill="url(#qu-blk)"/><path d="M114 142C110 152 110 162 112 172" stroke="#5a5e68" stroke-width="1.6" fill="none" stroke-linecap="round"/></g>')
# body with folded wing
B=['<use href="#qu-bodyp" fill="url(#qu-grey)"/>',
   '<g clip-path="url(#qu-bodyc)"><ellipse cx="168" cy="150" rx="46" ry="34" fill="#4a525e" opacity=".35"/><ellipse cx="108" cy="96" rx="14" ry="18" fill="#fff" opacity=".45"/></g>']
B.append('<path d="M112 98C136 86 164 98 176 118C184 132 190 150 198 172C180 162 158 154 140 146C124 138 112 120 112 98Z" fill="url(#qu-blk)"/>')
for i,(a,b) in enumerate([((140,128),(196,168)),((134,120),(190,156)),((128,112),(182,142))]):
    B.append(f'<path d="M{a[0]} {a[1]}C{(a[0]+b[0])/2} {a[1]+6} {b[0]-10} {b[1]-8} {b[0]} {b[1]}" stroke="#5c616b" stroke-width="1.4" fill="none"/>')
cov='M112 98C134 88 158 98 168 114C162 118 158 122 150 122C146 128 136 128 130 124C124 128 116 122 114 114C112 108 112 102 112 98Z'
B.append(f'<path d="{cov}" fill="url(#qu-cov)"/>')
B.append('<path d="M118 100C132 94 150 98 160 108" stroke="#fff" stroke-width="1.6" fill="none" opacity=".6" stroke-linecap="round"/>')
B.append('<path d="M174 116C182 130 188 148 194 166" stroke="#bcd6ff" stroke-width="2" fill="none" opacity=".55" stroke-linecap="round"/>')
A('<g id="qu-body">'+''.join(B)+'</g>')
# neck + head base
H=['<path d="M98 108C94 90 90 72 88 56L112 52C112 70 116 88 126 100Z" fill="url(#qu-grey)"/>',
   '<path d="M108 54C110 72 116 88 126 100L118 104C110 88 106 72 104 56Z" fill="#7d858f" opacity=".45"/>',
   '<path d="M84 50C82 36 92 28 102 29C114 30 118 40 116 50C114 60 104 64 96 63C88 62 85 57 84 50Z" fill="url(#qu-grey)"/>',
   '<path d="M108 32C116 38 118 48 114 56C110 60 104 62 100 62C108 54 110 44 108 32Z" fill="#7d858f" opacity=".45"/>',
   '<path d="M78 42C80 36 88 34 95 37C99 40 99 48 96 52C90 56 82 54 78 50Z" fill="url(#qu-face)"/>',
   '<path d="M84 41C76 40 68 44 63 52C61 57 63 60 66 58C69 54 73 52 79 52C82 51 84 49 84 46Z" fill="#9aa3ae"/>',
   '<path d="M66 50C63 53 62 57 64 60C66 60 68 57 69 54Z" fill="#2c3036"/>',
   '<path d="M84 41C78 41 72 44 68 49" stroke="#d4dae1" stroke-width="1.4" fill="none" stroke-linecap="round"/>',
   '<path d="M79 52C76 53 72 54 69 56" stroke="#5c646e" stroke-width="1.3" fill="none" stroke-linecap="round"/>']
A('<g id="qu-neck">'+''.join(H[:2])+'</g>')
A('<g id="qu-head">'+''.join(H[2:])+'</g>')
def crest(angles,lens,base=(108,38),nib=True):
    s=''
    for i,(a,L) in enumerate(zip(angles,lens)):
        r=math.radians(a); bx,by=base[0]+i*1.2,base[1]+i*1.5
        tx,ty=bx+L*math.cos(r),by+L*math.sin(r)
        mx,my=bx+0.55*L*math.cos(r)+3*math.sin(r),by+0.55*L*math.sin(r)-3*math.cos(r)
        s+=f'<path d="M{bx:.1f} {by:.1f}Q{mx:.1f} {my:.1f} {tx:.1f} {ty:.1f}" stroke="#1d1e22" stroke-width="1.8" fill="none" stroke-linecap="round"/>'
        # vane: from 0.5L to tip
        ux,uy=math.cos(r),math.sin(r); px,py=-uy,ux
        v0x,v0y=bx+0.5*L*ux,by+0.5*L*uy
        w=4.2
        last= nib and i==len(angles)-1
        col='#16171b'
        if last:
            # gold pen nib at tip
            n0x,n0y=bx+0.72*L*ux,by+0.72*L*uy
            s+=f'<path d="M{v0x:.1f} {v0y:.1f}Q{n0x+px*w:.1f} {n0y+py*w:.1f} {n0x+px*3:.1f} {n0y+py*3:.1f}L{tx:.1f} {ty:.1f}L{n0x-px*3:.1f} {n0y-py*3:.1f}Q{n0x-px*w:.1f} {n0y-py*w:.1f} {v0x:.1f} {v0y:.1f}Z" fill="{col}"/>'
            s+=f'<path d="M{n0x+px*3:.1f} {n0y+py*3:.1f}L{tx:.1f} {ty:.1f}L{n0x-px*3:.1f} {n0y-py*3:.1f}Z" fill="#e2b33c"/>'
            s+=f'<path d="M{(n0x+tx)/2:.1f} {(n0y+ty)/2:.1f}L{tx:.1f} {ty:.1f}" stroke="#8a6512" stroke-width=".9"/>'
        else:
            ex,ey=tx+ux*2,ty+uy*2
            s+=f'<path d="M{v0x:.1f} {v0y:.1f}Q{bx+0.8*L*ux+px*w:.1f} {by+0.8*L*uy+py*w:.1f} {ex:.1f} {ey:.1f}Q{bx+0.8*L*ux-px*w:.1f} {by+0.8*L*uy-py*w:.1f} {v0x:.1f} {v0y:.1f}Z" fill="{col}"/>'
            s+=f'<path d="M{v0x+px*1.5:.1f} {v0y+py*1.5:.1f}Q{bx+0.8*L*ux+px*3:.1f} {by+0.8*L*uy+py*3:.1f} {ex:.1f} {ey:.1f}" stroke="#4a4e57" stroke-width="1" fill="none"/>'
    return s
A('<g id="qu-crest">'+crest([-8,-22,-36,10,-50,-64],[40,44,42,34,40,38])+'</g>')
A('<g id="qu-crestF">'+crest([-30,-48,-66,-14,-84,-100],[42,46,44,36,42,40])+'</g>')
# open wing (near, spreading up-left). shoulder at origin; generate fan of primaries
def wing(sign=1):
    s=''
    # arm/coverts shape
    s+=f'<path d="M0 0C{-20*sign} -10 {-46*sign} -26 {-64*sign} -48C{-70*sign} -40 {-70*sign} -28 {-62*sign} -18C{-48*sign} -2 {-26*sign} 8 0 12Z" fill="url(#qu-cov)"/>'
    feathers=[]
    for i in range(7):
        a=math.radians(-150+ i*16) if sign==1 else math.radians(-30- i*16)
        L=54-i*3
        bx=-64*sign+ i*7*sign*0.9; by=-48+i*6
        tx,ty=bx+L*math.cos(a),by+L*math.sin(a)
        ux,uy=math.cos(a),math.sin(a); px,py=-uy,ux
        w=6.5
        feathers.append(f'<path d="M{bx+px*w:.1f} {by+py*w:.1f}Q{bx+0.7*L*ux+px*w:.1f} {by+0.7*L*uy+py*w:.1f} {tx:.1f} {ty:.1f}Q{bx+0.7*L*ux-px*w*0.7:.1f} {by+0.7*L*uy-py*w*0.7:.1f} {bx-px*w*0.7:.1f} {by-py*w*0.7:.1f}Z" fill="url(#qu-blk)" stroke="#53575f" stroke-width=".8"/>')
    s=''.join(feathers[::-1])+s
    s+=f'<path d="M{-8*sign} 2C{-28*sign} -6 {-46*sign} -20 {-60*sign} -38" stroke="#fff" stroke-width="1.6" fill="none" opacity=".55" stroke-linecap="round"/>'
    return s
A('<g id="qu-wingopenL">'+wing(1)+'</g>')
A('<g id="qu-wingopenR">'+wing(-1)+'</g>')
open('m-quill-defs.svg','w',encoding='utf8').write('\n'.join(O))
print(len('\n'.join(O)))
