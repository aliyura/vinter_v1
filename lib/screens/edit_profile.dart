import 'package:flutter/material.dart';
import 'package:vinter/components/get_themes.dart';
import 'package:vinter/models/data_models.dart';
import 'package:vinter/services/database.dart';
import 'package:vinter/services/auth.dart';
import 'package:vinter/components/get_dialogs.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:recase/recase.dart';
import 'package:vinter/components/get_app_bar.dart';
import 'package:toast/toast.dart';
import 'package:vinter/models/global.dart';
import 'package:vinter/config.dart' as config;

class EditProfile extends StatefulWidget {

   final user;
   EditProfile({@required this.user});


  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  String username = 'Untitled User';
  String country, countryCode;
  final usernameInputController = TextEditingController();
   UserModel currentUser;

   @override
  void initState() {
      currentUser =widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: singleAppBar(context, 'Edit Profile'),
      body: Container(
        color: AppTheme.white,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height / 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Center(
                          child: CircleAvatar(
                            backgroundImage:
                                ExactAssetImage('assets/images/avatar.jpg'),
                            minRadius: 60,
                            maxRadius: 70,
                            backgroundColor: AppTheme.appLightColor,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            margin: EdgeInsets.only(left: 150),
                            child: CircleAvatar(
                              backgroundColor: AppTheme.appLightColor,
                              minRadius: 25,
                              maxRadius: 25,
                              child: Icon(Icons.photo_camera,color: AppTheme.white,),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 4),
                      child: Column(
                        children: <Widget>[
                          Text(
                            username == ''
                                ? 'Untitled User'
                                : username.titleCase,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.appLightColor,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 40, right: 40),
                child: TextField(
                  maxLength: 30,
                  maxLines: 1,
                  textAlign: TextAlign.left,
                  controller: usernameInputController,
                  onChanged: (val) {
                    setState(() {
                      this.username = val;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "New Username",
                    hintStyle: AppTheme.hintStyle,
                    labelStyle: TextStyle(
                      fontSize: 16.0,
                      color: AppTheme.nearlyBlack,
                    ),
                    filled: true,
                    fillColor: AppTheme.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.nearlyDarkBlue),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    contentPadding:
                        EdgeInsets.only(left: 30.0, bottom: 20.0, top: 20.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.appLightColor),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  cursorColor: Colors.black12,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                  padding: EdgeInsets.only(right: 40),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: FloatingActionButton(
                      hoverColor: AppTheme.appLightColor,
                      child: Icon(Icons.arrow_forward),
                      backgroundColor: AppTheme.appLightColor,
                      elevation: 0,
                      onPressed: () async {

                        config.Application(context).clearFocus();
                        String uid =
                            currentUser.uid != null ? currentUser.uid : null;
                        String userName = usernameInputController.text;

                        if (userName != null && userName.length >= 3) {
                          dynamic result = DatabaseService(uid)
                              .addUser(userName, country, countryCode);
                          if (result != null) {
                            AuthService()
                                .updateUser(userName, '_username')
                                .then((username) {

                                  usernameInputController.clear();
                                  Toast.show('Saved', context,
                                  duration: Toast.LENGTH_SHORT,
                                  gravity: Toast.BOTTOM);
                            });
                          } else {
                            AppDialog(context).notify(
                                'Oops! Error Occured',
                                'Unable to setup your Profile',
                                AlertType.error);
                          }
                        } else {
                          Toast.show("Enter a Valid Username", context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM,
                              backgroundColor: AppTheme.appLightColor);
                        }
                      },
                    ),
                  )),
            ]),
      ),
    );
  }
}
