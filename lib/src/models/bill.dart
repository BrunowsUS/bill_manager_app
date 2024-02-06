class Bill {
  final String name;
  final DateTime dueDate;
  final double amount;
  bool isPaid;
  bool isExpired; // Novo campo

  Bill({
    required this.name,
    required this.dueDate,
    required this.amount,
    this.isPaid = false,
    this.isExpired = false, // Inicialize como false
  });
}