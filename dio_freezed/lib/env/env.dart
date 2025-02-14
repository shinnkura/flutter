import 'package:envied/envied.dart';
part 'env.g.dart';

// requireEnvFileがtrueの場合、.envファイルがないとエラーが出る
@Envied(requireEnvFile: true, path: '.env')
final class Env {
  @EnviedField(varName: 'DB_PASSWORD', obfuscate: true)
  static String dbPassword = _Env.dbPassword; 
  @EnviedField(varName: 'DB_PORT')
  static String dbPort = _Env.dbPort;
}
