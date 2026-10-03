"""Builds checklists/codesinger-videos.html (the review page for the Pascal Code Singer thumbnails,
titles and descriptions) from thumbs.json. Same OK / Needs fixing pattern as checklists/remediation.html.
python review.py"""
import html, json, os

HERE = os.path.dirname (os.path.abspath (__file__))
OUT = os.path.join (HERE, '..', '..', '..', 'checklists', 'codesinger-videos.html')

OLD = {  # titles on YouTube on 3 October 2026
 "jmqdIR8yidI":"Mission: Algorithm", "EDSOMA17T1E":"Let the Database Do the Work",
 "eRDH2Z_d9f0":"Make It GUI", "5BwAO8mr0fo":"You Gotta Comment Your Code music video Java",
 "kyGsQdyGe9c":"You Gotta Comment Your Code", "VBRpt4tUfBU":"Programmers are clever - problem solving",
 "KYBj68eKZhw":"Loop it up", "vmlBxOpEuQ0":"Keeping It DRY music video",
 "XX8oqXGubCU":"Read and Think - the debugging process.", "AsKKincNwCA":"No Single Letters",
 "Qgjfqf635oM":"Output in Pascal (Write, Writeln, Beep, TextColor, TextBackground, ClrScr, GotoXY)",
 "yXqKTmBDVCg":"Law, law baby - IT law in South Africa", "DrhceJSci4M":"Code like Jazz",
 "jmnBHdXu380":"What do computers actually do? (Add and Compare)"}

specs = json.load (open (os.path.join (HERE, 'thumbs.json'), encoding='utf-8'))
items = []
for s in specs:
    d = s['desc'] + ('\n\n[The sample code from the current description stays below this.]' if s.get ('keepCode') else '')
    items.append ({'id': s['id'], 'old': OLD[s['id']], 'title': s['ytTitle'], 'desc': d})

page = open (os.path.join (HERE, 'review-template.html'), encoding='utf-8').read ()
page = page.replace ('/*ITEMS*/[]', json.dumps (items, ensure_ascii=False))
open (OUT, 'w', encoding='utf-8').write (page)
print ('wrote', os.path.normpath (OUT), len (items), 'videos')
