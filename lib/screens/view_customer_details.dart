import 'package:banking_system/database/user_db.dart';
import 'package:banking_system/screens/all_customers_screen.dart';
import 'package:banking_system/screens/make_transfer_screen.dart';
import 'package:banking_system/screens/view_past_transfers_screen.dart';
import 'package:banking_system/widgets/navigation_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../constants/colors.dart';
import '../constants/textstyles.dart';
import '../models/transfer.dart';
import '../models/user.dart';
import '../widgets/user_info_widget.dart';

class ViewCustomerDetails extends StatelessWidget {

  final User selectedCustomer;
  final User currentUser;

  final List<Transfer> pastTransfersList;


  Widget showPastTransfersButton(){
    if(pastTransfersList.length > 0){
      return NavigationButton(onPressed: (){
        Get.to(PastTransfersListScreen(selectedCustomer: selectedCustomer, currentUser: currentUser, pastTransfersList: pastTransfersList));
      }, text: "View Transfer History");
    }else{
      return Container();
    }
  }

  const ViewCustomerDetails({super.key, required this.selectedCustomer, required this.pastTransfersList, required this.currentUser});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Get.to(AllCustomersScreen(currentUser: currentUser, contactslist: await UserDB().getUserContactsList(currentUser),));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(selectedCustomer.name, style: appbarNameTitleTextStyle,),

        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Image.asset(selectedCustomer.gender.toString() == "female" ? "images/woman.png" : "images/man.png"),
              ),

              Text(selectedCustomer.name.toString(),
                style: userWelcomeMessageTextStyle,
              ),
              SizedBox(height: 5,),
              Container(
                child: Divider(thickness: 2, color: DarkBlueColor,),
                width: MediaQuery.of(context).size.width * 0.7,
              ),


              SizedBox(height: 15,),
              UserInfoWidget(currentUserData: selectedCustomer,),

              SizedBox(height: 30,),



              NavigationButton(onPressed: (){
                Get.to(()=>MakeTransfersScreen(senderData: currentUser, receiverData: selectedCustomer, pastTransfersList: pastTransfersList,));
              }, text: "Transfer Money to this contact"),

              SizedBox(height: 15,),

              showPastTransfersButton()


            ],
          ),
        ),
      ),
    );
  }
}
