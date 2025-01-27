class User {
  String id;
  String username;
  String name;
  String phoneNumber;

  User(this.id, this.username, this.name, this.phoneNumber);

  factory User.fromMapJson(Map<String, dynamic> jsonObject) {
    return User(
      jsonObject['id'],
      jsonObject['username'],
      jsonObject['name'],
      jsonObject['phoneNumber'],
    );
  }
}
