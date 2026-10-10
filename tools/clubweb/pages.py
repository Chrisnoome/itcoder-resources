"""Writes every version of the Robotics Club's page, one per build step.

Each step's model is the page after that step; its starter is the page before
it (the previous step's model). The lessons load them with ClubPage()
(content/clubweb/helpers.php), and shots.py photographs the models. One source
for the page, so a later step can never drift from an earlier one.

  python -X utf8 tools/clubweb/pages.py
"""
import os

OUT = r'D:\DB Sync\Dropbox\Projects\AIPascalCourse\content\clubweb\pages'

HEAD = '<html>\n<head>\n<title>Robotics Club</title>\n</head>\n<body>\n'
FOOT = '</body>\n</html>\n'

INTRO1 = '<p>We design, build and program robots. Anyone in Grade 8 to 12 can join - you don\'t need to know anything yet.</p>\n'
INTRO2 = '<p>We meet in Room 12 every Tuesday and Thursday from 14:30 to 16:00.</p>\n'
DO_LIST = ('<ul>\n<li>Build robots from kits and cardboard</li>\n<li>Program them to follow lines and avoid walls</li>\n'
           '<li>Compete at the regional robotics challenge</li>\n</ul>\n')
JOIN = ('<h2>How to join</h2>\n<ol>\n<li>Come to Room 12 on a Tuesday.</li>\n<li>Fill in the form with Zanele, our captain.</li>\n'
        '<li>Bring R20 for your club badge.</li>\n</ol>\n')
BOXY = '<img src="boxy.png" alt="Boxy, our cardboard robot, waving" width="300">\n'
BUILD = '<img src="build.png" alt="A robot with wheels and an arm being built on a workbench" width="250">\n'
LINKS = ('<p>Read more about our school on the <a href="https://www.ridgeview.example">Ridgeview High website</a>.</p>\n'
         '<p>Questions? Email us at <a href="mailto:robotics@ridgeview.example">robotics@ridgeview.example</a>.</p>\n')
TOP = '<p><a href="#top">Back to top</a></p>\n'
TABLE = ('<h2>Competitions</h2>\n<table border="1">\n<tr>\n<th>Date</th>\n<th>Competition</th>\n<th>Where</th>\n</tr>\n'
         '<tr>\n<td>14 March</td>\n<td>Line-follower race</td>\n<td>Durban</td>\n</tr>\n'
         '<tr>\n<td>9 May</td>\n<td>Maze challenge</td>\n<td>Pietermaritzburg</td>\n</tr>\n'
         '<tr>\n<td>22 August</td>\n<td>Regional robotics challenge</td>\n<td>Durban</td>\n</tr>\n</table>\n')


TABLE_HEAD = ('<h2>Competitions</h2>\n<table border="1">\n<tr>\n<th>Date</th>\n<th>Competition</th>\n<th>Where</th>\n</tr>\n</table>\n')
TROPHIES = ('<h2 style="color: navy;">Our trophies</h2>\n<img src="trophy.png" alt="Our gold cog trophy" width="200">\n'
            '<ul>\n<li>2nd place, line-follower race, 2026</li>\n<li>Best newcomer team, maze challenge, 2026</li>\n</ul>\n')


def h1(styled=False, anchored=False):
    attrs = (' id="top"' if anchored else '') + (' style="color: navy;"' if styled else '')
    return f'<h1{attrs}>Ridgeview High Robotics Club</h1>\n'


def banner():
    return '<p style="background-color: yellow; text-align: center;">Come and see us at the Club Expo on Friday, in the hall!</p>\n'


PAGES = {
    # lesson 1
    'l1-start': '<html>\n<head>\n\n</head>\n<body>\n\n</body>\n</html>\n',
    'l1-title': '<html>\n<head>\n<title>Robotics Club</title>\n</head>\n<body>\n\n</body>\n</html>\n',
    'l1-body': HEAD + 'Welcome to the Ridgeview High Robotics Club!\n' + FOOT,
    # lesson 2
    'l2-heading': HEAD + h1() + FOOT,
    'l2-paras': HEAD + h1() + INTRO1 + INTRO2 + FOOT,
    'l2-h2': HEAD + h1() + INTRO1 + INTRO2 + '<h2>What we do</h2>\n' + FOOT,
    # lesson 3
    'l3-ul': HEAD + h1() + INTRO1 + INTRO2 + '<h2>What we do</h2>\n' + DO_LIST + FOOT,
    'l3-ol': HEAD + h1() + INTRO1 + INTRO2 + '<h2>What we do</h2>\n' + DO_LIST + JOIN + FOOT,
    # lesson 4
    'l4-boxy': HEAD + h1() + BOXY + INTRO1 + INTRO2 + '<h2>What we do</h2>\n' + DO_LIST + JOIN + FOOT,
    'l4-build': HEAD + h1() + BOXY + INTRO1 + INTRO2 + '<h2>What we do</h2>\n' + DO_LIST + BUILD + JOIN + FOOT,
    # lesson 5
    'l5-links': HEAD + h1() + BOXY + INTRO1 + INTRO2 + '<h2>What we do</h2>\n' + DO_LIST + BUILD + JOIN + LINKS + FOOT,
    'l5-top': HEAD + h1(anchored=True) + BOXY + INTRO1 + INTRO2 + '<h2>What we do</h2>\n' + DO_LIST + BUILD + JOIN + LINKS + TOP + FOOT,
    # lesson 6
    'l6-header': HEAD + h1(anchored=True) + BOXY + INTRO1 + INTRO2 + '<h2>What we do</h2>\n' + DO_LIST + BUILD + JOIN + TABLE_HEAD + LINKS + TOP + FOOT,
    'l6-table': HEAD + h1(anchored=True) + BOXY + INTRO1 + INTRO2 + '<h2>What we do</h2>\n' + DO_LIST + BUILD + JOIN + TABLE + LINKS + TOP + FOOT,
    # lesson 7
    'l7-colour': HEAD + h1(True, True) + BOXY + INTRO1 + INTRO2 + '<h2>What we do</h2>\n' + DO_LIST + BUILD + JOIN + TABLE + LINKS + TOP + FOOT,
    'l7-banner': HEAD + h1(True, True) + banner() + BOXY + INTRO1 + INTRO2 + '<h2>What we do</h2>\n' + DO_LIST + BUILD + JOIN + TABLE + LINKS + TOP + FOOT,
    # lesson 8 - the Expo page: the trophies section Zanele's brief asks for
    'l8-final': HEAD + h1(True, True) + banner() + BOXY + INTRO1 + INTRO2 + '<h2>What we do</h2>\n' + DO_LIST + BUILD + JOIN + TABLE + TROPHIES + LINKS + TOP + FOOT,
}


def main():
    os.makedirs(OUT, exist_ok=True)
    for name, html in PAGES.items():
        with open(os.path.join(OUT, name + '.html'), 'w', encoding='utf-8', newline='\n') as f:
            f.write(html)
    print(len(PAGES), 'pages written')


main()
