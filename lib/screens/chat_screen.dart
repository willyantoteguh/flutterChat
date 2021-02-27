// import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets/chat/messages.dart';
import 'package:flutter_chat/widgets/chat/new_messages.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'PuyangChat',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  child: Container(
                      child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Logout'),
                    ],
                  )),
                  value: 'logoutUser',
                )
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'logoutUser') {
                  FirebaseAuth.instance.signOut();
                }
              },
            )
          ]),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Messages(),
            ),
            NewMessage()
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //     child: Icon(Icons.add),
      //     onPressed: () {
      //       // print(data.documents[0]['text']);
      //       // data.documents.forEach((document) {
      //       //   print(document['text']);
      //       // });
      //       Firestore.instance
      //           .collection('chats/4MHhTRWsdUhG90Ah6Kbo/messages')
      //           .add({'text': 'This was added by clicking the button'});
      //     }),
    );
  }
}
