// Copyright (C) 2015 Sergey Akopkokhyants.
// https://github.com/akserg/angular.dart.material
// All rights reserved.  Please see the LICENSE.md file.part of material;
part of material;

@Decorator(selector: '.checkbox') // > label > input[type=checkbox]
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
@Decorator(selector: '.togglebutton') // > label > input[type=checkbox]
class ToggleButtonCompoent {
  ToggleButtonCompoent(dom.Element element) {
    dom.CheckboxInputElement checkbox = element.querySelector('label > input[type=checkbox]');
    if (checkbox != null){
      checkbox.dataset['mdproc'] = 'true';
      checkbox.insertAdjacentHtml('afterEnd', '<span class=toggle></span>');
    }
  }
}