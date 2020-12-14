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
  List<String> pendingLoanApprovalsRequests;
  List<String> pendingPaybackConfirmations;
  int pendingLoanApprovalsRequestsCount;
  int pendingPaybackConfirmationsCount;
  double totalAmountLended;
  double totalAmountOwed;
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
      this.pendingLoanApprovalsRequests,
      this.pendingLoanApprovalsRequestsCount,
      this.pendingPaybackConfirmations,
      this.pendingPaybackConfirmationsCount,
      this.totalAmountLended,
      this.totalAmountOwed,
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
    print(this.friendList);
    print(this.friendsLended);
    print(this.friendsOwed);
    print(this.pendingLoanApprovalsRequests);
    print(this.pendingLoanApprovalsRequestsCount);
    print(this.pendingPaybackConfirmations);
    print(this.pendingPaybackConfirmationsCount);
    print(this.totalAmountLended);
    print(this.totalAmountOwed);
    print(this.totalFriendsLended);
    print(this.totalFriendsOwed);
    print(this.totalRequests);
  }
}
