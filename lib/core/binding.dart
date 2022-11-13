import 'package:get/get.dart';
import 'package:getx_with_ddd_modular/app/network/db_repository.dart';
import 'package:getx_with_ddd_modular/app/network/global_variable.dart';
import 'package:getx_with_ddd_modular/app/network/provider/api_provider.dart';
import 'package:getx_with_ddd_modular/app/network/provider/db_provider.dart';
import 'package:getx_with_ddd_modular/app/network/provider/dl_provider.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // PREPARATION BASIC DEPENDENCY
    Get.put(APIProvider(), permanent: true);
    Get.put(DBProvider(), permanent: true);
    Get.put(DLProvider(), permanent: true);
    Get.put(GlobalVariables(), permanent: true);
    Get.put(
        DataSourceRepository(apiProvider: Get.find(), dbProvider: Get.find()),
        permanent: true);

    ///AUTH
    // Module Sign In
    // Get.put(SignInRemoteDataSource(apiProvider: Get.find()), permanent: true);
    // Get.put(SignInFactory(), permanent: true);
    // Get.put(SignInRepository(), permanent: true);
    // Get.put(SignInAppService(), permanent: true);

    //Module Request Reset Password
    // Get.put(ReqResetPassDataSource(), permanent: true);
    // Get.put(ReqResetPassFactory(), permanent: true);
    // Get.put(ReqResetPassRepository(), permanent: true);
    // Get.put(ReqResetPassAppService(), permanent: true);

    //Module Reset Password
    // Get.put(ResetPassDataSource(), permanent: true);
    // Get.put(ResetPassFactory(), permanent: true);
    // Get.put(ResetPassRepository(), permanent: true);
    // Get.put(ResetPassAppService(), permanent: true);
    // Get.put(ResetPassValidation(), permanent: true);

    ///PROFILE
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
