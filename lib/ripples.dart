// Copyright (C) 2015 Sergey Akopkokhyants.
// https://github.com/akserg/angular.dart.material
// All rights reserved.  Please see the LICENSE.md file.part of material;
part of material;

class Ripples {
  RegExp agentRegExp = new RegExp(r'Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini');
  dom.Element element;
  dom.DivElement wrapper;
  dom.DivElement ripple;
  var rippleColor;
  
  Ripples(this.element) {
    this.element.onMouseDown.listen(startRipplesHandler);
    this.element.onTouchStart.listen(startRipplesHandler);
  }
  
  void startRipplesHandler(dom.Event event) {
    // Verify if the user is just touching on a device and return if so
    if (isTouch() && event.type == 'mousedown') {
      return;
    }
    
    // Verify if the current element already has a ripple wrapper element and 
    // creates if it doesn't
    wrapper = this.element.querySelector('.ripple-wrapper');
    if (wrapper == null) {
      wrapper = new dom.DivElement();
      wrapper.classes.add('ripple-wrapper');
      this.element.append(wrapper);
    }
    
    // Get relY and relX positions
    var relY = getRelY(event);
    var relX = getRelX(event);
    
    // If relY and/or relX are false, return the event
    if (relY == null || relX == null) {
      return;
    }
    
    // Get the ripple color
    rippleColor = getRipplesColor(element);
    
    // Create the ripple element
    ripple = new dom.DivElement()
    ..classes.add("ripple")
    ..style.left = relX
    ..style.top = relY
    ..style.backgroundColor = rippleColor;
    
    // Append the ripple to the wrapper
    wrapper.append(ripple);
    
    // Make sure the ripple has the styles applied (ugly hack but it works)
    // (function() { return window.getComputedStyle($ripple[0]).opacity; })();
    ripple.getComputedStyle(null);
    
    // Turn on the ripple animation
    rippleOn();
    
    // Call the rippleEnd function when the transition "on" ends
    new Timer(new Duration(milliseconds: 500), () {
      rippleEnd();
    });
    
    // Detect when the user leaves the element
    element.onMouseUp.listen(endRipplesHandler);
    element.onMouseLeave.listen(endRipplesHandler);
    element.onTouchEnd.listen(endRipplesHandler);
  }
  
  endRipplesHandler(dom.Event event) {
    ripple.dataset['mousedown'] = 'off';

    if (ripple.dataset['animating'] == 'off') {
      rippleOut();
    }
  }
  
  // Get the new size based on the element height/width and the ripple width
  double getNewSize() {
    // return (Math.max($element.outerWidth(), $element.outerHeight()) / $ripple.outerWidth()) * 2.5;
    return (math.max(element.clientWidth, element.clientHeight) / ripple.clientWidth) * 2.5;
  }
  
  // Get the relX
  dynamic getRelX(dom.Event event) {
    var wrapperOffset = wrapper.offset;

    if (!isTouch()) {
      // Get the mouse position relative to the ripple wrapper
      return ((event as dom.MouseEvent).page.x - wrapperOffset.left).toString();
    } else {
      // Make sure the user is using only one finger and then get the touch
      // position relative to the ripple wrapper
      if ((event as dom.TouchEvent).touches.length != 1) {
        return ((event as dom.TouchEvent).touches[0].page.x - wrapperOffset.left).toString();
      }

      return null;
    }
  }
  
  // Get the relY
  String getRelY(dom.Event event) {
    var wrapperOffset = wrapper.offset;

    if (!isTouch()) {
      // Get the mouse position relative to the ripple wrapper
      return ((event as dom.MouseEvent).page.y - wrapperOffset.top).toString();
    } else {
      // Make sure the user is using only one finger and then get the touch
      // position relative to the ripple wrapper
      if ((event as dom.TouchEvent).touches.length != 1) {
        return ((event as dom.TouchEvent).touches[0].page.y - wrapperOffset.top).toString();
      }

      return null;
    }
  }
  
  // Get the ripple color
  getRipplesColor(dom.Element element) {
    var color = element.dataset.containsKey("ripple-color") ? element.dataset["ripple-color"] : element.getComputedStyle(null).color;

    return color;
  }
  
  // Verify if the client browser has transistion support
  bool hasTransitionSupport() {
    var thisBody  = dom.document.body != null ? dom.document.body : dom.document.documentElement;
    var thisStyle = thisBody.style;

    var support = 
      thisStyle.supportsProperty('transition') && thisStyle.getPropertyValue('transition') != null ||
      thisStyle.supportsProperty('WebkitTransition') && thisStyle.getPropertyValue('WebkitTransition') != null ||
      thisStyle.supportsProperty('MozTransition') && thisStyle.getPropertyValue('MozTransition') != null ||
      thisStyle.supportsProperty('MsTransition') && thisStyle.getPropertyValue('MsTransition') != null ||
      thisStyle.supportsProperty('OTransition') && thisStyle.getPropertyValue('OTransition') != null;

    return support;
  }
  
  // Verify if the client is using a mobile device
  bool isTouch() {
    Match m = agentRegExp.firstMatch(dom.window.navigator.userAgent);
    return m != null ? m.groupCount > 0 : false;
  }
  
  // End the animation of the ripple
  rippleEnd() {
    ripple.dataset['animating'] = 'off';

    if (ripple.dataset['mousedown'] == 'off') {
      rippleOut();
    }
  }
  
  // Turn off the ripple effect
  rippleOut() {
    // TODO: Switch off animation
    //ripple.off();

    if (hasTransitionSupport()) {
      ripple.classes.add("ripple-out");
    } else {
//      ripple.animate({"opacity": 0}, 100)., function() {
      ripple.dispatchEvent(new dom.Event('transitionend'));
//        });
    }

    ripple.onTransitionEnd.listen(transitionEndHandler);
    ripple.on['webkitTransitionEnd'].listen(transitionEndHandler);
    ripple.on['oTransitionEnd'].listen(transitionEndHandler);
    ripple.on['MSTransitionEnd'].listen(transitionEndHandler);
  }
  
  transitionEndHandler(dom.Event event) {
    ripple.remove();
  }
    
  
  // Turn on the ripple effect
  rippleOn() {
    var size = getNewSize().toString();

    if (hasTransitionSupport()) {
      ripple.style.setProperty("-ms-transform", "scale(${size})");
      ripple.style.setProperty("-moz-transform", "scale(${size})");
      ripple.style.setProperty("-webkit-transform", "scale(${size})");
      ripple.style.transform = "scale(${size})";
      ripple.classes.add("ripple-on");
      ripple.dataset["animating"] = "on";
      ripple.dataset["mousedown"] = "on";
    } else {
//      ripple.animate({
//          "width": Math.max($element.outerWidth(), $element.outerHeight()) * 2,
//          "height": Math.max($element.outerWidth(), $element.outerHeight()) * 2,
//          "margin-left": Math.max($element.outerWidth(), $element.outerHeight()) * (-1),
//          "margin-top": Math.max($element.outerWidth(), $element.outerHeight()) * (-1),
//          "opacity": 0.2
//        }, 500);
//      , function() {
        ripple.dispatchEvent(new dom.Event("transitionend"));
//      });
    }
  }
}