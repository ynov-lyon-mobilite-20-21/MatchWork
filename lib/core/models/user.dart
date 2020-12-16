class User {
  String uid;
  String firstName;
  String lastName;
  String pictureUrl;
  String phoneNumber;
  String mail;

  User(
      {this.uid,
      this.firstName,
      this.lastName,
      this.mail,
      this.phoneNumber,
      this.pictureUrl});

  String displayName() =>
      this.lastName.toUpperCase() +
      ' ' +
      this.firstName[0].toUpperCase() +
      this.firstName.substring(1).toLowerCase();
}
