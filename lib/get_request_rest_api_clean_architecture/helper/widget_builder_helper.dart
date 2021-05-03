import 'package:flutter/material.dart';
import 'package:get_request_rest_api/enum.dart';

class WidgetBuilderHelper extends StatefulWidget {
  final Function onErrorBuilder;
  final Function onSuccessBuilder;
  final Function onLoadingBuilder;
  final ViewState state;

  const WidgetBuilderHelper({
    Key key,
    this.onErrorBuilder,
    this.onSuccessBuilder,
    this.onLoadingBuilder,
    this.state,
  }) : super(key: key);

  @override
  _WidgetBuilderHelperState createState() => _WidgetBuilderHelperState();
}

class _WidgetBuilderHelperState extends State<WidgetBuilderHelper> {
  @override
  Widget build(BuildContext context) {
    switch (widget.state) {
      case ViewState.ERROR:
        return widget.onErrorBuilder();
      case ViewState.BUSY:
        return widget.onSuccessBuilder();
      case ViewState.RETRIVED:

      default:
        return widget.onSuccessBuilder();
    }
  }
}
