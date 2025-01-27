import 'package:flutter/material.dart';

@immutable
abstract class AvizAuthorStatus {}

class AvizAthorInitial extends AvizAuthorStatus {}

class AvizAthorLoading extends AvizAuthorStatus {}

class AvizAthorSuccess extends AvizAuthorStatus {
  final String phoneNumber;
  AvizAthorSuccess(this.phoneNumber);
}

class AvizAthorFailed extends AvizAuthorStatus {
  final String message;
  AvizAthorFailed(this.message);
}
