import 'package:get/get.dart';

import '../domain/get_profile/interface/get_profile_repository_base.dart';
import '../infrastructure/get_profile/repository/get_profile_repository.dart';

class GetProfileAppService {
  final GetProfileRepoBase _repository = Get.find<GetProfileRepo>();
}
