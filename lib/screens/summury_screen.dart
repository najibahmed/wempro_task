import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/form_provider.dart';

class SummaryScreen extends StatelessWidget {
  static const String routeName = "/summary";

  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context);

    // Ensure formFieldModel is loaded before displaying data
    if (formProvider.formFieldModel == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Summary"),centerTitle: true,),
        body: const Center(child: Text("No data available")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back)),
        title: const Text("Selected Input Summary"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Selected Input",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                Text("${formProvider.formData.length} Items",style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              ],
            ),
            Card(
              child: Column(
                children: List.generate(
                    formProvider.formFieldModel!.jsonResponse.attributes.length,
                    (index) {
                      final attribute =
                      formProvider.formFieldModel!.jsonResponse.attributes[index];
                      final selectedValue = formProvider.formData[attribute.id];

                      // Only show fields with selected values
                      if (selectedValue == null) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.radio_button_checked),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              "${attribute.title}:  ${selectedValue == true ? "Yes" : selectedValue == false ? "No" : selectedValue}",
                              style: GoogleFonts.aBeeZee(
                                  fontWeight: FontWeight.bold, color: Colors.black87),
                            )
                          ],
                        ),
                      );
                    },)
              )
              ),
          InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: const Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Edit Selections",style: TextStyle(fontWeight: FontWeight.bold),),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
          )
          ],
        ),
      ),
    );
  }
}
