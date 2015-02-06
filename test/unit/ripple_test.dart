// Copyright (C) 2015 Sergey Akopkokhyants.
// https://github.com/akserg/angular.dart.material
// All rights reserved.  Please see the LICENSE.md file.
part of angular_material_test;

testRipple() {
  describe("[Ripple]", () {
    TestBed _;
    Scope scope;
        
    beforeEach(setUpInjector);
    afterEach(tearDownInjector);

    beforeEach(() {
      module((Module _) => _
        ..install(new MaterialModule())
      );
    });

    it("should generate no errors", async(() {
      expect(0).toEqual(0);
    }));
  });
}
