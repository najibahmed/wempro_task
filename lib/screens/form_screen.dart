import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wempro_interview_task/screens/summury_screen.dart';
import '../Widgets/form_field.dart';
import '../providers/form_provider.dart';


class FormScreen extends StatelessWidget {
  static const String routeName='/form';

  const FormScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Input Types"),centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: Provider.of<FormProvider>(context, listen: false).fetchFormData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error loading data: ${snapshot.error}"));
            } else {
              return Consumer<FormProvider>(
                builder: (context, formProvider, child) {
                  return SingleChildScrollView(
                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...formProvider.formFieldModel!.jsonResponse.attributes.map((attribute) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: FormFieldWidget(attribute: attribute),
                          );
                        }),
                        const SizedBox(height: 20),
                        Center(
                          child: SizedBox(
                            height: 50,
                            width: 400,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              onPressed: () {
                                if (formProvider.validateForm()) {
                                  Navigator.pushNamed(context, SummaryScreen.routeName);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Please fill in all required fields")),
                                  );
                                }
                              },
                              child: const Text("Submit",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,)
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
