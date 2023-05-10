import 'package:flutter/foundation.dart';

class ProviderSelection with ChangeNotifier {
  String _generation = "";
  // String _type = "";
  int _nFilas = 1;
  int _typeView = 0;

  String get generation => _generation;
  int get nFila => _nFilas;
  int get typeView => _typeView;
  //String get type => _type;

  Future<void> setGeneration({@required value}) async {
    _generation = value;
    // _type = value2;
    notifyListeners();
  }

  Future<void> setNFilas({@required value}) async {
    _nFilas = value;
    notifyListeners();
  }

  Future<void> setTypeView({@required value}) async {
    _typeView = value;
    notifyListeners();
  }
}
