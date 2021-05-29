import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlm/api/api_service.dart';
import 'package:mlm/api/urlManage.dart';
import 'package:mlm/model/get_package_list_model.dart';
import 'package:mlm/model/get_board_list_model.dart';
import 'package:mlm/model/get_standard_list_model.dart';
import 'package:mlm/utils/strings.dart';
import 'dart:convert' as convert;

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

  RxList<GetPackagesModel> items = RxList<GetPackagesModel>();
  RxList<String> addPackagePrice = RxList<String>();
  RxList<String> addedPackageStandard = RxList<String>();
  RxList<String> addedPackageBoard = RxList<String>();
  RxList<String> addedPackageSubjectList = RxList<String>();
  RxInt totalPrice;

  /// List of subjects
  List<String> subjectsList=[];
  String subject="";

  String standard_id="";
  List<String> result=[];

  /// Send to add package
  int boardId;
  int standardId;
  String packagePrice;
  String allSubjects="";
  String addedPackageSubjects="";

  /// Show Add packages
  RxList<String> showPackageName=RxList<String>();

  /// Get all board list
  void getBoardList() async {
    var res = await ApiService.get(getBoardsUrl,tokenOptional: true);
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
    //"userId" : Strings.userId,
    "userId" : 26,//for try..change
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
    addPackagePrice.clear();
    if(res['message']==Strings.get_package_suceess){
      List jsonResponse=res['result'] as List;
      print(jsonResponse);
      jsonResponse.forEach((id) async {
        addPackagePrice.add(id['total_price']);
        getSelectedPackageDetails(id['board_id'].toString(),id['standard_id'].toString());
      });
    }
    else{
      return null;
    }
    update();
  }

  void getSelectedPackageDetails(String board,String stdId) async {
      var res = await ApiService.get(getStandardsUrl,params:board,tokenOptional: true);
      if(res['message']== Strings.get_standard_list_success){
        List jsonResponse = res['result'] as List;
        jsonResponse.forEach((id) {
          if(stdId==id['id_standards']){
            showPackageName.add(id['standard_name']);
            print(id['standard_name']);
          }
        });
      }
      else{
        return null;
      }
      update();
    }
}
