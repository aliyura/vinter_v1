import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:vinter/components/get_themes.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:toast/toast.dart';
import 'package:vinter/components/get_dialogs.dart';
import 'package:vinter/config.dart' as config;

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final codeInputController = TextEditingController();

  dynamic selectedCountry = config.defaultCountry;
  String phoneNumber, smsCode, varificationCode;
  AuthCredential authCredential;

  @override
  void initState() {
    super.initState();
  }

  Future<void> varifyPhoneNumber() async {
    print('initializing..');
    String countryCode = '+${selectedCountry.dialingCode}';
    String phoneNumber = this.phoneNumber;
    if (phoneNumber.startsWith('0')) {
      phoneNumber = phoneNumber.substring(1, phoneNumber.length);
    }
    phoneNumber = '$countryCode$phoneNumber';

    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String newCode) {
      this.varificationCode = newCode;
    };

    final PhoneCodeSent smsCodeSent = (String sentCode, [int forceCodeResent]) {
      this.varificationCode = sentCode;
      smsCodeDialog().then((value) {
        print('signed with $value');
      });
    };

    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential credential) {
      this.authCredential = credential;
      FirebaseAuth.instance.currentUser().then((user) {
        _signInWithPhoneNumber();
      });
    };

    final PhoneVerificationFailed verificationFailed = (AuthException error) {
      AppDialog(context)
          .notify('Oops! Error Occured', error.message, AlertType.error);
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 10),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed);
  }

  Future<dynamic> _signInWithPhoneNumber() async {
    AuthCredential userCredential;
    if (this.authCredential != null) {
      userCredential = this.authCredential;
    } else {
      userCredential = PhoneAuthProvider.getCredential(
          verificationId: varificationCode, smsCode: smsCode);
    }
    await FirebaseAuth.instance
        .signInWithCredential(userCredential)
        .then((AuthResult result) async {
      setState(() {
        FirebaseUser user = result.user;
        print('${user.uid} loged in');
      });
    }).catchError((error) {
      setState(() {
        AppDialog(context)
            .notify('Oops! Error Occured', error.message, AlertType.error);
      });
    });
  }

  Future<bool> smsCodeDialog() {
    return AppDialog(context).requestDialog(
      Container(
          alignment: Alignment.center,
          height: 210,
          padding: EdgeInsets.only(top: 10),
          child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    color: AppTheme.white,
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Enter OTP',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 25),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: TextField(
                  maxLength: 6,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  controller: codeInputController,
                  onChanged: (val) {
                    setState(() {
                      this.smsCode = val;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: " ----",
                    hintStyle: AppTheme.inpuStyle,
                    labelStyle: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.nearlyBlack,
                    ),
                    filled: true,
                    fillColor: Colors.white,
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
                  child: Align(
                alignment: Alignment.centerRight,
                child: FloatingActionButton(
                  hoverColor: AppTheme.appLightColor,
                  child: Icon(Icons.arrow_forward),
                  backgroundColor: AppTheme.appDarkColor,
                  elevation: 0,
                  onPressed: () {
                    FirebaseAuth.instance.currentUser().then((user) {
                      print('satrting with $user');
                      AppDialog(context).closeDialog();
                      _signInWithPhoneNumber();
                    });
                  },
                ),
              )),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/images/bg.jpg',
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    AppTheme.appDarkColor.withOpacity(0.1),
                    AppTheme.nearlyBlack
                  ],
                  stops: [
                    0.0,
                    2.0
                  ])),
        ),
        Container(
          padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).size.height / 3),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: TextFormField(
                    onChanged: (val) {
                      setState(() {
                        phoneNumber = val;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Phone Number",
                      hintStyle: AppTheme.inpuStyle,
                      helperMaxLines: 11,
                      labelStyle: TextStyle(
                        fontSize: 20.0,
                        color: AppTheme.nearlyBlack,
                      ),
                      prefixIcon: Container(
                        padding: EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                            border: Border(
                          right: BorderSide(
                            color: Colors.black12,
                            width: 3.0,
                          ),
                        )),
                        child: CountryPicker(
                          dense: false,
                          showFlag: true,
                          showDialingCode: false,
                          showName: false,
                          showCurrency: false,
                          showCurrencyISO: true,
                          onChanged: (Country country) {
                            setState(() async {
                              selectedCountry = country;
                              config.saveCountry(country);
                            });
                          },
                          selectedCountry: selectedCountry,
                        ),
                      ),
                      filled: true,
                      fillColor: AppTheme.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppTheme.appLightColor),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                      contentPadding:
                          EdgeInsets.only(left: 30.0, bottom: 20.0, top: 20.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppTheme.appLightColor),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                    ),
                    cursorColor: Colors.black12,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                    child: Align(
                  alignment: Alignment.centerRight,
                  child: FloatingActionButton(
                    hoverColor: AppTheme.appDarkColor,
                    child: Icon(Icons.arrow_forward),
                    backgroundColor: AppTheme.appDarkColor,
                    elevation: 1,
                    onPressed: () {
                      if (selectedCountry == null) {
                        Toast.show("Select your Country", context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM,
                            backgroundColor: AppTheme.appLightColor);
                      } else if (phoneNumber == null) {
                        Toast.show("Type your Phone Number", context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM,
                            backgroundColor: AppTheme.appLightColor);
                      } else {
                        if (config.isNumeric(phoneNumber)) {
                          config.Application(context).clearFocus();
                          varifyPhoneNumber();
                        } else {
                          Toast.show("Invalid Phone Number", context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM,
                              backgroundColor: AppTheme.appLightColor);
                        }
                      }
                    },
                  ),
                )),
              ]),
        ),
        Container(
          alignment: Alignment.bottomRight,
          padding: EdgeInsets.only(bottom: 50, left: 30),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Vinter Live',
                    style: TextStyle(
                        color: AppTheme.appLightColor,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa.',
                  style: TextStyle(color: AppTheme.TextGrey, fontSize: 16),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text('Help',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                      SizedBox(
                        width: 30,
                      ),
                      Text('Privacy & Policy ',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ],
                  ),
                ),
              ]),
        ),
      ]),
    );
  }
}
