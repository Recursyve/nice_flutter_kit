import "package:nice_flutter_kit/nice_flutter_kit.dart";

/// Provider that will be used by [NiceSignInCubit]
/// The [SocialProviders] can be anything, but an enum works best
abstract class NiceSignInProvider<SocialProviders> {
  /// Called when the user signs in with email / password
  /// Returns true if it was successful, and false otherwise
  ///
  /// The implementation is responsible for storing the token
  Future<bool> signInWithPassword(String email, String password);

  /// Called when the user signs in with a social provider
  ///
  /// Them implementation is responsible for storing the token
  Future<bool> signInWithSocialProvider(SocialProviders socialProviders);
}
