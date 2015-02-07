// Copyright (C) 2015 Sergey Akopkokhyants.
// https://github.com/akserg/angular.dart.material
// All rights reserved.  Please see the LICENSE.md file.part of material;
part of material;

//************
notmdproc(dom.Element obj) {
  return !obj.dataset.containsKey('mdproc');
}

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
   if (element.querySelector('input[type=checkbox]') != null) {
     element.onChange.listen((dom.Event evt) {
       element.blur();
     });
   }
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

// '.form-control-wrapper.fileinput [type=file]'
@Decorator(selector: '.form-control-wrapper.fileinput')
class FormControlWrapperReactiveComponent {
  FormControlWrapperReactiveComponent(dom.Element element) {
    if (element is dom.FileUploadInputElement) {
      element.onChange.listen((dom.Event evt) {
        var value = '';
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
    }
  }
}
