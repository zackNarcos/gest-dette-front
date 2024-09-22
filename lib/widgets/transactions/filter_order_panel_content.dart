import 'dart:ffi';

import 'package:d_liv/shared/constants/theme/colors.dart';
import 'package:d_liv/shared/constants/theme/text.dart';
import 'package:d_liv/widgets/forms/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

import '../../models/entity/transaction_model.dart';

class FilterOrderPanelContent extends StatefulWidget {
  final bool incomingFilter;
  final bool outgoingFilter;
  final Function(bool) onIncomingFilterChanged;
  final Function(bool) onOutgoingFilterChanged;

  const FilterOrderPanelContent({
    required this.incomingFilter,
    required this.outgoingFilter,
    required this.onIncomingFilterChanged,
    required this.onOutgoingFilterChanged,
    super.key
  });

  @override
  _FilterOrderPanelContentState createState() => _FilterOrderPanelContentState();
}

class _FilterOrderPanelContentState extends State<FilterOrderPanelContent> {
  bool _incomingFilter = false;
  bool _outgoingFilter = false;

  @override
  void initState() {
    super.initState();
    _incomingFilter = widget.incomingFilter;
    _outgoingFilter = widget.outgoingFilter;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      return Column(
        children: <Widget>[
          const Text(
            'Filtres de livraison',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Commandes entrantes', style: DLivTextStyles.body1),
              Switch(
                value: _incomingFilter,
                activeColor: DLivColors.primary,
                inactiveThumbColor: DLivColors.secondary,
                onChanged: (bool value) {
                  setState(() {
                    _incomingFilter = value;
                    widget.onIncomingFilterChanged(value);
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Commandes sortantes', style: DLivTextStyles.body1),
              Switch(
                value: _outgoingFilter,
                activeColor: DLivColors.primary,
                inactiveThumbColor: DLivColors.secondary,
                onChanged: (bool value) {
                  setState(() {
                    _outgoingFilter = value;
                    widget.onOutgoingFilterChanged(value);
                  });
                },
              ),
            ],
          ),
        ],
      );
  }
}

