import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../model/user_entity.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

abstract class AuthRepository {
  Stream<AuthenticationStatus> get status;
  Future<Either<Failure, UserEntity>> login(String email, String password);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, UserEntity>> getUserCredential();
  Future<void> setUserCredential(UserEntity user);
  void dispose();
}
