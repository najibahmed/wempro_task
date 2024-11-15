import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wempro_interview_task/network/api_urls.dart';

import '../Utils/app_logger_utils.dart';
import '../models/form_field_model.dart';
import 'api_client.dart';


class FormRepository {
    final ApiClient apiClient;
  FormRepository({required this.apiClient});

  Future<FormFieldModel> getFormData() {
    LoggerUtil.instance.printLog(msg: "here is form repository");
    return apiClient.fetchFormData();
  }
}
