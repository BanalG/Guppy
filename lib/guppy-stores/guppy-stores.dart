// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library guppy.stores;

import 'dart:async';
import 'package:logging/logging.dart';

//import 'package:guppy/guppy-core/guppy_core.dart';
//export 'package:guppy/guppy-core/guppy_core.dart';

part 'guppy-stores-config.dart';

/**
 * Class for implement Storages types
 */
abstract class IGuppyStore{
  final Logger log = new Logger('GuppyAbstractStorage');

  bool _isOpen = false;

  /// Set to true if configuration is required to handle the resource
  bool _needRC;

  IGuppyStore(this._needRC);

  /// Get the store status
  bool isOpen() => this._isOpen;


  /// Open the store
  Future open();

  /// Disconnect the store
  Future close();

  /*
   * Data management
   */

  /***   List all or search    ***/
  Stream<Map<String, String>>  list(String type, {Map fields: null, params: null, int start: null, int nb: null});
  //Stream<Map<String, String>>  search(String type, Map<String, String> filters, {Map fields: null, params: null, int start: null, int nb: null});

  /***   Classicals Atomic CRUD fonctions    ***/
  Future<Map<String, String>>  save(String type, Map<String, String> object, [String id]);
  Future<Map<String, String>>  get(String type, String id);
  Future<Map<String, String>>  update(String type, Map<String, String> object, String id, [Map <String, String> oldObject]);
  Future<Map<String, String>>  delete(String type, String id);

  /***   Extended CRUD Functions, optional    ***/
  //Stream<Map<String, String>>  saveManyByKeys(String type, List<Map<String, String>> objects){return null;}
  //Stream<Map<String, String>>  getManyByKeys(String type, List<String> ids){return null;}
  //Stream<Map<String, String>>  updateManyByKeys(String type, Map<String, String> objects){return null;}
  //Stream<Map<String, String>>  deleteManyByKeys(String type, String field, List<String> value){return null;}

  /*** Some stores need custom query for non CRUD operations ***/
  //Stream<Map<String, String>>  customQuery(String type, String queryName, Map data);

  ///Clear all datas of the store (usefull if you want to disconnect a store for ever.
  //Future nuke();
}