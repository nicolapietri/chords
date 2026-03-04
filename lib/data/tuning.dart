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
    'R',
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

  String getInterval(int string, int fret, String rootNote) {
    if (rootNote == '') return '';
    int start = _notes.indexOf(rootNote);
    int end = _notes.indexOf(getNote(string, fret));
    return _intervals[(end - start) % 12];
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
}
