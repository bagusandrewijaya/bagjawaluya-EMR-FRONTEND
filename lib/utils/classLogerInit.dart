import 'package:logger/logger.dart';

class LOG {
 static var logger = Logger(
  printer: PrettyPrinter(),
);

static var loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);
}