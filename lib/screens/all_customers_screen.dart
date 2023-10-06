import 'package:banking_system/database/transfer_db.dart';
import 'package:banking_system/database/user_db.dart';
import 'package:banking_system/screens/home_screen.dart';
import 'package:banking_system/screens/view_customer_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../constants/textstyles.dart';
import '../models/transfer.dart';
import '../models/user.dart';

class AllCustomersScreen extends StatelessWidget {

  final List<User> contactslist;
  final User currentUser;

  Future<List<Transfer>> getTransferList(int receiverId) async{
    return await TransferDB().fetchTransfersBySenderAndReceiverId(currentUser.user_id, receiverId);
  }

  const AllCustomersScreen({super.key, required this.contactslist, required this.currentUser});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Get.to(HomeScreen(currentUser: UserDB().fetchUserById(currentUser.user_id)));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Your contacts", style: appbarTitleTextStyle,),
        ),
        body: SafeArea(
            child: ListView.builder(itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: GestureDetector(
                  onTap: () async{
                    Get.to(ViewCustomerDetails(selectedCustomer: contactslist[index], pastTransfersList: await getTransferList(contactslist[index].user_id), currentUser: currentUser,));
                  },
                  child: ListTile(
                    leading: Image.asset(contactslist[index].gender.toString() == "female" ? "images/woman.png" : "images/man.png"),
                    title: Text(contactslist[index].name),
                    trailing: IconButton(icon: Icon(Icons.arrow_forward_ios_rounded), onPressed: () async{Get.to(ViewCustomerDetails(selectedCustomer: contactslist[index], pastTransfersList: await getTransferList(contactslist[index].user_id), currentUser: currentUser));},),
                  ),
                ),
              );
            },
            itemCount: contactslist.length,
            ) ),
      ),
    );
  }
}
