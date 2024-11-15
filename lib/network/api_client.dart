import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:wempro_interview_task/Utils/app_logger_utils.dart';

import '../Utils/app_ui_utils.dart';
import '../models/form_field_model.dart';
import 'api_urls.dart';

class ApiClient {
final Dio _dio = dioClient();

// ApiClient() {
//   _dio.options.baseUrl = ApiUrls.baseUrl;
// }
 Future<FormFieldModel> fetchFormData() async {
  try {
    LoggerUtil.instance.printLog(msg: "here is api client");
    final response = await _dio.get(ApiUrls.codingTest);
    if (response.statusCode == 200) {
      // LoggerUtil.instance.printLog(msg: response.data);
      return FormFieldModel.fromJson(response.data);
    } else {
      UIUtil.instance.onFailed('Failed to load form data');
      throw Exception('Failed to load form data');
    }
  } on DioException catch (error) {
    UIUtil.instance.onFailed(handleError(error));
    throw Exception('Error fetching form data: $error');
  }catch (e) {
    LoggerUtil.instance.printLog(msg:  'Something went wrong : $e');
    throw Exception('Error fetching form data: $e');
  }
}
}



/// Dio Error Checking
 handleError(DioException error) {
  switch (error.type) {
    case DioException.connectionTimeout:
      UIUtil.instance.onFailed("Connection Timeout : ${error.response.toString()}");
    case DioException.sendTimeout:
      UIUtil.instance.onFailed("Connection Sent Timeout : ${error.response.toString()}");
    case DioException.receiveTimeout:
      UIUtil.instance.onFailed("Connection Receive Timeout : ${error.response.toString()}");
    case DioException.badResponse:
      if (error.response == null) {
        UIUtil.instance.onFailed(error.response.toString(),);
      }
      switch (error.response?.statusCode) {
        case 401:
          UIUtil.instance.onFailed("401 : Unauthorized");
        case 400:
          UIUtil.instance.onFailed("400 : Bad Request");
        case 404:
          UIUtil.instance.onFailed("404 : Not Found");
        case 500:
          UIUtil.instance.onFailed("500 : Internal Server Error");
      }
      break;
    case DioErrorType.cancel:
      break;
    default:
      UIUtil.instance.onFailed(error.response.toString());
  }
}

  /// CLIENT
   Dio dioClient()  {
    Dio dio = Dio( _options());

    dio.interceptors.add(PrettyDioLogger(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 90));
    return dio;
  }

   BaseOptions _options()  {
    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    return BaseOptions(
      baseUrl: ApiUrls.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: header,
    );
  }

