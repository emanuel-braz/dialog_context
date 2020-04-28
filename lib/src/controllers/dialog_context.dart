import 'package:dialog_context/src/components/dialog_context_widget.dart';
import 'package:flutter/material.dart';

typedef Future<T> DialogFuture<T>(
    {bool barrierDismissible,
    Widget Function(BuildContext) builder,
    bool useRootNavigator});
typedef Future<T> DialogModalSheet<T>(
    {Widget Function(BuildContext) builder,
    Color backgroundColor,
    double elevation,
    ShapeBorder shape,
    Clip clipBehavior,
    bool isScrollControlled,
    bool useRootNavigator,
    bool isDismissible});
typedef Widget DialogBuilder(BuildContext context);
typedef ScaffoldFeatureController<SnackBar,
    SnackBarClosedReason> DialogSnackBar(SnackBar snackBar);
typedef PersistentBottomSheetController<T> DialogBottomSheet<T>(
    {Widget Function(BuildContext) builder,
    Color backgroundColor,
    double elevation,
    ShapeBorder shape,
    Clip clipBehavior});

class DialogContext {
  BuildContext context;

  DialogFuture _showDialog;
  DialogModalSheet _showModalBottomSheet;
  DialogSnackBar _showSnackBar;
  DialogBottomSheet _showBottomSheet;

  DialogContext._private();
  static DialogContext _instance = DialogContext._private();
  factory DialogContext() => _instance;

  Widget builder(BuildContext context, Widget widget) {
    return Navigator(
      onGenerateRoute: (settings) => MaterialPageRoute(
        builder: (context) => DialogContextWidget(
          child: widget,
        ),
      ),
    );
  }

  void registerDialogCallback(
      {DialogFuture showDialog,
      DialogModalSheet showModalBottomSheet,
      DialogSnackBar showSnackBar,
      DialogBottomSheet showBottomSheet}) {
    _showDialog = showDialog;
    _showSnackBar = showSnackBar;
    _showModalBottomSheet = showModalBottomSheet;
    _showBottomSheet = showBottomSheet;
  }

  Future<T> showDialog<T>(
      {@required Widget Function(BuildContext) builder,
      bool barrierDismissible = true,
      bool useRootNavigator = true}) async {
    assert(builder != null);
    return await _showDialog(
      builder: builder,
      barrierDismissible: barrierDismissible,
      useRootNavigator: useRootNavigator,
    );
  }

  void dismissSnackBar() => Scaffold.of(context).hideCurrentSnackBar();
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
      {@required SnackBar snackBar}) {
    assert(snackBar != null);
    return _showSnackBar(snackBar);
  }

  Future<T> showModalBottomSheet<T>(
      {@required Widget Function(BuildContext) builder,
      Color backgroundColor,
      double elevation,
      ShapeBorder shape,
      Clip clipBehavior,
      bool isScrollControlled = false,
      bool useRootNavigator = false,
      bool isDismissible = true}) async {
    assert(builder != null);
    return await _showModalBottomSheet(
        builder: builder,
        backgroundColor: backgroundColor,
        clipBehavior: clipBehavior,
        elevation: elevation,
        isDismissible: isDismissible,
        isScrollControlled: isScrollControlled,
        shape: shape,
        useRootNavigator: useRootNavigator);
  }

  PersistentBottomSheetController<T> showBottomSheet<T>(
      {@required Widget Function(BuildContext) builder,
      Color backgroundColor,
      double elevation,
      ShapeBorder shape,
      Clip clipBehavior}) {
    assert(builder != null);
    return _showBottomSheet(
        builder: builder,
        backgroundColor: backgroundColor,
        elevation: elevation,
        shape: shape,
        clipBehavior: clipBehavior);
  }
}
