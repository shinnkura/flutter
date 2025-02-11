import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void getToken() async {
  Response response = await Dio().post(
    'https://accounts.spotify.com/api/token',
    data: {
      'grant_type': 'client_credentials',
      'client_id': dotenv.env['SPOTIFY_CLIENT_ID'],
      'client_secret': dotenv.env['SPOTIFY_CLIENT_SECRET'],
    },
    options: Options(
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    ),
  );
  print(response.data['access_token']);
}
