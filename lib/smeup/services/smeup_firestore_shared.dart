import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';

class SmeupFirestoreShared {
  static Future<Source> getSource() async {
    final bool onValue = await isInternetOn();
    if (onValue) {
      return Source.server;
    } else {
      return Source.cache;
    }
  }

  static Future<bool> isInternetOn() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    switch (connectivityResult) {
      case ConnectivityResult.none:
        return false;
      default:
        return true;
    }
  }
}
