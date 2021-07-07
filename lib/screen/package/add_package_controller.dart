import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edutech/api/api_service.dart';
import 'package:edutech/api/urlManage.dart';
import 'package:edutech/model/get_package_list_model.dart';
import 'package:edutech/model/get_standard_list_model.dart';
import 'package:edutech/utils/strings.dart';
import 'package:edutech/utils/toast_component.dart';
import 'package:get_storage/get_storage.dart';

class AddPackageController extends GetxController{
  List<GetStandardListModel> standardDetails = [];

  List<GetStandardListModel> get getStandardDetails {
    return [...standardDetails];
  }

  List<GetPackagesModel> packageDetails = [];

  List<GetPackagesModel> get getPackageDetails {
    return [...packageDetails];
  }

  /// Send to add package
  int boardId;
  int standardId;
  String packagePrice;
  String allSubjects="";
  List<int> priceInInt=[];

  /// Show Add packages
  RxList<String> showAddPackagesPrice;
  RxList<String> showAddPackagesStdName;
  RxList<String> showAddPackagesSubName;
  RxList<String> showAddPackagesBoardName;
  int totalPrice;

  static final dataStorage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    showAddPackagesPrice = RxList<String>();
    showAddPackagesStdName = RxList<String>();
    showAddPackagesSubName = RxList<String>();
    showAddPackagesBoardName = RxList<String>();
    totalPrice = 0;
  }

  /// Get all board list
  void getBoardList() async {
    var res = await ApiService.get(getBoardsUrl,tokenOptional: false);
    Strings.allBoards.clear();
    Strings.allBoardsId.clear();
    if(res['message']==Strings.get_board_list_success){
      List jsonresponse=res['result'] as List;
      jsonresponse.forEach((id) {
        Strings.allBoards.add(id['board_name']);
        Strings.allBoardsId.add(id['id_boards']);
      });
    }
    else{
      return null;
    }
  }

  /// Get all standards by selected board
  void getStandardList(String boardId) async {
    var res = await ApiService.get(getStandardsUrl,params:boardId,tokenOptional: false);
    if(res['message']==Strings.get_standard_list_success){
      List jsonresponse=res['result'] as List;
      standardDetails.clear();
      Strings.allStandardsId.clear();
      Strings.allStandardsName.clear();
      Strings.priceList.clear();
      jsonresponse.forEach((id) {
        Strings.allStandardsId.add(id['id_standards']);
        Strings.allStandardsName.add(id['standard_name']);
        Strings.priceList.add(id['price']);
        if(id['subject_list'].contains('\n')) {
          allSubjects = id['subject_list'].replaceAll('\n', "");
        }
        else{
          allSubjects = id['subject_list'];
        }
        Strings.subjectList = allSubjects.split(",");
        standardDetails.add(GetStandardListModel(
            id_standards: id['id_standards'],
            standard_name: id['standard_name'],
            subject_list: id['subject_list'],
            price: id['price'],
            board_id: id['board_id']
        ));
      });
    }
    else{
      return null;
    }
    update();
  }

  /// Add selected package
  void addPackage(BuildContext context) async {
    int user_id = dataStorage.read("user_id");
  Map <String,dynamic> addPackageParams={
    "boardId" : boardId,
    "standardId" : standardId,
    "userId" : user_id,
    "totalPrice" : packagePrice,
  };
    var res = await ApiService.postWithDynamic(addPackageUrl,addPackageParams,tokenOptional: false);
    if(res['message']==Strings.added_package_suceess){
      Navigator.pop(context);
      ToastComponent.showDialog(res['message'], context);
      getPackagesList();
    }
    else{
      ToastComponent.showDialog('Something went wrong!', context);
    }
    update();
  }

  /// Get package list
  void getPackagesList() async {
    int user_id = dataStorage.read("user_id");
    var res = await ApiService.get(getPackageUrl,params:user_id.toString(),tokenOptional: false);
    showAddPackagesPrice.clear();
    showAddPackagesBoardName.clear();
    showAddPackagesStdName.clear();
    showAddPackagesSubName.clear();
    Strings.packagePurchaseList.clear();
    priceInInt.clear();
    if(res['message'] == Strings.get_package_suceess){
      List jsonResponse=res['result'] as List;
      jsonResponse.forEach((id) async {
        Strings.packagePurchaseList.add(id['id_package_purchase']);
        showAddPackagesPrice.add(id['total_price']);
        priceInInt.add(int.parse(id['total_price']));
        getSelectedPackageDetails(id['board_id'].toString(),id['standard_id'].toString());
      });
      calculateTotalPrice();
    }
    else{
      return null;
    }
    update();
  }

  /// Get board name, standard name and subject list from id
  void getSelectedPackageDetails(String board,String stdId) async {
    var boardResponse = await ApiService.get(getBoardsUrl,tokenOptional: false);
    if(boardResponse['message'] == Strings.get_board_list_success){
      List boardJsonResponse=boardResponse['result'] as List;
      boardJsonResponse.forEach((id) {
        if(board == id['id_boards'].toString()){
          showAddPackagesBoardName.add(id['board_name']);
        }
      });
    }
      var res = await ApiService.get(getStandardsUrl,params:board,tokenOptional: false);
      if(res['message']== Strings.get_standard_list_success){
        List jsonResponse = res['result'] as List;
        jsonResponse.forEach((id) {
          if(stdId==id['id_standards'].toString() && board == id['board_id'].toString()){
            showAddPackagesStdName.add(id['standard_name']);
            showAddPackagesSubName.add(id['subject_list']);
          }
        });
      }
      else{
        return null;
      }
      update();
    }

  /// Calculate total packages price
  void calculateTotalPrice() {
    if(priceInInt.isEmpty){
      totalPrice=0;
    }
    else{
      totalPrice = priceInInt.reduce((a, b) => a + b);
      Strings.price = totalPrice;
    }
    update();
  }

  /// Delete package
  void deletePackage(BuildContext context, String packageId) async{
    var res = await ApiService.delete(deletePackageUrl,params: packageId,tokenOptional: false);
    if(res['message']==Strings.delete_success){
      ToastComponent.showDialog(res['message'], context);
    }
    else{
      ToastComponent.showDialog("Something went wrong", context);
    }
    getPackagesList();
    update();
  }
}
