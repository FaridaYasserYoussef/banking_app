import 'package:banking_system/constants/colors.dart';
import 'package:banking_system/constants/textstyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../models/transfer.dart';
import '../models/user.dart';
import '../widgets/navigation_button.dart';
import '../widgets/user_card_widget.dart';
import 'all_customers_screen.dart';

class TransferDetailsScreen extends StatelessWidget {

  final User senderInstance;
  final User receiverInstance;
  final Transfer transferInstance;

  const TransferDetailsScreen({super.key, required this.senderInstance, required this.receiverInstance, required this.transferInstance});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DateFormat(
            "dd MMMM, yyyy - hh:mm a"
        ).format(transferInstance.dateTime), style: appbarNameTitleTextStyle,),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 30,),
              // transfer info
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    //sender info

                    Column(children: [
                      UserCardWidget(userData: senderInstance, title: "Sender"),


                    ],),

                    SizedBox(width: 15,),

                    //transfer icon

                    Icon(Icons.arrow_forward_outlined, size: 35,),

                    SizedBox(width: 15,),

                    //receiver info

                    Column(children: [
                      UserCardWidget(userData: receiverInstance, title: "Receiver"),

                    ],),


                  ],
                ),
              ),

              SizedBox(height: 30,),

              Text("Transfer Amount: " + transferInstance.amount.toString(), style:
              TextStyle(
              color: DarkBlueColor,
              fontWeight: FontWeight.bold,
              fontSize: 20
              ),)



              // NavigationButton(onPressed: () async{
              //   User user = await widget.senderData;
              //   List<User> users = await UserDB().fetchAllUsers();
              //   users.removeAt(0);
              //
              //   Get.to(()=>AllCustomersScreen(contactslist: users, currentUser: user,));
              // }, text: "Back to Contacts List"),
              //
              //
              // SizedBox(height: 10,),
              //
              //
              // NavigationButton(onPressed: () async{
              //   User user = await widget.senderData;
              //   List<User> users = await UserDB().fetchAllUsers();
              //   users.removeAt(0);
              //
              //   Get.to(()=>HomeScreen(currentUser: UserDB().fetchUserById(1),));
              // }, text: "Back to Home Page")



            ],
          ),
        ),
      ),
    );

  }
}
