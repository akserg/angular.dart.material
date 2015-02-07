// Copyright (C) 2015 Sergey Akopkokhyants.
// https://github.com/akserg/angular.dart.material
// All rights reserved.  Please see the LICENSE.md file.part of material;
part of material;

// '.checkbox > label > input[type=checkbox]'
@Decorator(selector: '.checkbox')
class CheckboxCompoent {
  CheckboxCompoent(dom.Element element) {
    dom.CheckboxInputElement checkbox = element.querySelector('label > input[type=checkbox]');
    if (checkbox != null){
      checkbox.dataset['mdproc'] = 'true';
      checkbox.insertAdjacentHtml('afterEnd', '<span class=ripple></span><span class=check></span>');
    }
  }
}

// '.togglebutton > label > input[type=checkbox]'
@Decorator(selector: '.togglebutton')
class ToggleButtonCompoent {
  ToggleButtonCompoent(dom.Element element) {
    dom.CheckboxInputElement checkbox = element.querySelector('label > input[type=checkbox]');
    if (checkbox != null){
      checkbox.dataset['mdproc'] = 'true';
      checkbox.insertAdjacentHtml('afterEnd', '<span class=toggle></span>');
    }
  }
}

// '.radio > label > input[type=radio]'
@Decorator(selector: '.radio')
class RadioButtonCompoent {
  RadioButtonCompoent(dom.Element element) {
    dom.RadioButtonInputElement checkbox = element.querySelector('label > input[type=radio]');
    if (checkbox != null){
      checkbox.dataset['mdproc'] = 'true';
      checkbox.insertAdjacentHtml('afterEnd', '<span class=circle></span><span class=check></span>');
    }
  }
}