import 'package:flutter/material.dart';
import 'package:vinter/components/get_dialogs.dart';
import 'package:vinter/components/get_themes.dart';
import 'package:toast/toast.dart';
import 'package:vinter/models/data_models.dart';
import 'package:vinter/models/global.dart';
import 'package:vinter/config.dart';
import 'package:vinter/services/database.dart';

class Channel {
  String channelName, channelDescription;
  final nameController = TextEditingController();
  final descController = TextEditingController();

  void requestAddDialog(BuildContext context) {
    AppDialog(context).requestDialog(
      Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 10),
          height: MediaQuery.of(context).size.height / 1.9,
          child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    color: AppTheme.white,
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Create New Channel',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: InkWell(
                          child: Icon(Icons.cancel),
                          onTap: () {
                            AppDialog(context).closeDialog();
                          },
                        ),
                      )),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Channel Name",
                    hintStyle: AppTheme.inpuStyle,
                    labelStyle: TextStyle(
                      fontSize: 20.0,
                      color: AppTheme.nearlyBlack,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.nearlyDarkBlue),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    contentPadding:
                        EdgeInsets.only(left: 30.0, bottom: 20.0, top: 20.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.appLightColor),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  cursorColor: Colors.black12,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: TextField(
                  controller: descController,
                  decoration: InputDecoration(
                    labelText: "Channel Description",
                    hintStyle: AppTheme.inpuStyle,
                    labelStyle: TextStyle(
                      fontSize: 20.0,
                      color: AppTheme.nearlyBlack,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.nearlyDarkBlue),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    contentPadding:
                        EdgeInsets.only(left: 30.0, bottom: 20.0, top: 20.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.appLightColor),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  maxLines: 3,
                  maxLength: 60,
                  cursorColor: Colors.black12,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                  child: Align(
                alignment: Alignment.centerRight,
                child: FloatingActionButton(
                  hoverColor: AppTheme.appLightColor,
                  child: Icon(Icons.arrow_forward),
                  backgroundColor: AppTheme.appDarkColor,
                  elevation: 0,
                  onPressed: () {
                    channelName = nameController.text;
                    channelDescription = descController.text;

                    if (channelName != null && channelDescription != null) {
                      if (channelName.length < 3) {
                        Toast.show("Min 3, Max 20 Alphabets", context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM);
                      } else if (channelDescription.length < 10) {
                        Toast.show("Min 10, Max 30 Alphabets", context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM);
                      }
                      else{

                        Application(context).clearFocus();
                        UserModel currentUser = CurrentUser(context).info;
                        final _db = DatabaseService(currentUser.uid);

                        dynamic res =
                            _db.addChannel(channelName, channelDescription);
                        if (res != null) {
                          AppDialog(context).closeDialog();
                          Toast.show("$channelName Added", context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.BOTTOM,
                              backgroundColor: AppTheme.appLightColor);
                        } else {
                          Toast.show("Unable to add Channel", context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM,
                              backgroundColor: AppTheme.appLightColor);
                        }
                      }
                    } else {
                      Toast.show("All fields most be Filed", context,
                          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                    }
                  },
                ),
              )),
            ],
          )),
    );
  }
}
