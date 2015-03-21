// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library guppy.example;

import 'dart:async';

import 'package:guppy/guppy-core/guppy_core.dart';
import 'package:guppy/guppy-manager/guppy_manager.dart';


import 'package:guppy/guppy-stores/localsAPI/indexedDB/indexedDB.dart'; // deferred as indexedDBLibrary;
import 'package:guppy/guppy-stores/distantsAPI/ToDo/REST.dart';

/**
 * Initializations of the stores
 */
final GuppyIndexedDB indexedDBStore = new GuppyIndexedDB('indexedDB')
  ..setDBName('GuppyTestDB');

final GuppyRest restStore = new GuppyRest('rest')
  ..setPathRoot('api.test.io/v1/');

/**
 * Initialization of the resources
 */
final GuppyResource userResource = new GuppyResource('User');
final GuppyResource eventResource = new GuppyResource('Event');
final GuppyResource placeResource = new GuppyResource('Place');

Stream guppyStream;

main() {
  GuppyManager storage = new GuppyManager();

  guppyStream = storage.initEventsStream();

  //add resources
  storage
  ..addResource(userResource)
  ..addResource(eventResource)
  ..addResource(placeResource);

  //add stores
  storage
    ..addStore(indexedDBStore)
    ..addStore(restStore);

  //set store for the tasks manager
  storage
  ..initTaskManager(indexedDBStore);

  //set specials conf between resources and stores
  GuppyIndexedDB_RC UserIndexedDBConf = new GuppyIndexedDB_RC()..addIndex('ID', 'id', true);


  //bind stores and resources
  storage
  ..bindResourceToStore(
      userResource,
      indexedDBStore,
      UserIndexedDBConf
  )
  ..bindResourceToStore(userResource, restStore)

  ..bindResourceToStore(eventResource, indexedDBStore)
  ..bindResourceToStore(eventResource, restStore)

  ..bindResourceToStore(placeResource, indexedDBStore)
  ..bindResourceToStore(placeResource, restStore);

  //store initialisation
  storage.init().then((_){
    print('Store initialized');

    //Initialisations of Data in the store if this is the first use (Tests only)


    //Utiliser le store
  }
  );

  //IHM Initialisation


}
