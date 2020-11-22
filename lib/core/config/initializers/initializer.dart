import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:form_filler/core/config/initializers/injection_container_initializer.dart'
    as _service_locator;
import 'package:form_filler/core/config/params/init_app_params.dart';

void initMain() async {
  _service_locator.init();
  await DotEnv().load('./../../../.env');
}

void initApp({@required InitAppParams params}) {}
