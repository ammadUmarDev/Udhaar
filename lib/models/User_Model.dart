import 'dart:ffi';

class UserModel {
  String userID;
  String fullName;
  String email;
  String createdDate;
  String lastPassChangeDate;
  List<String> friendList;
  List<String> friendsLended;
  List<String> friendsOwed;
  List<String> PendingLoanApprovalsRequests;
  List<String> PendingPaybackConfirmations;
  int PendingLoanApprovalsRequestsCount;
  int PendingPaybackConfirmationsCount;
  Float TotalAmountLended;
  Float TotalAmountOwed;
  int totalFriendsLended;
  int totalFriendsOwed;
  int totalFriends;
  int totalRequests;

  UserModel(
      {this.userID,
      this.fullName,
      this.email,
      this.createdDate,
      this.lastPassChangeDate,
      this.friendList,
      this.friendsLended,
      this.friendsOwed,
      this.PendingLoanApprovalsRequests,
      this.PendingLoanApprovalsRequestsCount,
      this.PendingPaybackConfirmations,
      this.PendingPaybackConfirmationsCount,
      this.TotalAmountLended,
      this.TotalAmountOwed,
      this.totalFriends,
      this.totalFriendsLended,
      this.totalFriendsOwed,
      this.totalRequests});

  // ignore: non_constant_identifier_names
  void print_user() {
    print(this.userID);
    print(this.fullName);
    print(this.email);
    print(this.createdDate);
    print(this.lastPassChangeDate);
  }
}
