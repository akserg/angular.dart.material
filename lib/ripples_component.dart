// Copyright (C) 2015 Sergey Akopkokhyants.
// https://github.com/akserg/angular.dart.material
// All rights reserved.  Please see the LICENSE.md file.part of material;
part of material;

// '.btn:not(.btn-link), '
@Decorator(selector: '.btn')
class ButtonRipplesComponent {
  ButtonRipplesComponent(dom.Element element) {
    if (!element.classes.contains('btn-link')) {
      new Ripples(element);
    }
  }
}

// 'a:not(.withoutripple), '
abstract class BaseNavRipplesComponent {
  BaseNavRipplesComponent(dom.Element element) {
    element.querySelectorAll('a').forEach((dom.AnchorElement el){
      if (!el.classes.contains('withoutripple')) {
        new Ripples(el);
      }
    });
  }
}

// '.navbar a:not(.withoutripple), ' 
@Decorator(selector: '.navbar')
class NavBarRipplesComponent extends BaseNavRipplesComponent {
  NavBarRipplesComponent(dom.Element element):super(element);
}

// '.nav-tabs a:not(.withoutripple), '
@Decorator(selector: '.nav-tabs')
class NavTabRipplesComponent extends BaseNavRipplesComponent {
  NavTabRipplesComponent(dom.Element element):super(element);
}

// '.dropdown-menu a, '
@Decorator(selector: '.dropdown-menu')
class DropDownRipplesComponent {
  DropDownRipplesComponent(dom.Element element) {
    element.querySelectorAll('a').forEach((dom.AnchorElement el){
      new Ripples(el);
    });
  }
}

// '.card-image, '
@Decorator(selector: '.card-image')
class CardImageRipplesComponent {
  CardImageRipplesComponent(dom.Element element) {
    new Ripples(element);
  }
}

// '.withripple'
@Decorator(selector: '.withripple')
  class WithRipplesComponent {
  WithRipplesComponent(dom.Element element) {
   new Ripples(element);
  }
}