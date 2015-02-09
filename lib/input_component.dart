// Copyright (C) 2015 Sergey Akopkokhyants.
// https://github.com/akserg/angular.dart.material
// All rights reserved.  Please see the LICENSE.md file.part of material;
part of material;

// input.form-control
@Component(selector: 'input', useShadowDom: false)
class InputComponent extends BaseInputCompoent {
  InputComponent(dom.Element element):super(element);
}

// textarea.form-control
@Component(selector: 'textarea', useShadowDom: false)
class TextareaComponent extends BaseInputCompoent {
  TextareaComponent(dom.Element element):super(element);
}

// select.form-control
@Component(selector: 'select', useShadowDom: false)
class SelectComponent extends BaseInputCompoent {
  SelectComponent(dom.Element element):super(element);
}

abstract class BaseInputCompoent {
  
  BaseInputCompoent(dom.Element element) {
    if (element.classes.contains('form-control') && _notmdproc(element)) {
      element.dataset['mdproc'] = 'true';
      inputHelper(element);
    }
  }
  
  inputHelper(el) {
    // $this.wrap('<div class=form-control-wrapper></div>');
    dom.DivElement wrap = new dom.DivElement();
    wrap.classes.add('form-control-wrapper');
    el.parent.insertBefore(wrap, el);
    el.remove();
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
      //el.parent.classes.add('fileinput');
      wrap.classes.add('fileinput');
      var input = el.parent.nextElementSibling;
      input.remove();
      el.insertAdjacentElement('afterEnd', input);
      _addHandler(wrap);
    }
  }
  
  void _addHandler(dom.DivElement wrap) {
    wrap.querySelectorAll('[type=file]').forEach((dom.FileUploadInputElement fileElement) {
      fileElement.onChange.listen((dom.Event evt) {
        var value = '';
        fileElement.files.forEach((dom.File file) {
          value += file.name + ', ';
        });
        if (value.length > 1) {
          value = value.substring(0, value.length - 2);
        }
        if (value.length > 0) {
          fileElement.previousElementSibling.classes.remove('empty');
        } else {
          fileElement.previousElementSibling.classes.add('empty');
        }
        (fileElement.previousElementSibling as dom.InputElement).value = value;
      });
    });
    wrap.querySelectorAll('input').forEach((dom.FileUploadInputElement fileElement) {
     fileElement.onFocus.listen((dom.FocusEvent evt) {
       fileElement.classes.add('focus');
     });
     //
     fileElement.onBlur.listen((dom.FocusEvent evt) {
       fileElement.classes.remove('focus');
     });
   });    
  }
}