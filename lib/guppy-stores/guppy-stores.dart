// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library guppy.stores;

import 'dart:async';
import 'package:logging/logging.dart';

import 'package:guppy/guppy-core/guppy_core.dart';
export 'package:guppy/guppy-core/guppy_core.dart';


abstract class IGuppyStore_RC{

}


/**
 * Class for implement Storages types
 */
abstract class IGuppyStore{
  final Logger log = new Logger('GuppyAbstractStorage');

  final String name;
  bool _isOpen = false;

  /// Set to true if configuration is required to handle the resource
  bool _needRC;
  StorageType _storageType;

  Map<String, GuppyResource> _resources = new Map();

  IGuppyStore(this.name, this._storageType, this._needRC);

  Map<String, GuppyResource> get resources => _resources;

  /// Add a [GuppyResource] to the store
  addResource(GuppyResource resource) {
    // Check if the resource isn't null
    if(resource == null) throw('resource is null');

    // Check if the resource already exist
    if (this._resources[resource] != null) throw('resource already exist');

    // If needed, check if the resource has the configuration for the store
    if(_needRC && !resource.hasConfOfStore(this)) throw('store $this need a resource configuration');

    // If needed, check the conf
    if(_needRC && !resource.getConfOfStore(this).isValid()) throw('the conf is invalid');

    // It's OK, add the Resource
    this._resources[resource.name] = resource;
  }

  /// Remove a [GuppyResource] from the store
  removeResource(GuppyResource resource){
    //check if the resource has been disconnected to the stores
    //No -> throw error
    //Yes -> Disconnect
    this._resources.remove(resource);
  }

  /// Open the store
  Future open();

  /// Get the store status
  bool isOpen() => this._isOpen;

  /// Disconnect the store
  Future close([bool eraseData = false]);

  ///Clear all datas of the store
  Future nuke();

  /// List all or search
  Stream<Map<String, String>>  list(String type,
                                    {Map fields: null, params: null, int start: null, int nb: null});
  Stream<Map<String, String>>  search(String type, Map<String, String> filters,
                                      {Map fields: null, params: null, int start: null, int nb: null});

  /// Classicals Atomic CRUD fonctions
  Future<Map<String, String>>  save(String type, Map<String, String> object, [String id]);
  Future<Map<String, String>>  get(String type, String id);
  Future<Map<String, String>>  update(String type, Map<String, String> object, String id);
  Future<Map<String, String>>  delete(String type, String id);

  /// Extended CRUD Functions, optional
  Stream<Map<String, String>>  saveManyByKeys(String type, List<Map<String, String>> objects){return null;}
  Stream<Map<String, String>>  getManyByKeys(String type, List<String> ids){return null;}
  Stream<Map<String, String>>  updateManyByKeys(String type, Map<String, String> objects){return null;}
  Stream<Map<String, String>>  deleteManyByKeys(String type, String field, List<String> value){return null;}
}