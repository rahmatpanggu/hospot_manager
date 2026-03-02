import 'package:flutter/material.dart';

class ConfigForm extends StatefulWidget {
  final String initialSsid;
  final String initialPassword;
  final Function(String, String) onSave;

  const ConfigForm({
    Key? key,
    required this.initialSsid,
    required this.initialPassword,
    required this.onSave,
  }) : super(key: key);

  @override
  _ConfigFormState createState() => _ConfigFormState();
}

class _ConfigFormState extends State<ConfigForm> {
  late TextEditingController _ssidController;
  late TextEditingController _passwordController;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _ssidController = TextEditingController(text: widget.initialSsid);
    _passwordController = TextEditingController(text: widget.initialPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _ssidController,
          decoration: InputDecoration(
            labelText: 'Nama Jaringan (SSID)',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.wifi),
          ),
        ),
        SizedBox(height: 16),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            labelText: 'Password (min. 8 karakter)',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.lock),
          ),
          obscureText: true,
        ),
        SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _isSaving ? null : () async {
              setState(() => _isSaving = true);
              
              String ssid = _ssidController.text.trim();
              String password = _passwordController.text.trim();
              
              if (ssid.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Nama jaringan tidak boleh kosong')),
                );
                setState(() => _isSaving = false);
                return;
              }
              
              await widget.onSave(ssid, password);
              
              setState(() => _isSaving = false);
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
            child: _isSaving
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text('SIMPAN KONFIGURASI'),
          ),
        ),
      ],
    );
  }
}