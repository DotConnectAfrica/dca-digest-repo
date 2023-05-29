class ModelNews {
  String? image;
  String? title;
  String? author;
  String? date;
  String? body;
  String? link;

  ModelNews(Map<String, dynamic> data) {
    this.image = data['image'];
    this.title = data['title'];
    this.author = data['author'];
    this.date = data['date'];
    this.body = data['body'];
    this.link = data['link'];
  }

  @override
  String toString() {
    return 'news_model{image: $image, title: $title, author: $author, date: $date, body: $body, link: $link}';
  }
}
