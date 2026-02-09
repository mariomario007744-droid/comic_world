class ComicModel {
  final int id;
  final String name;
  final String createdAt;
  final bool isCompleted;
  final String bannerUrl;
  final String posterUrl;
  final String description;
  final String productionCompany;
  final String publishYear;
  final String ageRating;
  final String warning;
  final int viewedCount;
  final double evaluation;

  ComicModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.isCompleted,
    required this.bannerUrl,
    required this.posterUrl,
    required this.description,
    required this.productionCompany,
    required this.publishYear,
    required this.ageRating,
    required this.warning,
    required this.viewedCount,
    required this.evaluation,
  });

  factory ComicModel.fromJson(Map<String, dynamic> json) {
    return ComicModel(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'].toString(),
      isCompleted: json['is_completed'],
      bannerUrl: json['banner_url'],
      posterUrl: json['poster_url'],
      description: json['description'],
      productionCompany: json['production_company'],
      publishYear: json['publish_year'],
      ageRating: json['age_rating'],
      warning: json['warning'] ?? '',
      viewedCount: json['viewed'],
      evaluation: json['evaluation'].toDouble(),
    );
  }
}
