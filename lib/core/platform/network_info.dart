import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImple implements NetworkInfo {
  final InternetConnectionChecker _checker;

  NetworkInfoImple(this._checker);

  @override
  Future<bool> get isConnected => _checker.hasConnection;
}
