import 'package:chatt_squad/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  final CollectionReference _messages =
      FirebaseFirestore.instance.collection('messages');

  DatabaseService({this.uid});

  Future<void> sendMessage({final Message message}) async {
    // await _messages.doc(uid).collection('userMessages').add({
    //   'text': message.text,
    //   'sender': message.sender,
    //   'time': Timestamp.now(),
    // });
    await _messages.add({
      'text': message.text,
      'sender': message.sender,
      'time': Timestamp.now(),
    });
  }

  List<Message> _messageListFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.docs
        .toList()
        .map(
          (doc) => Message(
            text: doc.get('text'),
            sender: doc.get('sender'),
          ),
        )
        .toList();
  }

  Stream<List<Message>> get messages {
    return _messages.snapshots().map(_messageListFromSnapShot);
    //_messages.doc('userMessages').snapshots()
  }
//   /**

//    * 1- we need a collection reference which is ref to a collection in the firestore
//   It does not matter if we created the collection if it does not exists firestore will created
//   final CollectionReference brewCollection =
//   FirebaseFirestore.instance.collection('brews');

//   This uid is used to link the firestore record of a particular collection to a particular user
//   final String uid;

//   DatabaseService({this.uid});

//   Future updateUserData({String name, String sugars, int strength}) async {
//     return await brewCollection.doc(uid).set({
//       'sugars': sugars,
//       'strength': strength,
//       'name': name,
//     });
//   }

//   List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
//     return snapshot.docs.toList().map((doc) {
//       return Brew(
//         name: doc.get('name') ?? 'Dummy name',
//         strength: doc.get('strength') ?? 100,
//         sugars: doc.get('sugars') ?? '0',
//       );
//     }).toList();
//   }

//   This stream will listen to any changes on collection that the ref is pointing to and notify us
//   Stream<List<Brew>> get brews {
//     return brewCollection.snapshots().map(_brewListFromSnapshot);
//   }

// UserData from Snapshot of a user data document
//   UserData _userDataFromSnapshot(DocumentSnapshot snapshot) => snapshot == null
//       ? null
//       : UserData(
//           uid: this.uid, //snapshot.get('uid'),
//           name: snapshot.get('name'), // snapshot.data['name]
//           strength: snapshot.get('strength'),
//           sugars: snapshot.get('sugars'),
//         );
//   //User document at each change
//   Stream<UserData> get userData =>
//       brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);

}
