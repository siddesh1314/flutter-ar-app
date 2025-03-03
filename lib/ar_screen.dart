import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart';

class ARScreen extends StatefulWidget {
  final String imagePath;

  const ARScreen({super.key, required this.imagePath});

  @override
  State<ARScreen> createState() => _ARScreenState();
}

class _ARScreenState extends State<ARScreen> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARNode? imageNode;

  void updateNode(Vector3 newPosition, Vector3 newScale) {
    if (imageNode != null) {
      setState(() {
        imageNode!.position = newPosition;
        imageNode!.scale = newScale;
      });
      //print("Node updated: Position: $newPosition, Scale: $newScale");
    }
  }

  @override
  void dispose() {
    arSessionManager?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AR View")),
      body: Stack(
        children: [
          ARView(onARViewCreated: onARViewCreated),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add, size: 40), // Zoom In
                      onPressed: () {
                        if (imageNode != null) {
                          updateNode(
                            imageNode!.position,
                            imageNode!.scale * 1.1, // Inc scale by 10%
                          );
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove, size: 40), // Zoom Out
                      onPressed: () {
                        if (imageNode != null) {
                          updateNode(
                            imageNode!.position,
                            imageNode!.scale * 0.9, // Dec scale by 10%
                          );
                        }
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, size: 40),
                      onPressed: () {
                        if (imageNode != null) {
                          updateNode(
                            Vector3(imageNode!.position.x - 0.1,
                                imageNode!.position.y, imageNode!.position.z),
                            imageNode!.scale,
                          );
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_upward, size: 40),
                      onPressed: () {
                        if (imageNode != null) {
                          updateNode(
                            Vector3(
                                imageNode!.position.x,
                                imageNode!.position.y + 0.1,
                                imageNode!.position.z),
                            imageNode!.scale,
                          );
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_downward, size: 40),
                      onPressed: () {
                        if (imageNode != null) {
                          updateNode(
                            Vector3(
                                imageNode!.position.x,
                                imageNode!.position.y - 0.1,
                                imageNode!.position.z),
                            imageNode!.scale,
                          );
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward, size: 40),
                      onPressed: () {
                        if (imageNode != null) {
                          updateNode(
                            Vector3(imageNode!.position.x + 0.1,
                                imageNode!.position.y, imageNode!.position.z),
                            imageNode!.scale,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onARViewCreated(
    ARSessionManager sessionManager,
    ARObjectManager objectManager,
    ARAnchorManager? anchorManager,
    ARLocationManager locationManager,
  ) {
    arSessionManager = sessionManager;
    arObjectManager = objectManager;
    _loadARImage(widget.imagePath);
  }

  Future<void> _loadARImage(String imagePath) async {
    if (arObjectManager == null) return;

    final newNode = ARNode(
      type: NodeType.webGLB,
      uri: imagePath,
      scale: Vector3(0.5, 0.5, 0.5),
      position: Vector3(0, 0, -1),
    );

    bool success = await arObjectManager!.addNode(newNode) ?? false;
    if (success) {
      setState(() {
        imageNode = newNode;
      });
    }
  }
}
