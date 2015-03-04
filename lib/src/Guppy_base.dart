// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

// TODO: Put public facing types in this file.

library Guppy.base;

import 'dart:convert';
import 'dart:collection';
import 'dart:async';
import 'package:logging/logging.dart';
import 'package:angular/angular.dart';
import 'package:Guppy/Guppy.dart';

@Injectable()
abstract class GuppyAbstractLocalStorage {

  static String guppyStoreType;
  final GuppyConfig config;

  factory GuppyAbstractLocalStorage(){
    guppyStoreType = 'local';
  }

  Future init(/*Map<String, String> conf*/);

  Future<List<Map<String, String>>> list(String type);
  Future<Map<String, String>>       save(String type, Map<String, String> object, [String id]);
  Future<Map<String, String>>       get(String type, String id);
  Future<Map<String, String>>       update(String type, Map<String, String> object, String id);
  Future<Map<String, String>>       delete(String type, String id);
}

@Injectable()
abstract class GuppyAbstractDistStorage {
  static String guppyStoreType;

  factory GuppyAbstractDistStorage(){
    guppyStoreType = 'distant';
  }

  Future init(/*Map<String, String> conf*/);

  Future<List<String>> list(String type);
  Future<Map<String, String>> save(String type, Map<String, String> object, [String id]);
  Future<Map<String, String>> get(String type, String id);
  Future<Map<String, String>> update(String type, Map<String, String> object, String id);
  Future<Map<String, String>> delete(String type, String id);
}