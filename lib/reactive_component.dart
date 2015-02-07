// Copyright (C) 2015 Sergey Akopkokhyants.
// https://github.com/akserg/angular.dart.material
// All rights reserved.  Please see the LICENSE.md file.part of material;
part of material;

/*
dom.document.onChange.listen((dom.Event event) {
  var value = '';
  handle('.form-control-wrapper.fileinput [type=file]', (dom.FileUploadInputElement element) {
    element.files.forEach((dom.File file) {
      value += file.name + ', ';
    });
    if (value.length > 1) {
      value = value.substring(0, value.length - 2);
    }
    if (value.length > 0) {
      element.previousElementSibling.classes.remove('empty');
    } else {
      element.previousElementSibling.classes.add('empty');
    }
    (element.previousElementSibling as dom.InputElement).value = value;
  });
});
*/

// '.checkbox input[type=checkbox]'
@Decorator(selector: '.checkbox')
class CheckboxReactiveCompoent {
  CheckboxReactiveCompoent(dom.Element element) {
   if (element.querySelector('input[type=checkbox]') != null) {
     element.onChange.listen((dom.Event evt) {
       element.blur();
     });
   }
  }
}

// '.form-control'
@Decorator(selector: '.form-control')
class FormControlReactiveCompoent {
  // Just leave element without type because it can be 
  // input, text area or selector elements
  FormControlReactiveCompoent(dom.Element element) {
    element.onChange.listen((dom.Event evt) {
      var el = element;
      if (el.value == '' && el.checkValidity()) {
        el.classes.add('empty');
      } else {
        el.classes.remove('empty');
      }
    });
  }
}