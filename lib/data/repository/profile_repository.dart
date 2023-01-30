import 'package:charity/data/datasource/profile_datasource.dart';
import 'package:charity/di/di.dart';
import 'package:charity/models/profile_model.dart';
import 'package:dartz/dartz.dart';

import '../../constants/constants.dart';
import '../../util/api_exception.dart';
import '../../util/auth_manager.dart';

abstract class IprofileRepository {
  Future<Either<String, ProfileModel>> getProfileDetails();
  Future<Either<String, ProfileUpdateModel>> profileUpdate({
    required String username,
    required String phone,
    required String email,
    // required String deviceName,
    required String address,
    // required String password,
    // required String paswordConfirm,
  });
}

class ProfileRepository extends IprofileRepository {
  String? token = AuthManager.authChangeNotifire.value;
  final ProfileDataSource _dataSource = locator.get();
  @override
  Future<Either<String, ProfileModel>> getProfileDetails() async {
    try {
      var response = await _dataSource.getProfile(token!);
      return right(response);
    } on ApiException catch (e) {
      if (e.code == 304) {
        return left(ErrorsMessages.unAvailable);
      } else {
        return left(e.message ?? 'خطا محتوای متنی ندارد');
      }
    } catch (e) {
      return left('خطای ناشناخته');
    }
  }

  @override
  Future<Either<String, ProfileUpdateModel>> profileUpdate({
    required String username,
    required String phone,
    required String email,
    // required String deviceName,
    required String address,
    // required String password,
    // required String paswordConfirm,
  }) async {
    try {
      var response = await _dataSource.updateProfile(
        address: address,
        deviceName: 'android',
        email: email,
        // password: '',
        // paswordConfirm: '',
        phone: phone,
        token: token!,
        username: username,
      );
      return right(response);
    } on ApiException catch (e) {
      if (e.code == 304) {
        return left(ErrorsMessages.unAvailable);
      } else {
        return left(e.message ?? 'خطا محتوای متنی ندارد');
      }
    } catch (e) {
      return left('خطای ناشناخته');
    }
  }
}
