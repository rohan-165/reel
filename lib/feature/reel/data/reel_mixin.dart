import 'package:share_plus/share_plus.dart';

mixin ReelMixin {
  void shareLink({required String url}) async {
    // Implement sharing functionality using the platform's share API
    await Share.share(url, subject: 'Check out this reel!');
  }
}
