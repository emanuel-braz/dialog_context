import 'package:dialog_context/src/controllers/dialog_context.dart';
import 'package:flutter/material.dart';

class DialogContextWidget extends StatefulWidget {
  final Widget child;
  DialogContextWidget({Key key, this.child}) : super(key: key);
  _DialogContextWidgetState createState() => _DialogContextWidgetState();
}

class _DialogContextWidgetState extends State<DialogContextWidget> {
  @override
  void initState() {
    super.initState();
    DialogContext().registerDialogCallback(
        showDialog: _showDialog,
        showSnackBar: _showSnackBar,
        showModalBottomSheet: _showModalBottomSheet,
        showBottomSheet: _showBottomSheet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (scaffoldContext) {
          DialogContext().scaffoldContext = scaffoldContext;
          return widget.child;
        },
      ),
    );
  }

  Future<T> _showDialog<T>(
          {bool barrierDismissible = true,
          Widget Function(BuildContext) builder,
          bool useRootNavigator = true}) =>
      showDialog<T>(
        context: context,
        builder: (context) => builder(context),
        barrierDismissible: barrierDismissible,
        useRootNavigator: useRootNavigator,
      );

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _showSnackBar(
          SnackBar snackBar) =>
      Scaffold.of(DialogContext().scaffoldContext).showSnackBar(snackBar);

  Future<T> _showModalBottomSheet<T>(
      {Widget Function(BuildContext) builder,
      Color backgroundColor,
      double elevation,
      ShapeBorder shape,
      Clip clipBehavior,
      bool isScrollControlled = false,
      bool useRootNavigator = false,
      bool isDismissible = true}) {
    return showModalBottomSheet<T>(
      context: context,
      builder: builder,
      backgroundColor: backgroundColor,
      clipBehavior: clipBehavior,
      elevation: elevation,
      isDismissible: isDismissible,
      isScrollControlled: isScrollControlled,
      shape: shape,
      useRootNavigator: useRootNavigator,
    );
  }

  PersistentBottomSheetController<T> _showBottomSheet<T>(
      {@required Widget Function(BuildContext) builder,
      Color backgroundColor,
      double elevation,
      ShapeBorder shape,
      Clip clipBehavior}) {
    return showBottomSheet<T>(
        context: DialogContext().scaffoldContext,
        builder: builder,
        backgroundColor: backgroundColor,
        elevation: elevation,
        shape: shape,
        clipBehavior: clipBehavior);
  }
}
