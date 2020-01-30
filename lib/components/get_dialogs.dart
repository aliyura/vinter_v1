import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:vinter/components/get_themes.dart';

class Consts {
  Consts._();

  static const double padding = 5.0;
  static const double avatarRadius = 5.0;
}

class AppDialog {

  BuildContext appContext;
  AppDialog(BuildContext context){
    appContext=context;
  }

  Future<bool> requestDialog(Widget widget) {
    return showDialog(
        barrierDismissible: false,
        context: appContext,
        builder: (BuildContext context) => AppCustomDialog(context:appContext, widget: widget));
  }

  void closeDialog(){
     Navigator.of(appContext,rootNavigator: true).pop();
  }

  void notify(String title, String message, dynamic type) {
    Alert(
      context: appContext,
      type: type,
      title: title,
      desc: message,
      buttons: [
        DialogButton(
          child: Text(
            "Okay",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => this.closeDialog(),
          color: AppTheme.appDarkColor,
          radius: BorderRadius.circular(25),
        ),
      ],
    ).show();
  }
}

class AppCustomDialog extends StatelessWidget {
  final widget;
  final context;
  AppCustomDialog({@required this.context, this.widget});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0.1,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(top: Consts.avatarRadius),
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(Consts.padding),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: widget,
    );
  }
}
