class LoanModel {
  String loanFrom;
  String loanTo;
  String status;
  int amount;
  int tenure;
  String date;

  LoanModel({
    this.loanFrom,
    this.loanTo,
    this.status,
    this.amount,
    this.tenure,
    this.date,
  });

  // ignore: non_constant_identifier_names
  void print_loan() {
    print(this.loanFrom);
    print(this.loanTo);
    print(this.status);
    print(this.amount);
    print(this.tenure);
    print(this.date);
  }
}
