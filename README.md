# dialog_context

### Show Dialog, BottomSheet, ModalBottomSheet and SnackBar without BuildContext.

```dart
// example snackBar
DialogContext().showSnackBar(
    snackBar: SnackBar(content: Text('My awesome snackBar!'))
);
```

```dart
// example dialog
DialogContext().showDialog(
    builder: (context) => AlertDialog( 
        title: new Text("The Title"),
        content: new Text("The Body"),
    )
);
```

```dart
// example bottomSheet
DialogContext().showBottomSheet(
    builder: (context) => Container(
    alignment: Alignment.topCenter,
    height: 200,
    child: IconButton(
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 50,
        color: Colors.white,
        onPressed: () => Navigator.pop(context)),
    ),
);
```

## Important: Use the builder of MaterialApp
```dart
MaterialApp(
  builder: (context, widget) => Navigator( // important: Use builder to initiate routes
    onGenerateRoute: (settings) => MaterialPageRoute(
      builder: (context) => DialogContextWidget( // important: Use the DialogContextWidget as root widget
        child: widget,
      ),
    ),
  ),
  home: MyHomePage(title: 'Dialogs without BuildContext'),
);
```