class VariantType {
  String? id;
  String? title;
  VariantTypeEnum? type;

  VariantType(this.id, this.title, this.type);

  factory VariantType.fromMapJson(Map<String, dynamic> jsonObject) {
    return VariantType(
      jsonObject['id'],
      jsonObject['title'],
      _getTypeEnum(jsonObject['type']),
    );
  }
}

enum VariantTypeEnum { MOSHAKHASAT, GHEYMAT, VIZHEGI, EMKANAT, TOZIHAT }

VariantTypeEnum _getTypeEnum(String type) {
  switch (type) {
    case 'مشخصات':
      return VariantTypeEnum.MOSHAKHASAT;
    case 'قیمت':
      return VariantTypeEnum.GHEYMAT;
    case 'ویژگی ها':
      return VariantTypeEnum.VIZHEGI;
    case 'امکانات':
      return VariantTypeEnum.EMKANAT;
    case 'توضیحات':
      return VariantTypeEnum.TOZIHAT;
    default:
      return VariantTypeEnum.TOZIHAT;
  }
}
