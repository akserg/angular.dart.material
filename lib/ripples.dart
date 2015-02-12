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
    
    Position position = getClickOrTouchPosition(event);
    if (position != null) {
      // Get the ripple color
      rippleColor = getRipplesColor();
      
      // Create the ripple element
      ripple = new dom.DivElement()
      ..classes.add("ripple")
      ..style.left = "${position.x}px"
      ..style.top = "${position.y}px"
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
  }
  
  endRipplesHandler(dom.Event event) {
    ripple.dataset['mousedown'] = 'off';

    if (ripple.dataset['animating'] == 'off') {
      rippleOut();
    }
  }
  
  // Get the new size based on the element height/width and the ripple width
  String getNewSize() {
    return ((math.max(element.offsetWidth, element.offsetHeight) / ripple.offsetWidth) * 2.5).toString();
  }
  
  getClickOrTouchPosition(dom.Event e) {
    Position position;
    if (isTouch()) {
      // Make sure the user is using only one finger and then get the touch
      // position relative to the ripple wrapper
      if ((e as dom.TouchEvent).touches.length != 1) {
        position = getPosition(wrapper);
        position.x = (e as dom.TouchEvent).touches[0].page.x - position.x;
        position.y = (e as dom.TouchEvent).touches[0].page.y - position.y;
      }
    } else {
      position = getPosition(wrapper);
      position.x = (e as dom.MouseEvent).client.x - position.x;
      position.y = (e as dom.MouseEvent).client.y - position.y;
    }
    return position;
  }
   
  getPosition(dom.Element element) {
    Position position = new Position(0, 0);
        
    while (element != null) {
      position.x += (element.offsetLeft - element.scrollLeft + element.clientLeft);
      position.y += (element.offsetTop - element.scrollTop + element.clientTop);
      element = element.offsetParent;
    }
    return position;
  }
  
  // Get the ripple color
  getRipplesColor() {
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
    if (hasTransitionSupport()) {
      ripple.classes.add("ripple-out");
    } else {
      ripple.animate({"opacity": 0}, 100).play();
      ripple.dispatchEvent(new dom.Event('transitionend'));
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
    var size = getNewSize();

    if (hasTransitionSupport()) {
      ripple.style.setProperty("-ms-transform", "scale(${size})");
      ripple.style.setProperty("-moz-transform", "scale(${size})");
      ripple.style.setProperty("-webkit-transform", "scale(${size})");
      ripple.style.transform = "scale(${size})";
      ripple.classes.add("ripple-on");
      ripple.dataset["animating"] = "on";
      ripple.dataset["mousedown"] = "on";
    } else {
      ripple.animate({
        "width": math.max(element.offsetWidth, element.offsetHeight) * 2,
        "height": math.max(element.offsetWidth, element.offsetHeight) * 2,
        "margin-left": math.max(element.offsetWidth, element.offsetHeight) * (-1),
        "margin-top": math.max(element.offsetWidth, element.offsetHeight) * (-1),
        "opacity": 0.2
      }, 500).play();
      ripple.dispatchEvent(new dom.Event("transitionend"));
    }
  }
}

class Position {
  int x;
  int y;

  Position (this.x, this.y);
}