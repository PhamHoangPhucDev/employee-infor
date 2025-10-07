import 'package:flutter/material.dart';

import '../../../../core/components/appBar_component.dart';
import '../widgets/item_settingNotifiSwitchTile.dart';

class SettingNotifiScreen extends StatefulWidget {
  SettingNotifiScreen({super.key, required this.title});
  final String title;

  @override
  State<SettingNotifiScreen> createState() => _SettingNotifiScreenState();
}

class _SettingNotifiScreenState extends State<SettingNotifiScreen> {
  bool generalNotification = true;
  bool soundEnabled = false;
  bool callSoundEnabled = true;
  bool vibrateEnabled = true;

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        "title": "Thông Báo Chung",
        "value": generalNotification,
        "onChanged": (bool val) =>
            setState(() => generalNotification = val),
      },
      {
        "title": "Âm Thanh",
        "value": soundEnabled,
        "onChanged": (bool val) => setState(() => soundEnabled = val),
      },
      {
        "title": "Âm Thanh Cuộc Gọi",
        "value": callSoundEnabled,
        "onChanged": (bool val) =>
            setState(() => callSoundEnabled = val),
      },
      {
        "title": "Rung",
        "value": vibrateEnabled,
        "onChanged": (bool val) => setState(() => vibrateEnabled = val),
      },
    ];

    return Scaffold(
      appBar: AppBarComponent(title: widget.title),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(10),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = items[index];
                  return ItemSettingNotifiSwitchTile(
                    title: item["title"] as String,
                    value: item["value"] as bool,
                    onChanged: item["onChanged"] as Function(bool),
                  );
                },
                childCount: items.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
