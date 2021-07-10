String baseUrl = "http://15.206.125.174:8091/";

/*api urls end point*/
String getLogin = baseUrl + "user/getLogin";
String verifyReferral = baseUrl + "user/verifyReferralCode";
String getOtp = baseUrl + "user/getOTPForRegistration";
String verifyOtp = baseUrl + "user/verifyOTP";
String updateUserUrl = baseUrl + "user/updateUserDetails";

String addUser = baseUrl + "user/addUser";
String uploadProfileImageUrl = baseUrl +"photo/28/uploadProfilePhoto";
String uploadAadharFrontImageUrl = baseUrl +"photo/28/uploadAadhaarFrontPhoto";
String uploadAadharBackImageUrl = baseUrl +"photo/28/uploadAadhaarBackPhoto";

String getBoardsUrl = baseUrl + "package/getBoards";
String getStandardsUrl = baseUrl + "package/getStandardsByBoardId";
String addPackageUrl = baseUrl + "package/addPackage";
String getPackageUrl = baseUrl + "package/getPackageByUserId";
String deletePackageUrl = baseUrl + "package/deletePackageByPackageId";

String createPaymentUrl = baseUrl + "payment/createPaymentOrder";
String confirmPaymentStatusUrl = baseUrl + "payment/confirmPaymentStatus";

String addBackDetailsUrl = baseUrl + "bank/addBankDetails";

String getDashboardDetailsUrl = baseUrl + "user/getDashBoardDetailsByUserId";
String getWalletDetailsUrl = baseUrl + "payment/getWalletDetailsByUserId";

String getOTPForForgotPasswordUrl = baseUrl + "user/getOTPForForgotPassword";
String verifyForgotPasswordOTPUrl = baseUrl + "user/verifyForgotPasswordOTP";
String changePasswordUrl = baseUrl + "user/changePassword";
String checkEmailUrl = baseUrl + "user/checkEmailID";

String walletTransferUrl = baseUrl + "wallet/requestTransfer";
String walletHistoryUrl = baseUrl + "wallet/getWalletHistoryByUserId";
String studentDetailsUrl = baseUrl + "package/addStudent";

String uploadPancardUrl = baseUrl +"photo/28/uploadPancardPhoto";

String getReferralListUrl = baseUrl + "admin/getDistributorTreeById";
