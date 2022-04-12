import 'package:example/pages/auth/auth.page.dart';
import 'package:example/pages/home.page.dart';
import 'package:example/pages/onboarding.page.dart';
import 'package:example/pages/page-view-form.page.dart';
import 'package:example/pages/radio-expandable-cards.page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NiceConfig.setup(
    onboardingConfig: NiceOnboardingGlobalConfig(),
    baseCubitConfig: NiceBaseCubitConfig(
      wrapErrorHandler: (e, s) {
        print(e);
        print(s);
      },
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const pageRoutes = <RouteData>[
    RouteData(
      path: "/onboarding",
      title: "Onboarding",
      child: OnboardingPage(),
    ),
    RouteData(
      path: "/page-view-form",
      title: "Page view form",
      child: PageViewFormPage(),
    ),
    RouteData(
      path: "/auth",
      title: "Auth",
      child: AuthPage(),
    ),
    RouteData(
      path: "/radio-expandable-cards",
      title: "Radio expandable cards",
      child: RadioExpandableCardsPage(),
    ),
  ];

  final _router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (_, __) => const HomePage(),
      ),
      for (final route in pageRoutes)
        GoRoute(
          path: route.path,
          builder: (_, __) => route.child,
        ),
    ],
  );

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class RouteData {
  final String path;
  final String title;
  final Widget child;

  const RouteData({
    required this.path,
    required this.title,
    required this.child,
  });
}
