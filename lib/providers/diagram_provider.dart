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
    relative = true;
    tuning.capo = 0;
    nextIsRoot();
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

    items.add(Bullet(string: 6, fret: 3)); //5
    items.add(Bullet(string: 6, fret: 4)); //b6
    items.add(Bullet(string: 6, fret: 6)); //b7
    //--
    items.add(Bullet(string: 5, fret: 3)); //1
    items.add(Bullet(string: 5, fret: 5)); //2
    items.add(Bullet(string: 5, fret: 6)); //b3
    //--
    items.add(Bullet(string: 4, fret: 3)); //4
    items.add(Bullet(string: 4, fret: 5)); //5
    items.add(Bullet(string: 4, fret: 6)); //b6
    //--
    items.add(Bullet(string: 3, fret: 3)); //b7
    items.add(Bullet(string: 3, fret: 5)); //8
    //--
    items.add(Bullet(string: 2, fret: 3)); //2
    items.add(Bullet(string: 2, fret: 4)); //b3
    items.add(Bullet(string: 2, fret: 6)); //4
    //--
    items.add(Bullet(string: 1, fret: 3)); //5
    items.add(Bullet(string: 1, fret: 4)); //b6
    items.add(Bullet(string: 1, fret: 6)); //b7

    return setRoot('c').setRelative(relative);
  }

  DiagramProvider minorHarmonicScale() {
    reset();

    items.add(Bullet(string: 6, fret: 3)); //5
    items.add(Bullet(string: 6, fret: 4)); //b6
    items.add(Bullet(string: 6, fret: 7)); //7
    //--
    items.add(Bullet(string: 5, fret: 3)); //1
    items.add(Bullet(string: 5, fret: 5)); //2
    items.add(Bullet(string: 5, fret: 6)); //b3
    //--
    items.add(Bullet(string: 4, fret: 3)); //4
    items.add(Bullet(string: 4, fret: 5)); //5
    items.add(Bullet(string: 4, fret: 6)); //b6
    //--
    items.add(Bullet(string: 3, fret: 4)); //7
    items.add(Bullet(string: 3, fret: 5)); //8
    //--
    items.add(Bullet(string: 2, fret: 3)); //2
    items.add(Bullet(string: 2, fret: 4)); //b3
    items.add(Bullet(string: 2, fret: 6)); //4
    //--
    items.add(Bullet(string: 1, fret: 3)); //5
    items.add(Bullet(string: 1, fret: 4)); //b6
    items.add(Bullet(string: 1, fret: 7)); //7

    return setRoot('c').setRelative(relative);
  }

  DiagramProvider minorMelodicScale() {
    reset();

    items.add(Bullet(string: 6, fret: 3)); //5
    items.add(Bullet(string: 6, fret: 5)); //6
    items.add(Bullet(string: 6, fret: 7)); //7
    //--
    items.add(Bullet(string: 5, fret: 3)); //1
    items.add(Bullet(string: 5, fret: 5)); //2
    items.add(Bullet(string: 5, fret: 6)); //b3
    //--
    items.add(Bullet(string: 4, fret: 3)); //4
    items.add(Bullet(string: 4, fret: 5)); //5
    items.add(Bullet(string: 4, fret: 7)); //6
    //--
    items.add(Bullet(string: 3, fret: 4)); //7
    items.add(Bullet(string: 3, fret: 5)); //8
    //--
    items.add(Bullet(string: 2, fret: 3)); //2
    items.add(Bullet(string: 2, fret: 4)); //b3
    items.add(Bullet(string: 2, fret: 6)); //4
    //--
    items.add(Bullet(string: 1, fret: 3)); //5
    items.add(Bullet(string: 1, fret: 5)); //6
    items.add(Bullet(string: 1, fret: 7)); //7

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
    if (nextRoot == '?') {
      nextRoot = '';
      root = tuning.getNote(bullet.string, bullet.fret);
    } else {
      bullet.alternative++;
    }
    _updateBullets();
    notifyListeners();
    return this;
  }

  DiagramProvider addBulletAtFret(int tappedString, int tappedFret) {
    if (tuning.capo > 1 && tappedFret == 0) return this;

    if (!bulletExists(tappedString, tappedFret)) {
      Bullet newBullet = Bullet(string: tappedString, fret: tappedFret);

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

  bool intervalExists(String interval) {
    for (Bullet bullet in items) {
      if (bullet.interval == interval) return true;
    }
    return false;
  }

  Bullet? getBulletByInterval(String interval) {
    for (Bullet bullet in items) {
      if (bullet.interval == interval) return bullet;
    }
    return null;
  }

  int getRootOctave() {
    /* search lower octave of root */
    int lowerOctave = 6;
    int octave;
    for (Bullet bullet in items) {
      if (bullet.root) {
        octave = tuning.getOctave(bullet.string, bullet.fret);
        if (octave < lowerOctave) lowerOctave = octave;
      }
    }
    return lowerOctave;
  }

  void _resetAlternatives() {
    for (Bullet bullet in items) {
      bullet.alternative = 0;
    }
  }

  void _updateBullets() {
    for (Bullet bullet in items) {
      /* assign absolute octave */
      bullet.octave = tuning.getOctave(bullet.string, bullet.fret);

      /* assign base interval */
      if (root != '') {
        bullet.interval = tuning.getInterval(bullet.string, bullet.fret, root);
      }

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
      return (a.fret < b.fret ? -1 : 1);
    });

    dump();
  }

  void dump() {
    /*print("----------- Bullets -----------");
    for (Bullet bullet in items) {
      print(
        "[${bullet.string}:${bullet.fret}] (${bullet.interval}) (octave ${bullet.octave}) \"${bullet.text}\"",
      );
    }
    print("---------- Intervals ----------");
    String line = '';
    for (String interval in getAllIntervals()) {
      line = "$line $interval";
    }
    print(line);
    */
  }

  List<String> getAllIntervals() {
    List<String> all = [];
    int sevenOctave = 10;
    if (intervalExists('7')) {
      var b = getBulletByInterval('7');
      if (b != null) sevenOctave = b.octave;
    }
    if (intervalExists('b7')) {
      var b = getBulletByInterval('b7');
      if (b != null) sevenOctave = b.octave;
    }
    int rootOctave = getRootOctave();

    for (Bullet bullet in items) {
      String interval = bullet.interval;

      /* extensions only if 7 or b7 is present */
      if (bullet.octave > sevenOctave) {
        /* 9th extensions */
        if (interval == 'b2') interval = 'b9';
        if (interval == '2') interval = '9';
        /* #9 is b3 so it's added only if b3 is already set */
        if (interval == 'b3' && (all.contains('b3') || all.contains('3'))) {
          interval = '#9';
        }
        /* 11th extensions */
        if (interval == '4') interval = '11';
        /* b5 is #11 so it's added only if b5 is already set */
        if (interval == 'b5' && all.contains('b5')) interval = '#11';
        /* 13th extensions */
        if (interval == 'b6') interval = 'b13';
        if (interval == '6') interval = '13';
      } else {
        /* 13th without 7 */
        if (all.contains('6') || all.contains('b6')) {
          if (interval == 'b6') interval = 'b13';
          if (interval == '6') interval = '13';
        }
      }

      /* extensions based on octave only */
      if (bullet.octave > rootOctave) {
        /* 9th extensions */
        if (interval == 'b2') interval = 'b9';
        if (interval == '2') interval = '9';
        /* #9 is b3 so it's added only if b3 is already set */
        if (interval == 'b3' && all.contains('b3')) interval = '#9';
      }

      if (!all.contains(interval)) {
        all.add(interval);
      }
    }

    all.sort((a, b) {
      return int.parse(a.replaceAll(RegExp(r'[b#]'), '')) <
              int.parse(b.replaceAll(RegExp(r'[b#]'), ''))
          ? -1
          : 1;
    });

    return all;
  }

  String sequence(List<String> intervals) {
    return intervals.reduce((a, b) => "$a $b").trim();
  }

  String getChordNameFromIntervals(List<String> intervals) {
    intervals.remove('5');
    if (intervals.isEmpty) return '';
    String mode = intervals.contains('b3') ? 'm' : '';
    String sequence = this.sequence(intervals);

    /* TRIADS (perfect-fifth independant) */
    /* major 1 3 5 */
    if (sequence == '1 3') return '';
    /* minor 1 b3 5 */
    if (sequence == '1 b3') return 'm';
    /* generic flat-five */
    if (sequence == '1 b5') return 'dim';
    /* major flat-five 1 3 b5 */
    if (sequence == '1 3 b5') return '(b5)';
    /* minor flat-five 1 b3 b5 */
    if (sequence == '1 b3 b5') return 'dim';

    /* SUSPENDED 2 and 4 */
    if (sequence == '1 2' || sequence == '1 9') return 'sus2';
    if (sequence == '1 4' || sequence == '1 11') return 'sus4';
    if (sequence == '1 b7 4' || sequence == '1 b7 11') return '7sus4';
    if (sequence == '1 2 4' || sequence == '1 4 9') return 'sus4/9';

    /* TRIADS WITH ADDS 4/9/11/13 */
    String sequenceNoMode = this.sequence(
      intervals.where((e) => e != '3' && e != 'b3').toList(),
    );
    /* additions */
    if (sequenceNoMode == '1 4') return mode == 'm' ? 'm(add4)' : 'add4';
    if (sequenceNoMode == '1 b9') return "$mode(b9)";
    if (sequenceNoMode == '1 9') return mode == 'm' ? 'm(add9)' : 'add9';
    if (sequenceNoMode == '1 #9') return mode == 'm' ? 'm(add#9)' : 'add#9';
    if (sequenceNoMode == '1 6 9') return "${mode}6/9";
    if (sequenceNoMode == '1 11') return mode == 'm' ? 'm(add11)' : 'add11';
    if (sequenceNoMode == '1 #11') return mode == 'm' ? 'm(add#11)' : 'add#11';
    if (sequenceNoMode == '1 b13') return "$mode(b13)";
    if (sequenceNoMode == '1 13') return mode == 'm' ? 'm(add13)' : 'add13';

    /* pure 9th, 11th and 13th dominant or major*/
    if (sequenceNoMode == '1 b7 9') return "${mode}9"; // dominant 9
    if (sequenceNoMode == '1 7 9') return mode == 'm' ? 'm(maj9)' : 'maj9';
    if (sequenceNoMode == '1 7 11') return "${mode}11";
    if (sequenceNoMode == '1 7 13') return "${mode}13";

    /* QUADRIADS */

    /* major seven 1 3 5 7 */
    if (sequence == '1 3 7') return 'maj7';
    if (sequence == '1 b3 7') return 'm(maj7)';
    /* minor seven 1 b3 5 7 */
    if (sequence == '1 b3 b7') return 'm7';
    /* dominant seven 1 b3 5 7 */
    if (sequence == '1 3 b7') return '7';
    /* major sixth 1 b3 6 */
    if (sequence == '1 3 6') return '6';
    /* minor sixth 1 b3 6 */
    if (sequence == '1 b3 6') return 'm6';
    /* diminished seven 1 b3 b5 6 */
    if (sequence == '1 b3 b5 6') return 'dim7';
    return '';
  }
}

/*
<?php

class ChordIdentifier {
    private static $chordLibrary = [
        // Triadi Base
        'Major'             => [0, 4, 7],
        'Minor'             => [0, 3, 7],
        
        // --- ACCORDI SUSPENDED ---
        'Sus2'              => [0, 2, 7], // La terza è sostituita dalla seconda
        'Sus4'              => [0, 5, 7], // La terza è sostituita dalla quarta
        '7sus4'             => [0, 5, 7, 10], // Settima di dominante con quarta sospesa
        
        // Accordi di Settima
        'Major 7'           => [0, 4, 7, 11],
        'Dominant 7'        => [0, 4, 7, 10],
        'Minor 7'           => [0, 3, 7, 10],
        
        // Estensioni (Normalizzate modulo 12)
        'Major 9'           => [0, 2, 4, 7, 11],
        'Dominant 9'        => [0, 2, 4, 7, 10],
        'Minor 9'           => [0, 2, 3, 7, 10],
        'Dominant 11'       => [0, 2, 4, 5, 7, 10],
        'Dominant 13'       => [0, 2, 4, 7, 9, 10],
        
        // Altri
        'Diminished'        => [0, 3, 6],
        'Power Chord'       => [0, 7],
    ];

    public static function identify(array $intervals) {
        // 1. Normalizzazione Modulo 12 (gestisce note su ottave diverse)
        $normalized = array_map(fn($n) => $n % 12, $intervals);

        // 2. Pulizia: rimuove duplicati e ordina in modo crescente
        sort($normalized);
        $normalized = array_values(array_unique($normalized));

        // 3. Confronto con la libreria
        foreach (self::$chordLibrary as $name => $pattern) {
            sort($pattern);
            if ($normalized === $pattern) {
                return $name;
            }
        }

        // 4. Gestione Fallback (opzionale): Se non trova nulla, 
        // potrebbe essere un rivolto o un accordo con note mancanti.
        return "Accordo non identificato (" . implode(',', $normalized) . ")";
    }
}

// --- ESEMPI DI TEST ---

// Test Sus4: Tonica (0), Quarta Giusta (5), Quinta Giusta (7)
echo "Test Sus4: " . ChordIdentifier::identify([0, 5, 7]) . "\n"; 
// Output: Sus4

// Test 7sus4: Tonica (0), Quarta (5), Quinta (7), Settima Minore (10)
echo "Test 7sus4: " . ChordIdentifier::identify([0, 10, 5, 7]) . "\n"; 
// Output: 7sus4

// Test Sus2: Tonica (0), Seconda Maggiore (2), Quinta Giusta (7)
echo "Test Sus2: " . ChordIdentifier::identify([0, 2, 7]) . "\n"; 
// Output: Sus2
*/
