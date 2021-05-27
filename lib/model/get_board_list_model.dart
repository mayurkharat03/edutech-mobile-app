//class GetBoardListModel {
//  GetBoardListModel({
//    this.idBoards,
//    this.boardName,
//    this.createdDate,
//    this.updateDate,
//  });
//
//  int idBoards;
//  String boardName;
//  DateTime createdDate;
//  DateTime updateDate;
//}


import 'dart:convert';

List<GetBoardListModel> getBoardFromJson(String str) => List<GetBoardListModel>.from(json.decode(str).map((x) => GetBoardListModel.fromJson(x)));

String getBoardToJson(List<GetBoardListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetBoardListModel {
  GetBoardListModel({
    this.idBoards,
    this.boardName,
    this.createdDate,
    this.updateDate,
  });

  int idBoards;
  String boardName;
  DateTime createdDate;
  DateTime updateDate;

  factory GetBoardListModel.fromJson(Map<String, dynamic> json) => GetBoardListModel(
    idBoards: json["id_boards"],
    boardName: json["board_name"],
    createdDate: DateTime.parse(json["created_date"]),
    updateDate: DateTime.parse(json["update_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id_boards": idBoards,
    "board_name": boardName,
    "created_date": createdDate.toIso8601String(),
    "update_date": updateDate.toIso8601String(),
  };
}