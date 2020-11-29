import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:form_filler/core/config/initializers/dependencies/injection_container_initializer.dart'
    as _service_locator;
import 'package:form_filler/core/config/params/init_app_params.dart';

void initMain() async {
  await DotEnv().load('.env');
  _service_locator.init();
}

void initApp({@required InitAppParams params}) {}
