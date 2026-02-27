class CategoryModel {
  final String nameEn;
  final String nameAr;
    final int id;


  CategoryModel({required this.nameAr,required this.nameEn,required this.id});

  factory CategoryModel.fromJson(Map<String, dynamic> json){
    return CategoryModel(nameAr: json['name_ar'], nameEn: json['name_en'],id: json['id']);
  }
}
