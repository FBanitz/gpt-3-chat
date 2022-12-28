import 'dart:convert';

extension FromJSON on String {
  dynamic get fromJson => json.decode(this);
}