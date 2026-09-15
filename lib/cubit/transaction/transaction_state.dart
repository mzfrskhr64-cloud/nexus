import 'package:nexus/models/transaction_model.dart';

class TransactionState {
  final bool isLoading;
  final List<TransactionModel> transactions;
  final String? errorMessage;

  const TransactionState({
    this.isLoading = false,
    this.transactions = const [],
    this.errorMessage,
  });
}