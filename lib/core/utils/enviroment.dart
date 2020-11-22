import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Enviroment extends Equatable {
  Enviroment({@required this.env});

  final Map<String, dynamic> env;

  String get apiUrl => env['VAR_API_URL'];

  @override
  List<Object> get props => [env];
}
