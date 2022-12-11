class SearchModel {
  String? status;
  int? totalResults;
  List<Article>? articles;

  //ArticleModel({this.status, this.totalResults, this.articles});

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = <Article>[];
      json['articles'].forEach((e) {
        articles!.add(Article.fromJson(e));
      });
    }
  }
}

class Article {
  Source? source;
  String? author;
  String? title;
  String? desc;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.desc,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> jsonData) {
    return Article(
      source: jsonData['source'] != null
          ? Source.fromJson(jsonData['source'])
          : null,
      author: jsonData['author'],
      title: jsonData['title'],
      desc: jsonData['description'],
      url: jsonData['url'],
      urlToImage: jsonData['urlToImage'],
      publishedAt: jsonData['publishedAt'],
      content: jsonData['content'],
    );
  }
}

class Source {
  dynamic id;
  String? name;
  Source({
    required this.id,
    required this.name,
  });

  factory Source.fromJson(jsonData) {
    return Source(
      id: jsonData['id'],
      name: jsonData['name'],
    );
  }
}
