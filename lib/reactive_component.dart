// Copyright (C) 2015 Sergey Akopkokhyants.
// https://github.com/akserg/angular.dart.material
// All rights reserved.  Please see the LICENSE.md file.part of material;
part of material;

_isChar(dom.KeyboardEvent evt) {
  if (evt.which > 0) {
    return !evt.ctrlKey && !evt.metaKey && !evt.altKey && evt.which != 8 && evt.which != 9;
  }
  return false;
}

// '.checkbox input[type=checkbox]'
@Decorator(selector: '.checkbox')
class CheckboxReactiveComponent {
  CheckboxReactiveComponent(dom.Element element) {
   element.querySelectorAll('input[type=checkbox]').forEach((dom.CheckboxInputElement checkbox) {
     checkbox.onChange.listen((dom.Event evt) {
       element.blur();
     });
   });
  }
}

// '.form-control'
@Decorator(selector: '.form-control')
class FormControlReactiveComponent {
  // Just leave element without type because it can be 
  // input, text area or selector elements
  FormControlReactiveComponent(dom.Element element) {
    element.onChange.listen((dom.Event evt) {
      var el = element;
      if (el.value == '' && el.checkValidity()) {
        el.classes.add('empty');
      } else {
        el.classes.remove('empty');
      }
    });
    //
    element.onKeyDown.listen((dom.KeyboardEvent evt) {
      if(_isChar(evt)) {
        element.classes.remove('empty');
      }
    });
    //
    element.onPaste.listen((dom.Event event) {
      element.classes.remove('empty');
    });
    //
    element.onKeyUp.listen((dom.KeyboardEvent event) {
      var el = element;
      if (el.value == '' && el.checkValidity()) {
        element.classes.add('empty');
      } else {
        element.classes.remove('empty');
      }
    });
  }
}