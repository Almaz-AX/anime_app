import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo{

  final connectivityResultFuture = Connectivity().checkConnectivity();

  @override
  Future<bool> get isConnected async {
    final connectivityResult = await connectivityResultFuture;
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi ){
      return Future.value(true);
    }
    return Future.value(false);
  }

}