import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mlm/api/api_exceptions.dart';
import 'package:mlm/api/urlManage.dart';
import 'package:mlm/utils/strings.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static Map<String, String> headers = {"Content-Type": "application/json",};
  static final dataStorage = GetStorage(); // instance of getStorage class

  /// Get method with and without parameter
  static Future<dynamic> get(String url,{var params, bool tokenOptional}) async
  {
    if (tokenOptional == false) {
//      String token = dataStorage.read("token");
//      headers["Authorization"] = Strings.token;
      headers={"Content-Type": "application/json",};
    }
    else{
      headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + Strings.token
      };
    }
    var responseJson;
    try {
      final response = await http.get(params==null ? url : url + "/" + params, headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');
    return responseJson;
  }

  /// Post method
  static Future<dynamic> post(String url, Map<String, String> body, {bool tokenOptional}) async {
    if (tokenOptional == false) {
      String token = dataStorage.read("token");
      headers["Authorization"] = token;
    }
    var responseJson;
    try {
      final response = await http.post(url, body: json.encode(body), headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  /// Post method with String,dynamic
  static Future<dynamic> postWithDynamic(String url, Map<String, dynamic> body, {bool tokenOptional}) async {
    if (tokenOptional == false) {
      String token = dataStorage.read("token");
      headers["Authorization"] = token;
    }
    var responseJson;
    try {
      final response = await http.post(url, body: json.encode(body), headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
  /// Post method without using token
  static Future<dynamic> postWithoutToken(String url, Map<String, dynamic> body, {bool tokenOptional}) async
  {
    if (tokenOptional == false) {
      String token = dataStorage.read("token");
      headers["Authorization"] = token;
    }
    else{
      headers = {
      };
    }
    var responseJson;
    try {
      final response = await http.post(url, body: json.encode(body), headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  /// To upload images..using multipart
  static Future<dynamic> upload(File imageFile, String apiEndPoint, String paramName,) async
  {
    Map<String, String> headers = {
      //"Authorization": "Bearer " + ApiService.dataStorage.read("token")
      "Authorization": "Bearer " + Strings.token
    };
    var stream = new http.ByteStream(Stream.castFrom(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse(apiEndPoint);
    var request = new http.MultipartRequest("POST", uri);
    request.headers.addAll(headers);
    var multipartFile = new http.MultipartFile(paramName, stream, length, filename: basename(imageFile.path));
    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
//    response.stream.transform(utf8.decoder).listen((value) {
//      print(value);
//    });
    return response.stream.transform(utf8.decoder);
  }

  /// Status code in response
  static dynamic _returnResponse(http.Response response) {
    var responseJson = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return responseJson;
      case 400:
        return responseJson;
      case 401:
        return responseJson;
      case 403:
        throw UnauthorisedException(response.body.toString());
        return responseJson;
      case 409:
        return responseJson;//No already exists..conflicts
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
