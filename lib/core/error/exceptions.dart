// ignore_for_file: public_member_api_docs, sort_constructors_first

class DatabaseExeption implements Exception {}

enum NetworkExceptionType {
  noInternetConnection,
  unauthorized,
  notFound,
  // requestTimeout,
  // sendTimeout,
  unexpected,
}

class NetworkException implements Exception {
  final NetworkExceptionType type;
  NetworkException({
    required this.type,
  });
}

 // const factory NetworkExceptions.requestCancelled() = RequestCancelled;

  // const factory NetworkExceptions.unauthorizedRequest(String reason) =
  //     UnauthorizedRequest;

  // const factory NetworkExceptions.badRequest() = BadRequest;

  // const factory NetworkExceptions.notFound(String reason) = NotFound;

  // const factory NetworkExceptions.requestTimeout() = RequestTimeout;

  // const factory NetworkExceptions.sendTimeout() = SendTimeout;

  // const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  // static NetworkExceptions handleResponse(Response? response) {
  //   ErrorModel? errorModel;

  //   errorModel = ErrorModel.fromJson(response?.data);

  //   int statusCode = response?.statusCode ?? 0;
  //  if (statusCode >= 400 && statusCode < 500) {
  //     message =
  //         'Client error - the request contains bad syntax or cannot be fulfilled';
  //   } else if (statusCode >= 500 && statusCode < 600) {
  //     message =
  //         'Server error - the server failed to fulfil an apparently valid request';
  //   } else {
  //     message =
  //         'A response with a status code that is not within the range of inclusive 100 to exclusive 600'
  //         'is a non-standard response, possibly due to the server\'s software';
  //   }

  // }

  // static NetworkExceptions getDioException(exeption) {
  //   if (exeption is Exception) {
  //     try {
  //       NetworkExceptions networkExceptions;
  //       if (exeption is DioException) {
  //         switch (exeption.type) {
  //           case DioExceptionType.cancel:
  //             networkExceptions = NetworkExceptions.requestCancelled();
  //             break;
  //           case DioExceptionType.connectionTimeout:
  //             networkExceptions = NetworkExceptions.requestTimeout();
  //             break;
  //           case DioExceptionType.connectionError:
  //             networkExceptions = NetworkExceptions.noInternetConnection();
  //             break;
  //           case DioExceptionType.receiveTimeout:
  //             networkExceptions = NetworkExceptions.sendTimeout();
  //             break;
  //           case DioExceptionType.badResponse:
  //             networkExceptions =
  //                 NetworkExceptions.handleResponse(exeption.response);
  //             break;
  //           case DioExceptionType.sendTimeout:
  //             networkExceptions = NetworkExceptions.sendTimeout();
  //             break;
  //           case DioExceptionType.badCertificate:
  //             networkExceptions = NetworkExceptions.badCertificate();
  //             break;
  //           case DioExceptionType.unknown:
  //             networkExceptions = NetworkExceptions.unknown();
  //             break;
  //         }
  //       } else if (exeption is SocketException) {
  //         networkExceptions = NetworkExceptions.noInternetConnection();
  //       } else {
  //         networkExceptions = NetworkExceptions.unexpectedError();
  //       }
  //       return networkExceptions;
  //     }
  //   }
  // }

  // static String getErrorMessage(NetworkExceptions networkExceptions) {
  //   var errorMessage = "";
  //   networkExceptions.when(notImplemented: () {
  //     errorMessage = "Not Implemented";
  //   }, requestCancelled: () {
  //     errorMessage = "Request Cancelled";
  //   }, internalServerError: () {
  //     errorMessage = "Internal Server Error";
  //   }, notFound: (String reason) {
  //     errorMessage = reason;
  //   }, serviceUnavailable: () {
  //     errorMessage = "Service unavailable";
  //   }, methodNotAllowed: () {
  //     errorMessage = "Method Allowed";
  //   }, badRequest: () {
  //     errorMessage = "Bad request";
  //   }, unauthorizedRequest: (String error) {
  //     errorMessage = error;
  //   }, unexpectedError: () {
  //     errorMessage = "Unexpected error occurred";
  //   }, requestTimeout: () {
  //     errorMessage = "Connection request timeout";
  //   }, noInternetConnection: () {
  //     errorMessage = "No internet connection";
  //   }, conflict: () {
  //     errorMessage = "Error due to a conflict";
  //   }, sendTimeout: () {
  //     errorMessage = "Send timeout in connection with API server";
  //   }, unableToProcess: () {
  //     errorMessage = "Unable to process the data";
  //   }, defaultError: (String error) {
  //     errorMessage = error;
  //   }, formatException: () {
  //     errorMessage = "Unexpected error occurred";
  //   }, notAcceptable: () {
  //     errorMessage = "Not acceptable";
  //   });
  //   return errorMessage;
  // }