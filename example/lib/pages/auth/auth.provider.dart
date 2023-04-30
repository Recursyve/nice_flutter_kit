import "package:collection/collection.dart" show IterableExtension;
import "package:nice_flutter_kit/nice_flutter_kit.dart";

class User {
  final String userId;
  final String email;
  final String password;

  const User({
    required this.userId,
    required this.email,
    required this.password,
  });
}

class Account {
  final String userId;
  final String name;

  const Account({
    required this.userId,
    required this.name,
  });
}

class AuthProvider implements NiceAuthProvider<User, Account> {
  const AuthProvider();

  static User? currentUser;

  static const users = [
    User(userId: "aoeu", email: "foo@bar.dev", password: "123456Ab"),
    User(userId: "123", email: "test@test.com", password: "123456aB"),
  ];

  static const accounts = [
    Account(userId: "aoeu", name: "Foobar"),
  ];

  @override
  Future<User?> getCurrentUser() async {
    await Future.delayed(const Duration(seconds: 1));
    return currentUser;
  }

  @override
  Future<Account?> getCurrentAccount() async {
    await Future.delayed(const Duration(seconds: 1));
    if (currentUser == null) {
      return null;
    }

    return accounts.firstWhereOrNull((account) => account.userId == currentUser!.userId);
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(seconds: 1));
    currentUser = null;
  }
}
