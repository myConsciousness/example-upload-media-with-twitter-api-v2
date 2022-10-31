import 'dart:io';

import 'package:twitter_api_v2/twitter_api_v2.dart';

Future<void> main() async {
  final twitter = TwitterApi(
    bearerToken: 'NO_NEED_OAUTH2_AUTHORIZATION',
    oauthTokens: OAuthTokens(
      consumerKey: 'YOUR_CONSUMER_KEY',
      consumerSecret: 'YOUR_CONSUMER_SECRET',
      accessToken: 'YOUR_ACCESS_TOKEN',
      accessTokenSecret: 'YOUR_ACCESS_TOKEN_SECRET',
    ),
  );

  try {
    final uploadedMedia = await twitter.media.uploadMedia(
      file: File.fromUri(
        Uri.file('funny_movie.mp4'),
      ),
      altText: 'This is alt text!',
    );

    print(uploadedMedia);
  } on TwitterUploadException catch (e) {
    print(e);
  }
}
