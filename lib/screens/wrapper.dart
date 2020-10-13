import 'package:chatt_squad/models/custom_user.dart';
import 'package:chatt_squad/screens/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authentication/auth_screen.dart';
import 'home_screen.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<CustomUser>(context);
    if (_user == null) {
      return ChangeNotifierProvider<ValueNotifier<bool>>(
        create: (context) => ValueNotifier<bool>(true),
        child: AuthScreen(),
      );
    } else {
      return ChatScreen();
    }
  }
}
