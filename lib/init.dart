import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinter/authenticate/sign_in.dart';
import 'package:vinter/screens/app.dart';
import 'package:vinter/screens/setup_profile.dart';
import 'package:vinter/models/data_models.dart';
import 'package:vinter/services/database.dart';

class AppInit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return user != null && user.name == null
        ? SetupProfile()
        : user != null && user.name != null?  
          StreamProvider<UserModel>.value(value: SnapingService(user.uid).geUser, child: AppScreen())
        : SignIn();
  }
}
