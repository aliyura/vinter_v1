import 'package:vinter/components/get_app_bar.dart';
import 'package:vinter/components/get_themes.dart';
import 'package:flutter/material.dart';
import 'package:vinter/models/data_models.dart';

class ProfileScreen extends StatefulWidget {

  final user;
  ProfileScreen({@required this.user});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

 UserModel currentUser;

  @override
  void initState() {
    currentUser=widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: singleAppBar(context, 'My Profile'),
      body: Container(
          color: AppTheme.background,
          child: ListView(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(30),
                height: 250,
                decoration: BoxDecoration(color: AppTheme.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Center(
                          child: CircleAvatar(
                            backgroundColor: AppTheme.white,
                            backgroundImage: currentUser.photo != null
                                ? NetworkImage(currentUser.photo)
                                : AssetImage('assets/images/avatar.jpg'),
                            minRadius: 60,
                            maxRadius: 70,
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
                              child: Icon(Icons.photo_camera,
                                  color: AppTheme.white),
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
                            currentUser.name != null
                                ? currentUser.name
                                : 'Untitled',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.nearlyBlack,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            currentUser.location != null
                                ? currentUser.location
                                : 'No Location',
                            style: TextStyle(
                              color: AppTheme.appDarkColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8, left: 4),
                color: AppTheme.background,
                height: MediaQuery.of(context).size.height / 2.5,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      color: AppTheme.white,
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text(currentUser.name != null
                            ? currentUser.name
                            : 'Untitled'),
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                    Container(
                      width: double.infinity,
                      color: AppTheme.background,
                      child: ListTile(
                        leading: Icon(Icons.phone),
                        title: Text(currentUser.phoneNumber != null
                            ? currentUser.phoneNumber
                            : 'No Number'),
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                    Container(
                      width: double.infinity,
                      color: AppTheme.white,
                      child: ListTile(
                        leading: Icon(Icons.email),
                        title: Text('No Email Address'),
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                    Container(
                      width: double.infinity,
                      color: AppTheme.background,
                      child: ListTile(
                        leading: Icon(Icons.location_city),
                        title: Text(currentUser.location != null
                            ? currentUser.location
                            : 'Location Not Available'),
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
