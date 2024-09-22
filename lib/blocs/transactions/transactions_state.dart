import 'package:d_liv/models/entity/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:d_liv/models/entity/transaction_model.dart';

final class TransactionsState extends Equatable {
  const TransactionsState({
    this.transactions,
    this.selectedTransaction,
    this.selectedUser,
    this.isLoading,
    this.error
  });

  final Transaction? selectedTransaction;
  final User? selectedUser;
  final List<Transaction>? transactions;
  final bool? isLoading;
  final String? error;

  @override
  List<Object?> get props => [transactions, selectedTransaction, selectedUser, isLoading, error];

  TransactionsState copyWith({
    Transaction? selectedTransaction,
    User? selectedUser,
    List<Transaction>? transactions,
    bool? isLoading,
    String? error,
  }) {
    return TransactionsState(
      selectedTransaction: selectedTransaction ?? this.selectedTransaction,
      selectedUser: selectedUser ?? this.selectedUser,
      transactions: transactions ?? this.transactions,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}