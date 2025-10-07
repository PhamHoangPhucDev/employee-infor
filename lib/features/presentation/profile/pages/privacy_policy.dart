import 'package:flutter/material.dart';

import '../../../../core/components/appBar_component.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  PrivacyPolicyScreen({super.key,required this.title});
  String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(title: title,),
    );
  }
}