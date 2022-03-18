abstract class NiceLoginProvider<SocialProviders> {
  Future<bool> loginWithPassword(String email, String password);

  Future<void> loginWithProvider(SocialProviders socialProviders);
}
