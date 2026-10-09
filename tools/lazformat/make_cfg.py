# The house style (AIResources/pascal-house-style.md) as Lazarus's JEDI Code Format settings, from Lazarus's own
# defaults (10 October 2026) - the download on the Pascal guide 'lazformat'. Run: python make_cfg.py [Key=Value ...]
# Tested with JCF's command-line build (C:\lazarus\components\jcf2\CommandLine\Lazarus\jcf.lpi, lazbuild to D:):
#   jcf.exe -clarify -config=<this file> -F <file.pas> -inplace -y
# on the tutorial videos' Pascal files - see AIResources/platform.md, "Lazarus formats code".
import re, sys
src = open('C:/lazarus/components/jcf2/IdePlugin/lazarus/Default_JCFSETTINGS.cfg', encoding='utf-8').read()
SET = {
  'Description': 'BestLessons Pascal layout (bestlessons.co.za)',
  # capitals: Begin, End, If, Div, Mod, True, Nil, Integer, Override
  'ReservedWords': '2', 'Operators': '2', 'Directives': '2', 'Constants': '2', 'Types': '2',
  # a space before every colon in a declaration, before ( and round operators
  'SpacesBeforeColonVar': '1', 'SpacesBeforeColonConst': '1', 'SpacesBeforeColonParam': '1', 'SpacesBeforeColonFn': '1',
  'SpacesBeforeColonClassVar': '1', 'SpacesBeforeColonRecordField': '1', 'SpacesBeforeColonCaseLabel': '1',
  'SpaceBeforeOpenBracketsInFunctionDeclaration': 'True', 'SpaceBeforeOpenBracketsInFunctionCall': 'True',
  'UseMaxSpacesInCode': 'False',
  # never re-break a pupil's lines
  'WhenRebreakLines': '0',
  # programs: {$H+}, Var and Begin at the left, not indented as a library's would be
  'IndentLibraryProcs': 'False',
  # Class (TObject); a long heading keeps the line breaks it was typed with
  'SpaceBeforeClassHeritage': 'True', 'RemoveProcedureDefReturns': 'False',
  # a Case's Else lines up with Case; Else If nests the If, as the lessons write it
  'IndentCaseElse': 'False', 'IndentElse': 'True',
  # a statement after Then / Do goes on its own line
  'Block': '0',
  # every branch gets Begin ... End
  'BeginEndStyle': '1',   # leave: adding Begin ... End would put them in Case branches too
}
for line in sys.argv[1:]:
    k, v = line.split('=', 1); SET[k] = v
for key, value in SET.items():
    src, n = re.subn(r'(<%s>) .*? (</%s>)' % (key, key), lambda m: '%s %s %s' % (m.group(1), value, m.group(2)), src, count=1)
    assert n == 1, key
WORDS = 'Writeln,Write,Readln,Read,ReadKey,KeyPressed,ClrScr,GotoXY,TextColor,TextBackground,Delay,IntToStr,StrToInt,FloatToStr,FloatToStrF,StrToFloat,Length,Copy,Pos,Delete,Insert,UpCase,UpperCase,LowerCase,Trim,Random,Randomize,Round,Trunc,Sqrt,Sqr,Abs,Inc,Dec,Ord,Chr,Low,High,SetLength,Exit,Free,Create,Destroy,Result,Self,Format,Odd,Val,Str,ToString,Crt,SysUtils,Math,Classes,LongInt,ShortInt,SmallInt,Int64,AnsiString,DateUtils'
src = re.sub(r'(<Identifiers>\s*<Enabled>) .*? (</Enabled>\s*<Words>) .*? (</Words>)', lambda m: '%s True %s %s %s' % (m.group(1), m.group(2), WORDS, m.group(3)), src, flags=re.S)
src = re.sub(r'(<SpecificWordCaps>\s*<Enabled>) .*? (</Enabled>\s*<Words>) .*? (</Words>)', lambda m: '%s True %s %s %s' % (m.group(1), m.group(2), 'private,public,protected,published,strict,Override,Virtual,Abstract,Overload,DownTo', m.group(3)), src, flags=re.S)
src = re.sub(r'(<NotIdent>\s*<Enabled>) .*? (</Enabled>)', r'\1 False \2', src, flags=re.S)
src = re.sub(r'(<UnitNameCaps>\s*<Enabled>) .*? (</Enabled>)', r'\1 False \2', src, flags=re.S)
open('D:/DB Sync/Dropbox/Projects/AIPascalCourse/public/assets/practical/pascal/jcfsettings.cfg', 'w', encoding='utf-8', newline='\r\n').write(src)
print('jcfsettings.cfg written')
