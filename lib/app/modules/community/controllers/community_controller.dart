import 'package:get/get.dart';

import '../../../data/models/community_model.dart';
import '../../../data/repository/community_repository.dart';

class CommunityController extends GetxController {
  var communities = <Community>[].obs;
  var isLoading = false.obs;

  final CommunityRepository repository = CommunityRepository();

  @override
  void onInit() {
    super.onInit();
    fetchCommunities();
  }

  void fetchCommunities() async {
    try {
      isLoading.value = true;
      final data = await repository.fetchCommunities();
      communities.value = data;
    } catch (e) {
      // Tangani error, misal log atau tampilkan snackbar
      print('Error fetching communities: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
