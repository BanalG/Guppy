// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

/// The Guppy library.
///
/// This is an awesome library. More dartdocs go here.
library guppy;

// TODO: Export any libraries intended for clients of this package.

import 'src/guppy_base.dart';
export 'src/guppy_base.dart';

import 'dart:indexed_db' as idb;
//import 'package:angular/angular.dart';
import 'dart:async';
import 'dart:html';
import 'dart:core';
import 'dart:convert';
import 'package:logging/logging.dart';

part 'src/config.dart';
part 'src/guppy_manager.dart';
part 'src/task.dart';
part 'src/localsAPI/indexedDB.dart';
part 'src/localsAPI/memory.dart';
part 'src/localsAPI/localstorage.dart';
part 'src/distantsAPI/REST.dart';
part 'src/distantsAPI/evernotes.dart';

/*
class Guppy extends Module{
  Guppy() {
    bind(GuppyConfig);
    bind(GuppyManager);
    bind(GuppyIndexedDB);
    bind(GuppyAbstractLocalStorage);
    bind(GuppyAbstractDistStorage);
    //bind(GuppyMemory);
    //bind(GuppyREST);
    //bind(ObjectStore);
  }

}*/

class Guppy extends GuppyManager{
  Guppy();
}