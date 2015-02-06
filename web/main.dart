library main;

import 'dart:html' as dom;

import 'package:angular/application_factory.dart';
import 'package:logging/logging.dart';
import 'package:angular/angular.dart';
import 'package:angular_material/material.dart';

main() {
  hierarchicalLoggingEnabled = true;
  Logger.root.level = Level.OFF;
  Logger.root.onRecord.listen((LogRecord r) {
    DateTime now = new DateTime.now();
    dom.window.console.log('${now} [${r.level}] ${r.loggerName}: ${r.message}');
  });
  new Logger("Material")..level = Level.FINER;

  applicationFactory()
    .addModule(new DemoModule())
    .run();
}

/**
 * Demo Module
 */
class DemoModule extends Module {
  DemoModule() {
    install(new MaterialModule());
  }
}
