import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexus/models/transaction_model.dart';

import 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(const TransactionState());

  void addTransaction(TransactionModel transaction) {
    final newTransaction = TransactionModel(
      id: transaction.id ?? DateTime.now().microsecondsSinceEpoch,
      partnerId: transaction.partnerId,
      amount: transaction.amount,
      type: transaction.type,
      date: transaction.date,
      notes: transaction.notes,
      isArchived: transaction.isArchived,
    );

    emit(
      TransactionState(
        transactions: [
          ...state.transactions,
          newTransaction,
        ],
      ),
    );
  }

  void archiveTransaction(int id) {
    final updatedTransactions = state.transactions.map((transaction) {
      if (transaction.id == id) {
        return TransactionModel(
          id: transaction.id,
          partnerId: transaction.partnerId,
          amount: transaction.amount,
          type: transaction.type,
          date: transaction.date,
          notes: transaction.notes,
          isArchived: true,
        );
      }

      return transaction;
    }).toList();

    emit(
      TransactionState(
        transactions: updatedTransactions,
      ),
    );

  }

  void unarchiveTransaction(int id) {
    final updatedTransactions = state.transactions.map((transaction) {
      if (transaction.id == id) {
        return TransactionModel(
          id: transaction.id,
          partnerId: transaction.partnerId,
          amount: transaction.amount,
          type: transaction.type,
          date: transaction.date,
          notes: transaction.notes,
          isArchived: false,
        );
      }

      return transaction;
    }).toList();

    emit(
      TransactionState(
        transactions: updatedTransactions,
      ),
    );
  }
}