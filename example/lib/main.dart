import 'package:device_preview/device_preview.dart';
import 'package:example/pages/auth/auth.page.dart';
import 'package:example/pages/base-list/infinite-scroll-base-list.page.dart';
import 'package:example/pages/base-list/paginated-base-list.page.dart';
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

  runApp(
    DevicePreview(
      builder: (_) => MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
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
    RouteData(
      path: "/base-list/infinite-scroll",
      title: "Infinite scroll base list",
      child: InfiniteScrollLoadedBaseListPage(),
    ),
    RouteData(
      path: "/base-list/paginated",
      title: "Paginated base list",
      child: PaginatedBaseListPage(),
    ),
  ];

  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (_, __) => const HomePage(),
      ),
      for (final route in MyApp.pageRoutes)
        GoRoute(
          path: route.path,
          builder: (_, __) => route.child,
        ),
    ],
  );

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
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      supportedLocales: NiceLocalizations.supportedLocales,
      localizationsDelegates: NiceLocalizations.delegates,
      localeResolutionCallback: NiceLocalizations.localResolutionCallback,
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
