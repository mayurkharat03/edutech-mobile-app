String baseUrl = "http://15.206.125.174:8091/";

/*api urls end point*/
String getLogin = baseUrl + "user/getLogin";
String verifyReferral = baseUrl + "user/verifyReferralCode";
String getOtp = baseUrl + "user/getOTPForRegistration";

String addUser = baseUrl + "user/addUser";
String uploadProfileImageUrl = baseUrl +"photo/28/uploadProfilePhoto";
String uploadAadharFrontImageUrl = baseUrl +"photo/28/uploadAadhaarFrontPhoto";
String uploadAadharBackImageUrl = baseUrl +"photo/28/uploadAadhaarBackPhoto";

String getBoardsUrl = baseUrl + "package/getBoards";
String getStandardsUrl = baseUrl + "package/getStandardsByBoardId";
String addPackageUrl = baseUrl + "package/addPackage";
String getPackageUrl = baseUrl + "package/getPackageByUserId";
