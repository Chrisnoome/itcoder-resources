# CAT 11 lesson 11: Topologies and cables - videos

Lesson: `content/cattheory11/topologies.php`. Three videos: UTP or fibre
(both boards), STP, coaxial and what goes wrong with a signal (IEB), and the
seven topologies (IEB). Board in the CAT marker style with Clicky
(brand/cat-art-style.md); yellow highlighter on any words on screen being
talked about. Everything below is in the lesson text. No screen recordings
needed. Real cables on camera would help (a UTP cable cut open, a coaxial
cable, a fibre patch lead) if Chris has them; otherwise draw them.

## cat11-11.1 UTP or fibre? (about 7 min)

**Goes:** after section `#choose` - the comment after `r11WhyNotFibre`.
**The pupil can afterwards:** say what UTP and fibre-optic cable are, how each carries data, compare them, and choose the right medium for a link - and explain why fibre is safer between buildings when there is lightning.
**Thumbnail:** tag `CAT · NETWORKS`, title "Copper or *glass*?"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. The installer unrolls his plan at Phumlani. Blue lines to every desk, one orange line to the main building. "The blue is copper, the orange is glass."
   > Board: the plan - a star of blue lines and one long orange line. Clicky holding a blue and an orange cable.
2. **UTP (0:40-2:00).** Four pairs of copper wires, each pair twisted. Carries electricity. About 100 m. Cheap, thin, easy to fit. About 1 Gbps to a desk. Electrical noise can disturb it; the twists help cancel it.
   > Board: the nh-cables drawing, the UTP half. Yellow highlighter on "100 m".
3. **Fibre (2:00-3:40).** Light in glass as thin as a hair. Step by step: a laser flashes the data; the light travels along the core; the glass round it bounces it back in; a sensor turns flashes back into data. Kilometres; far more data; not disturbed by electricity; very hard to tap. Expensive to lay, fragile, joining needs special skill.
   > Board: the fibre-inside drawing, the light zigzagging along; each step numbered as it is said.
4. **The table (3:40-4:40).** Carries; how far; how much; interference; security; cost and fitting; used for.
   > Board: the Learn table drawn row by row, a tick on the winner of each row.
5. **Choosing - three questions (4:40-6:00).** How far? Does it move? What is around it? Worked example 1: 30 desktops within 30 m - UTP. Worked example 2: 250 m to the main building, the whole lab's data, Pretoria's storms - fibre. Lightning: copper between buildings can carry a surge that burns out the switches at both ends; glass cannot.
   > Board: three question marks in a column; then the two worked examples; a lightning bolt hitting a copper cable, sparks at both ends, and bouncing off a glass one.
6. **Why not fibre to every desk? (6:00-6:40).** Cost and fitting; every desk is under 100 m, and 1 Gbps is plenty for one computer.
   > Board: a price tag on each cable; Clicky shaking its head at a fibre to a desk.
7. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| the installer's plan | Start here |
| UTP: what, for, example; 100 m; 1 Gbps; twists | `#cables` |
| fibre: what, for, example; the four steps | `#cables` (the numbered list) |
| the comparison table | `#cables` (Learn / Memorise) |
| three questions; the two worked examples; lightning | `#choose` |
| why the lab uses UTP | `r11WhyNotFibre` (after `#choose`) |

## cat11-11.2 STP, coaxial and what goes wrong with a signal (IEB, about 8 min)

**Goes:** after the IEB section `#weaknesses` - the comment after the board section.
**The pupil can afterwards:** describe STP and coaxial cable and where each is used, give the speed of each cable, and name, explain and fix attenuation, EMI, crosstalk and eavesdropping.
**Thumbnail:** tag `CAT · NETWORKS · IEB`, title "Four things that *break* a signal"

### Scenes

1. **Hook (0:00-0:30).** Hi, and welcome to BestLessons. The library's connection drops every time the lift moves. Why?
   > Board: a lift going up and down, a cable beside it crackling; Clicky with its fingers in its ears.
2. **STP and coaxial (0:30-2:20).** STP: UTP with a foil shield round each pair - for factories and lift shafts; thicker, dearer, no faster. Coaxial: a copper core, insulation, a braided shield, a jacket - satellite dishes, TV aerials, security cameras; the first LANs at 10 Mbps.
   > Board: the copper-cables drawing, one cable at a time; yellow highlighter on "shield".
3. **How fast (2:20-3:00).** Cat 5e UTP 1 Gbps; Cat 6a 10 Gbps over 100 m; STP the same as its UTP; coaxial LANs 10 Mbps long ago; fibre the fastest.
   > Board: the speed table as a race, fibre far ahead.
4. **Attenuation (3:00-4:10).** The signal grows weaker with distance - a shout across a rugby field. Why UTP stops at 100 m; Wi-Fi fades through walls; fibre only after tens of km. Fix: a repeater or switch; fibre.
   > Board: the attenuation-repeater drawing - a wave shrinking, then a box that makes it big again.
5. **EMI (4:10-5:10).** Electrical noise from motors, air conditioners, fluorescent lights, power cables, lightning. Copper and radio suffer; a microwave oven can drop the Wi-Fi; fibre does not. The library: EMI from the lift motor. Fix: route the cable away, STP, fibre.
   > Board: back to the lift; a fibre cable sliding calmly past it.
6. **Crosstalk (5:10-6:10).** A signal leaks into the wire next to it - another conversation on a bad phone line. Twists stop most of it; a plug with the wires untwisted too far back causes it. Fix: twisted pairs fitted properly, STP, fibre.
   > Board: the crosstalk-pairs drawing; two speech bubbles bleeding into each other.
7. **Eavesdropping (6:10-7:20).** Secretly listening in. Radio is easiest - the signal reaches the car park; copper can be tapped or a spare socket used; fibre is the hardest. Fix: encryption (a strong Wi-Fi password), locked cupboards, fibre.
   > Board: a car in the car park with an antenna; a padlock scrambling the signal into nonsense.
8. **Why fibre escapes three of them (7:20-7:50).** EMI and crosstalk are electrical; fibre carries light in glass.
   > Board: the weaknesses table, fibre's column filled in.
9. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| STP; coaxial; the speed table | `#moreCables` |
| attenuation and the repeater | `#weaknesses` |
| EMI; the lift motor | `#weaknesses` (and `w11LiftMotor`) |
| crosstalk; badly fitted plugs | `#weaknesses` |
| eavesdropping; encryption | `#weaknesses` |
| why fibre has no EMI or crosstalk | `r11FibreNoEmi` and the Learn table |

## cat11-11.3 Seven topologies (IEB, about 8 min)

**Goes:** after the IEB section `#topologies` / `#moreTopologies` - the comment after the board section.
**The pupil can afterwards:** say what a topology is, recognise star, bus, ring, mesh, point-to-point, tree and hybrid in a drawing, and give an advantage and a disadvantage of each.
**Thumbnail:** tag `CAT · NETWORKS · IEB`, title "Why the network is a *star*"

### Scenes

1. **Hook (0:00-0:30).** Hi, and welcome to BestLessons. Thabo's other question: why does the plan look like a star? That shape has a name - the topology.
   > Board: the plan from video 1, a star traced over it in highlighter.
2. **Topology (0:30-1:00).** The layout - how devices and cables are connected. Not the same as the kind of network: a LAN covers one site; its topology is how its cables are laid out.
   > Board: the word TOPOLOGY with "= layout" under it.
3. **Star (1:00-2:00).** Every device its own cable to a switch - bicycle spokes. A cut cable cuts off one device; easy to add; easy to find faults; the switch sends data only where it must go. But: the switch fails and all lose the network; lots of cable; ports run out.
   > Board: a star; one cable snipped (one computer goes grey); then the switch crossed out (all grey).
4. **Bus (2:00-2:50).** One shared cable - passengers on a bus. Cheap. One break stops all; one sender at a time; every device sees all the data. 1980s; the CAN bus in cars.
   > Board: the nh-bus-break doodle - a bus with a snapped cable.
5. **Ring (2:50-3:40).** A closed loop, data passed round. No collisions, copes with heavy traffic. One break stops the ring - unless it is a double ring, which is why city fibre is laid in rings.
   > Board: a loop; a digger cuts it; the data turns and goes the other way.
6. **Mesh (3:40-4:30).** Many paths; full mesh = everyone to everyone. Very reliable - the Internet's routers, mesh Wi-Fi. Expensive and complicated.
   > Board: five dots, every one linked to every other; one link crossed out, a dot finds another way.
7. **Point-to-point (4:30-5:10).** One link, exactly two ends: the fibre from the main building to the lab; Mr Botha's wireless link to his storeroom. Simple, fast, private; joins only two.
   > Board: two buildings, one line between them.
8. **Tree and the backbone (5:10-6:20).** Stars in levels under one main switch - trunk, branches, leaves; also called an extended star. The backbone joins the branches, usually fibre. Easy to grow; the main switch or backbone is the weak point.
   > Board: the star-extended drawing, drawn as a tree with the main switch at the top.
9. **Hybrid (6:20-7:10).** Two or more different topologies: stars in each building joined in a fibre ring, or stars on one shared cable. Each part gets what suits it; complicated and expensive. A tree is built from stars, so some books call it a hybrid too.
   > Board: three stars joined in a ring.
10. **The table (7:10-7:50).** Layout, main advantage, main disadvantage, for all seven.
   > Board: the Learn table, a row at a time, yellow highlighter on each name.
11. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| what a topology is; not the kind of network | `#topologies` |
| star, bus and ring - what, example, good and bad | `#topologies` |
| mesh, point-to-point, tree (backbone), hybrid | `#moreTopologies` |
| the seven compared | `#moreTopologies` (Learn / Memorise) |
