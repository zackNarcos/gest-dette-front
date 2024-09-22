import 'package:d_liv/shared/constants/theme/colors.dart';
import 'package:d_liv/models/entity/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class OrderGroupTile extends StatefulWidget {
  final DateTime date;
  final List<Transaction> orders;
  final Function(Transaction) onOrderTap;


  const OrderGroupTile({
    super.key,
    required this.date,
    required this.orders,
    required this.onOrderTap,
  });

  @override
  State<StatefulWidget> createState() {
    return _OrderGroupTileState();
  }
}

class _OrderGroupTileState extends State<OrderGroupTile> {

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              DateFormat('MMMM dd, yyyy').format(widget.date),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...widget.orders.map((order) {
              return Container(
                margin: const EdgeInsets.only(top: 12.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                child: ListTile(
                  title: Row(
                    children: <Widget>[
                      const Spacer(),
                      Text(order.amount.toString()),
                      const SizedBox(width: 4.0),
                      const Text(
                        '€',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: DLivColors.primary
                        )
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      Text('${order.client}, ${DateFormat('hh:mm a').format(order.createdAt??DateTime.now())}'),
                      const Spacer(),
                      Icon(
                        order.isDette ? Icons.arrow_downward : Icons.arrow_upward,
                        color: order.isDette ? DLivColors.muted : DLivColors.primary,
                        size: 26.0,
                      ),
                    ],
                  ),
                  onTap: () {
                    widget.onOrderTap(order);
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
