import 'package:edutech/api/api_service.dart';
import 'package:edutech/api/urlManage.dart';
import 'package:edutech/model/referral_model.dart';
import 'package:edutech/utils/strings.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ReferralController extends GetxController{
  static final dataStorage = GetStorage();
  int user_id = dataStorage.read("user_id");
  List<ReferralModel> referralDetails = [];

  List<ReferralModel> get getReferralDetails {
    return [...referralDetails];
  }

  @override
  void onInit() {
    super.onInit();
  }

  /// Get dashboard details
  void getReferralData() async
  {
    var res = await ApiService.get(getReferralListUrl,params: user_id.toString(),tokenOptional: false);
    if (res["message"] == Strings.referral_list_success) {
        referralDetails.add(ReferralModel(

        ));
    }
    update();
  }
}