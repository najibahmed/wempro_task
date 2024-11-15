import 'package:flutter/material.dart';
import 'package:wempro_interview_task/Utils/app_logger_utils.dart';
import '../models/form_field_model.dart';
import '../network/api_repository.dart';


class FormProvider with ChangeNotifier {
  final FormRepository formRepository;
  FormFieldModel? formFieldModel;
  Map<String, dynamic> formData = {};
  GlobalKey<FormState> dropdownKey=GlobalKey<FormState>();

  // Error state variables
  bool checkboxValidation = false;
  bool cleaningFrequencyError = false;

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
    for (var attribute in formFieldModel!.jsonResponse.attributes) {
      if (attribute.type == 'checkbox' && formData[attribute.id] == null) {
        checkboxValidation=true;
        notifyListeners();
        return false;
      }
      if ((attribute.type == 'radio' || attribute.type == 'dropdown') &&
          (formData[attribute.id] == null || formData[attribute.id].isEmpty)) {
        return false;
      }

      if (attribute.type == 'textfield' &&
          (formData[attribute.id] == null || formData[attribute.id].trim().isEmpty)) {
        return false;
      }


    }
    return true;
  }

}
