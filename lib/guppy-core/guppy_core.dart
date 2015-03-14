// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

// TODO: Put public facing types in this file.

library guppy.core;

import 'dart:convert';
import 'dart:collection';
import 'dart:async';
import 'package:logging/logging.dart';

part 'src/guppy_core_stores.dart';
part 'src/guppy_core_resources.dart';
part 'src/guppy_core_config.dart';


/**
 * Types of stores :
 *  - Local : no risks of ruptures between this code and the storage module (ie localStorage, IndexedDB)
 *  - Distant : risks of ruptures between this code and the storage module (ie REST API)
 */
enum StorageType{LOCAL, DISTANT}



