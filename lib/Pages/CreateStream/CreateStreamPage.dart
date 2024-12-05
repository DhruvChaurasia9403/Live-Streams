import 'package:flutter/material.dart';
import 'package:streamstreak/Widgets/TextFields.dart';

class CreateStreamPage extends StatefulWidget {
  const CreateStreamPage({super.key});

  @override
  State<CreateStreamPage> createState() => _CreateStreamPageState();
}

class _CreateStreamPageState extends State<CreateStreamPage> {
  final TextEditingController urlController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  String selectedPlatform = "YouTube"; // Default value for dropdown

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Stream",style: Theme.of(context).textTheme.headlineSmall?.copyWith(color:Theme.of(context).colorScheme.primaryContainer))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              "Stream URL",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(height: 8),
            SearchHome(text: "Paste Your Streaming Link"),
            SizedBox(height: 20),
            Text(
              "Select Platform",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedPlatform,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
                )
              ),
              onChanged: (value) {
                setState(() {
                  selectedPlatform = value!;
                });
              },
              items: ["YouTube", "Twitch", "Facebook", "Other"]
                  .map((platform) => DropdownMenuItem(
                value: platform,
                child: Text(platform),
              ))
                  .toList(),
            ),
            SizedBox(height: 20),
            Text(
              "Stream Title",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(height: 8),
            SearchHome(text: "Video / Stream Title"),
            SizedBox(height: 16),


            //add a image picker
          ],
        ),
      ),
    );
  }
}
