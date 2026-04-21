// coverage:ignore-file

import 'package:injectable/injectable.dart';
import 'package:registration_form/core/infrastructure/environment/environment_variables.dart';
import 'package:registration_form/core/service_registrar.dart';

@module
abstract class EnvironmentModule {
  @lazySingleton
  @appServerUrl
  String getAppServerUrl(EnvironmentVariables environmentVariables) => environmentVariables.appServerUrl;
}
