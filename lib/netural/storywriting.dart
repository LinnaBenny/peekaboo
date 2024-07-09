import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:typed_data';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Story Writer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ImageStoryWriterPage(),
    );
  }
}

class ImageStoryWriterPage extends StatefulWidget {
  @override
  _ImageStoryWriterPageState createState() => _ImageStoryWriterPageState();
}

class _ImageStoryWriterPageState extends State<ImageStoryWriterPage> {
  TextEditingController storyController = TextEditingController();
  String selectedImageUrl = '';
  Color borderColor = Colors.transparent;
  int selectedImageIndex = -1; 

  void downloadPage() {
    if (selectedImageUrl.isEmpty || selectedImageIndex == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select an image.'),
        ),
      );
      return;
    }

   
    String imageUrl = 'image/story${selectedImageIndex + 1}.jpg';

    // Assemble HTML content with the selected image URL and story content
    String htmlContent = '''
      <!DOCTYPE html>
      <html>
        <head>
          <title>Image Story</title>
        </head>
        <body>
          <img src="$imageUrl" alt="Image" style="width: 100%; height: auto;">
          <h2>Story:</h2>
          <p>${storyController.text}</p>
        </body>
      </html>
    ''';

    
    Uint8List bytes = Uint8List.fromList(htmlContent.codeUnits);

    var blob = html.Blob([bytes], 'text/html');

    var url = html.Url.createObjectUrlFromBlob(blob);
    var anchor = html.AnchorElement(href: url)
      ..setAttribute('download', 'story.html');
    
    html.document.body?.append(anchor);
    anchor.click();

   
    html.Url.revokeObjectUrl(url);
    anchor.remove();
  }

  void selectImage(String imageUrl, int index) {
    setState(() {
      selectedImageUrl = imageUrl;
      borderColor = Colors.lightBlue;
      selectedImageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Story Writer'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 250,
                height: 180,
                decoration: BoxDecoration(
                  border: Border.all(color: borderColor),
                ),
                child: selectedImageUrl.isNotEmpty
                    ? Image.asset(
                        selectedImageUrl,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Placeholder(
                        fallbackHeight: 180,
                        fallbackWidth: 250,
                      ),
              ),
              SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                children: List.generate(
                  6,
                  (index) {
                    return GestureDetector(
                      onTap: () {
                        selectImage('image/story${index + 1}.jpg', index);
                      },
                      child: Image.asset(
                        'image/story${index + 1}.jpg',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: storyController,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Write your story',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: downloadPage,
                child: Text('Download'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
