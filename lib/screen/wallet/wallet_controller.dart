import 'package:edutech/api/api_service.dart';
import 'package:edutech/api/urlManage.dart';
import 'package:edutech/model/wallet_history_list_model.dart';
import 'package:edutech/utils/strings.dart';
import 'package:edutech/utils/toast_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WalletController extends GetxController{

  static final dataStorage = GetStorage();
  int user_id = dataStorage.read("user_id");

  TextEditingController walletAmountController;

  List<WalletHistoryModel> walletDetails = [];

  List<WalletHistoryModel> get getWalletDetails {
    return [...walletDetails];
  }

  @override
  void onInit() {
    walletAmountController = TextEditingController();
    super.onInit();
  }

  /// Get wallet history
  void getWalletHistory() async
  {
    var res = await ApiService.get(walletHistoryUrl,params: user_id.toString(),tokenOptional: false);
    if (res["message"] == Strings.wallet_history_success) {

      walletDetails.clear();
      res["result"].forEach((id) {
        walletDetails.add(WalletHistoryModel(
          date: id["created_at"],
          name: id["beneficiary_name"],
          amount: id["amount"],
        ));
      });

      // walletDetails.add(WalletHistoryModel(
      //   date:"27-01-2021",
      //   name: "Mona Jadhav",
      //   amount: "200.0",
      // ));
    }

    update();
  }

  /// Wallet transfer request
  void withdrawMoney(BuildContext context) async
  {
    String bank_name = dataStorage.read("bank_name");
    String account_number = dataStorage.read("account_number");
    String account_name = dataStorage.read("account_name");
    String ifsc_code = dataStorage.read("ifsc_code");
    String upi_id = dataStorage.read("upi_id");
    String email = dataStorage.read("email");
    String phone = dataStorage.read("phone_number");

    Map<String, dynamic> params={
      "userId": user_id.toString(),
      "beneficiaryType":"bank_account",
      "beneficiaryName":account_name,
      "accountNumber":account_number,
      "ifsc":ifsc_code,
      "upiHandle":"",
      "paymentMode":"IMPS",
      "amount":walletAmountController.text,
      "email":email,
      "phoneNumber":phone,
      "narration":"testing",
    };
    var res = await ApiService.postWithDynamic(walletTransferUrl,params,tokenOptional: false);
    if (res["message"] == Strings.wallet_transfer_success) {
      ToastComponent.showDialog("Transfer successfully",context);
    }
    else{
      ToastComponent.showDialog(res["message"],context);
    }
    update();
  }
}