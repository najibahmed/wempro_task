import 'package:flutter/material.dart';
import 'package:wempro_interview_task/Utils/app_logger_utils.dart';
import '../models/form_field_model.dart';
import '../network/api_repository.dart';


class FormProvider with ChangeNotifier {
  final FormRepository formRepository;
  FormFieldModel? formFieldModel;
  Map<String, dynamic> formData = {};
  GlobalKey<FormState> textFieldKey=GlobalKey();
  GlobalKey<FormState> dropDowmKey=GlobalKey();
  // bool isLoading = false;

  FormProvider({required this.formRepository});

  Future<void> fetchFormData() async {
    // isLoading = true;
    // notifyListeners();

    try {
      LoggerUtil.instance.printLog(msg: "here is form provider");
      formFieldModel = await formRepository.getFormData();
      formData = {for (var attr in formFieldModel!.jsonResponse.attributes) attr.id: null};
    } catch (error) {
      LoggerUtil.instance.printLog(msg: 'Error fetching form data: $error',logType: LogType.error);
      // Handle error accordingly
    }

    // isLoading = false;
    notifyListeners();
  }

  void updateField(String id, dynamic value) {
    formData[id] = value;
    notifyListeners();
  }

  bool validateForm() {
    // Check only the required fields
    final requiredFields = ["House type", "Cleaning Frequency"];
    var i  =1;
    for (var field in formData.keys) {
      if(i==10){
        break ;
      }
      final attribute = formFieldModel!.jsonResponse.attributes[i];
     //  LoggerUtil.instance.printLog(msg: attribute.title);
     LoggerUtil.instance.printLog(msg: formData[0]);
     //  if (formData.keys) {
     //    return false; // If any required field is empty, validation fails
     //  }
      i++;
    }

    return true; // All required fields are filled
  }

}
