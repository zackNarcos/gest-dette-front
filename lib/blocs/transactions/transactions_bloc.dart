import 'package:d_liv/models/repositories/transactions/transactions_repository.dart';
import 'package:d_liv/shared/enums/form_steps.dart';
import 'package:d_liv/models/entity/transaction_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'transactions_event.dart';
import 'transactions_state.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  TransactionsBloc({
    required TransactionsRepository transactionsRepository,
  })  : _transactionsRepository = transactionsRepository,
        super(
        const TransactionsState(),
      ) {
    on<LoadTransactions>(_onLoadTransactions);
    on<AddTransaction>(_onAddTransaction);
    on<SelectTransaction>(_onSelectTransaction);
    on<SelectClient>(_onSelectClient);
    // on<UpdateTransaction>(_onUpdateTransaction);
    // on<RemoveTransaction>(_onRemoveTransaction);
  }

  final TransactionsRepository _transactionsRepository;
  final FlutterSecureStorage _storage = const FlutterSecureStorage(); // Utilisé pour le stockage sécurisé local

  void _onSelectClient(SelectClient event, Emitter<TransactionsState> emit) {
    emit(state.copyWith(selectedUser: event.client));
  }

  void _onSelectTransaction(SelectTransaction event, Emitter<TransactionsState> emit) {
    emit(state.copyWith(selectedTransaction: event.transaction));
  }

  Future<void> _onLoadTransactions(LoadTransactions event, Emitter<TransactionsState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      final response = await _transactionsRepository.getAll();

      // Simuler la conversion de la réponse en liste d'objets Transaction
      // final List<Transaction> transactions = response.body.map<Transaction>((json) => Transaction.fromJson(json)).toList();

      // Sauvegarder les transactions dans le stockage local
      // await _storage.write(key: 'transactions', value: transactions.map((t) => t.toJson()).toString());

      // emit(state.copyWith(transactions: transactions, isLoading: false));
    } catch (err) {
      emit(state.copyWith(isLoading: false, error: 'Erreur de chargement des transactions.'));
    }
  }

  Future<void> _onAddTransaction(AddTransaction event, Emitter<TransactionsState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));

      // Ajouter la nouvelle transaction via le repository
      final newTransaction = await _transactionsRepository.store(event.transaction);

      // Mettre à jour la liste des transactions dans l'état
      final updatedTransactions = List<Transaction>.from(state.transactions as Iterable)..add(newTransaction as Transaction);

      // Sauvegarder dans le stockage local
      await _storage.write(key: 'transactions', value: updatedTransactions.map((t) => t.toJson()).toString());

      emit(state.copyWith(transactions: updatedTransactions, isLoading: false));
    } catch (err) {
      emit(state.copyWith(isLoading: false, error: 'Erreur lors de l’ajout de la transaction.'));
    }
  }

  // Future<void> _onUpdateTransaction(UpdateTransaction event, Emitter<TransactionsState> emit) async {
  //   try {
  //     emit(state.copyWith(isLoading: true));
  //
  //     // Mettre à jour la transaction via le repository
  //     final updatedTransaction = await _transactionsRepository.update(event.transaction);
  //
  //     // Mettre à jour la liste des transactions dans l'état
  //     final updatedTransactions = state.transactions.map((transaction) {
  //       return transaction.id == updatedTransaction.id ? updatedTransaction : transaction;
  //     }).toList();
  //
  //     // Sauvegarder dans le stockage local
  //     await _storage.write(key: 'transactions', value: updatedTransactions.map((t) => t.toJson()).toString());
  //
  //     emit(state.copyWith(transactions: updatedTransactions, isLoading: false));
  //   } catch (err) {
  //     emit(state.copyWith(isLoading: false, errorMessage: 'Erreur lors de la mise à jour de la transaction.'));
  //   }
  // }

  // Future<void> _onRemoveTransaction(RemoveTransaction event, Emitter<TransactionsState> emit) async {
  //   try {
  //     emit(state.copyWith(isLoading: true));
  //
  //     // Supprimer la transaction via le repository
  //     await _transactionsRepository.delete(event.transactionId);
  //
  //     // Mettre à jour la liste des transactions dans l'état
  //     final updatedTransactions = state.transactions.where((t) => t.id != event.transactionId).toList();
  //
  //     // Sauvegarder dans le stockage local
  //     await _storage.write(key: 'transactions', value: updatedTransactions.map((t) => t.toJson()).toString());
  //
  //     emit(state.copyWith(transactions: updatedTransactions, isLoading: false));
  //   } catch (err) {
  //     emit(state.copyWith(isLoading: false, errorMessage: 'Erreur lors de la suppression de la transaction.'));
  //   }
  // }
}
