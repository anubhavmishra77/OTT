import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';
import '../models/video.dart';

class VideoPlayerController extends GetxController {
  final RxList<Video> videos = <Video>[].obs;
  final RxInt currentIndex = 0.obs;
  final RxBool isPlayerInitialized = false.obs;
  final RxBool isPlaying = false.obs;
  final RxBool isLoading = true.obs;

  late PreloadPageController pageController;
  BetterPlayerController? betterPlayerController;

  @override
  void onInit() {
    super.onInit();

    final arguments = Get.arguments as Map<String, dynamic>;
    videos.value = arguments['videos'] as List<Video>;
    currentIndex.value = arguments['currentIndex'] as int;

    pageController = PreloadPageController(initialPage: currentIndex.value);

    initializePlayer();
  }

  void initializePlayer() {
    if (videos.isNotEmpty && currentIndex.value < videos.length) {
      final currentVideo = videos[currentIndex.value];

      BetterPlayerDataSource dataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        currentVideo.videoUrl,
        videoFormat: BetterPlayerVideoFormat.hls,
        headers: {
          'User-Agent': 'Flutter/BetterPlayer',
          'Accept': '*/*',
          'Accept-Encoding': 'identity',
          'Connection': 'keep-alive',
        },
        useAsmsSubtitles: false,
        useAsmsAudioTracks: false,
        bufferingConfiguration: BetterPlayerBufferingConfiguration(
          minBufferMs: 2000,
          maxBufferMs: 8000,
          bufferForPlaybackMs: 1000,
          bufferForPlaybackAfterRebufferMs: 2000,
        ),
      );

      BetterPlayerConfiguration configuration = BetterPlayerConfiguration(
        autoPlay: true,
        looping: false,
        aspectRatio: 9 / 16,
        fullScreenByDefault: false,
        allowedScreenSleep: false,
        fit: BoxFit.cover,
        handleLifecycle: true,
        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ],
        systemOverlaysAfterFullScreen: [
          SystemUiOverlay.top,
          SystemUiOverlay.bottom,
        ],
        controlsConfiguration: const BetterPlayerControlsConfiguration(
          enablePlayPause: true,
          enableMute: true,
          enableFullscreen: false,
          enablePip: false,
          enableSkips: false,
          enableProgressBar: true,
          enableProgressText: true,
          enableAudioTracks: false,
          enableSubtitles: false,
          enableQualities: false,
          enablePlaybackSpeed: false,
          playerTheme: BetterPlayerTheme.material,
          controlBarColor: Colors.black26,
          progressBarPlayedColor: Colors.red,
          progressBarHandleColor: Colors.red,
          progressBarBufferedColor: Colors.white60,
          progressBarBackgroundColor: Colors.white24,
          showControlsOnInitialize: false,
        ),
      );

      betterPlayerController = BetterPlayerController(
        configuration,
        betterPlayerDataSource: dataSource,
      );

      betterPlayerController?.addEventsListener((event) {
        if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
          isPlayerInitialized.value = true;
          isLoading.value = false;
        } else if (event.betterPlayerEventType == BetterPlayerEventType.play) {
          isPlaying.value = true;
        } else if (event.betterPlayerEventType == BetterPlayerEventType.pause) {
          isPlaying.value = false;
        } else if (event.betterPlayerEventType ==
            BetterPlayerEventType.exception) {
          print('Video player error: ${event.parameters}');
          isLoading.value = false;
        }
      });
    }
  }

  void nextVideo() {
    if (currentIndex.value < videos.length - 1) {
      currentIndex.value++;
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousVideo() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
      pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void onPageChanged(int index) {
    if (index != currentIndex.value) {
      disposeCurrentPlayer();

      currentIndex.value = index;

      isLoading.value = true;
      isPlayerInitialized.value = false;
      isPlaying.value = false;

      Future.delayed(Duration(milliseconds: 100), () {
        if (currentIndex.value == index) {
          initializePlayer();
        }
      });
    }
  }

  void disposeCurrentPlayer() {
    betterPlayerController?.dispose();
    betterPlayerController = null;
  }

  void goBack() {
    Get.back();
  }

  @override
  void onClose() {
    disposeCurrentPlayer();
    pageController.dispose();
    super.onClose();
  }
}
