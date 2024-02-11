import 'package:flutter/material.dart';
import 'package:lab_quiz1/model.dart';

class Names extends ChangeNotifier {
  final List<Name> _names = [];
  List<Name> get names => _names;

  void isFav(Name name) {
    name.isFavorite = !name.isFavorite;
    notifyListeners();
  }

  void add(Name p) {
    _names.add(p);
    notifyListeners();
  }
}
