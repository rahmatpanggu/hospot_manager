import 'package:flutter/material.dart';

class HotspotToggle extends StatelessWidget {
  final bool isOn;
  final VoidCallback onToggle;

  const HotspotToggle({
    Key? key,
    required this.isOn,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Status Hotspot',
            style: TextStyle(fontSize: 16),
          ),
          Switch(
            value: isOn,
            onChanged: (_) => onToggle(),
            activeColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}