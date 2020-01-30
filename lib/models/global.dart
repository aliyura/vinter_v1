import 'package:flutter/material.dart';
import 'package:vinter/models/data_models.dart';
import 'package:provider/provider.dart';

class CurrentUser {
  BuildContext context;
  CurrentUser(BuildContext currentContext) {
    context = currentContext;
  }

  UserModel get info {
    final user = Provider.of<UserModel>(context,listen: false);
    return user != null
        ? user
     : UserModel();
  }
}
