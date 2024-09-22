import 'package:d_liv/models/entity/transaction_model.dart';
import 'package:d_liv/models/entity/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class TransactionsEvent extends Equatable {
  const TransactionsEvent();

  @override
  List<Object> get props => [];
}

class InitTransaction extends TransactionsEvent {}

final class SelectTransaction extends TransactionsEvent {
  final Transaction transaction;

  const SelectTransaction({required this.transaction});

  @override
  List<Object> get props => [transaction];
}

final class SelectClient extends TransactionsEvent {
  final User client;

  const SelectClient({required this.client});

  @override
  List<Object> get props => [client];
}

final class AddTransaction extends TransactionsEvent {
  final Transaction transaction;

  const AddTransaction({required this.transaction});

  @override
  List<Object> get props => [transaction];
}

final class RemoveTransaction extends TransactionsEvent {
  final Transaction transaction;

  const RemoveTransaction({required this.transaction});

  @override
  List<Object> get props => [transaction];
}

final class UpdateTransaction extends TransactionsEvent {
  final Transaction newTransaction;

  const UpdateTransaction({required this.newTransaction});

  @override
  List<Object> get props => [newTransaction];
}

class LoadTransactions extends TransactionsEvent {
  const LoadTransactions();

  @override
  List<Object> get props => [];
}