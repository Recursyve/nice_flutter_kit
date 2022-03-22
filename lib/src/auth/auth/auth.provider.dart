abstract class NiceAuthProvider<User extends Object, Account extends Object> {
  const NiceAuthProvider();

  /// Returns the current [User]
  /// If no user is logged in, null should be returned
  Future<User?> getCurrentUser();

  /// Returns the current [Account] linked to the [User]
  /// If no user is logged or the user doesn't have an account, null should be returned
  Future<Account?> getCurrentAccount();

  /// Signs out the current user
  Future<void> signOut();
}
