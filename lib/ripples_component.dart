// Copyright (C) 2015 Sergey Akopkokhyants.
// https://github.com/akserg/angular.dart.material
// All rights reserved.  Please see the LICENSE.md file.part of material;
part of material;

/**
 * 
      '.card-image, ' + 
      '.dropdown-menu a, ' + 
      '.withripple'
 */

// '.btn:not(.btn-link), '
@Decorator(selector: '.btn')
class ButtonRipplesCompoent {
  ButtonRipplesCompoent(dom.Element element) {
    if (!element.classes.contains('btn-link')) {
      new Ripples(element);
    }
  }
}

// 'a:not(.withoutripple), '
abstract class BaseNavRipplesCompoent {
  BaseNavRipplesCompoent(dom.Element element) {
    dom.ElementList<dom.AnchorElement> anchors = element.querySelectorAll('a');
    var length = anchors.where((dom.AnchorElement el) {
      return el.classes.contains('withoutripple');
    }).toList().length;
    //
    if (length == 0) {
      new Ripples(element);
    }
  }
}

// '.navbar a:not(.withoutripple), ' 
@Decorator(selector: '.navbar')
class NavBarRipplesCompoent extends BaseNavRipplesCompoent {
  NavBarRipplesCompoent(dom.Element element):super(element);
}

// '.nav-tabs a:not(.withoutripple), '
@Decorator(selector: '.nav-tabs')
class NavTabRipplesCompoent extends BaseNavRipplesCompoent {
  NavTabRipplesCompoent(dom.Element element):super(element);
}
