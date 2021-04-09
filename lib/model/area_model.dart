import '../core/base/base_model.dart';

class Area extends BaseModel {
  String? strArea;

  Area({this.strArea});

  @override
  Area fromJson(Map<String, dynamic> json) {
    return Area(strArea: json['strArea'] as String);
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['strArea'] = strArea;
    return data;
  }
}
