import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlm/api/api_service.dart';
import 'package:mlm/api/urlManage.dart';
import 'package:mlm/model/get_board_list_model.dart';
import 'package:mlm/utils/strings.dart';
import 'dart:convert' as convert;

class AddPackageController extends GetxController{
//  var getlist=List<GetBoardListModel>().obs;
//  GetBoardServices services=GetBoardServices();
//  var postloading = true.obs;
//
//  GetBoardListModel getBoardListModel;
//  final selected = "Boards".obs;
//
//  void setSelected(String value){
//    selected.value = value;
//  }
//  @override
//  void onInit() {
//    callMethod();
//    super.onInit();
//  }
//
//  callMethod() async{
//    try{
//      postloading.value = true;
//      final result=await services.getBoardList();
//      if(result!=null){
//        getlist.assignAll(result);
//      }
//      else{
//        print("null");
//      }
//    }
//    finally {
//      postloading.value = false;
//    }
//    update();
//  }

  void getBoardList() async {
    var res = await ApiService.get(getBoards,tokenOptional: true);
    if(res['message']==Strings.get_board_list_success){
      print(res['result']);
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

  void getStandardList(int boardId) async {
    var res = await ApiService.get(getStandardsUrl,params:boardId,tokenOptional: true);
    if(res['message']==Strings.get_standard_list_success){

    }
    else{
      return null;
    }
  }
}

class GetBoardServices{
  Future<List<GetBoardListModel>> getBoardList() async {
    try{
      var res = await ApiService.get(getBoards,tokenOptional: true)
        .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("connection time out try agian");
    });
      if(res['message']==Strings.get_board_list_success){
        print(res['result']);
        List jsonresponse=res['result'] as List;
        jsonresponse.forEach((id) {
          Strings.allBoards.add(id['board_name']);
          Strings.allBoardsId.add(id['id_boards']);
        });
        return jsonresponse.map((e) => new GetBoardListModel.fromJson(e)).toList();
      }
      else{
        return null;
      }
    }
    on TimeoutException catch (_) {
      print("response time out");
    }
  }
}
