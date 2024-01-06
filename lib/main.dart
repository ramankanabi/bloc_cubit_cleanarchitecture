import 'package:flutter/material.dart';
import 'package:flutter_bloc_course/2_app/pages/advicePage/advice_page.dart';
import 'injection.dart' as di; //di= dependency injection

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.inti();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AdvicePageWrapperProvider(),
    );
  }
}

// helllooo