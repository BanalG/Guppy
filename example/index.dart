// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library Guppy.example;

import 'package:guppy/guppy.dart';

import 'package:guppy/guppy-stores/localsAPI/indexedDB.dart'; // deferred as hello
import 'package:guppy/guppy-stores/localsAPI/memory.dart';
import 'package:guppy/guppy-stores/localsAPI/localstorage.dart';
import 'package:guppy/guppy-stores/distantsAPI/REST.dart';
import 'package:guppy/guppy-stores/distantsAPI/evernotes.dart';


//Todo Utiliser des exemples generiques (Contacts, Milestones, etc.)

/**
 * Initializations of the stores
 */
GuppyIndexedDB indexedDBStore = new GuppyIndexedDB(
  'indexedDB',
  {
      //put what is needed by the plugin here
      'dbName':'GuppyTestDB'
  }
);

GuppyRest restStore = new GuppyRest(
    'rest',
    {//put what is needed by the plugin here
        'pathRoot':'api.test.io/v1/'
    }
);

GuppyEvernotes googleCalendarStore = new GuppyEvernotes(
    'googleCalendar',
    {//put what is needed by the plugin here
        'pathRoot':'api.test.io/v1/'
    }
);

/**
 * Initialization of the resources
 */
GuppyResource userResource = new GuppyResource(
    'User',
    localStore:indexedDBStore,
    distStore:restStore,
    indexes:[ // = Can be searched by key :
        {'name':'ID', 'keyPath':'id', 'unique':true}
    ]
);

GuppyResource eventResource = new GuppyResource(
    'Event',
    localStore:indexedDBStore,
    distStore:restStore,
    indexes:[ // = Can be searched by key :
        {'name':'ID', 'keyPath':'id', 'unique':true}
    ]
);

GuppyResource placeResource = new GuppyResource(
    'Place',
    localStore:indexedDBStore,
    distStore:restStore,
    indexes:[ // = Can be searched by key :
        {'name':'ID', 'keyPath':'id', 'unique':true}
    ]
);

Map config = {
  'stores':[
      indexedDBStore,
      restStore,
      googleCalendarStore
  ],
    'default':{
        'localStore':{
            //'type': GuppyIndexedDB,
            'dbName':'compterenduDB'
        },
        'distStore':{
            //'type':null,
            'pathRoot':''
        }
    },
    'resources':[
        userResource,
        eventResource,
        placeResource
    ]
};

main() {
  GuppyManager storage = new GuppyManager();

  //add stores
  storage.addStore(indexedDBStore);
  storage.addStore(restStore);
  storage.addStore(googleCalendarStore);

  //add resources
  storage.addResource(userResource);
  storage.addResource(eventResource);
  storage.addResource(placeResource);

  //OR
  //storage.setConfig(config);

  //store initialisation
  storage.init().then((_){
    print('Store initialized');

    //Initialisations of Data in the store if this is the first use (Tests only)


    //Utiliser le store
  }
  );

  //IHM Initialisation


}
