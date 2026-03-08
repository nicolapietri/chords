import 'package:chords/providers/diagram_provider.dart';

import 'bullet.dart';

class Tuning {
  String first = 'e';
  String second = 'b';
  String third = 'g';
  String fourth = 'd';
  String fifth = 'a';
  String sixth = 'e';
  int capo = 0;
  List _stringNotes = ['e', 'b', 'g', 'd', 'a', 'e'];

  Tuning({
    this.first = 'e',
    this.second = 'b',
    this.third = 'g',
    this.fourth = 'd',
    this.fifth = 'a',
    this.sixth = 'e',
    this.capo = 0,
  }) {
    _stringNotes = [first, second, third, fourth, fifth, sixth];
  }

  final List _notes = [
    'c',
    'c#',
    'd',
    'd#',
    'e',
    'f',
    'f#',
    'g',
    'g#',
    'a',
    'a#',
    'b',
  ];

  final List _notesAlt = [
    ['C'],
    ['C#', 'Db'],
    ['D'],
    ['D#', 'Eb'],
    ['E'],
    ['F'],
    ['F#', 'Gb'],
    ['G'],
    ['G#', 'Ab'],
    ['A'],
    ['A#', 'Bb'],
    ['B'],
  ];

  final List _intervals = [
    '1',
    'b2',
    '2',
    'b3',
    '3',
    '4',
    'b5',
    '5',
    'b6',
    '6',
    'b7',
    '7',
  ];

  final List _intervalsAlt = [
    ['R'],
    ['b2', 'b9', '#1'],
    ['2', '9'],
    ['b3', '#9', '#2'],
    ['3'],
    ['4', '11'],
    ['#4', 'b5', '#11'],
    ['5'],
    ['b6', 'b13'],
    ['6', '13', 'bb7'],
    ['b7'],
    ['7'],
  ];

  String getNote(int string, int fret) {
    int freeString = _notes.indexOf(_stringNotes[string - 1]);

    return _notes[(freeString + fret + capo) % 12];
  }

  String getNoteText(Bullet bullet) {
    int freeString = _notes.indexOf(_stringNotes[bullet.string - 1]);
    List alternatives = _notesAlt[(freeString + bullet.fret + capo) % 12];

    if (bullet.alternative >= alternatives.length) {
      return 'x';
    }

    return alternatives[bullet.alternative];
  }

  int getRootOctave(DiagramProvider diagram) {
    /* search lower octave of root */
    int lowerOctave = 6;
    int octave;
    for (Bullet bullet in diagram.items) {
      if (bullet.root) {
        octave = diagram.tuning.getOctave(bullet.string, bullet.fret);
        if (octave < lowerOctave) lowerOctave = octave;
      }
    }
    return lowerOctave;
  }

  int getOctave(int string, int fret) {
    int octave;
    if (string == 6 || string == 5) {
      octave = 2;
    } else if (string == 4 || string == 3 || string == 2) {
      octave = 3;
    } else {
      octave = 4;
    }
    for (int i = 1; i <= fret; i++) {
      if (getNote(string, i) == 'c') octave++;
    }
    return octave;
  }

  String getInterval(int string, int fret, String rootNote) {
    if (rootNote == '') return '';
    int start = _notes.indexOf(rootNote);
    int end = _notes.indexOf(getNote(string, fret));
    return _intervals[(end - start) % 12];
  }

  List<String> getAllIntervals(DiagramProvider diagram) {
    if (diagram.root == '') return [];

    int rootOctave = getRootOctave(diagram);

    List<String> all = ['1'];
    String interval;
    for (Bullet bullet in diagram.items) {
      if (bullet.fret > 0 ||
          (bullet.fret == 0 && bullet.alternative == 0 && capo == 0)) {
        int octave = getOctave(bullet.string, bullet.fret);

        interval = getInterval(bullet.string, bullet.fret, diagram.root);
        if (!all.contains(interval) && interval != '') {
          /* check for 9th extensions */
          if (interval == '2' && octave > rootOctave) interval = '9';
          if (interval == 'b2' && octave > rootOctave) interval = 'b9';
          if (interval == 'b3' && all.contains('3')) interval = '#9';
          /* check for 11th extensions */
          if (interval == '4' && octave > rootOctave) interval = '11';
          if (interval == 'b5' && octave > rootOctave) interval = '#11';
          all.add(interval);
        } else {
          /* check for 9th extensions */
          if (interval == 'b2' && all.contains('b2')) all.add('b9');
          if (interval == '2' && all.contains('2')) all.add('9');
          if (all.contains('3') || all.contains('b3')) {
            if (interval == 'b3' && all.contains('b3')) all.add('#9');
          }
          /* check for 11th extensions */
          if (interval == '4' && all.contains('b2')) all.add('b9');
        }
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

  String getIntervalText(Bullet bullet, String rootNote) {
    int intervalIndex = _intervals.indexOf(
      getInterval(bullet.string, bullet.fret, rootNote),
    );
    List alternatives = _intervalsAlt[intervalIndex];

    if (bullet.alternative >= alternatives.length) {
      return 'x';
    }

    return alternatives[bullet.alternative];
  }

  String getChordNameFromIntervals(List<String> intervals) {
    String mode = intervals.contains('b3') ? 'm' : '';
    String seven = intervals.contains('b7')
        ? '7'
        : (intervals.contains('7') ? 'maj7' : '');
    // extended with 9
    if (intervals.contains('b7') && intervals.contains('9')) {
      seven = '9';
    }
    if (intervals.contains('7') && intervals.contains('9')) {
      seven = 'maj9';
    }
    // extended with 11
    if (intervals.contains('b7') &&
        intervals.contains('9') &&
        intervals.contains('11')) {
      seven = '11';
    }
    return "$mode$seven";
  }
}
