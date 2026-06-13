import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../models/media_item.dart';
import '../services/content_service.dart';

class SignagePlayerScreen extends StatefulWidget {
  const SignagePlayerScreen({super.key});

  @override
  State<SignagePlayerScreen> createState() => _SignagePlayerScreenState();
}

class _SignagePlayerScreenState extends State<SignagePlayerScreen> {
  final ContentService contentService = ContentService();
  List<MediaItem> mediaList = [];
  int currentIndex = 0;
  Timer? timer;
  VideoPlayerController? videoController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadContent();
  }

  Future<void> loadContent() async {
    try {
      mediaList = await contentService.getContents();
      if (mediaList.isNotEmpty) {
        await showCurrentMedia();
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> showCurrentMedia() async {
    timer?.cancel();

    await _disposeVideoController();

    final currentItem = mediaList[currentIndex];

    if (currentItem.type == "video") {
      videoController =
          VideoPlayerController.networkUrl(Uri.parse(currentItem.url))
            ..initialize().then((_) {
              setState(() {});
            });

      // await videoController!.initialize();

      await videoController!.play();

      // setState(() {});
    }

    timer = Timer(const Duration(seconds: 10), goToNextMedia);
  }

  Future<void> goToNextMedia() async {
    currentIndex++;

    if (currentIndex >= mediaList.length) {
      currentIndex = 0;
    }

    await showCurrentMedia();

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _disposeVideoController() async {
    if (videoController != null) {
      await videoController!.pause();
      await videoController!.dispose();
      videoController = null;
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    _disposeVideoController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final item = mediaList[currentIndex];
    print("the item type is ${item.type}");

    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: item.type == "image"
            ? Image.network(
                item.url,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return const Center(
                    child: Text(
                      'Image Load Failed',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              )
            : videoController != null && videoController!.value.isInitialized
            ? FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: videoController!.value.size.width,
                  height: videoController!.value.size.height,
                  child: VideoPlayer(videoController!),
                ),
              )
            : const Center(child: CircularProgressIndicator(color: Colors.red)),
      ),
    );
  }
}
