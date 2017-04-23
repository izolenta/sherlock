import 'dart:html';
import 'package:angular2/angular2.dart';

@Injectable()
class SoundService {
  void playWaterdrop() {
    new AudioElement("sounds/item_removed.wav").play();
  }

  void playSuccess() {
    new AudioElement("sounds/game_ok.wav").play();
  }

  void playPowerup() {
    new AudioElement("sounds/cell_opened.wav").play();
  }
}