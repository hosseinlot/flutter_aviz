import 'package:aviz_app/data/model/variant.dart';
import 'package:aviz_app/data/model/variant_type.dart';

class AvizVariant {
  VariantType variantType;
  List<Variant> variantList;

  AvizVariant(this.variantType, this.variantList);
}
