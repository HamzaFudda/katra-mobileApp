import '../helper/my_connectivity.dart';

class BaseRepo {
  final connectivity = MyConnectivity.instance;

  BaseRepo() {
    connectivity.initialise();
  }
}
