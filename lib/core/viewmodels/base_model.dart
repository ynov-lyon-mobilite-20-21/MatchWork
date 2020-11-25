import 'package:flutter/foundation.dart';

class BaseModel extends ChangeNotifier {
  bool _busy = false;

  bool get busy => _busy;

  set busy(bool value) {
    _busy = value;
    notifyListeners();
  }
}
