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
    tuning.capo = (tuning.capo + 3) % 15;
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

  DiagramProvider addBulletAtOffset(
    Offset offset,
    double width,
    double height,
  ) {
    int tapperString = 6 - ((offset.dx / width * 100.0 - 8) / 14).toInt();
    if (tapperString < 1 || tapperString > 6) return this;

    int tapperFret = ((offset.dy / height * 100.0 - 10) / 10).toInt();
    if (tapperFret < 1 || tapperFret > 7) return this;

    if (!bulletExists(tapperString, tapperFret)) {
      items.add(Bullet(string: tapperString, fret: tapperFret));
      /* set next root */
      if (nextRoot == '?') {
        nextRoot = '';
        root = tuning.getNote(tapperString, tapperFret);
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
      if (!relative) {
        bullet.text = tuning.getNoteText(bullet);
      } else if (root == '') {
        bullet.text = bullet.alternative > 0 ? 'x' : '';
      } else {
        bullet.text = tuning.getIntervalText(bullet, root);
      }
      bullet.filled =
          (!bullet.text.contains('b') && !bullet.text.contains('#'));
      bullet.root = tuning.getInterval(bullet.string, bullet.fret, root) == 'R';
    }
    /* delete marked bullets */
    for (Bullet bullet in items) {
      if (bullet.text == 'x') items.remove(bullet);
    }
  }
}
