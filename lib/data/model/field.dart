class Field {
  String title;
  dynamic defaultValue;
  FieldTypeEnum type;
  FieldInputTypeEnum inputType;

  Field(this.title, this.defaultValue, this.type, this.inputType);

  Map<String, dynamic> toJson() => {
        'title': title,
        'value': defaultValue,
        'type': getTypeName(),
      };

  String getTypeName() {
    switch (type) {
      case FieldTypeEnum.MOSHAKHASAT:
        return 'مشخصات';
      case FieldTypeEnum.GHEYMAT:
        return 'قیمت';
      case FieldTypeEnum.VIZHEGI:
        return 'ویژگی';
      case FieldTypeEnum.EMKANAT:
        return 'امکانات';
      case FieldTypeEnum.TOZIHAT:
        return 'توضیحات';
    }
  }
}

enum FieldTypeEnum { MOSHAKHASAT, GHEYMAT, VIZHEGI, EMKANAT, TOZIHAT }

enum FieldInputTypeEnum { TEXT, NUMBER, CHECKBOX }
