import 'package:flutter/foundation.dart';

class CompleteCheckerNotifier extends ChangeNotifier
    implements ValueListenable<bool> {
  final bool Function() _checkerCallback;
  late bool _isChecked = false;

  CompleteCheckerNotifier(this._checkerCallback) {
    _isChecked = _checkerCallback();
  }

  @override
  bool get value => _isChecked;

  void checkIsDataCompleted() {
    bool currentCheck = _checkerCallback();

    if (_isChecked != currentCheck) {
      _isChecked = currentCheck;
      notifyListeners();
    }
  }
}
