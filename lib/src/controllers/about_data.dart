class AboutData {
  static String logoAsset = 'assets/appIcon-adaptive.png';
  static String appName = 'NewsOnly';
  static List<String> content = [
    "Built using Flutter, Google’s UI toolkit for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase, this mobile application receives data from the \"News API\"",
    'This is an open-source project. Any and all the help is appreciable. Click the link below to find the GitHub Repository. You can also file issues or request features on the GitHub repo'
  ];
  static List<AboutLink> aboutLinks = [
    AboutLink(
      category: 'Creator',
      text: 'Madhur Maurya',
      url: 'https://github.com/emem365',
    ),
    AboutLink(
      category: 'GitHub Repo',
      text: 'emem365/news_app',
      url: 'https://github.com/emem365/news_app',
    ),
    AboutLink(
      category: 'API in use',
      text: 'News API',
      url: 'https://newsapi.org/',
    ),
  ];
}

class AboutLink {
  AboutLink({
    this.category,
    this.text,
    this.url,
  });
  final String category;
  final String text;
  final String url;
}
