// Copyright (C) 2015 Sergey Akopkokhyants.
// https://github.com/akserg/angular.dart.material
// All rights reserved.  Please see the LICENSE.md file.part of material;
part of material;

/**
 * 
      '.btn:not(.btn-link), ' + 
      '.card-image, ' + 
      '.navbar a:not(.withoutripple), ' + 
      '.dropdown-menu a, ' + 
      '.nav-tabs a:not(.withoutripple), ' + 
      '.withripple'
 */
@Decorator(selector: '.btn')
class ButtonRipplesCompoent {
  ButtonRipplesCompoent(dom.Element element) {
    if (!element.classes.contains('btn-link')) {
      new Ripples(element);
    }
  }
}

/*
ripples({String selector:null}) {
    //$((selector) ? selector : this.options.withRipples).ripples();
    dom.ElementList list = dom.document.querySelectorAll(selector != null ? selector : options.withRipples);
    list.forEach((dom.Element el) {
      new Ripples(el);
    });
  }
*/