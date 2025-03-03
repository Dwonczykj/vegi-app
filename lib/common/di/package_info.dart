import 'package:injectable/injectable.dart';
import 'package:package_info/package_info.dart';
import 'package:vegan_liverpool/common/di/di.dart';
import 'package:vegan_liverpool/common/di/env.dart';

@Environment(Env.qa)
@Environment(Env.dev)
@Environment(Env.prod)
@module
abstract class PackageInfoDi {
  @preResolve
  Future<PackageInfo> get packageInfo => PackageInfo.fromPlatform();
}

@Environment(Env.qa)
@Environment(Env.dev)
@Environment(Env.prod)
final PackageInfo packageInfo = getIt<PackageInfo>();
