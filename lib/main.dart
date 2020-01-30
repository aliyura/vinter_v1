import 'package:flutter/material.dart';
import 'package:vinter/init.dart';
import 'package:provider/provider.dart';
import 'package:vinter/models/data_models.dart';
import 'package:vinter/services/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        }),
      ),
      home: StreamProvider<UserModel>.value(
        value: AuthService().user,
        child: MaterialApp(
          home: AppInit(),
        ),
      ),
    );
  }
}
