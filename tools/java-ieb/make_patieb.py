"""Make content/java/patieb.php from the Pascal PAT lesson, with the Java words."""
ROOT = r'D:\DB Sync\Dropbox\Projects\AIPascalCourse'
src = open(ROOT + r'\content\pascal\lesson27.php', encoding='utf-8').read()
body = src[src.index('return ['):]
reps = [
 ('the waiter (<a class="lesson-link" href="/lesson.php?c=pascal&amp;id=lesson22">lesson 22</a>);',
  'the waiter (<a class="lesson-link" href="/lesson.php?c=java&amp;id=lesson24#separate">lesson 24</a>);'),
 ('<li><strong>a lot of meaningful data kept in storage</strong> - a database, text\nfiles or JSON - not just a few settings;</li>',
  '<li><strong>a lot of meaningful data kept in storage</strong> - text files\n(<a class="lesson-link" href="/lesson.php?c=java&amp;id=lesson18">lesson 18</a>), an SQLite or Java DB database (<a class="lesson-link" href="/lesson.php?c=java&amp;id=lesson25">lessons 25 to 27</a>) or JSON - not just a few settings;</li>'),
 ('<a class="lesson-link" href="/lesson.php?c=pascal&amp;id=lesson16">lesson 16</a> taught',
  '<a class="lesson-link" href="/lesson.php?c=java&amp;id=lesson17">lesson 17</a> taught'),
 ('The forms only handle the screen and call the classes - they never touch the stored data themselves.',
  'The window classes only handle the screen and call the backend classes - they never touch the stored data themselves.'),
 ('file and maths errors caught with Try ... Except; every message clear.',
  'file and maths errors caught with try ... catch; every message clear.'),
 ("<p>The biggest lesson is <a class=\"lesson-link\" href=\"/lesson.php?c=pascal&amp;id=lesson22\">lesson 22</a>'s: <strong>the waiter and the kitchen</strong>.\nA button's click event should be a few lines that read the screen, call a method\nof a backend class, and show the result. If your form opens a text file or runs\na loop over your data, that code belongs in a class - and costs you up to 6\nmarks where it is.</p>",
  "<p>The biggest lesson is <a class=\"lesson-link\" href=\"/lesson.php?c=java&amp;id=lesson24#separate\">lesson 24</a>'s: <strong>the waiter and the kitchen</strong>.\nA button's event handler should be a few lines that read the screen, call a\nmethod of a backend class, and show the result. If your window opens a text file,\nruns SQL or loops over your data, that code belongs in a class - and costs you up\nto 6 marks where it is. (Lesson 25's ProductsDB is the pattern: all the SQL in\none class.)</p>"),
 ('still one mark. So is Button1. So is a chain of Ifs that should be a Case. So\nis the same five lines pasted three times instead of a method.</p>',
  'still one mark. So is jButton1. So is a chain of ifs that should be a switch. So\nis the same five lines pasted three times instead of a method.</p>'),
 ('closes the file - all in btnSaveClick. What is the problem?',
  'closes the file - all in saveClicked, in the window class. What is the problem?'),
 ("'d' => 'The button should have been called Button1',", "'d' => 'The button should have been called jButton1',"),
 ('The form is the waiter.', 'The window is the waiter.'),
 ('(as in <a class="lesson-link" href="/lesson.php?c=pascal&amp;id=lesson26">the data validation task lesson</a>)',
  '(as in <a class="lesson-link" href="/lesson.php?c=java&amp;id=dvtieb">the data validation task lesson</a>)'),
 ('Pasting Pascal instead earns nothing for that section.', 'Pasting Java instead earns nothing for that section.'),
 ('<li>Go through every unit and say out loud what each method does.</li>',
  '<li>Go through every class and say out loud what each method does.</li>'),
 ('<li>Working code in the forms: file handling, loops over data, calculations.</li>',
  '<li>Working code in the window classes: file handling, SQL, loops over data, calculations.</li>'),
 ('source files themselves: select all your .pas and form files at once.</p>',
  'source files themselves: select all your .java files (and any .fxml or NetBeans\n.form files) at once.</p>'),
 ("'**All working code in backend classes**; forms only handle the screen and call methods.',",
  "'**All working code in backend classes**; window classes only handle the screen and call methods.',"),
 ('indentation, names, Ifs instead of Case, variables instead of arrays, repeated code.',
  'indentation, names, ifs instead of a switch, variables instead of arrays, repeated code.'),
 ("A class that holds data and does the work; the forms only call it.",
  "A class that holds data and does the work; the window classes only call it."),
]
for old, new in reps:
    assert body.count(old) == 1, old[:80]
    body = body.replace(old, new)
doc = '''<?php
/**
 * Java IEB lesson : The PAT - IEB (lessonId 'patieb')
 *
 * The Java course's copy of Pascal's lesson27 (content/pascal/lesson27.php),
 * converted 26 September 2026. Chris's brief for the Pascal lesson carries
 * over: "the same for the pat which has 3 documents and code. everything must
 * be uploaded as pdf (unless you suggest an alternative)" - the code part
 * takes the source files (.java, .fxml, .form - lib/tasks.php, 'uploadJava')
 * or a PDF printout.
 *
 * SOURCE: the IEB's 2026 PAT Task Guidelines and Assessment Rubric, as the
 * Pascal lesson: Specifications 15 (February), Design 30 (March), Coding 40
 * (July), Technical & Testing 15 (August); at most 20% borrowed or
 * AI-generated code, referenced and declared; an interview. The rubric lines
 * here and in lib/tasks.php (TaskDefinitions, 'pat') must agree - a new
 * year's rubric changes both. The PAT is language-neutral, so the text is
 * the Pascal lesson's with the Java words: window classes for forms, try ...
 * catch, switch for Case, jButton1 for Button1, .java files to upload, and
 * links to the Java lessons (17 class diagrams, 18 text files, 24 separation,
 * 25-27 databases, dvtieb). Never name the syllabus to a pupil.
 *
 * QUOTE: W. Edwards Deming, attributed - deming.png, as the Pascal lesson.
 */

'''
open(ROOT + r'\content\java\patieb.php', 'w', encoding='utf-8', newline='\n').write(doc + body)
print('ok')
