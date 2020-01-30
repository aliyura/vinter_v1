import 'package:flutter/material.dart';
import 'package:vinter/components/get_contacts.dart';

class ContactsView extends StatefulWidget {
  @override
  _ContactsViewState createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       height: MediaQuery.of(context).size.height/1.8,
      child: ContactsList()
    );
  }
}
