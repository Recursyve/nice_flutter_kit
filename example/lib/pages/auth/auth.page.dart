import "package:example/pages/common/base.page.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isSignedIn = false;

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Auth",
      child: NiceSignIn(
        child: Center(
          child: Builder(
            builder: (context) {
              if (_isSignedIn) {
                return NiceAnimatedFadeIn(
                  key: UniqueKey(),
                  duration: const Duration(milliseconds: 200),
                  child: Column(
                    children: [
                      const Text("Signed in"),
                      const SizedBox(height: 64),
                      _buildSignOutButton(),
                    ],
                  ),
                );
              }

              return NiceAnimatedFadeIn(
                key: UniqueKey(),
                duration: const Duration(milliseconds: 200),
                child: _buildSignIn(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSignIn() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 350,
        ),
        child: NiceSignInUsernamePassword(
          autofill: true,
          onSignIn: (username, password) async {
            await Future.delayed(const Duration(seconds: 2));

            final valid = username == "foo" && password == "bar";

            if (valid) {
              setState(() {
                _isSignedIn = true;
              });
            }

            return valid;
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Column(
                children: [
                  NiceSignInUsernameField(
                    decoration: InputDecoration(
                      label: Text("Email"),
                    ),
                  ),
                  SizedBox(height: 32),
                  NiceSignInPasswordField(
                    decoration: InputDecoration(
                      label: Text("Password"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const NiceSignInErrors(
                errorText: "Invalid credentials",
                invalidCredentialsText: "Invalid credentials",
                style: TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 16),
              const NiceSignInUsernamePasswordButton(
                type: NiceButtonTypes.Elevated,
                text: "Sign in",
                loadingLineColor: Colors.white,
                loadingLineWidth: 2,
              ),
              const SizedBox(height: 64),
              NiceSignInSocialButton(
                onSignIn: (context) async {
                  await Future.delayed(const Duration(seconds: 2));

                  setState(() {
                    _isSignedIn = true;
                  });

                  return true;
                },
                type: NiceButtonTypes.Outlined,
                icon: const Icon(Icons.code),
                child: const Text("GitHub"),
              ),
              const SizedBox(height: 32),
              NiceSignInSocialButton(
                onSignIn: (context) async {
                  await Future.delayed(const Duration(seconds: 2));

                  return false;
                },
                type: NiceButtonTypes.Outlined,
                icon: const Icon(Icons.code),
                child: const Text("Google"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignOutButton() {
    return BlocBuilder<NiceSignInCubit, NiceSignInState>(
      builder: (context, state) => ElevatedButton(
        onPressed: switch (state.loading) {
          false => () => setState(() => _isSignedIn = false),
          _ => null,
        },
        child: NiceLoadingOverlay(
          loading: state.loading,
          color: Colors.white,
          lineWidth: 2,
          child: Visibility(
            visible: !state.loading,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: const Text("Sign out"),
          ),
        ),
      ),
    );
  }
}
