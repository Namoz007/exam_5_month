import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../../controllers/recipe_add_controller.dart';

class VideoUploadWidget extends StatefulWidget {
  @override
  _VideoUploadWidgetState createState() => _VideoUploadWidgetState();
}

class _VideoUploadWidgetState extends State<VideoUploadWidget> {
  VideoPlayerController? _controller;
  String? _videoPath;

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  Future<void> _pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null) {
      _videoPath = result.files.single.path;

      _controller = VideoPlayerController.file(File(_videoPath!))
        ..initialize().then((_) {
          setState(() {}); // Refresh the UI to show the video player
        });
    }
  }

  _onContinuePressed() {
    final recipeAddController = context.read<RecipeAddController>();
    recipeAddController.addVideo(_videoPath ?? "");
    recipeAddController.pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.bounceIn);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: GestureDetector(
              onTap: _pickVideo,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: _controller == null
                      ? const Icon(Icons.videocam, size: 50)
                      : _controller!.value.isInitialized
                          ? AspectRatio(
                              aspectRatio: _controller!.value.aspectRatio,
                              child: VideoPlayer(_controller!),
                            )
                          : const CircularProgressIndicator(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _controller != null
                ? () {
                    if (_controller!.value.isPlaying) {
                      _controller?.pause();
                    } else {
                      _controller?.play();
                    }
                  }
                : null,
            child: Text(_controller != null && _controller!.value.isPlaying
                ? 'Pause'
                : 'Play'),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: _onContinuePressed,
            child: Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: const Color(0xffFF9B05),
              ),
              child: const Text(
                "Continue",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
