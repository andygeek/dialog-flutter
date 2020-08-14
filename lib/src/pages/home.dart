import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateHome();
  }
}

enum Opciones { primero, segundo, tercero }

class StateHome extends State<Home> {
  String opcionEscogida = '';
  String opcionAlert = '';
  String opcionModalSheet = '';
  String opcionPersistentBottomSheet = '';
  String opcionSnackBar = '';
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: globalKey,
        appBar: AppBar(title: Text('My App')),
        body: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10.0,
                ),
                RaisedButton(
                  color: Colors.amber,
                  onPressed: () {
                    openDialog();
                  },
                  child: Text(
                    'SimpleDialog',
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  opcionEscogida,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 10.0,
                ),
                RaisedButton(
                  color: Colors.red,
                  textColor: Colors.white,
                  onPressed: () {
                    openAlert();
                  },
                  child: Text(
                    'AlertDialog',
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  opcionAlert,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 10.0,
                ),
                RaisedButton(
                  color: Colors.purple,
                  textColor: Colors.white,
                  onPressed: () {
                    openModalBottomSheet();
                  },
                  child: Text(
                    'ModalBottomSheet',
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  opcionModalSheet,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 10.0,
                ),
                RaisedButton(
                  color: Colors.teal,
                  textColor: Colors.white,
                  onPressed: () {
                    openPersistentBottomSheet();
                  },
                  child: Text(
                    'PersistentBottomSheet',
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  opcionPersistentBottomSheet,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 10.0,
                ),
                RaisedButton(
                  color: Colors.lime,
                  textColor: Colors.black,
                  onPressed: () {
                    openSnackBar();
                  },
                  child: Text(
                    'SnackBar',
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  opcionSnackBar,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            )
          ],
        ));
  }

  Future<void> openDialog() async {
    switch (await showDialog<Opciones>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('SimpleDialog'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, Opciones.primero);
                },
                child: Text('Primera opción'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, Opciones.segundo);
                },
                child: Text('Segunda opción'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, Opciones.tercero);
                },
                child: Text('Tercera opción'),
              )
            ],
          );
        })) {
      case Opciones.primero:
        setState(() {
          opcionEscogida = 'Se seleccionó la primera opción';
        });
        break;
      case Opciones.segundo:
        setState(() {
          opcionEscogida = 'Se seleccionó la segunda opción';
        });
        break;
      case Opciones.tercero:
        setState(() {
          opcionEscogida = 'Se seleccionó la tercera opción';
        });
        break;
    }
  }

  Future<void> openAlert() {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text('AlertDialog'),
            content: Text('Este es un AlertDialog'),
            actions: [
              FlatButton(
                  onPressed: () {
                    setState(() {
                      opcionAlert = 'Aceptaste';
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Aceptar')),
              FlatButton(
                  onPressed: () {
                    setState(() {
                      opcionAlert = 'Cancelaste';
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Cancelar'))
            ],
          );
        });
  }

  Future<void> openModalBottomSheet() {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            color: Colors.amber,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    onPressed: () {
                      setState(() {
                        opcionModalSheet = 'Aceptaste';
                        Navigator.pop(context);
                      });
                    },
                    color: Colors.black,
                    textColor: Colors.white,
                    child: Text('Click me'),
                  )
                ],
              ),
            ),
          );
        });
  }

  PersistentBottomSheetController openPersistentBottomSheet() {
    return globalKey.currentState.showBottomSheet((context) {
      return Container(
        height: 100,
        color: Colors.amber,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                onPressed: () {
                  setState(() {
                    opcionPersistentBottomSheet = 'Aceptaste';
                    Navigator.pop(context);
                  });
                },
                color: Colors.black,
                textColor: Colors.white,
                child: Text('Click me'),
              )
            ],
          ),
        ),
      );
    });
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> openSnackBar() {
    return globalKey.currentState.showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Row(
          children: [
            Text('Este es el SnackBar'),
            Expanded(child: SizedBox()),
            RaisedButton(
              onPressed: () {
                setState(() {
                  opcionSnackBar = 'Hiciste click';
                });
              },
              child: Text('Click me'),
            )
          ],
        )));
  }
}
