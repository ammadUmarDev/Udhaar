class UserModel {
  String userID;
  String fullName;
  String email;
  String createdDate;
  String lastPassChangeDate;
  List<String> friendList;

  UserModel({
    this.userID,
    this.fullName,
    this.email,
    this.createdDate,
    this.lastPassChangeDate,
    this.friendList,
  });

  // ignore: non_constant_identifier_names
  void print_user() {
    print(this.userID);
    print(this.fullName);
    print(this.email);
    print(this.createdDate);
    print(this.lastPassChangeDate);
  }
}
