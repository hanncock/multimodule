import 'package:flutter/material.dart';

class SettingsDash extends StatefulWidget {
  const SettingsDash({super.key});

  @override
  State<SettingsDash> createState() => _SettingsDashState();
}

class _SettingsDashState extends State<SettingsDash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('this is the dash for settings'),
    );
  }
}
