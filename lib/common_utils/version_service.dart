import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VersionCheckService {
  static const String _versionKey = 'app_version';

  Future<bool> isAppUpdated(bool isFirstTime) async {
    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = "${packageInfo.version}(${packageInfo.buildNumber})";
    print(currentVersion);
    final prefs = await SharedPreferences.getInstance();
    if (!isFirstTime) {
      await prefs.setString(_versionKey, currentVersion);
    }

    final storedVersion = prefs.getString(_versionKey);

    if (storedVersion != currentVersion) {

      return true; // Indicates that the app has been updated
    }

    return false; // No update, go to HomeScreen
  }
}
