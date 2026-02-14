class ComicPartModel {
  final int part;
  final String pdfUrl;

  ComicPartModel({required this.part, required this.pdfUrl});

  factory ComicPartModel.fromJson(Map<String, dynamic> json) {
    return ComicPartModel(
      part: json['part'],
      pdfUrl: json['link_pdf'],
    );
  }
}