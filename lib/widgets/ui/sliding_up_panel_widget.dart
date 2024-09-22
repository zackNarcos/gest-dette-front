import 'package:d_liv/shared/constants/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';


class SlidingUpPanelWidget extends StatefulWidget {
  final PanelController panelController;
  final Widget content;
  final int minPanelHeight;
  final int marginTop;
  final bool isClosable;
  final Function? onClose;

  const SlidingUpPanelWidget({
    required this.panelController,
    required this.content,
    this.minPanelHeight = 0,
    this.marginTop = 200,
    this.isClosable = false,
    super.key,
    this.onClose,
  });

  @override
  _SlidingUpPanelWidgetState createState() => _SlidingUpPanelWidgetState();
}

class _SlidingUpPanelWidgetState extends State<SlidingUpPanelWidget> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Focus(
        focusNode: _focusNode,
        child: GestureDetector(
          onTap: () {
            _focusNode.requestFocus();
          },
          child: SlidingUpPanel(
            controller: widget.panelController,
            renderPanelSheet: false,
            backdropEnabled: true,
            onPanelOpened: () {
              if (widget.isClosable) {
                _focusNode.requestFocus();
              }
            },
            panel: Column(
              children: [
                if(widget.isClosable)
                  GestureDetector(
                    onTap: () {
                      widget.panelController.close();
                      if (widget.onClose != null) {
                        widget.onClose!();
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            height: 35,
                            width: 35,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(60),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: const Icon(
                                  Icons.close, color: DLivColors.label, size: 20),
                              onPressed: () {
                                widget.panelController.close();
                                if (widget.onClose != null) {
                                  widget.onClose!();
                                }
                              },
                            )
                        ),
                      ],
                    ),
                  ),

                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.only(top: 12),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            //radius only top
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          child: Center(
                            child: Container(
                              width: 60,
                              height: 5,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: DLivColors.muted,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        widget.content,
                      ],
                    ),
                  ),
                ),
              ],
            ),
            minHeight: widget.minPanelHeight.toDouble(),
            maxHeight: MediaQuery.of(context).size.height - widget.marginTop.toDouble(),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
        ),
      ),
    );
  }
}
