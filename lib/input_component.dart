// Copyright (C) 2015 Sergey Akopkokhyants.
// https://github.com/akserg/angular.dart.material
// All rights reserved.  Please see the LICENSE.md file.part of material;
part of material;

abstract class BaseInputCompoent {
  BaseInputCompoent(dom.Element element) {
    if (element.classes.contains('form-control') && notmdproc(element)) {
      element.dataset['mdproc'] = 'true';
      inputHelper(element);
    }
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
}

// input.form-control
@Component(selector: 'input', useShadowDom: false)
class InputComponent extends BaseInputCompoent {
  InputComponent(dom.Element element):super(element);
}

// textarea.form-control
@Decorator(selector: 'textarea')
class TextareaComponent extends BaseInputCompoent {
  TextareaComponent(dom.Element element):super(element);
}

// select.form-control
@Decorator(selector: 'select')
class SelectComponent extends BaseInputCompoent {
  SelectComponent(dom.Element element):super(element);
}