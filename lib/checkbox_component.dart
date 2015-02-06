// Copyright (C) 2015 Sergey Akopkokhyants.
// https://github.com/akserg/angular.dart.material
// All rights reserved.  Please see the LICENSE.md file.part of material;
part of material;

@Decorator(selector: '.checkbox > label > input[type=checkbox]')
class CheckboxCompoent {
  CheckboxCompoent(dom.Element element, NodeAttrs attrs) {
    element.dataset['mdproc'] = 'true';
    element.insertAdjacentHtml('afterEnd', '<span class=ripple></span><span class=check></span>');
  }
}