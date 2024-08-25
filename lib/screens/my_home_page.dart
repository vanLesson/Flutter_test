import 'package:flutter/material.dart';
import '../widgets/background.dart';
import '../widgets/center_image.dart';
import '../widgets/form.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: const Stack(
            children: [
              Background(),
              CenterImage(),
              RegistrationForm(),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
