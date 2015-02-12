Angular Material [![Build Status](https://travis-ci.org/akserg/angular.dart.material.svg?branch=master)](https://travis-ci.org/akserg/angular.dart.material)
=====================

Bootstrap Material Design implementation for Angular Dart UI.

Inspired by *Federico Zivolo* implementation of [Bootstrap Material Design](http://fezvrasta.github.io/bootstrap-material-design).

This Bootstrap theme is an easy way to use the new [Material Design guidelines by Google](http://www.google.com/design/spec/material-design/introduction.html) in your Bootstrap 3 based application.
Just include the theme, after the Bootstrap CSS and include the module in your Angular Dart project at the end of your document (just before the `</body>` tag), and everything will be converted to Material Design (Paper) style.

Check out [the Bootstrap elements at this link](http://akserg.github.io/angular.dart.material/bootstrap-elements.html).
                                  

#### material-wfont.css or material.css?

The only difference is that `material-wfont.css` has the Google web fonts included.

#### Use custom color as primary

Is often asked how to change the primary color of this theme without edit the bower package directly.

You can do it by creating a less file in your project:

    dependencies:
      less_dart: ">=0.1.4 <0.2.0"
    transformers:
      - less_dart:
        entry_point: web/less/ripples.less
        output: web/css/ripples.css
    - less_dart:
        entry_point: web/less/material-wfont.less
        include_path: web/less
        output: web/css/material-wfont.css
    ...
    // Override @primary color with one took from _colors.less
    @primary: @deep-purple;

Then, compiling this file, the entire theme will be compiled using the color chosen by you.

### Buttons

Add `.btn-flat` to a button to make it flat, without shadows.
Add `.btn-raised` to a button to add a permanent shadow to it.

### Inputs

Add `.floating-label` to an input field with a `placeholder` to transform the placeholder in a floating label.
Add `data-hint="some hint"` to show an hint under the input when the user focus it.

Remember to use the proper HTML markup to get radio and checkboxes styled correctly (choose between *radio* or *checkbox*):

    <div class="radio/checkbox radio-primary">
        <label>
            <input type="radio/checkbox" checked>
            Option one is this
        </label>
    </div>

### Icons

Material Design for Bootstrap includes 490 original Material Design icons!
These icons are extracted from the original Google sources and are licensed under the BSD license.
They are provided as an iconic and easy to use font.

Variations are available for every icon, including the original Bootstrap icons.

The syntax to add a Material icon is:

     <i class="icon icon-material-favorite"></i>

### Ripples

This is part of the Material Design for Bootstrap project and is a Dart script which creates the ripple effect when clicking on the specified elements.

You may want to set a custom color to the ripples of a specific element, to do so write:

    <button class="btn btn-default" data-ripple-color="#F0F0F0">Custom ripple</button>

## Compatibility

Currently, Material Design for Bootstrap supports:

- Google Chrome (tested v37+), 
- Mozilla Firefox (tested 30+), 
- Internet Explorer (tested 11+). 
 
Mobile browsers are not currently tested but they may work.



