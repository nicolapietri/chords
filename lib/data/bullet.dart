class Bullet {
  Bullet({required this.string, required this.fret});

  int string;
  int fret;
  bool filled = false;
  bool root = false;
  String text = '';
  String interval = '';
  int octave = 0;
  int alternative = 0;
}
