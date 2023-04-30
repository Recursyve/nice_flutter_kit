import "package:collection/collection.dart" show IterableExtension;
import "package:example/pages/auth/auth.provider.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

enum SocialProviders {
  GitHub,
}

class SignInProvider implements NiceSignInProvider<SocialProviders> {
  const SignInProvider();

  @override
  Future<bool> signInWithPassword(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    AuthProvider.currentUser = AuthProvider.users.firstWhereOrNull(
      (user) => user.email == email && user.password == password,
    );
    return AuthProvider.currentUser != null;
  }

  @override
  Future<bool> signInWithSocialProvider(SocialProviders socialProvider) {
    throw UnimplementedError();
  }
}
