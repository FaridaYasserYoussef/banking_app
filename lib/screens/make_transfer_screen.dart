import 'package:banking_system/constants/colors.dart';
import 'package:banking_system/controllers/transfer_controller.dart';
import 'package:banking_system/database/transfer_db.dart';
import 'package:banking_system/database/user_db.dart';
import 'package:banking_system/screens/home_screen.dart';
import 'package:banking_system/screens/view_past_transfers_screen.dart';
import 'package:banking_system/widgets/navigation_button.dart';
import 'package:banking_system/widgets/user_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/textstyles.dart';
import '../models/transfer.dart';
import '../models/user.dart';
import 'all_customers_screen.dart';

class MakeTransfersScreen extends StatefulWidget {

   final User senderData;
   final User receiverData;
   final List<Transfer> pastTransfersList;


   const MakeTransfersScreen({super.key, required this.senderData, required this.receiverData, required this.pastTransfersList});

  @override
  State<MakeTransfersScreen> createState() => _MakeTransfersScreenState();
}

class _MakeTransfersScreenState extends State<MakeTransfersScreen> {
  TransferController transferController = Get.put(TransferController());
  final _formKey = GlobalKey<FormState>();
  TextEditingController amountOfTransferController = TextEditingController();

  Future<void> makeTransfer() async{
    try{
      var dialogResult = await Get.dialog(
        AlertDialog(
          title: Text("Transfer Confirmation", style: userInfoInHomePageTextStyle,),
          content: Text("Are you sure You want to transfer an amount of " + amountOfTransferController.text + " to " + widget.receiverData.name),
          actions: [
            TextButton(onPressed: (){
              Get.back();
            },
                child: Text(
                  "No",
                  style: TextStyle(color: Colors.black),

                )),
            TextButton(
                onPressed: (){
                  Get.back(result: "transfer");
                },
                child: Text(
                    "Yes",
                    style: TextStyle(color: Colors.black)

                ))
          ],

        )
      );
     if(dialogResult == "transfer"){
       int lastTransferId = await TransferDB().createTransfer(senderId: widget.senderData.user_id, receiverId: widget.receiverData.user_id, amount: double.parse(amountOfTransferController.text));
       Transfer lastInsertedTransfer = await TransferDB().fetchTransferById(lastTransferId);
       await transferController.addToTransfersList(lastInsertedTransfer);
       await UserDB().updateUserBalance(widget.senderData.user_id, double.parse(amountOfTransferController.text) * -1);
       await UserDB().updateUserBalance(widget.receiverData.user_id, double.parse(amountOfTransferController.text));
      await transferController.setSenderBalance(transferController.senderBalance - double.parse(amountOfTransferController.text));
       await transferController.setReceiverBalance(transferController.receiverBalance + double.parse(amountOfTransferController.text));
     }
    }catch(e){
      print(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     transferController.setSenderBalance(widget.senderData.balance);
    transferController.setReceiverBalance(widget.receiverData.balance);
    transferController.setTransferList(widget.pastTransfersList);


  }

  Widget showNavigateToTransferHistoryButton(){
    if(widget.pastTransfersList.length == 0){
      return Container();
    }
    return   NavigationButton(onPressed: () async{

      Get.to(PastTransfersListScreen(

        currentUser: await UserDB().fetchUserById(widget.senderData.user_id),
        selectedCustomer: await UserDB().fetchUserById(widget.receiverData.user_id),
        pastTransfersList: widget.pastTransfersList,
      ));
    }, text: "Back to Contacts List");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Transfer Money to " + widget.receiverData.name, style: appbarNameTitleTextStyle, ),
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
                     UserCardWidget(userData: widget.senderData, title: "Sender"),

                     GetBuilder<TransferController>(
                       init: TransferController(),
                       builder: (controller) {
                         return Text(transferController.senderBalance.toStringAsFixed(2) + " EGP",style: balanceStyle);
                       },
                     )
                   ],),

                    SizedBox(width: 15,),

                    //transfer icon

                    Icon(Icons.arrow_forward_outlined, size: 35,),

                    SizedBox(width: 15,),

                    //receiver info

                    Column(children: [
                      UserCardWidget(userData: widget.receiverData, title: "Receiver"),



                      GetBuilder<TransferController>(

                        init: TransferController(),

                        builder: (controller) {
                          return Text(transferController.receiverBalance.toStringAsFixed(2) + " EGP", style: balanceStyle,);
                        },
                      )
                    ],),


                  ],
                ),
              ),

              SizedBox(height: 50,),

              //transfer form
              Padding(
                padding: const EdgeInsets.fromLTRB(45, 20, 20, 20),
                child: Form(
                  key: _formKey,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: amountOfTransferController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            hintText: "Amount",
                            alignLabelWithHint: true,
                            constraints: BoxConstraints(
                                maxWidth: 200
                            ),
                            border: OutlineInputBorder()
                        ),

                        validator: (value) {
                          if(double.parse(value.toString()) > widget.senderData.balance){
                            return "There is not enough \n money in your balance";
                          }
                          if(double.parse(value.toString()) < 0){
                            return "You cannot enter\n an amount in negative";
                          }
                          return null;
                        },

                      ),

                      SizedBox(width: 30,),

                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Material(
                            color: DarkBlueColor,
                            child: InkWell(
                              onTap: () async{


                                if (_formKey.currentState!.validate()) {
                                  await makeTransfer();

                                }

                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text("Transfer", style: buttonTextStyle,),
                              ),
                            ),
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              ),

              SizedBox(height: 30,),






              NavigationButton(onPressed: () async{
                User user = await widget.senderData;
                List<User> users = await UserDB().fetchAllUsers();
                users.removeAt(0);

                Get.to(()=>HomeScreen(currentUser: UserDB().fetchUserById(1),));
              }, text: "Back to Home Page"),

              SizedBox(height: 10,),


              GetBuilder(
                init: TransferController(),
                builder: (controller) {
                  if(transferController.transfersList.length == 0){
                    return Container();
                  }
                  return NavigationButton(onPressed: () async{

                    Get.to(PastTransfersListScreen(

                      currentUser: await UserDB().fetchUserById(widget.senderData.user_id),
                      selectedCustomer: await UserDB().fetchUserById(widget.receiverData.user_id),
                      pastTransfersList: widget.pastTransfersList,
                    ));
                  }, text: "View Transfers History");
                },
              )



            ],
          ),
        ),
      ),
    );
  }
}
