#!/bin/sh
# Builds and runs lesson 24's screenshot drivers (Git Bash on Windows).
# Needs JDK 21 and the OpenJFX 21 jars listed in fxpath.txt. Put FreeSerif.ttf
# (GNU FreeFont) in build/ first - ShotsFonts renames it away for one picture.
# Never add synthetic mouse clicks to a driver: see README.md.
J=/d/xampp/jdk-21/bin
MP=$(cat fxpath.txt)
FX="--module-path $MP --add-modules javafx.controls"
mkdir -p build/out build2/out build3/out
$J/javac $FX -d build src/*.java tools/Shot.java tools/FxShot.java tools/SwingGallery.java tools/FxGallery.java \
  tools/ShotsBooking.java tools/ShotsBookingFx.java tools/ShotsNotes.java tools/ShotsFonts.java tools/ShotsBad.java || exit 1
$J/javac -d build2 src2/*.java tools/Shot.java tools/ShotsForms.java || exit 1
$J/javac $FX -d build3 src2fx/*.java tools/Shot.java tools/FxShot.java tools/ShotsFormsFx.java || exit 1
(cd build && for driver in SwingGallery ShotsBooking ShotsNotes ShotsFonts ShotsBad FxGallery ShotsBookingFx; do $J/java $FX -cp . $driver; done)
(cd build2 && $J/java -cp . ShotsForms)
(cd build3 && $J/java $FX -cp . ShotsFormsFx)
python publish_shots.py
