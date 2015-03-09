// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

// TODO: Put public facing types in this file.

library guppy.base;

import 'dart:convert';
import 'dart:collection';
import 'dart:async';
import 'package:logging/logging.dart';
import 'package:guppy/guppy.dart';

/**
 * Types of stores :
 *  - Local : no risks of ruptures between this code and the storage module (ie localStorage, IndexedDB)
 *  - Distant : risks of ruptures between this code and the storage module (ie REST API)
 */
enum StorageType{LOCAL, DISTANT}

/**
 * Class for implement Storages types
 */
abstract class GuppyAbstractStorage{
  final Logger log = new Logger('GuppyAbstractStorage');
  final String name;
  final StorageType guppyStoreType;
  List<GuppyResource> resource;
  GuppyConfig config;

  GuppyAbstractStorage(this.name, this.guppyStoreType){
  }

  Future init(List<GuppyResource> resources);

  Stream<Map<String, String>>       list(String type);
  Future<Map<String, String>>       save(String type, Map<String, String> object, [String id]);
  Future<Map<String, String>>       get(String type, String id);
  Future<Map<String, String>>       update(String type, Map<String, String> object, String id);
  Future<Map<String, String>>       delete(String type, String id);

  /*
  Stream<String>                    getByKeys(String type, List<String> id);
  Stream<String>                    getByValue(String type, String field, List<String> value);
  */
}

/**
 *
 */
abstract class GuppyAbstractLocalStorage extends GuppyAbstractStorage{
  final Logger log = new Logger('GuppyAbstractLocalStorage');
  GuppyConfig config;

  GuppyAbstractLocalStorage(name) : super(name, StorageType.LOCAL){
  }
}

/**
 *
 */
abstract class GuppyAbstractDistStorage extends GuppyAbstractStorage{
  final Logger log = new Logger('GuppyAbstractDistStorage');
  //StorageType guppyStoreType;

  GuppyAbstractDistStorage(name) : super(name, StorageType.DISTANT){

  }
}


class GuppyResource{
  final Logger log = new Logger('GuppyResource');
  String name;
  bool isAutoIncrementKey;
  List<Map> indexes;

  GuppyAbstractLocalStorage localStore;
  GuppyAbstractDistStorage distStore;

  GuppyResource(
      this.name,
      {
      this.localStore: null,
      this.distStore: null,
      this.isAutoIncrementKey: false,
      this.indexes: null
      });

  bool hasLocalStore(){ return this.localStore == null ? false : true; }
  bool hasDistStore(){ return this.distStore == null ? false : true; }

}