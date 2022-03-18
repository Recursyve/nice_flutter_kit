abstract class NiceAuthProvider<User extends Object, Account extends Object> {
  Future<User> getUser();

  Future<Account> getAccount();

  Future<void> signOut();
}
