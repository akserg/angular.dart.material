library material;

import 'dart:html' as dom;

notmdproc(dom.Element obj) {
  return !obj.dataset.containsKey("mdproc");
}

_isChar(dom.Event evt) {
//  if (evt.which == "undefined") {
//    return true;
//  } else if (typeof evt.which == "number" && evt.which > 0) {
//    return !evt.ctrlKey && !evt.metaKey && !evt.altKey && evt.which != 8 && evt.which != 9;
//  }
}

class Material {
  // These options set what will be started by $.material.init()
  var options = {
  "input": true,
  "ripples": true,
  "checkbox": true,
  "togglebutton": true,
  "radio": true,
  "arrive": true,
  "autofill": false,

  "withRipples": [
    ".btn:not(.btn-link)",
    ".card-image",
    ".navbar a:not(.withoutripple)",
    ".dropdown-menu a",
    ".nav-tabs a:not(.withoutripple)",
    ".withripple"
  ].join(","),
    "inputElements": "input.form-control, textarea.form-control, select.form-control",
    "checkboxElements": ".checkbox > label > input[type=checkbox]",
    "togglebuttonElements": ".togglebutton > label > input[type=checkbox]",
    "radioElements": ".radio > label > input[type=radio]"
  };
  
  Material() {
    dom.document.onChange.listen((dom.Event event) {
      if (event.currentTarget is dom.Element) {
        dom.Element element = event.currentTarget as dom.Element;
        if (element.classes.contains('checkbox') || element is dom.CheckboxInputElement) {
          element.blur();
        }
      }
    });
    //
    formControl(dom.Event event) {
      if (event.currentTarget is dom.Element) {
        dom.Element element = event.currentTarget as dom.Element;
        if (element.classes.contains('form-control')) {
          
        }
      }
    };
    dom.document.onKeyDown.listen(formControl);
    dom.document.onPaste.listen(formControl);
  }
  
  checkbox({String selector:null}) {
    // Add fake-checkbox to material checkboxes
    dom.ElementList list = dom.document.querySelectorAll(selector != null ? selector : this.options.checkboxElements);
    list.takeWhile(notmdproc).forEach((dom.Element el) {
      el.dataset["mdproc"] = 'true';
      el.insertAdjacentHtml('after', "<span class=ripple></span><span class=check></span>");
    });
  }
  
  togglebutton({String selector:null}) {
    // Add fake-toggle to material toggle buttons
    dom.ElementList list = dom.document.querySelectorAll(selector != null ? selector : this.options.togglebuttonElements);
    list.takeWhile(notmdproc).forEach((dom.Element el) {
      el.dataset["mdproc"] = 'true';
      el.insertAdjacentHtml('after', "<span class=toggle></span>");
    });
  }
  
  radio({String selector:null}) {
    // Add fake-radio to material radios
    dom.ElementList list = dom.document.querySelectorAll(selector != null ? selector : this.options.radioElements);
    list.takeWhile(notmdproc).forEach((dom.Element el) {
      el.dataset["mdproc"] = 'true';
      el.insertAdjacentHtml('after', "<span class=circle></span><span class=check></span>");
    });
  }
  
  input({String selector:null}) {
    dom.ElementList list = dom.document.querySelectorAll(selector != null ? selector : this.options.inputElements);
    list.takeWhile(notmdproc).forEach((dom.Element el) {
      el.dataset["mdproc"] = 'true';
      inputHelper(el as dom.InputElement);
    });
  }
  
  inputHelper(dom.InputElement el) {
    if (!el.attributes.containsKey("data-hint") && !el.classes.contains("floating-label")) {
      return;
    }
    
    // $this.wrap("<div class=form-control-wrapper></div>");
    dom.DivElement wrap = new dom.DivElement();
    wrap.classes.add('form-control-wrapper');
    el.parent.insertBefore(wrap, el);
    wrap.append(el);
    
    // $this.after("<span class=material-input></span>");
    el.insertAdjacentHtml('after', "<span class=material-input></span>");

    // Add floating label if required
    if (el.classes.contains("floating-label")) {
      var placeholder = el.attributes["placeholder"];
      el.attributes.remove("placeholder");
      el.classes.remove("floating-label");
      el.insertAdjacentHtml('after', "<div class=floating-label>" + placeholder + "</div>");
    }

    // Add hint label if required
    if (el.attributes.containsKey("data-hint")) {
      el.insertAdjacentHtml('after', "<div class=hint>" + el.attributes["data-hint"] + "</div>");
    }

    // Set as empty if is empty (damn I must improve this...)
    if (el.value == null || el.value == "") {
      el.classes.add("empty");
    }

    // Support for file input
    if (el.parent.nextElementSibling is dom.FileUploadInputElement) {
      el.parent.classes.add("fileinput");
      var input = el.parent.nextElementSibling.remove();
      el.insertAdjacentElement('after', input);
    }
  }
}