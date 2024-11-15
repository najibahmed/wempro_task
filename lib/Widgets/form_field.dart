import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/form_field_model.dart';
import '../providers/form_provider.dart';

class FormFieldWidget extends StatelessWidget {
  final Attribute attribute;

  const FormFieldWidget({super.key, required this.attribute});

  @override
  Widget build(BuildContext context) {
    switch (attribute.type) {
      case 'radio':
        return RadioGroupWidget(attribute: attribute);
      case 'dropdown':
        return DropdownWidget(attribute: attribute);
      case 'textfield':
        return TextFieldWidget(attribute: attribute);
      case 'checkbox':
        return CheckboxWidget(attribute: attribute);
      default:
        return Container();
    }
  }
}

class RadioGroupWidget extends StatelessWidget {
  final Attribute attribute;

  const RadioGroupWidget({super.key, required this.attribute});

  @override
  Widget build(BuildContext context) {
    return Consumer<FormProvider>(
      builder: (context, formProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(attribute.title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            if (formProvider.formData[attribute.id] == null)const Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                ),

                  Padding(
                      padding: EdgeInsets.only(left: 14.0),
                      child: Text(
                        "Required",
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      )),
              ],
            ),
            Column(
              children: attribute.options.map<Widget>((option) {
                return RadioListTile(
                  title: Text(option),
                  value: option,
                  groupValue: formProvider.formData[attribute.id],
                  onChanged: (value) {
                    formProvider.updateField(attribute.id, value);
                  },
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}

class DropdownWidget extends StatelessWidget {
  final Attribute attribute;

  const DropdownWidget({super.key, required this.attribute});

  @override
  Widget build(BuildContext context) {
    return Consumer<FormProvider>(
      builder: (context, formProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(attribute.title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            if (formProvider.formData[attribute.id] == null) const Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                ),

                  Padding(
                      padding: EdgeInsets.only(left: 14.0),
                      child: Text(
                        "Required",
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      )),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "0 ${attribute.title}",
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold)),
              items: attribute.options
                  .map<DropdownMenuItem<String>>((option) => DropdownMenuItem(
                        value: option,
                        child: Text(option),
                      ))
                  .toList(),
              value: formProvider.formData[attribute.id],
              onChanged: (value) {
                formProvider.updateField(attribute.id, value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please select a Field";
                }
                return null;
              },
            ),
            // if (formProvider.formData[attribute.id] == null)
            //   const Padding(
            //       padding: EdgeInsets.only(left: 16.0),
            //       child: Text(
            //         "Please select a field",
            //         style: TextStyle(color: Colors.red, fontSize: 14),
            //       )),
          ],
        );
      },
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  final Attribute attribute;

  const TextFieldWidget({super.key, required this.attribute});

  @override
  Widget build(BuildContext context) {
    return Consumer<FormProvider>(
      builder: (context, formProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              attribute.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            if (formProvider.formData[attribute.id] == null) const Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                ),

                  Padding(
                      padding: EdgeInsets.only(left: 14.0),
                      child: Text(
                        "Required",
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      )),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "Type ${attribute.title}"),
              onChanged: (value) {
                formProvider.updateField(attribute.id, value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please type preferred time";
                }
                return null;
              },
            ),
            // if (formProvider.formData[attribute.id] == null)
            //   const Padding(
            //       padding: EdgeInsets.only(left: 16.0),
            //       child: Text(
            //         "Please enter this field",
            //         style: TextStyle(color: Colors.red, fontSize: 14),
            //       )),
          ],
        );
      },
    );
  }
}

class CheckboxWidget extends StatelessWidget {
  final Attribute attribute;

  const CheckboxWidget({super.key, required this.attribute});

  @override
  Widget build(BuildContext context) {
    return Consumer<FormProvider>(
      builder: (context, formProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(attribute.title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            if (formProvider.formData[attribute.id] == null) const Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                ),

                  Padding(
                      padding: EdgeInsets.only(left: 14.0),
                      child: Text(
                        "Required",
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      )),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: formProvider.formData[attribute.id] == true,
                  onChanged: (value) {
                    print(formProvider.formData[attribute.id] == true);
                    formProvider.updateField(
                        attribute.id, value == true ? true : null);
                  },
                ),
                const Text("Yes"),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: formProvider.formData[attribute.id] == false,
                  onChanged: (value) {
                    print(value);
                    formProvider.updateField(
                        attribute.id, value == true ? false : null);
                  },
                ),
                const Text("No"),
              ],
            ),
            // if (formProvider.formData[attribute.id] == null)
            //   const Padding(
            //       padding: EdgeInsets.only(left: 16.0),
            //       child: Text(
            //         "Please select Yes or No",
            //         style: TextStyle(color: Colors.red, fontSize: 14),
            //       )),
          ],
        );
      },
    );
  }
}
