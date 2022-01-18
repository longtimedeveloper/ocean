import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

mixin Logger {
  /// Emit a log event using the dart:developer library provided in the SDK.
  ///
  /// This function was designed to map closely to the logging information
  /// collected by `package:logging`.
  ///
  /// - [message] is the log message
  /// - [time] (optional) is the timestamp
  /// - [sequenceNumber] (optional) is a monotonically increasing sequence number
  /// - [level] (optional) is the severity level (a value between 0 and 2000); see
  ///   the `package:logging` `Level` class for an overview of the possible values
  /// - [name] (optional) is the name of the source of the log message
  /// - [zone] (optional) the zone where the log was emitted
  /// - [error] (optional) an error object associated with this log event
  /// - [stackTrace] (optional) a stack trace associated with this log event
  void log(String message,
      {DateTime? time,
      int? sequenceNumber,
      int level = 0,
      String name = '',
      Zone? zone,
      Object? error,
      StackTrace? stackTrace}) {
    time ??= DateTime.now();
    if (kDebugMode) {
      developer.log(message,
          time: time,
          sequenceNumber: sequenceNumber,
          level: level,
          name: name,
          zone: zone,
          error: error,
          stackTrace: stackTrace);
    }

    //TODO add call to logger service if required.
  }

  /// Only emits event to the console when using a debug build.
  /// Nothing is emitted when in a release build.
  /// If a logging service has been defined, log to the service as well.
  ///
  /// - [message] is the log message
  /// - [className] (optional) is the name of the class that originated this event.
  /// - [methodName] (optional) is the name of the method that originated this event.
  void logDebug(String message, {String className = '', String methodName = ''}) {
    if (kDebugMode) {
      print('');
      print('Debug: ${_formatMessage(message, className, methodName).toString()}');
      print('');
    }
  }

  /// Only emits event to the console when using a debug build.
  /// If a logging service has been defined, logs to the service as well.
  ///
  /// - [message] is the log message
  /// - [error] an error object associated with this log event
  /// - [stackTrace] a stack trace associated with this log event
  ///
  /// Example invoking this method.
  /// ```dart
  /// try {
  ///   // some method
  /// } catch (e, s) {
  ///   logError('Error when updating applicationSettings', e, s);
  /// }
  ///  ```
  void logError(String message, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      print('');
      print('Error Message: $message');
      print('Error        : ${error.toString()}');
      print('Stack Trace  : ${stackTrace.toString()}');
      print('');
    }

    //TODO add call to logger service if required.
    // Ensure you pass the time of the event:  DateTime.now().toUtc();
  }

  /// When debugging, emit event to the console.
  /// If a logging service has been defined, logs to the service as well.
  ///
  /// - [message] is the log message
  void logInfo(String message) {
    if (kDebugMode) {
      print('');
      print('Information: $message}');
      print('');
    }

    //TODO add call to logger service if required.
    // Ensure you pass the time of the event:  DateTime.now().toUtc();
  }

  String _formatMessage(String message, String className, String methodName) {
    final sb = StringBuffer();

    if (className.isNotEmpty) {
      sb.write('[$className]');
    }
    if (methodName.isNotEmpty) {
      if (sb.isNotEmpty) {
        sb.write('.');
      }
      sb.write(methodName);
    }

    if (sb.isNotEmpty) {
      sb.write(', ');
    }

    sb.write(message);
    return sb.toString();
  }
}
