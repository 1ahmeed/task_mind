import 'package:flutter/material.dart';

import '../../core/utils/local_data.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(child: Material(
color: Colors.blueAccent,
        child: TextButton(
          child: const Text("LogOut",style: TextStyle(color: Colors.white),),
          onPressed: (){
            signOut(context);
          },
        ),
      )),
    );
  }
  void signOut(context) {
    CacheNetwork.removeData(key: 'token').then((value){
      if(value==true){
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);

      }
    });
  }
}