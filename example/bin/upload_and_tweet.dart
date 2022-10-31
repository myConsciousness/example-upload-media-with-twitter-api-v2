import 'dart:io';

import 'package:twitter_api_v2/twitter_api_v2.dart';

Future<void> main() async {
  final twitter = TwitterApi(
    bearerToken: 'YOUR_BEARER_TOKEN',
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
      onProgress: (event) {
        switch (event.state) {
          case UploadState.preparing:
            print('Upload is preparing...');
            break;
          case UploadState.inProgress:
            print('${event.progress}% completed...');
            break;
          case UploadState.completed:
            print('Upload has completed!');
            break;
        }
      },
      onFailed: (error) => print('Upload failed. Due to "${error.message}"'),
    );

    await twitter.tweets.createTweet(
      text: 'Tweet with media!',
      media: TweetMediaParam(
        mediaIds: [
          uploadedMedia.data.id,
        ],
      ),
    );
  } on TwitterUploadException catch (e) {
    print(e);
  }
}
