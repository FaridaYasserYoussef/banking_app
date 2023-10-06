import 'package:flutter/cupertino.dart';

import '../constants/colors.dart';
import '../constants/textstyles.dart';
import '../models/user.dart';

class UserCardWidget extends StatelessWidget {

 final User userData;
 final String title;

  const UserCardWidget({super.key, required this.userData, required this.title});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
      child: Container(
        width: 140,
        height: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: WhiteColor,
            boxShadow: [
              BoxShadow(color: Color(0xffD7EBFC),
                  offset: Offset(3, 3)
              )
            ]
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            children: [
              Text(title, style: cardTitleStyle,),
              Image.asset(userData.gender == "female" ? "images/woman.png" : "images/man.png", width: 110, height: 110,),
              Text(userData.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: nameOnCardStyle,),

            ],
          ),
        ),
      ),
    );
  }
}
