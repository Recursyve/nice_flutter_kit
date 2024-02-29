import "package:device_preview/device_preview.dart";
import "package:example/cubit/app.cubit.dart";
import "package:example/cubit/app.state.dart";
import "package:example/pages/auth/auth.page.dart";
import "package:example/pages/base-list/infinite-scroll-base-list.page.dart";
import "package:example/pages/base-list/paginated-base-list.page.dart";
import "package:example/pages/home.page.dart";
import "package:example/pages/onboarding.page.dart";
import "package:example/pages/page-view-form.page.dart";
import "package:example/pages/radio-expandable-cards.page.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NiceConfig.setup(
    baseCubitConfig: NiceBaseCubitConfig(
      wrapErrorHandler: (e, s) {
        // ignore: avoid_print
        print(e);
        // ignore: avoid_print
        print(s);
      },
    ),
    localizationsConfig: const NiceLocalizationsConfig(),
  );

  runApp(
    DevicePreview(
      builder: (_) => const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  static const pageRoutes = <RouteData>[
    RouteData(
      path: "/onboarding",
      titleKey: "home.pages.onboarding",
      child: OnboardingPage(),
    ),
    RouteData(
      path: "/page-view-form",
      titleKey: "home.pages.page_view_form",
      child: PageViewFormPage(),
    ),
    RouteData(
      path: "/auth",
      titleKey: "home.pages.auth",
      child: AuthPage(),
    ),
    RouteData(
      path: "/radio-expandable-cards",
      titleKey: "home.pages.radio_expandable_cards",
      child: RadioExpandableCardsPage(),
    ),
    RouteData(
      path: "/base-list/infinite-scroll",
      titleKey: "home.pages.infinite_scroll_base_list",
      child: InfiniteScrollLoadedBaseListPage(),
    ),
    RouteData(
      path: "/base-list/paginated",
      titleKey: "home.pages.paginated_base_list",
      child: PaginatedBaseListPage(),
    ),
  ];

  const MyApp({super.key});

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
    return BlocProvider<AppCubit>(
      create: (context) => AppCubit(),
      child: BlocSelector<AppCubit, AppState, Locale?>(
        selector: (state) => state.overrideLocale,
        builder: (context, overrideLocale) => MaterialApp.router(
          routerConfig: _router,
          title: "Flutter Demo",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          locale: overrideLocale ?? DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          supportedLocales: NiceLocalizations.supportedLocales,
          localizationsDelegates: NiceLocalizations.delegates,
          localeResolutionCallback: NiceLocalizations.localResolutionCallback,
        ),
      ),
    );
  }
}

class RouteData {
  final String path;
  final String titleKey;
  final Widget child;

  const RouteData({
    required this.path,
    required this.titleKey,
    required this.child,
  });
}
