class GetPackagesModel{
  int board_id;
  int standard_id;
  String total_price="";
  DateTime purchase_date;
  DateTime expiry_date;

  GetPackagesModel({this.board_id, this.standard_id, this.total_price, this.purchase_date, this.expiry_date});
}
