import "package:example/cubit/app.cubit.dart";
import "package:example/main.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            for (final route in MyApp.pageRoutes)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16)),
                  onPressed: () => context.push(route.path),
                  child: Text(
                    context.translate(route.titleKey),
                  ),
                ),
              ),
            const SizedBox(height: 32),
            _buildLocaleSelector(),
          ],
        ),
      ),
    );
  }

  Widget _buildLocaleSelector() {
    return Builder(
      builder: (context) => DropdownButtonFormField(
        value: NiceLocalizations.of(context).locale,
        items: [
          for (final locale in NiceLocalizations.supportedLocales)
            DropdownMenuItem(
              value: locale,
              child: Text(locale.languageCode),
            ),
        ],
        onChanged: (locale) {
          if (locale != null) {
            context.read<AppCubit>().setOverrideLocale(locale);
          }
        },
      ),
    );
  }
}
