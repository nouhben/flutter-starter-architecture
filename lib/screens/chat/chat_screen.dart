import 'package:chatt_squad/components/custom_loader.dart';
import 'package:chatt_squad/models/custom_user.dart';
import 'package:chatt_squad/models/message.dart';
import 'package:chatt_squad/services/authentication_service.dart';
import 'package:chatt_squad/services/database_service.dart';
import 'package:chatt_squad/shared/constants.dart';

import 'package:chatt_squad/shared/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageTextController = TextEditingController();
  final AuthService _authService = AuthService();
  String messageText;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final user = Provider.of<CustomUser>(context, listen: false);
    final DatabaseService _db = DatabaseService(uid: user.uid);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 8.0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundColor: kPrimaryColor,
              backgroundImage: NetworkImage(
                  'https://randomuser.me/api/portraits/men/81.jpg'),
            ),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: () async {
              await _authService.signOut();
            },
            child: Text('logout'),
          ),
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              StreamBuilder<List<Message>>(
                stream: _db.messages,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CustomLoader(duration: 2);
                  } else {
                    List<MessageBubble> messageBubbles = [];
                    for (Message msg in snapshot.data.reversed) {
                      messageBubbles.add(
                        MessageBubble(
                          message: msg,
                          isMe: msg.sender == user.email,
                        ),
                      );
                    }
                    return Expanded(
                      child: ListView(
                        children: messageBubbles,
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenHeight(10)),
                      ),
                      // return Expanded(
                      //   child: ListView(
                      //     reverse: false,
                      //     children: List.generate(
                      //       snapshot.data.length,
                      //       (index) => MessageBubble(
                      //         message: snapshot.data[index],
                      //         isMe: snapshot.data[index].sender == user.email,
                      //       ),
                      //     ),
                      //     scrollDirection: Axis.vertical,
                      //   ),
                    );
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageTextController,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) => messageText = value,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        if (messageText.isNotEmpty) {
                          await _db.sendMessage(
                            message: Message(
                              text: messageText,
                              sender: user.email,
                            ),
                          );
                        }
                        _messageTextController.clear();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(36),
                            bottomLeft: Radius.circular(36),
                            topRight: Radius.zero,
                            bottomRight: Radius.zero,
                          ),
                          color: kPrimaryColor,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(15),
                          vertical: getProportionateScreenWidth(15),
                        ),
                        margin: EdgeInsets.only(left: 10),
                        height: 60,
                        child: Text(
                          'send',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StreamMessages extends StatelessWidget {
  const StreamMessages({
    Key key,
    @required DatabaseService db,
    @required this.user,
  })  : _db = db,
        super(key: key);

  final DatabaseService _db;
  final CustomUser user;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
      stream: _db.messages,
      builder: (context, snapshot) => !snapshot.hasData
          ? CustomLoader(duration: 2)
          : Expanded(
              child: ListView.builder(
                reverse: true,
                itemBuilder: (context, index) => MessageBubble(
                  message: snapshot.data[index],
                  isMe: snapshot.data[index].sender == user.email,
                ),
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.length,
              ),
            ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isMe;

  const MessageBubble({Key key, this.message, this.isMe}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Container(
          width: SizeConfig.screenWidth * 0.65,
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenWidth(10),
          ),
          decoration: BoxDecoration(
            color: isMe
                ? Color.fromARGB(50, 49, 79, 255)
                : kPrimaryColor.withOpacity(0.23),
            borderRadius: BorderRadius.only(
              topLeft: isMe ? Radius.circular(25) : Radius.zero,
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0),
              topRight: isMe ? Radius.zero : Radius.circular(25),
            ),
          ),
          child: Column(
            crossAxisAlignment:
                this.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(this.message.sender),
              Text(
                this.message.text,
                style: TextStyle(
                  color: Theme.of(context).textTheme.headline5.color,
                ),
                softWrap: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
