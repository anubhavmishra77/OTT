import 'package:get/get.dart';
import '../models/category.dart';
import '../models/video.dart';
import '../services/data_service.dart';

class HomeController extends GetxController {
  final RxList<Category> categories = <Category>[].obs;
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final loadedCategories = await DataService.loadCategories();
      categories.value = loadedCategories;

      if (categories.isEmpty) {
        errorMessage.value = 'No content available';
      }
    } catch (e) {
      errorMessage.value = 'Failed to load content: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToVideo(Video video) {
    final allVideos = DataService.getAllVideos(categories);
    final currentIndex = allVideos.indexWhere((v) => v.id == video.id);

    Get.toNamed('/video-player', arguments: {
      'videos': allVideos,
      'currentIndex': currentIndex,
    });
  }

  Future<void> refreshData() async {
    await loadData();
  }
}
