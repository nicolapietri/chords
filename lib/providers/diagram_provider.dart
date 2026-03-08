import 'package:flutter/material.dart';
import '../data/bullet.dart';
import '../data/tuning.dart';

class DiagramProvider extends ChangeNotifier {
  Tuning tuning = Tuning();
  List<Bullet> items = [];
  bool relative = true;
  String root = '';
  String nextRoot = '';

  DiagramProvider({required this.tuning, this.relative = true}) {
    items.clear();
  }

  DiagramProvider reset() {
    items.clear();
    root = '';
    nextRoot = '';
    relative = true;
    tuning.capo = 0;
    notifyListeners();
    return this;
  }

  DiagramProvider nextIsRoot() {
    /* mark next bullet as root */
    nextRoot = '?';
    return this;
  }

  DiagramProvider majorScale() {
    reset();

    items.add(Bullet(string: 6, fret: 3));
    items.add(Bullet(string: 6, fret: 5));
    //--
    items.add(Bullet(string: 5, fret: 2));
    items.add(Bullet(string: 5, fret: 3));
    items.add(Bullet(string: 5, fret: 5));
    //--
    items.add(Bullet(string: 4, fret: 2));
    items.add(Bullet(string: 4, fret: 3));
    items.add(Bullet(string: 4, fret: 5));
    //--
    items.add(Bullet(string: 3, fret: 2));
    items.add(Bullet(string: 3, fret: 4));
    items.add(Bullet(string: 3, fret: 5));
    //--
    items.add(Bullet(string: 2, fret: 3));
    items.add(Bullet(string: 2, fret: 5));
    items.add(Bullet(string: 2, fret: 6));
    //--
    items.add(Bullet(string: 1, fret: 3));
    items.add(Bullet(string: 1, fret: 5));

    return setRoot('c').setRelative(relative);
  }

  DiagramProvider minorNaturalScale() {
    reset();

    items.add(Bullet(string: 6, fret: 3));
    items.add(Bullet(string: 6, fret: 4));
    items.add(Bullet(string: 6, fret: 6));
    //--
    items.add(Bullet(string: 5, fret: 3));
    items.add(Bullet(string: 5, fret: 5));
    items.add(Bullet(string: 5, fret: 6));
    //--
    items.add(Bullet(string: 4, fret: 3));
    items.add(Bullet(string: 4, fret: 5));
    items.add(Bullet(string: 4, fret: 6));
    //--
    items.add(Bullet(string: 3, fret: 3));
    items.add(Bullet(string: 3, fret: 5));
    //--
    items.add(Bullet(string: 2, fret: 3));
    items.add(Bullet(string: 2, fret: 4));
    items.add(Bullet(string: 2, fret: 6));
    //--
    items.add(Bullet(string: 1, fret: 3));
    items.add(Bullet(string: 1, fret: 4));
    items.add(Bullet(string: 1, fret: 6));

    return setRoot('c').setRelative(relative);
  }

  DiagramProvider setRoot(String rootNote) {
    root = rootNote;
    _updateBullets();
    notifyListeners();
    return this;
  }

  DiagramProvider setRelative(bool relative) {
    this.relative = relative;
    _resetAlternatives();
    _updateBullets();
    notifyListeners();
    return this;
  }

  DiagramProvider toggleRelative() {
    return setRelative(!relative);
  }

  DiagramProvider moveCapoDown() {
    tuning.capo = (tuning.capo + 1) % 15;
    _resetAlternatives();
    _updateBullets();
    notifyListeners();
    return this;
  }

  DiagramProvider rotateBulletAlternative(Bullet bullet) {
    bullet.alternative++;
    _updateBullets();
    notifyListeners();
    return this;
  }

  DiagramProvider addBulletAtFret(int tappedString, int tappedFret) {
    if (tuning.capo > 1 && tappedFret == 0) return this;

    if (!bulletExists(tappedString, tappedFret)) {
      Bullet newBullet = Bullet(string: tappedString, fret: tappedFret);
      /*if (relative && root != '') {
        /* search lower octave of root */
        int lowerOctave = 6;
        int octave;
        for (Bullet bullet in items) {
          if (bullet.root) {
            octave = tuning.getOctave(bullet.string, bullet.fret);
            if (octave < lowerOctave) lowerOctave = octave;
          }
        }
        /* compare with this new bullet's octave */
        octave = tuning.getOctave(newBullet.string, newBullet.fret);
        if (octave > lowerOctave) {
          /* search for bullet extensions */
          bool found = false;
          for (int alternative = 0; alternative < 5; alternative++) {
            if (!found) {
              newBullet.alternative = alternative;
              String altText = tuning.getIntervalText(newBullet, root);
              if (altText.contains('9') ||
                  altText.contains('11') ||
                  altText.contains('13')) {
                found = true;
              }
            }
          }
          if (!found) newBullet.alternative = 0;
        }
      }
      */
      items.add(newBullet);
      /* set next root */
      if (nextRoot == '?') {
        nextRoot = '';
        root = tuning.getNote(tappedString, tappedFret);
      }
    } else {
      for (Bullet bullet in items) {
        if (bullet.string == tappedString && bullet.fret == tappedFret) {
          rotateBulletAlternative(bullet);
          return this;
        }
      }
    }

    _updateBullets();
    notifyListeners();
    return this;
  }

  bool bulletExists(int string, int fret) {
    for (Bullet bullet in items) {
      if (bullet.string == string && bullet.fret == fret) return true;
    }
    return false;
  }

  void _resetAlternatives() {
    for (Bullet bullet in items) {
      bullet.alternative = 0;
    }
  }

  void _updateBullets() {
    for (Bullet bullet in items) {
      if (bullet.fret == 0) {
        bullet.text = (tuning.capo > 1
            ? 'x'
            : (bullet.alternative > 1 ? 'x' : ''));
      } else if (!relative) {
        bullet.text = tuning.getNoteText(bullet);
      } else if (root == '') {
        bullet.text = bullet.alternative > 0 ? 'x' : '';
      } else {
        bullet.text = tuning.getIntervalText(bullet, root);
      }
      bullet.filled =
          (!bullet.text.contains('b') && !bullet.text.contains('#'));
      bullet.root = tuning.getInterval(bullet.string, bullet.fret, root) == '1';
    }
    /* delete marked bullets */
    items.removeWhere((bullet) => bullet.text == 'x');

    /* sort bullets */
    items.sort((a, b) {
      if (a.string < b.string) return 1;
      if (a.string > b.string) return -1;
      return (a.fret < b.fret ? 1 : -1);
    });
    print("---------------------------");
    for (Bullet bullet in items) {
      print(
        "${bullet.string}:${bullet.fret} ${bullet.text} ${bullet.root ? '(R)' : ''} ${bullet.filled ? 'filled' : ''}",
      );
    }
  }
}
