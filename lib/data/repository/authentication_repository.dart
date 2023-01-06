import 'package:charity/data/datasource/authentication_dataSource.dart';
import 'package:charity/di/di.dart';
import 'package:charity/util/auth_manager.dart';

import 'package:dartz/dartz.dart';

import '../../util/api_exception.dart';

abstract class IAuthRepository {
  Future<Either<List<String?>?, String>> register(
    String username,
    String phone,
    String email,
    String deviceName,
    String password,
    String paswordConfirm,
  );

  Future<Either<List<String?>?, String>> login(
    String phone,
    String password,
    String deviceName,
  );
}

class AuthenticationRepository implements IAuthRepository {
  final IAuthenticationDataSurce _dataSurce = locator.get();

  //RegisterExseptions
  List<String?>? errorRegister;
  static RegisterErrorModel registerErrorModel =
      RegisterErrorModel('', '', '', '', '');
  dynamic nameRegisterE;
  dynamic phoneRegisterE;
  dynamic emailRegisterE;
  dynamic passwordRegisterE;
  dynamic unknowRegisterE;
  //loginExseptions
  List<String?>? errorLogin;
  static LoginErrorModel loginErrorModel = LoginErrorModel('', '', '', '');

  dynamic phoneLoginE;
  dynamic passwordLoginE;
  dynamic unknowLoginE;
  dynamic messageLoginE;
  @override
  Future<Either<List<String?>?, String>> register(
      String username,
      String phone,
      String email,
      String deviceName,
      String password,
      String paswordConfirm) async {
    try {
      String _token = await _dataSurce.register(
          username, phone, email, deviceName, password, paswordConfirm);

      if (AuthenticationRemote.checkRegisterErrors['status'] == 'success') {
        AuthManager.saveToken(_token);

        return right('ثبت نام انجام شد');
      } else {
        // AuthenticationRemote.checkerrors;
        if (await AuthenticationRemote.checkRegisterErrors['errors']['name'] !=
            null) {
          nameRegisterE = await AuthenticationRemote
              .checkRegisterErrors['errors']['name'][0];
        } else {
          nameRegisterE = '';
        }
        if (await AuthenticationRemote.checkRegisterErrors['errors']['phone'] !=
            null) {
          phoneRegisterE = await AuthenticationRemote
                  .checkRegisterErrors['errors']['phone'][0] ??
              '';
        } else {
          phoneRegisterE = '';
        }
        if (await AuthenticationRemote.checkRegisterErrors['errors']
                ['password'] !=
            null) {
          passwordRegisterE = await AuthenticationRemote
                  .checkRegisterErrors['errors']['password'][0] ??
              '';
        } else {
          passwordRegisterE = '';
        }
        if (await AuthenticationRemote.checkRegisterErrors['errors']['email'] !=
            null) {
          emailRegisterE = await AuthenticationRemote
                  .checkRegisterErrors['errors']['email'][0] ??
              '';
        } else {
          emailRegisterE = '';
        }

        unknowRegisterE = '';

        registerErrorModel.name = nameRegisterE;
        registerErrorModel.phone = phoneRegisterE;
        registerErrorModel.email = emailRegisterE;
        registerErrorModel.password = passwordRegisterE;
        registerErrorModel.unknow = unknowRegisterE;
        errorRegister = [
          registerErrorModel.name,
          registerErrorModel.phone,
          registerErrorModel.email,
          registerErrorModel.password,
          registerErrorModel.unknow,
        ];
        return left(errorRegister);
      }
    } on ApiException catch (ex) {
      registerErrorModel.unknow = ex.message;
      return left(errorRegister);
    }
  }

  @override
  Future<Either<List<String?>?, String>> login(
    String phone,
    String password,
    String device,
  ) async {
    try {
      String? _token = await _dataSurce.login(phone, password, device);
      if (_token.isNotEmpty) {
        AuthManager.saveToken(_token);
        print('oth2 ==  ' + _token);

        return right('ورود موفقیت آمیز');
      } else {
        if (await AuthenticationRemote.checkLoginErrors['errors']['phone'] !=
            null) {
          phoneLoginE = await AuthenticationRemote.checkLoginErrors['errors']
                  ['phone'][0] ??
              '';
        } else {
          phoneLoginE = '';
        }
        if (await AuthenticationRemote.checkLoginErrors['errors']['password'] !=
            null) {
          passwordLoginE = await AuthenticationRemote.checkLoginErrors['errors']
                  ['password'][0] ??
              '';
        } else {
          passwordLoginE = '';
        }
        if (await AuthenticationRemote.checkLoginErrors['errors']['massage'] !=
            null) {
          messageLoginE = await AuthenticationRemote.checkLoginErrors['errors']
                  ['massage'] ??
              '';
        } else {
          messageLoginE = '';
        }
        unknowLoginE = '';
        loginErrorModel.phone = phoneLoginE;
        loginErrorModel.password = passwordLoginE;
        loginErrorModel.message = messageLoginE;
        loginErrorModel.unknow = unknowLoginE;

        errorLogin = [
          loginErrorModel.phone,
          loginErrorModel.password,
          loginErrorModel.unknow,
          messageLoginE,
        ];
        return left(errorLogin);
      }
    } on ApiException catch (ex) {
      loginErrorModel.unknow = ex.message;

      return left(errorLogin);
    }
  }
}
