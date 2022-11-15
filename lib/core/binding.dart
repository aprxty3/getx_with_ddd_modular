import 'package:get/get.dart';
import 'package:getx_with_ddd_modular/app/network/db_repository.dart';
import 'package:getx_with_ddd_modular/app/network/global_variable.dart';
import 'package:getx_with_ddd_modular/app/network/provider/api_provider.dart';
import 'package:getx_with_ddd_modular/app/network/provider/db_provider.dart';
import 'package:getx_with_ddd_modular/feature/core/application/request_reset_pass_app_service.dart';
import 'package:getx_with_ddd_modular/feature/core/infrastructure/reset_pass/data_source/request_reset_data_source.dart';
import 'package:getx_with_ddd_modular/feature/core/infrastructure/reset_pass/repository/request_reset_pass_repository.dart';
import 'package:getx_with_ddd_modular/feature/core/infrastructure/reset_pass/request_reset_pass_factory.dart';

import '../feature/core/application/sign_in_app_service.dart';
import '../feature/core/infrastructure/sign_in/data_source/sign_in_remote_data_source.dart';
import '../feature/core/infrastructure/sign_in/repository/sign_in_repository.dart';
import '../feature/core/infrastructure/sign_in/sign_in_factory.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // PREPARATION BASIC DEPENDENCY
    Get.put(APIProvider());
    Get.put(APIProvider(), tag: 'APIProvider');
    Get.put(DBProvider(), permanent: true);
    Get.put(GlobalVariables(), permanent: true);
    Get.put(
        DataSourceRepository(apiProvider: Get.find(), dbProvider: Get.find()),
        permanent: true);

    //TODO : dont forget to add bindings when you finished create App Service, Domain, & Infrastructure Directory

    ///AUTH
    // Module Sign In
    Get.put(SignInRemoteDataSource(apiProvider: Get.find()), permanent: true);
    Get.put(SignInFactory(), permanent: true);
    Get.put(SignInRepository(), permanent: true);
    Get.put(SignInAppService(), permanent: true);

    //Module Request Reset Password
    Get.put(RequestResetPassDataSource(), permanent: true);
    Get.put(RequestResetPassFactory(), permanent: true);
    Get.put(RequestResetPassRepository(), permanent: true);
    Get.put(RequestResetPassAppService(), permanent: true);

    ///Main
    //Modul Get Profile
    // Get.put(GetProfileDataSource(), permanent: true);
    // Get.put(GetProfileRepository(), permanent: true);
    // Get.put(GetProfileAppService(), permanent: true);

    //Modul Edit Profile
    // Get.put(EditProfileDataSource(), permanent: true);
    // Get.put(EditProfileFactory(), permanent: true);
    // Get.put(EditProfileRepository(), permanent: true);
    // Get.put(EditProfileAppService(), permanent: true);

    //Modul Change Password
    // Get.put(ChangePasswordDataSource(), permanent: true);
    // Get.put(ChangePasswordFactory(), permanent: true);
    // Get.put(ChangePasswordRepository(), permanent: true);
    // Get.put(ChangePasswordAppService(), permanent: true);
  }
}
