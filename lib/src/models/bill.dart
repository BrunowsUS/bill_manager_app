class Bill {
  final String name;
  final DateTime dueDate;
  final double amount;
  bool isPaid;

  Bill({
    required this.name,
    required this.dueDate,
    required this.amount,
    this.isPaid = false,
  });
}
