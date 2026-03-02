import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/hotspot_service.dart';
import '../widgets/hotspot_toggle.dart';
import '../widgets/config_form.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  bool _isHotspotOn = false;
  String _ssid = '';
  String _password = '';
  List<String> _connectedDevices = [];
  String _message = '';

  @override
  void initState() {
    super.initState();
    _loadStatus();
  }

  Future<void> _loadStatus() async {
    setState(() => _isLoading = true);
    
    bool isRunning = await HotspotService.isHotspotRunning();
    Map<String, String> config = await HotspotService.getCurrentConfig();
    List<String> devices = await HotspotService.getConnectedDevices();
    
    setState(() {
      _isHotspotOn = isRunning;
      _ssid = config['ssid'] ?? '';
      _password = config['password'] ?? '';
      _connectedDevices = devices;
      _isLoading = false;
    });
  }

  Future<void> _toggleHotspot() async {
    String result;
    
    if (_isHotspotOn) {
      result = await HotspotService.stopHotspot();
    } else {
      result = await HotspotService.startHotspot();
    }
    
    setState(() {
      _message = result;
    });
    
    _loadStatus();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result)),
    );
  }

  Future<void> _saveConfig(String ssid, String password) async {
    String result = await HotspotService.setHotspotConfig(ssid, password);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result)),
    );
    
    if (result.startsWith('SUCCESS')) {
      setState(() {
        _ssid = ssid;
        _password = password;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotspot Manager'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadStatus,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status Card
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          HotspotToggle(
                            isOn: _isHotspotOn,
                            onToggle: _toggleHotspot,
                          ),
                          SizedBox(height: 16),
                          if (_isHotspotOn)
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.green),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.wifi, color: Colors.green),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Hotspot AKTIF dengan nama: $_ssid',
                                      style: TextStyle(color: Colors.green.shade900),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          else
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.wifi_off, color: Colors.grey),
                                  SizedBox(width: 8),
                                  Text('Hotspot sedang MATI'),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 16),
                  
                  // Konfigurasi Form
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pengaturan Hotspot',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          ConfigForm(
                            initialSsid: _ssid,
                            initialPassword: _password,
                            onSave: _saveConfig,
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 16),
                  
                  // Perangkat Terhubung
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Perangkat Terhubung (${_connectedDevices.length})',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          if (_connectedDevices.isEmpty)
                            Center(
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Text('Belum ada perangkat terhubung'),
                              ),
                            )
                          else
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: _connectedDevices.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: Icon(Icons.devices),
                                  title: Text(_connectedDevices[index]),
                                  dense: true,
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}