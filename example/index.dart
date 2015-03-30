// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library guppy.example;

import 'dart:async';

import 'package:guppy/guppy-core/guppy_core.dart';
import 'package:guppy/guppy-manager/guppy_manager.dart';


import 'package:guppy/guppy-stores/localsAPI/indexedDB/indexedDB.dart' deferred as iDB;
import 'package:guppy/guppy-stores/localsAPI/memory/memory.dart' deferred as memDB;


/*
Exigences :
- Pouvoir ajouter un store a une resource en cours d'execution


 */

Map guppyConfig = {
  'orm':{},
  'dispatcher':{
    'eventStream':true,
    'resources':{
      'UserPrefs':{
        'store1':'localstorage',
        'store2':'restDB'
      },
      'Action':{
        'store1':'memory',
        'store2':'indexeddb'
      },
      'CompteRendu':{
        'store1':'memory',
        'store2':'indexeddb'
      },
      'Decision':{
        'store1':'memory',
        'store2':'indexeddb'
      }
    }
  },
  'stores':{
    'indexdedb':{
      'instance':new iDB.GuppyIndexedDB(),
      'config':{
        'dbName':'compterenduDB'
      },
      'resources':{
        'Action':{
          'indexes':[
            {'name':'ID', 'keyPath':'id', 'unique':true}
          ]
        },
        'CompteRendu':{
          'indexes':[
            {'name':'ID', 'keyPath':'id', 'unique':true}
          ]
        },
        'Decision':{}
      }
    },
    'memory':{
      'instance':new memDB.GuppyInMemoryDB()
    }
  }
};

Stream guppyStream;

main() {
  GuppyManager storage = new GuppyManager();


  //store initialisation
  storage.open().then((_){
    print('Store initialized');

    //Initialisations of Data in the store if this is the first use (Tests only)


    //Utiliser le store
  }
  );

  //IHM Initialisation


}
