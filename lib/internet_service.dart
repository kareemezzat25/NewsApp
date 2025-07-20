import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class InternetService {
  InternetService._internal();
  static final InternetService _instance = InternetService._internal();
  factory InternetService() => _instance;

  StreamController<bool> streamControllerConnection =
      StreamController<bool>.broadcast();

  Stream<bool> connectionStream() => streamControllerConnection.stream;

  final Connectivity _connectivity = Connectivity();

  Future<bool> checkConnectivity() async {
    List<ConnectivityResult> result = await _connectivity.checkConnectivity();
    return updateInternetConnection(result);
  }

  bool updateInternetConnection(List<ConnectivityResult> result) {
    bool isConnected = true;

    for (var data in result) {
      if (data == ConnectivityResult.none) {
        isConnected = false;
      }
    }

    streamControllerConnection.add(isConnected);
    debugPrint("Has Internet $isConnected");
    return isConnected;
  }

  void init() {
    _connectivity.onConnectivityChanged.listen(
      (event) {
        updateInternetConnection(event);
      },
    );
  }

  void dispose() {
    streamControllerConnection.close();
  }
}
