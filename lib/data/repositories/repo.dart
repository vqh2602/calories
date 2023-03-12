
import 'package:dio/dio.dart';

class Repo{
  final dioRepo = Dio(BaseOptions(
    baseUrl: 'http://localhost:8080',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 10),
    receiveDataWhenStatusError: true,
    // 5s
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    },
    contentType: Headers.jsonContentType,
    // Transform the response data to a String encoded with UTF8.
    // The default value is [ResponseType.JSON].
    responseType: ResponseType.plain,
    validateStatus: (statusCode){
      if(statusCode == null){
        return false;
      }
      if(statusCode == 422 || statusCode == 400){ // your http status code
        return true;
      }else{
        return statusCode >= 200 && statusCode < 300;
      }
    },
  ));
}