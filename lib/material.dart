// Copyright (C) 2015 Sergey Akopkokhyants.
// https://github.com/akserg/angular.dart.material
// All rights reserved.  Please see the LICENSE.md file.part of material;
library material;

import 'dart:html' as dom;
import 'dart:async';
import 'dart:math' as math;

import "package:angular/angular.dart";
//import "package:angular/core_dom/module_internal.dart";

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
    bind(CheckboxCompoent);
    bind(ToggleButtonCompoent);
    bind(RadioButtonCompoent);
    // Rippples elements
    bind(ButtonRipplesCompoent);
    bind(NavBarRipplesCompoent);
    bind(NavTabRipplesCompoent);
    bind(DropDownRipplesCompoent);
    bind(CardImageRipplesCompoent);
    bind(WithRipplesCompoent);
    // Reactive components
    bind(CheckboxReactiveCompoent);
    bind(FormControlReactiveCompoent);
  }
}

@Injectable()
class MaterialOptions {
  var input = true;
  var ripples = true;
  var checkbox = true;
  var togglebutton = true;
  var radio = true;
  var arrive = true;
  var autofill = false;

  var withRipples = '.btn:not(.btn-link), ' + 
      '.card-image, ' + 
      '.navbar a:not(.withoutripple), ' + 
      '.dropdown-menu a, ' + 
      '.nav-tabs a:not(.withoutripple), ' + 
      '.withripple';
  var inputElements = 'input.form-control, textarea.form-control, select.form-control';
  var checkboxElements = '.checkbox > label > input[type=checkbox]';
  var togglebuttonElements = '.togglebutton > label > input[type=checkbox]';
  var radioElements = '.radio > label > input[type=radio]';
}

@Injectable()
class Material {
  // These options set what will be started by $.material.init()
  var options = new MaterialOptions();
  
  Material() {
    dom.document.onChange.listen((dom.Event event) {
      handle('.checkbox input[type=checkbox]', (dom.Element element) {
        element.blur();
      });
      //
      handle('.form-control', (element) {
        if (element.value == '' && element.checkValidity()) {
          element.classes.add('empty');
        } else {
          element.classes.remove('empty');
        }
      });
      //
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
    
    dom.document.onKeyDown.listen((dom.KeyboardEvent event) {
      handle('.form-control', (dom.Element element) {
        if(_isChar(event)) {
          element.classes.remove('empty');
        }
      });
    });
    
    dom.document.onPaste.listen((dom.Event event) {
      handle('.form-control', (dom.Element element) {
        element.classes.remove('empty');
      });
    });
    
    dom.document.onKeyUp.listen((dom.KeyboardEvent event) {
      handle('.form-control', (element) {
        if (element.value == '' && element.checkValidity()) {
          element.classes.add('empty');
        } else {
          element.classes.remove('empty');
        }
      });
    });
    
    dom.document.onFocus.listen((dom.Event event) {
      handle('.form-control-wrapper.fileinput', (dom.Element element) {
        handle('input', (dom.InputElement inputElement) {
          inputElement.classes.add('focus');
        });
      });
    });
      
    dom.document.onBlur.listen((dom.Event event) {
      handle('.form-control-wrapper.fileinput', (dom.Element element) {
        handle('input', (dom.InputElement inputElement) {
          inputElement.classes.remove('focus');
        });
      });
    });
  }
  
  handle(String selector, Function fn) {
    dom.document.querySelectorAll(selector).forEach((dom.Element element) {
      fn(element);
    });
  }
  
  init() {
    if (options.ripples) {
      ripples();
    }
    if (options.input) {
      input();
    }
    if (options.checkbox) {
      checkbox();
    }
    if (options.togglebutton) {
      togglebutton();
    }
    if (options.radio) {
      radio();
    }
    if (options.autofill) {
      autofill();
    }

    // Check for add/remove children
//    if (dom.document.arrive && options.arrive) {
//      if ($.fn.ripples && options.ripples) {
//        $(document).arrive(options.withRipples, function() {
//          $.material.ripples($(this));
//        });
//      }
//      if (options.input) {
//        $(document).arrive(options.inputElements, function() {
//          $.material.input($(this));
//        });
//      }
//      if (options.checkbox) {
//        $(document).arrive(options.checkboxElements, function() {
//          $.material.checkbox($(this));
//        });
//      }
//      if (options.radio) {
//        $(document).arrive(options.radioElements, function() {
//          $.material.radio($(this));
//        });
//      }
//      if (options.togglebutton) {
//        $(document).arrive(options.togglebuttonElements, function() {
//          $.material.togglebutton($(this));
//        });
//      }
//    }
  }
  
  checkbox({String selector:null}) {
    // Add fake-checkbox to material checkboxes
    dom.ElementList list = dom.document.querySelectorAll(selector != null ? selector : options.checkboxElements);
    list.takeWhile(notmdproc).forEach((dom.Element el) {
      el.dataset['mdproc'] = 'true';
      el.insertAdjacentHtml('afterEnd', '<span class=ripple></span><span class=check></span>');
    });
  }
  
  togglebutton({String selector:null}) {
    // Add fake-toggle to material toggle buttons
    dom.ElementList list = dom.document.querySelectorAll(selector != null ? selector : options.togglebuttonElements);
    list.takeWhile(notmdproc).forEach((dom.Element el) {
      el.dataset['mdproc'] = 'true';
      el.insertAdjacentHtml('afterEnd', '<span class=toggle></span>');
    });
  }
  
  radio({String selector:null}) {
    // Add fake-radio to material radios
    dom.ElementList list = dom.document.querySelectorAll(selector != null ? selector : options.radioElements);
    list.takeWhile(notmdproc).forEach((dom.Element el) {
      el.dataset['mdproc'] = 'true';
      el.insertAdjacentHtml('afterEnd', '<span class=circle></span><span class=check></span>');
    });
  }
  
  input({String selector:null}) {
    dom.ElementList list = dom.document.querySelectorAll(selector != null ? selector : options.inputElements);
    list.takeWhile(notmdproc).forEach((dom.Element el) {
      el.dataset['mdproc'] = 'true';
      inputHelper(el);
    });
  }
  
  inputHelper(el) {
    if (!el.attributes.containsKey('data-hint') && !el.classes.contains('floating-label')) {
      return;
    }
    
    // $this.wrap('<div class=form-control-wrapper></div>');
    dom.DivElement wrap = new dom.DivElement();
    wrap.classes.add('form-control-wrapper');
    el.parent.insertBefore(wrap, el);
    wrap.append(el);
    
    // $this.after('<span class=material-input></span>');
    el.insertAdjacentHtml('afterEnd', '<span class=material-input></span>');

    // Add floating label if required
    if (el.classes.contains('floating-label')) {
      var placeholder = el.attributes['placeholder'];
      el.attributes.remove('placeholder');
      el.classes.remove('floating-label');
      el.insertAdjacentHtml('afterEnd', '<div class=floating-label>' + placeholder + '</div>');
    }

    // Add hint label if required
    if (el.attributes.containsKey('data-hint')) {
      el.insertAdjacentHtml('afterEnd', '<div class=hint>' + el.attributes['data-hint'] + '</div>');
    }

    // Set as empty if is empty (damn I must improve this...)
    if (el.value == null || el.value == '') {
      el.classes.add('empty');
    }

    // Support for file input
    if (el.parent.nextElementSibling is dom.FileUploadInputElement) {
      el.parent.classes.add('fileinput');
      var input = el.parent.nextElementSibling;
      input.remove();
      el.insertAdjacentElement('afterEnd', input);
    }
  }
  
  ripples({String selector:null}) {
    //$((selector) ? selector : this.options.withRipples).ripples();
    dom.ElementList list = dom.document.querySelectorAll(selector != null ? selector : options.withRipples);
    list.forEach((dom.Element el) {
      new Ripples(el);
    });
  }
  
  autofill() {
    // This part of code will detect autofill when the page is loading (username and password inputs for example)
    Timer loading = new Timer(new Duration(milliseconds: 100), () {
      dom.document.querySelectorAll('input[type!=checkbox]').forEach((dom.InputElement element) {
        if (element.value != null && element.value.length > 0 && element.value != element.attributes['value']) {
          element.dispatchEvent(new dom.Event('change'));
        }
      });
    });

    // After 10 seconds we are quite sure all the needed inputs are autofilled then we can stop checking them
    new Timer(new Duration(seconds: 10), () {
      loading.cancel();
    });
    // Now we just listen on inputs of the focused form (because user can select from the autofill dropdown only when the input has focus)
    Timer focused;
    dom.document.onFocus.listen((dom.Event event) {
      handle('input', (dom.InputElement element) {
        // element.parents('form').find('input').not('[type=file]');
        dom.ElementList<dom.InputElement> inputs = findParent(element, 'form').querySelectorAll('input').takeWhile((dom.InputElement el) {
          return el is! dom.FileUploadInputElement;
        });
        focused = new Timer(new Duration(milliseconds: 100), () {
          inputs.forEach((dom.InputElement inp) {
              if (inp.value != inp.attributes['value']) {
                inp.dispatchEvent(new dom.Event('change'));
              }
            });
          });
      });
    });
    dom.document.onFocus.listen((dom.Event event) {
      handle('input', (dom.InputElement element) {
        
      });
    });
    dom.document.onBlur.listen((dom.Event event) {
      handle('input', (dom.InputElement element) {
        focused.cancel();
      });
    });
  }
  
  dom.Element findParent(dom.Element element, String selector) {
    var parent = element.parent;
    if (parent is dom.Element) {
      var found = parent.querySelector(selector);
      if (found == parent) {
        return parent;
      }
      return findParent(parent, selector);
    }
    return null;
  }
  
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
}