import 'package:edutech/api/api_service.dart';
import 'package:edutech/api/urlManage.dart';
import 'package:edutech/utils/strings.dart';
import 'package:edutech/utils/toast_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StudentController extends GetxController{

  static final dataStorage = GetStorage();
  int user_id = dataStorage.read("user_id");
  TextEditingController studentFirstNameController;
  TextEditingController studentMiddleNameController;
  TextEditingController studentLastNameController;
  TextEditingController studentSchoolNameController;
  TextEditingController studentBoardNameController;


  @override
  void onInit() {
    super.onInit();
    studentFirstNameController = TextEditingController();
    studentMiddleNameController = TextEditingController();
    studentLastNameController = TextEditingController();
    studentSchoolNameController = TextEditingController();
    studentBoardNameController = TextEditingController();
  }

  /// Get student details
  Future<void> saveStudentDetails(BuildContext context,String salutation, String dateOfBirth, String gender, int id) async
  {

    int selectedGender;

    if(gender=="Male"){
      selectedGender = 1;
    }
    else{
      selectedGender = 2;
    }
    Map<String, dynamic> params={
      "salutation": salutation,
      "firstName": studentFirstNameController.text,
      "middleName": studentMiddleNameController.text,
      "lastName": studentLastNameController.text,
      "gender": selectedGender,
      "schoolName": studentSchoolNameController.text,
      "dateOfBirth": dateOfBirth,
      "packageId":id,
      "userId":user_id,
    };
    var res = await ApiService.postWithDynamic(studentDetailsUrl,params,tokenOptional: false);
    if (res["message"] == Strings.add_student_success) {
        ToastComponent.showDialog("Student added successfully", context);
    }
    else{
      ToastComponent.showDialog("Something went wrong", context);
    }
    update();
  }
}