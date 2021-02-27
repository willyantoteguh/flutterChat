import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets/chat/message_buble.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: SpinKitChasingDots(
            color: Colors.lime,
            size: 30,
          ));
        }
        return StreamBuilder(
            stream: Firestore.instance
                .collection('chat')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (ctx, chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting) {
                return SpinKitChasingDots(
                  color: Colors.lime,
                  size: 30,
                );
              }
              final chatDocs = chatSnapshot.data.documents;
              return ListView.builder(
                  reverse: true,
                  itemCount: chatDocs.length,
                  itemBuilder: (ctx, index) => MessageBuble(
                        chatDocs[index]['text'],
                        chatDocs[index]['username'],
                        chatDocs[index]['userId'] == futureSnapshot.data.uid,
                        key: ValueKey(chatDocs[index].documentID),
                      ));
            });
      },
    );
  }
}
