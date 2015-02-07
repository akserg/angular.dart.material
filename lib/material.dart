// Copyright (C) 2015 Sergey Akopkokhyants.
// https://github.com/akserg/angular.dart.material
// All rights reserved.  Please see the LICENSE.md file.part of material;
library material;

import 'dart:html' as dom;
import 'dart:async';
import 'dart:math' as math;

import "package:angular/angular.dart";

part 'ripples.dart';
part 'input_component.dart';
part 'switch_component.dart';
part 'ripples_component.dart';
part 'reactive_component.dart';

/**
 * Material Module.
 */
class MaterialModule extends Module {
  MaterialModule() {
    // Input element
    bind(InputComponent);
    bind(TextareaComponent);
    bind(SelectComponent);
    // Switch elements
    bind(CheckboxComponent);
    bind(ToggleButtonComponent);
    bind(RadioButtonComponent);
    // Rippples elements
    bind(ButtonRipplesComponent);
    bind(NavBarRipplesComponent);
    bind(NavTabRipplesComponent);
    bind(DropDownRipplesComponent);
    bind(CardImageRipplesComponent);
    bind(WithRipplesComponent);
    // Reactive components
    bind(CheckboxReactiveComponent);
    bind(FormControlReactiveComponent);
    bind(FormControlWrapperReactiveComponent);
  }
}

notmdproc(dom.Element obj) {
  return !obj.dataset.containsKey('mdproc');
}