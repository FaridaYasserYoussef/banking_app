import 'package:get/get.dart';

import '../models/transfer.dart';

class TransferController extends GetxController{
   RxDouble _senderBalance = 0.0.obs;
   RxDouble _receiverBalance = 0.0.obs;
   RxList<Transfer> _transfersList = <Transfer>[].obs;


   double get senderBalance => _senderBalance.value;
   double get receiverBalance => _receiverBalance.value;
   List<Transfer> get transfersList => _transfersList.value;


 Future<void>  setSenderBalance(double senderBalanceValue) async{
    _senderBalance.value = senderBalanceValue;
    await Future.delayed(Duration(milliseconds: 20),(){update();});

 }

   Future<void>  setReceiverBalance(double receiverBalanceValue) async{
    _receiverBalance.value = receiverBalanceValue;
    await Future.delayed(Duration(milliseconds: 20),(){update();});


   }

   Future<void> setTransferList(List<Transfer> transferList) async{
   _transfersList.value  = transferList;
   await Future.delayed(Duration(milliseconds: 20),(){update();});


   }

Future<void> addToTransfersList(Transfer newTransfer) async{
   _transfersList.value.add(newTransfer);
   await Future.delayed(Duration(milliseconds: 20),(){update();});


}

}