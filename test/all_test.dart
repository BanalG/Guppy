// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library Guppy.test;

import 'package:unittest/unittest.dart';
import 'package:guppy/guppy.dart';

main() {
  group('A group of tests', () {
    Awesome awesome;

    setUp(() {
      awesome = new Awesome();
    });

    test('First Test', () {
      expect(awesome.isAwesome, isTrue);
    });
  });

  //Creation de l'instance sans configuration OK


  //Ajout des configurations

}
