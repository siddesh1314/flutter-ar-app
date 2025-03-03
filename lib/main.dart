import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';

import 'package:vector_math/vector_math_64.dart';

import 'ar_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImageSelectionScreen(),
    );
  }
}

class ImageSelectionScreen extends StatelessWidget {
  final List<Map<String, String>> images = [
    {
      "thumbnail": "assets/thumbnails/image1.png",
      "model":
          "https://github.com/microsoft/experimental-pcf-control-assets/blob/master/chair.glb?raw=true"
    },
    {
      "thumbnail": "assets/thumbnails/image2.png",
      "model":
          "https://github.com/KhronosGroup/glTF-Sample-Assets/blob/main/Models/ChairDamaskPurplegold/glTF-Binary/ChairDamaskPurplegold.glb?raw=true"
    },
    {
      "thumbnail": "assets/thumbnails/image3.png",
      "model":
          "https://github.com/KhronosGroup/glTF-Sample-Assets/blob/main/Models/SheenChair/glTF-Binary/SheenChair.glb?raw=true"
    },
    {
      "thumbnail": "assets/thumbnails/caterpie.png",
      "model":
          "https://github.com/Sudhanshu-Ambastha/Pokemon-3D/blob/main/models/glb/regular/10.glb?raw=true"
    },
    {
      "thumbnail": "assets/thumbnails/cubone.png",
      "model":
          "https://github.com/Sudhanshu-Ambastha/Pokemon-3D/blob/main/models/glb/regular/104.glb?raw=true"
    },
    {
      "thumbnail": "assets/thumbnails/bulbasaur.png",
      "model":
          "https://github.com/Sudhanshu-Ambastha/Pokemon-3D/blob/main/models/glb/regular/1.glb?raw=true"
    },
  ];

  ImageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select an Image for AR")),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFFF5722),
              ),
              child: Text(
                "Simple AR app\n~Siddesh",
                style: TextStyle(color: Color(0xFFf5d8d3), fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context); // Close drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {
                Navigator.pop(context); // Close drawer
              },
            ),
          ],
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Display two images per row
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ARScreen(imagePath: images[index]["model"]!),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child:
                    Image.asset(images[index]["thumbnail"]!, fit: BoxFit.cover),
              ),
            ),
          );
        },
      ),
    );
  }
}
