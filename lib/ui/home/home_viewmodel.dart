import 'package:stacked/stacked.dart';

class HomeViewmodel extends BaseViewModel {
  List<String> static = ['abc ', 'dsd', 'dfd'];

  int _currentPage = 0;

  int get currentPage => _currentPage;

  void onPageChanged(int index) {
    _currentPage = index;
    notifyListeners();
  }
}
