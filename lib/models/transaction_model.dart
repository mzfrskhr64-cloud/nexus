class TransactionModel {
  final int? id;
  final int partnerId;
  final double amount;
  final String type;
  final DateTime date;
  final String? notes;
  final bool isArchived;

  const TransactionModel({
    this.id,
    required this.partnerId,
    required this.amount,
    required this.type,
    required this.date,
    this.notes,
    this.isArchived = false,
  });
}