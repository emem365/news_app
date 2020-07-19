
class Article {
  String sourceID;
  String sourceName;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  DateTime publishedAt;
  String content;

  Article({
    this.sourceID,
    this.sourceName,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map json) => Article(
        sourceID: json['source']['id'] ?? '[\'null\']',
        sourceName: json['source']['name'] ?? '[\'null\']',
        author: json['author'] ?? '[\'null\']',
        title: json['title'] ?? '[\'null\']',
        description: json['description'] ?? '[\'null\']',
        url: json['url'] ?? '[\'null\']',
        urlToImage: json['urlToImage'] ?? '[\'null\']',
        publishedAt: DateTime.parse(json['publishedAt']) ?? null,
        content: json['content'] ?? '[\'null\']',
      );

  String toString() {
    return 'Article($title, $sourceName, $publishedAt)';
  }
}
