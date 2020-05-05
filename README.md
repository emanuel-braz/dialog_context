[![Pub Version](https://img.shields.io/pub/v/dialog_context?color=%2302569B&label=pub&logo=flutter)](https://pub.dev/packages/dialog_context) ![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)

### Show Dialog, BottomSheet, ModalBottomSheet and SnackBar with no need BuildContext.
To be discontinued, use the OneContext package: [one_context](https://pub.dev/packages/one_context)


## https://pub.dev/packages/one_context

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

## Important: Use the DialogContext().builder in MaterialApp
```dart
MaterialApp(
  builder: DialogContext().builder, /// important: Use [DialogContext().builder] builder here!
  home: MyHomePage(title: 'Dialogs without BuildContext'),
);
```

#### Add dependency
```yaml
  dependencies:
    dialog_context: ^0.1.1
```
