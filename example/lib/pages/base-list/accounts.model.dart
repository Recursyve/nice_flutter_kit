import "package:faker/faker.dart";

class Accounts {
  static List<Accounts> generatedAccounts = [
    for (int i = 0; i < 200; i++) Accounts.faked(i),
  ];

  final int id;
  final String firstname;
  final String lastname;
  final String userId;

  const Accounts({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.userId,
  });

  factory Accounts.faked(int id) => Accounts(
        id: id,
        firstname: faker.person.firstName(),
        lastname: faker.person.lastName(),
        userId: faker.guid.guid(),
      );

  bool matchesSearchQuery(String searchQuery) {
    final tokens = searchQuery.split(" ");

    return tokens.every(
      (token) => [firstname, lastname, userId].any((property) => property.toLowerCase().contains(token.toLowerCase())),
    );
  }
}
