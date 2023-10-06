import 'package:banking_system/database/user_db.dart';
import 'package:banking_system/screens/transfer_details_screen.dart';
import 'package:banking_system/screens/view_customer_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../constants/textstyles.dart';
import '../models/transfer.dart';
import '../models/user.dart';

class PastTransfersListScreen extends StatelessWidget {

  final User selectedCustomer;
  final User currentUser;

  final List<Transfer> pastTransfersList;

  const PastTransfersListScreen({super.key, required this.selectedCustomer, required this.currentUser, required this.pastTransfersList});

  Future<User> getTransferUser(int transferuserId) async{
    return await UserDB().fetchUserById(transferuserId);

  }

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async{
        Get.to(()=>ViewCustomerDetails(selectedCustomer: selectedCustomer, pastTransfersList: pastTransfersList, currentUser: currentUser));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Transfer History: " + selectedCustomer.name, style: appbarNameTitleTextStyle,),
        ),
        body: SafeArea(
            child: ListView.builder(itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: GestureDetector(
                  onTap: () async{
                    Get.to(
                        TransferDetailsScreen(
                          senderInstance: await getTransferUser(pastTransfersList[index].senderId),
                          receiverInstance: await getTransferUser(pastTransfersList[index].receiverId),
                          transferInstance: pastTransfersList[index],

                        ));


                  },
                  child: ListTile(
                    leading: Image.asset("images/transaction.png"),
                    title: Text("Transfer #" + pastTransfersList[index].id.toString()),
                    subtitle: Text(DateFormat(
                        "dd MMMM, yyyy - hh:mm a"
                    ).format(pastTransfersList[index].dateTime)),
                    trailing: IconButton(icon: Icon(Icons.arrow_forward_ios_rounded), onPressed: () async{

                      Get.to(
                          TransferDetailsScreen(
                            senderInstance: await getTransferUser(pastTransfersList[index].senderId),
                            receiverInstance: await getTransferUser(pastTransfersList[index].receiverId),
                            transferInstance: pastTransfersList[index],

                          ));

                    },),
                  ),
                ),
              );
            },
              itemCount: pastTransfersList.length,
            ) ),
      ),
    );

  }
}
