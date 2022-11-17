class News {

  final String title;
  final String content;

  News({required this.title, required this.content});

  factory News.fromJson(Map<String, String> json) {
    return News(
        title: json["Title"],
        content: json["Content"]
    );
  }
