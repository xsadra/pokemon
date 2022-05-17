import '../constants/consts.dart';

abstract class Failure {}

// General failures
class ServerFailure extends Failure {}

class NotFoundFailure extends Failure {}

class NoInternetFailure extends Failure {}

extension FailureExtension on Failure {
  String get toMessage {
    switch (runtimeType) {
      case ServerFailure:
        return App.error.serverFailureMessage;
      case NotFoundFailure:
        return App.error.notFoundFailureMessage;
      default:
        return App.error.unexpectedError;
    }
  }
}
