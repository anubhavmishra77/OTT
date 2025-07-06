import 'package:get/get.dart';
import '../views/home_view.dart';
import '../views/video_player_view.dart';
import '../bindings/home_binding.dart';
import '../bindings/video_player_binding.dart';

class AppRoutes {
  static const String home = '/';
  static const String videoPlayer = '/video-player';

  static List<GetPage> routes = [
    GetPage(
      name: home,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: videoPlayer,
      page: () => VideoPlayerView(),
      binding: VideoPlayerBinding(),
    ),
  ];
}
