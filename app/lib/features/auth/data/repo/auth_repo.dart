import '../models/login_request.dart';
import '../models/login_response.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  bool authenticated();
  Future<Either<String, LoginResponse>> login(LoginRequest loginRequest);
}
