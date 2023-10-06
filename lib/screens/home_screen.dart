
import 'package:banking_system/constants/colors.dart';
import 'package:banking_system/constants/textstyles.dart';
import 'package:banking_system/screens/all_customers_screen.dart';
import 'package:banking_system/widgets/navigation_button.dart';
import 'package:banking_system/widgets/user_info_widget.dart';
import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../database/user_db.dart';
import '../models/user.dart';
import 'package:get/get.dart';
class HomeScreen extends StatefulWidget {
  final Future<User> currentUser;
   HomeScreen({Key? key, required this.currentUser}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  getToAllCustomersScreen() async{
    User currentUser = await widget.currentUser;

    Get.to(AllCustomersScreen(
        contactslist: await UserDB().getUserContactsList(currentUser) ,
        currentUser: currentUser,));

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Home Page"),
        titleTextStyle: appbarTitleTextStyle,
      ),
      body: FutureBuilder(
        future: widget.currentUser,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          if(snapshot.hasError){
            print(snapshot.error.toString());
          }
          if(!snapshot.hasData){
            return Center(
              child: Text("User was not found")

              ,);
          }else{
            User currentUserData = snapshot.data!;
            return  Center(
              child: SafeArea(child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Image.asset(currentUserData.gender.toString() == "female" ? "images/woman.png" : "images/man.png"),
                    ),
                    Text("Hello " + currentUserData.name.toString(),
                      style: userWelcomeMessageTextStyle,
                    ),
                    SizedBox(height: 5,),
                    Container(
                        child: Divider(thickness: 2, color: DarkBlueColor,),
                      width: MediaQuery.of(context).size.width * 0.7,
                    ),


                    SizedBox(height: 15,),
                    UserInfoWidget(currentUserData: currentUserData,),

                    SizedBox(height: 30,),

                    NavigationButton(onPressed: getToAllCustomersScreen, text: "View Your contacts")


                  ],
                ),
              )),
            );
          }
        },
      )
    );
  }
}





