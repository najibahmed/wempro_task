import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/form_field_model.dart';
import '../providers/form_provider.dart';

class FormFieldWidget extends StatelessWidget {
  final Attribute attribute;

  const FormFieldWidget({Key? key, required this.attribute}) : super(key: key);

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

  const RadioGroupWidget({Key? key, required this.attribute}) : super(key: key);

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

  const DropdownWidget({Key? key, required this.attribute}) : super(key: key);

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
            SizedBox(height: 5,),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "0 ${attribute.title}",
                  labelStyle: TextStyle(fontWeight: FontWeight.bold)),
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
          ],
        );
      },
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  final Attribute attribute;

  const TextFieldWidget({Key? key, required this.attribute}) : super(key: key);

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
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Type ${attribute.title}"),
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
          ],
        );
      },
    );
  }
}

class CheckboxWidget extends StatelessWidget {
  final Attribute attribute;

  const CheckboxWidget({Key? key, required this.attribute}) : super(key: key);

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
            Row(
              children: [
                Checkbox(
                  value: formProvider.formData[attribute.id] == true,
                  onChanged: (value) {
                    formProvider.updateField(attribute.id, value);
                  },
                ),
                Text("Yes"),
              ],
            ),
            // Row(
            //   children: [
            //     Checkbox(
            //       value: formProvider.formData[attribute.id] == true,
            //       onChanged: (value) {
            //         formProvider.updateField(attribute.id, value);
            //       },
            //     ),
            //     Text("No"),
            //   ],
            // ),

            // Column(
            //   children: attribute.options.map<Widget>((option) {
            //     return CheckboxListTile(
            //       title: Text(attribute.title),
            //       value: formProvider.formData[attribute.id] == true,
            //       onChanged: (value) {
            //         formProvider.updateField(attribute.id, value);
            //       },
            //
            //     );
            //   }).toList(),
            // ),
          ],
        );
      },
    );
  }
}
