import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Enviroment extends Equatable {
  Enviroment({@required this.env});

  final Map<String, dynamic> env;

  String get apiUrl =>
      'http://ec2-18-221-176-220.us-east-2.compute.amazonaws.com:5000';

  @override
  List<Object> get props => [env];
}
