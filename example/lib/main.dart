import 'package:flutter/material.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NiceConfig.setup(
    onboardingConfig: NiceOnboardingGlobalConfig(),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NiceOnboarding(
        configuration: NiceOnboardingConfiguration(
          welcome: NiceOnboardingWelcomeConfiguration(
            imageUrl: "assets/bacon.png",
            title: NiceTextAccentPunctuation(
              text: "Bacon ipsum",
              punctuation: ".",
            ),
            paragraph:
                "Bacon ipsum dolor amet kevin pork belly biltong, burgdoggen frankfurter pastrami t-bone meatball bacon hamburger turkey.",
            bottomButtonText: "Ipsum",
          ),
        ),
        child: Scaffold(
          body: Container(
            child: const Center(
              child: Text("Hello  World!"),
            ),
          ),
        ),
      ),
    );
  }
}
