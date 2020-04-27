import 'package:dialog_context/dialog_context.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) => Navigator( // important: Use builder to initiate
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => DialogContextWidget( // important: Use the DialogContextWidget as root widget
            child: widget,
          ),
        ),
      ),
      title: 'Dialogs without BuildContext',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Dialogs without BuildContext'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Show SnackBar'),
              onPressed: () {
                DialogContext().dismissSnackBar(); // Dismiss snackbar
                DialogContext().showSnackBar(
                    snackBar: SnackBar(
                  content: Text(
                    'My awesome snackBar!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(color: Colors.white),
                  ),
                  action: SnackBarAction(label: 'DISMISS', onPressed: () {}),
                ));
              },
            ),
            RaisedButton(
              child: Text('Show Dialog'),
              onPressed: () async {
                var result = await DialogContext().showDialog<String>(
                    // Don't need context to show alertDialog
                    builder: (context) => AlertDialog(
                          title: new Text("The Title"),
                          content: new Text("The Body"),
                          actions: <Widget>[
                            new FlatButton(
                                child: new Text("OK"),
                                onPressed: () =>
                                    Navigator.of(context).pop('ok')),
                            new FlatButton(
                                child: new Text("CANCEL"),
                                onPressed: () =>
                                    Navigator.of(context).pop('cancel')),
                          ],
                        ));
                print(result);
              },
            ),
            RaisedButton(
              child: Text('Show modalBottomSheet'),
              onPressed: () async {
                var result = await DialogContext().showModalBottomSheet<String>(
                    builder: (context) => Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                  leading: Icon(Icons.music_note),
                                  title: Text('Music'),
                                  onTap: () =>
                                      Navigator.of(context).pop('Music')),
                              ListTile(
                                leading: Icon(Icons.videocam),
                                title: Text('Video'),
                                onTap: () => Navigator.of(context).pop('Video'),
                              ),
                              SizedBox(height: 45)
                            ],
                          ),
                        ));
                print(result);
              },
            ),
            RaisedButton(
              child: Text('Show bottomSheet'),
              onPressed: () {
                DialogContext().showBottomSheet(
                  builder: (context) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.red,
                    ),
                    margin: EdgeInsets.all(16),
                    alignment: Alignment.topCenter,
                    height: 200,
                    child: IconButton(
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 50,
                        color: Colors.white,
                        onPressed: () => Navigator.pop(context)),
                  ),
                );
              },
            ),
            RaisedButton(
                child: Text('Show and await input'),
                onPressed: () async {
                  switch (await DialogContext().showDialog<int>(
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          title: const Text('Select assignment'),
                          children: <Widget>[
                            SimpleDialogOption(
                              onPressed: () {
                                Navigator.pop(context, 1);
                              },
                              child: const Text('Number 1'),
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                                Navigator.pop(context, 2);
                              },
                              child: const Text('Number 2'),
                            ),
                          ],
                        );
                      })) {
                    case 1:
                      print('number one');
                      break;
                    case 2:
                      print('number two');
                      break;
                  }
                }),
          ],
        ),
      ),
    );
  }
}
