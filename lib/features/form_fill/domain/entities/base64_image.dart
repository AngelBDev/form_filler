import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Base64Image extends Equatable {
  Base64Image({
    @required this.base64Image,
    @required this.data,
  });

  final String base64Image;
  final String data;

  @override
  List<Object> get props => [base64Image, data];
}
