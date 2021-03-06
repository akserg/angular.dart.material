// Copyright (C) 2015 Sergey Akopkokhyants.
// https://github.com/akserg/angular.dart.material
// All rights reserved.  Please see the LICENSE.md file.part of material;
part of material;

// '.checkbox > label > input[type=checkbox]'
@Decorator(selector: '.checkbox')
class CheckboxComponent {
  CheckboxComponent(dom.Element element) {
    dom.CheckboxInputElement checkbox = element.querySelector('label > input[type=checkbox]');
    if (checkbox != null) {
      checkbox.dataset['mdproc'] = 'true';
      checkbox.insertAdjacentHtml('afterEnd', '<span class=ripple></span><span class=check></span>');
    }
  }
}

// '.togglebutton > label > input[type=checkbox]'
@Decorator(selector: '.togglebutton')
class ToggleButtonComponent {
  ToggleButtonComponent(dom.Element element) {
    dom.CheckboxInputElement checkbox = element.querySelector('label > input[type=checkbox]');
    if (checkbox != null) {
      checkbox.dataset['mdproc'] = 'true';
      checkbox.insertAdjacentHtml('afterEnd', '<span class=toggle></span>');
    }
  }
}

// '.radio > label > input[type=radio]'
@Decorator(selector: '.radio')
class RadioButtonComponent {
  RadioButtonComponent(dom.Element element) {
    dom.RadioButtonInputElement radio = element.querySelector('label > input[type=radio]');
    if (radio != null) {
      radio.dataset['mdproc'] = 'true';
      radio.insertAdjacentHtml('afterEnd', '<span class=circle></span><span class=check></span>');
    }
  }
}