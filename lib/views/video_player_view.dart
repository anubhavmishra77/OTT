import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:better_player_plus/better_player_plus.dart';
import 'package:preload_page_view/preload_page_view.dart';
import '../controllers/video_player_controller.dart';
import '../models/video.dart';

class VideoPlayerView extends GetView<VideoPlayerController> {
  const VideoPlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Obx(() {
        if (controller.videos.isEmpty) {
          return Center(
            child: Text(
              'No videos available',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          );
        }

        return Stack(
          children: [
            SizedBox.expand(
              child: PreloadPageView.builder(
                controller: controller.pageController,
                scrollDirection: Axis.vertical,
                itemCount: controller.videos.length,
                onPageChanged: controller.onPageChanged,
                preloadPagesCount: 3,
                itemBuilder: (context, index) {
                  final video = controller.videos[index];
                  return VideoPlayerPage(
                    video: video,
                    isCurrentPage: index == controller.currentIndex.value,
                  );
                },
              ),
            ),
            Positioned(
              top: 50,
              left: 16,
              child: SafeArea(
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: controller.goBack,
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              right: 16,
              child: VideoControls(),
            ),
          ],
        );
      }),
    );
  }
}

class VideoPlayerPage extends GetView<VideoPlayerController> {
  final Video video;
  final bool isCurrentPage;

  const VideoPlayerPage({
    Key? key,
    required this.video,
    required this.isCurrentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black,
      child: Stack(
        children: [
          // Video Player - Full Screen
          if (isCurrentPage)
            Positioned.fill(
              child: _buildVideoPlayer(context),
            )
          else
            Container(color: Colors.black),

          // Full Screen Tap Area for Play/Pause
          if (isCurrentPage)
            Positioned.fill(
              child: _buildPlayPauseOverlay(context),
            ),

          // Video Info Overlay
          Positioned(
            bottom: 120,
            left: 16,
            right: 80,
            child: VideoInfoOverlay(video: video),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoPlayer(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Container(
          color: Colors.black,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            ),
          ),
        );
      }

      if (controller.betterPlayerController == null) {
        return Container(
          color: Colors.black,
          child: Center(
            child: Icon(
              Icons.error,
              color: Colors.white,
              size: 64,
            ),
          ),
        );
      }

      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: BetterPlayer(
              controller: controller.betterPlayerController!,
            ),
          ),
        ),
      );
    });
  }

  Widget _buildPlayPauseOverlay(BuildContext context) {
    return GetBuilder<VideoPlayerController>(
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            if (controller.betterPlayerController != null) {
              if (controller.isPlaying.value) {
                controller.betterPlayerController!.pause();
              } else {
                controller.betterPlayerController!.play();
              }
            }
          },
          child: Container(
            color: Colors.transparent,
            child: Obx(() => AnimatedOpacity(
                  opacity: controller.isPlaying.value ? 0.0 : 1.0,
                  duration: Duration(milliseconds: 300),
                  child: Center(
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 48,
                      ),
                    ),
                  ),
                )),
          ),
        );
      },
    );
  }
}

class VideoInfoOverlay extends StatelessWidget {
  final Video video;

  const VideoInfoOverlay({
    Key? key,
    required this.video,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          video.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          video.description,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(
              Icons.star,
              color: Colors.yellow,
              size: 16,
            ),
            SizedBox(width: 4),
            Text(
              video.rating.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 16),
            Icon(
              Icons.access_time,
              color: Colors.white70,
              size: 16,
            ),
            SizedBox(width: 4),
            Text(
              video.duration,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class VideoControls extends GetView<VideoPlayerController> {
  const VideoControls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Previous video button
        Container(
          decoration: BoxDecoration(
            color: Colors.black54,
            shape: BoxShape.circle,
          ),
          child: Obx(() => IconButton(
                icon: Icon(
                  Icons.skip_previous,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: controller.currentIndex.value > 0
                    ? controller.previousVideo
                    : null,
              )),
        ),
        SizedBox(height: 16),
        // Next video button
        Container(
          decoration: BoxDecoration(
            color: Colors.black54,
            shape: BoxShape.circle,
          ),
          child: Obx(() => IconButton(
                icon: Icon(
                  Icons.skip_next,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed:
                    controller.currentIndex.value < controller.videos.length - 1
                        ? controller.nextVideo
                        : null,
              )),
        ),
        SizedBox(height: 16),
        // Share button
        Container(
          decoration: BoxDecoration(
            color: Colors.black54,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.white,
              size: 24,
            ),
            onPressed: () {
              Get.snackbar(
                'Share',
                'Share functionality',
                backgroundColor: Colors.black54,
                colorText: Colors.white,
              );
            },
          ),
        ),
        SizedBox(height: 16),
        // Favorite button
        Container(
          decoration: BoxDecoration(
            color: Colors.black54,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: Colors.white,
              size: 24,
            ),
            onPressed: () {
              Get.snackbar(
                'Favorite',
                'Added to favorites',
                backgroundColor: Colors.black54,
                colorText: Colors.white,
              );
            },
          ),
        ),
      ],
    );
  }
}
