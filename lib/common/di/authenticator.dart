import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:vegan_liverpool/utils/onboard/Istrategy.dart';
import 'package:vegan_liverpool/utils/onboard/authentication.dart';

@module
abstract class AuthenticationInjectableModule {
  @lazySingleton
  Authentication get authenticator => Authentication();
}
