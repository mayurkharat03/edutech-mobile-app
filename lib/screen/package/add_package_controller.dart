import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mlm/api/api_service.dart';
import 'package:mlm/api/urlManage.dart';
import 'package:mlm/model/get_package_list_model.dart';
import 'package:mlm/model/get_standard_list_model.dart';
import 'package:mlm/utils/strings.dart';
import 'package:mlm/utils/toast_component.dart';

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
    var res = await ApiService.get(getBoardsUrl,tokenOptional: true);
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
    var res = await ApiService.get(getStandardsUrl,params:boardId,tokenOptional: true);
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
        print(Strings.subjectList);
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
  Map <String,dynamic> addPackageParams={
    "boardId" : boardId,
    "standardId" : standardId,
    "userId" : Strings.userId,
    "totalPrice" : packagePrice,
  };
    var res = await ApiService.postWithDynamic(addPackageUrl,addPackageParams,tokenOptional: true);
    if(res['message']==Strings.added_package_suceess){
      Navigator.pop(context);
      ToastComponent.showDialog(res['message'], context);
    }
    else{
      ToastComponent.showDialog('Something went wrong!', context);
    }
    update();
  }

  /// Get package list
  void getPackagesList() async {
    var res = await ApiService.get(getPackageUrl,params:Strings.userId.toString(),tokenOptional: true);
    showAddPackagesPrice.clear();
    showAddPackagesBoardName.clear();
    showAddPackagesStdName.clear();
    showAddPackagesSubName.clear();
    priceInInt.clear();
    if(res['message']==Strings.get_package_suceess){
      List jsonResponse=res['result'] as List;
      jsonResponse.forEach((id) async {
        showAddPackagesPrice.add(id['total_price']);
        priceInInt.add(int.parse(id['total_price']));
        print(priceInInt);
        getSelectedPackageDetails(id['board_id'].toString(),id['standard_id'].toString());
      });
      increment();
    }
    else{
      return null;
    }
    update();
  }

  /// Get board name, standard name and subject list from id
  void getSelectedPackageDetails(String board,String stdId) async {
    var boardResponse = await ApiService.get(getBoardsUrl,tokenOptional: true);
    if(boardResponse['message']==Strings.get_board_list_success){
      List boardJsonResponse=boardResponse['result'] as List;
      boardJsonResponse.forEach((id) {
        if(board == id['id_boards'].toString()){
          showAddPackagesBoardName.add(id['board_name']);
          print(showAddPackagesBoardName);
        }
      });
    }
      var res = await ApiService.get(getStandardsUrl,params:board,tokenOptional: true);
      if(res['message']== Strings.get_standard_list_success){
        List jsonResponse = res['result'] as List;
        jsonResponse.forEach((id) {
          if(stdId==id['id_standards'].toString() && board== id['board_id'].toString()){
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

  void increment() {
    totalPrice = priceInInt.reduce((a, b) => a + b);
    print(totalPrice);
    update(); // use update() to update counter variable on UI when increment be called
  }
}
