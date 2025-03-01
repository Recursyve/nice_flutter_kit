import "package:example/pages/auth/auth.provider.dart";
import "package:example/pages/auth/sign-in.provider.dart";
import "package:example/pages/common/base.page.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Auth",
      child: Center(
        child: NiceAuth<User, Account>(
          authProvider: const AuthProvider(),
          child: BlocBuilder<NiceAuthCubit<User, Account>, NiceAuthState<User, Account>>(
            buildWhen: (prev, curr) => prev.isSignedIn != curr.isSignedIn || prev.isRegistered != curr.isRegistered,
            builder: (context, state) {
              if (state.isSignedIn) {
                return NiceAnimatedFadeIn(
                  key: UniqueKey(),
                  duration: const Duration(milliseconds: 200),
                  child: Column(
                    children: [
                      if (state.isRegistered)
                        const Text("Signed in and registered")
                      else
                        const Text("Signed in and not registered"),
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
        child: const NiceSignIn<SocialProviders, User, Account>(
          signInProvider: SignInProvider(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              NiceSignInEmailField<SocialProviders>(
                decoration: InputDecoration(
                  label: Text("Email"),
                ),
              ),
              SizedBox(height: 32),
              NiceSignInPasswordField<SocialProviders>(
                decoration: InputDecoration(
                  label: Text("Password"),
                ),
              ),
              SizedBox(height: 16),
              NiceSignInErrors<SocialProviders>(
                errorText: "Invalid credentials",
                invalidCredentialsText: "Invalid credentials",
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(height: 16),
              NiceSignInEmailPasswordButton<SocialProviders>(
                type: NiceButtonTypes.Elevated,
                text: "Sign in",
                loadingLineColor: Colors.white,
                loadingLineWidth: 2,
              ),
              SizedBox(height: 64),
              NiceSignInSocialButton<SocialProviders>(
                socialProvider: SocialProviders.GitHub,
                type: NiceButtonTypes.Outlined,
                icon: Icon(Icons.code),
                child: Text("GitHub"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignOutButton() {
    return BlocBuilder<NiceAuthCubit<User, Account>, NiceAuthState<User, Account>>(
      builder: (context, state) => ElevatedButton(
        onPressed: state.loading ? null : NiceAuthCubit.of<User, Account>(context).signOut,
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
