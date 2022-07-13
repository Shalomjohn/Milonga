import 'package:url_launcher/url_launcher.dart';

enum SocialMedia { facebook, twitter, email, linkedin, whatsapp }

Future share(SocialMedia socialPlatform) async {
  String appURL = '';
  const subject = 'Introducing Milonga';
  const text =
      'Milonga helps you to learn how to dance using your phone. Download now!';
  final urlShare = Uri.encodeComponent(appURL);

  final urls = {
    SocialMedia.facebook:
        'https://www.facebook.com/sharer/sharer.php?u=$urlShare&t=$text',
    SocialMedia.twitter:
        'https://twitter.com/intent/tweet?url=$urlShare&text=$text',
    SocialMedia.email: 'mailto:?subject=$subject&body=$text\n\n$urlShare',
    SocialMedia.linkedin:
        'https://www.linkedin.com/shareArticle?mini=true&url=$urlShare',
    SocialMedia.whatsapp: 'https://api.whatsapp.com/send?text=$text$urlShare'
  };
  final url = urls[socialPlatform];

  if (await canLaunchUrl(Uri.parse(url!))) {
    await launchUrl(Uri.parse(url));
  }
}
