import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/form_provider.dart';

class SummaryScreen extends StatelessWidget {
  static const String routeName="/summary";
  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context);

    // Ensure formFieldModel is loaded before displaying data
    if (formProvider.formFieldModel == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Summary")),
        body: const Center(child: Text("No data available")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Selected Input Summary"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: formProvider.formFieldModel!.jsonResponse.attributes.length,
          itemBuilder: (context, index) {
            final attribute = formProvider.formFieldModel!.jsonResponse.attributes[index];
            final selectedValue = formProvider.formData[attribute.id];

            // Only show fields with selected values
            if (selectedValue == null) {
              return const SizedBox.shrink();
            }

            return Card(
              color: Colors.grey[50],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.radio_button_checked),
                    const SizedBox(width: 8,),
                    Text("${attribute.title}:  ${selectedValue==true? "Yes": selectedValue==false? "No":selectedValue }",style: GoogleFonts.fahkwang(fontWeight: FontWeight.bold,color: Colors.black87),)
                  ],
                ),
              ),
            );
            //   ListTile(
            //   title: Text(attribute.title),
            //   subtitle: Text(
            //     selectedValue.toString(),
            //     style: TextStyle(color: Colors.grey[700]),
            //   ),
            // );
          },
        ),
      ),
    );
  }
}
