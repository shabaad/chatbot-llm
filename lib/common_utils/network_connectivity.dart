import 'dart:io';

import 'common_methods.dart';


class NetworkConnectivity{
  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
  Future<bool> checkInternetConnection() async{
    if(await hasNetwork())
      {
        return true;
      }
    else
      {
        noInternetDialog();
        return false;
      }
  }
}
