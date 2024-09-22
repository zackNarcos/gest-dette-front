class Transaction {
  final String? id;
  final String? client;
  final int? amount;
  final bool isDette;
  final bool isPaid;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Transaction({
    this.id,
    this.client,
    this.amount = 0,
    this.isDette = true,
    this.isPaid = false,
    this.createdAt,
    this.updatedAt,
  });

  Transaction copyWith({
    String? id,
    String? clientId,
    int? amount,
    bool? isDette,
    bool? isPaid,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Transaction(
      id: id ?? this.id,
      client: clientId ?? this.client,
      amount: amount ?? this.amount,
      isDette: isDette ?? this.isDette,
      isPaid: isPaid ?? this.isPaid,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['_id'],
      client: json['client'],
      amount: json['amount'],
      isDette: json['isDette'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientId': client,
      'amount': amount,
      'isDette': isDette,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}