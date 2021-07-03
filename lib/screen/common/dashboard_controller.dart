import 'package:edutech/api/api_service.dart';
import 'package:edutech/api/urlManage.dart';
import 'package:edutech/utils/strings.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';

class DashboardController extends GetxController{
  static final dataStorage = GetStorage();
  int user_id = dataStorage.read("user_id");

  @override
  void onInit() {
    super.onInit();
  }

  void getDashboardData() async
  {
    var res = await ApiService.get(getDashboardDetailsUrl,params: user_id.toString(),tokenOptional: false);
    if (res["message"] == Strings.get_dashboard_data_success) {
      ApiService.dataStorage.write("user_id", res["result"][0]["id_user"]);
      ApiService.dataStorage.write("first_name", res["result"][0]["first_name"]);
      ApiService.dataStorage.write("last_name", res["result"][0]["last_name"]);
      ApiService.dataStorage.write("email", res["result"][0]["email"]);
      ApiService.dataStorage.write("referred_by", res["result"][0]["referred_by"]);
      ApiService.dataStorage.write("photo", res["result"][0]["photo"]);
      ApiService.dataStorage.write("aadhaar_front", res["result"][0]["aadhaar_front"]);
      ApiService.dataStorage.write("aadhaar_back", res["result"][0]["aadhaar_back"]);
      ApiService.dataStorage.write("pancard_photo", res["result"][0]["pancard_photo"]);
      ApiService.dataStorage.write("isPackagePurchase", res["result"][0]["isPackagePurchase"]);
      ApiService.dataStorage.write("isAadhaarFrontUploaded", res["result"][0]["isAadhaarFrontUploaded"]);
      ApiService.dataStorage.write("isAadhaarBackUploaded", res["result"][0]["isAadhaarBackUploaded"]);
      ApiService.dataStorage.write("isPanUploaded", res["result"][0]["isPanUploaded"]);
      ApiService.dataStorage.write("isProfileUploaded", res["result"][0]["isProfileUploaded"]);
      ApiService.dataStorage.write("referralStatus", res["result"][0]["referralStatus"]);
      ApiService.dataStorage.write("walletAmount", res["result"][0]["resultReferral"][0]['walletAmount']);
      ApiService.dataStorage.write("code", res["result"][0]["resultReferral"][0]['code']);
    }
    update();
  }
}