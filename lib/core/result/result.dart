import 'package:either_dart/either.dart';

typedef Result<T> = Either<Exception, T>;
typedef Ok<T> = Right<Exception, T>;
typedef Fail<T> = Left<Exception, T>;

typedef FutureResult<T> = Future<Result<T>>;
typedef NullableFutureResult<T> = Future<Result<T>?>;
