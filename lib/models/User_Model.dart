class UserModel {
  String userID;
  String fullName;
  String email;
  String pass;
  String createdDate;
  String lastPassChangeDate;

  UserModel({
    this.userID,
    this.fullName,
    this.email,
    this.pass,
    this.createdDate,
    this.lastPassChangeDate,
  });

  void print_user() {
    print(this.userID);
    print(this.fullName);
    print(this.email);
    print(this.pass);
    print(this.createdDate);
    print(this.lastPassChangeDate);
  }
}
