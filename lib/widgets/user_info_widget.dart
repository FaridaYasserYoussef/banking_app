import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/textstyles.dart';
import '../models/user.dart';

class UserInfoWidget extends StatelessWidget {
 final User  currentUserData;

  const UserInfoWidget({super.key, required this.currentUserData});


  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: lightBlueColor
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Email: " + currentUserData.email.toString(),
                  style: userInfoInHomePageTextStyle,
                  textAlign: TextAlign.left,
                ),

                SizedBox(height: 10,),
                Divider(thickness: 2, color: DarkBlueColor,),
                SizedBox(height: 10,),



                Text("Current Balance: " + currentUserData.balance.toStringAsFixed(2),
                  style: userInfoInHomePageTextStyle,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
