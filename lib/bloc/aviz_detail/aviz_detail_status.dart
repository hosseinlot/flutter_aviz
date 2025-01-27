import 'package:aviz_app/data/model/aviz.dart';
import 'package:aviz_app/data/model/variant.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AvizDetailStatus {}

class AvizDetailLoading extends AvizDetailStatus {}

class AvizDetailSuccess extends AvizDetailStatus {
  final Aviz aviz;
  final List<Variant> variantList;
  AvizDetailSuccess(this.aviz, this.variantList);
}

class AvizDetailFailed extends AvizDetailStatus {
  final String message;
  AvizDetailFailed(this.message);
}
