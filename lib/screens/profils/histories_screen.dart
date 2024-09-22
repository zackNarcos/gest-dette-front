import 'package:d_liv/widgets/ui/list_tile/order_group_tile.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../models/entity/transaction_model.dart';
import '../../widgets/transactions/detail_order_panel_content.dart';
import '../../widgets/transactions/filter_order_panel_content.dart';
import '../../widgets/ui/sliding_up_panel_widget.dart';

class HistoriesScreen extends StatefulWidget {

  const HistoriesScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HistoriesScreenState();
  }

}

class _HistoriesScreenState extends State<HistoriesScreen> {
  final PanelController _detailsPanelController = PanelController();
  final ValueNotifier<bool> _isDetailsPanelVisible = ValueNotifier(false);
  final ValueNotifier<bool> _isDetailsPanelOpened = ValueNotifier(false);

  final PanelController _filterPanelController = PanelController();
  final ValueNotifier<bool> _isFiltersPanelVisible = ValueNotifier(false);
  final ValueNotifier<bool> _isFiltersPanelOpened = ValueNotifier(false);

  bool _showIncoming = true;
  bool _showOutgoing = true;

  final List<Transaction> orders = [
    const Transaction(
      client: 'Jane Doe',
      amount: 933,
      isDette: false,
    ),
    const Transaction(
      client: 'Jane Doe',
      amount: 933,
      isDette: false,
    ),
    const Transaction(
      client: 'Jane Doe',
      amount: 933,
      isDette: false,
    ),
    const Transaction(
      client: 'Jane Doe',
      amount: 933,
      isDette: false,
    ),
    const Transaction(
      client: 'Jane Doe',
      amount: 933,
      isDette: false,
    ),
  ];

  late ValueNotifier<Transaction> _selectedOrder = ValueNotifier(orders[0]);

  @override
  void initState() {
    _selectedOrder = ValueNotifier(orders[0]);
    super.initState();
  }

  @override
  void dispose() {
    _isDetailsPanelVisible.dispose();
    _isDetailsPanelOpened.dispose();
    _isFiltersPanelOpened.dispose();
    _isFiltersPanelVisible.dispose();
    _selectedOrder.dispose();
    super.dispose();
  }

  void _onOrderSelected(Transaction order) {
    _selectedOrder.value = order;
    _isDetailsPanelVisible.value = true;
    _detailsPanelController.open();
  }

  void _onFiltersOpen() {
    _showFilter(context);
  }

  void _handleIncomingFilterChanged(bool value) {
    setState(() {
      _showIncoming = value;
    });
  }

  void _handleOutgoingFilterChanged(bool value) {
    setState(() {
      _showOutgoing = value;
    });
  }

  void _showFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20),
                // rounded top
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: FilterOrderPanelContent(
                    incomingFilter: _showIncoming,
                    outgoingFilter: _showOutgoing,
                    onIncomingFilterChanged: _handleIncomingFilterChanged,
                    onOutgoingFilterChanged: _handleOutgoingFilterChanged,
                  ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Historique des commandes"),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            ListView(
              children: [
                //section filter
                Container(
                  padding: const EdgeInsets.all(20),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      padding: const EdgeInsets.all(0),
                    ),
                    onPressed: () {  },
                    child: TextButton(
                        onPressed: _onFiltersOpen,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Filtrer par',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Icon(
                              Icons.filter_list,
                              color: Colors.black,
                            ),
                          ],
                        ),
                    ),
                  ),
                ),
                //section orders
                ...orders.map((order) {
                  return OrderGroupTile(
                    date: order.createdAt ?? DateTime.now(),
                    orders: orders,
                    onOrderTap: _onOrderSelected,
                  );
                }),
                // if (_selectedOrder.value != null)
              ],
            ),
            SlidingUpPanelWidget(
              panelController: _detailsPanelController,
              content: DetailOrderPanelContent(
                transaction: _selectedOrder,
                isPanelOpened: _isDetailsPanelVisible,
              ),
              minPanelHeight: 0,
              marginTop: 200,
              isClosable: true,
            ),
          ],
        ),
      ),
    );
  }
}