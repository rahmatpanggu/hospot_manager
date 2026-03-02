import 'dart:io';

class HotspotService {
  // Cek status hotspot
  static Future<bool> isHotspotRunning() async {
    try {
      ProcessResult result = await Process.run(
        'netsh',
        ['wlan', 'show', 'hostednetwork'],
        runInShell: true,
      );
      
      return result.stdout.toString().contains('Status                 : Started');
    } catch (e) {
      return false;
    }
  }

  // Nyalakan hotspot
  static Future<String> startHotspot() async {
    try {
      ProcessResult result = await Process.run(
        'netsh',
        ['wlan', 'start', 'hostednetwork'],
        runInShell: true,
      );
      
      if (result.exitCode == 0) {
        return 'SUCCESS: Hotspot dinyalakan';
      } else {
        return 'ERROR: ${result.stderr}';
      }
    } catch (e) {
      return 'ERROR: $e';
    }
  }

  // Matikan hotspot
  static Future<String> stopHotspot() async {
    try {
      ProcessResult result = await Process.run(
        'netsh',
        ['wlan', 'stop', 'hostednetwork'],
        runInShell: true,
      );
      
      if (result.exitCode == 0) {
        return 'SUCCESS: Hotspot dimatikan';
      } else {
        return 'ERROR: ${result.stderr}';
      }
    } catch (e) {
      return 'ERROR: $e';
    }
  }

  // Set konfigurasi hotspot
  static Future<String> setHotspotConfig(String ssid, String password) async {
    if (password.length < 8) {
      return 'ERROR: Password minimal 8 karakter';
    }
    
    try {
      ProcessResult result = await Process.run(
        'netsh',
        ['wlan', 'set', 'hostednetwork', 'mode=allow', 'ssid=$ssid', 'key=$password'],
        runInShell: true,
      );
      
      if (result.exitCode == 0) {
        return 'SUCCESS: Konfigurasi berhasil disimpan';
      } else {
        return 'ERROR: ${result.stderr}';
      }
    } catch (e) {
      return 'ERROR: $e';
    }
  }

  // Dapatkan konfigurasi saat ini
  static Future<Map<String, String>> getCurrentConfig() async {
    try {
      ProcessResult result = await Process.run(
        'netsh',
        ['wlan', 'show', 'hostednetwork'],
        runInShell: true,
      );
      
      String output = result.stdout;
      
      String ssid = '';
      String password = '';
      
      RegExp ssidRegex = RegExp(r'SSID name\s+:\s"(.+)"');
      RegExp passRegex = RegExp(r'Passphrase\s+:\s(.+)');
      
      var ssidMatch = ssidRegex.firstMatch(output);
      var passMatch = passRegex.firstMatch(output);
      
      if (ssidMatch != null) ssid = ssidMatch.group(1) ?? '';
      if (passMatch != null) password = passMatch.group(1) ?? '';
      
      return {'ssid': ssid, 'password': password};
    } catch (e) {
      return {'ssid': '', 'password': ''};
    }
  }

  // Dapatkan daftar perangkat terhubung
  static Future<List<String>> getConnectedDevices() async {
    List<String> devices = [];
    
    try {
      ProcessResult result = await Process.run(
        'netsh',
        ['wlan', 'show', 'hostednetwork'],
        runInShell: true,
      );
      
      String output = result.stdout;
      
      // Parse MAC addresses
      RegExp macRegex = RegExp(r'([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})');
      Iterable<Match> matches = macRegex.allMatches(output);
      
      for (var match in matches) {
        devices.add(match.group(0) ?? '');
      }
    } catch (e) {
      print('Error getting devices: $e');
    }
    
    return devices;
  }
}