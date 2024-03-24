// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Stream<bool> get watchConnection;
}

class NetworkInfoImpl implements NetworkInfo {
  final StreamController<bool> controller = StreamController<bool>.broadcast();
  final connectivityResultFuture = Connectivity().checkConnectivity();
  late final StreamSubscription<ConnectivityResult> subscription;
  NetworkInfoImpl() {
    subscription =
        Connectivity().onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.none) {
        controller.sink.add(false);
      } else {
        controller.sink.add(true);
      }
    });
  }

  @override
  Stream<bool> get watchConnection {
    return controller.stream;
  }
}
