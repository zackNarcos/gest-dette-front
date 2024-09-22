import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/repositories/auth/auth_repository.dart';
import '../../widgets/forms/custom_text_field.dart';
import '../../widgets/forms/custom_button.dart';

class AssistanceScreen extends StatelessWidget {

  const AssistanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assistance Screen"),
      ),
      body: const Text("Assistance Screen"),
    );
  }
}