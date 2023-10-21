import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String email;
  final int occupationLevel;
  final String occupationName;

  const UserEntity({
    required this.email,
    required this.occupationLevel,
    required this.occupationName,
  });

  @override
  List<Object?> get props => [
        email,
        occupationLevel,
        occupationName,
      ];
}
