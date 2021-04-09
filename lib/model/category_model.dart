import '../core/base/base_model.dart';

class Category extends BaseModel {
  String? idCategory;
  String? strCategory;
  String? strCategoryThumb;
  String? strCategoryDescription;

  Category({this.idCategory, this.strCategory, this.strCategoryThumb, this.strCategoryDescription});

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['idCategory'] = idCategory;
    data['strCategory'] = strCategory;
    data['strCategoryThumb'] = strCategoryThumb;
    data['strCategoryDescription'] = strCategoryDescription;
    return data;
  }

  @override
  Category fromJson(Map<String, dynamic> json) {
    return Category(
        idCategory: json['idCategory'] as String,
        strCategory: json['strCategory'] as String,
        strCategoryThumb: json['strCategoryThumb'] as String,
        strCategoryDescription: json['strCategoryDescription'] as String);
  }
}
