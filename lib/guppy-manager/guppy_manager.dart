library guppy.manager;

import 'dart:async';
import 'dart:html';
import 'package:logging/logging.dart';
import 'package:guppy/guppy-core/guppy_core.dart';

class GuppyManager {
  final Logger log = new Logger('GuppyManager');

  List<GuppyAbstractStorage> stores;
  Map<String, GuppyResource> resources;
  Map<String, String> StoresAndResourcesBinding;

  final StreamController GuppyStream = new StreamController();

  /// Check if all stores are open
  bool get isOpen => _isOpen;
  bool _isOpen = false;

  /*** Task Manager ***/
  List<Object> _pendingTasks = new List();
  initTaskManager(GuppyAbstractStorage store){
    var tasksResource = new GuppyResource('GuppyTasks');
    addResource(new GuppyResource('GuppyTasks'));

    bindResourceToStore(tasksResource, store, null);
  }

  /*** Manage network connectivity ***/
  bool _isOnline = false;
  bool get isOnline => _isOnline;

  _setOnline(){
    GuppyStream.add('Online');
    this._isOnline = true;
  }

  _setOffline(){
    GuppyStream.add('Offline');
    this._isOnline = false;
  }

  /**
   * Initialisation
   */
  GuppyManager(/*this.config, [this.localStore, this.distantStore]*/){
    this.init();

    // Register GuppyStream events
    GuppyStream.stream.listen((v) => log.finest('stream : $v'));

    //Register online/offline detection
    window.onOnline.listen(_setOnline());
    window.onOffline.listen(_setOffline());
  }

  Future<String> waitForInitialization([Duration timeout, int order]) {
    var completer = new Completer();

    if(this.isOpen){
      //Si c'est configure on passe a la suite
      completer.complete();
    } else {
      //Si ce n'est pas configure on lance un timer
      if(timeout == null){
        timeout = new Duration(milliseconds: 10 );
        order = 1;
      } else {
        timeout = timeout * 2;
        order++;
      }
      var timer = new Timer(timeout, (){
        return waitForInitialization(timeout, order).then( (_) => completer.complete()); });
    }

    return completer.future;
  }


  /**
   *
   */
  Future init(){
    log.finest('init');
    //Instantiation des systemes de stockage
    List<Future> toInit = new List();
    this.stores.forEach((v){
      toInit.add(v.open(this.resources.values));
    });

    return Future.wait(toInit)
      .then((v) =>  _isOpen = true)
      .catchError((e) => log.severe('Error in Guppy Initialization'));
  }

  /** Manage Stores **/
  GuppyAbstractStorage addStore(GuppyAbstractStorage store){
    this.stores.add(store);
    return store;
  }

  Future<bool> removeStore(GuppyAbstractStorage store){
    return store.close().then((_){
      this.stores.remove(store);
    });
  }

  /** Manage Resources **/
  GuppyResource addResource(GuppyResource resource){
    //if resource already exist, reject
    this.resources[resource.name] = resource;
    return resource;
  }

  GuppyResource getResource(String resource){
    return this.resources[resource];
  }

  GuppyResource removeResource(String resource){
    //Todo if resource is binded, reject
    return this.resources[resource];
  }

  /** Manage resources and stores binding **/
  bindResourceToStore(GuppyResource resource, GuppyAbstractStorage store, [GuppyAbstractStoreResource conf]){
    // If resource isn't known, add to resources list

    // If store isn't known, add to store list

    // Inform the store of the resource with it's config
    store.addRessource(resource, conf);
  }

  unbindResourceToStore(GuppyResource resource, GuppyAbstractStorage store){
    //store.
  }


  /**
   * Automatic binding of Resources and Stores
   */
  autobindResourcesToStore(){
    // Check that there is no binding yet

    // Check that there is at least one Store AND only one or zero local Store AND only one or zero distant Store

    // Check that there is at least one Resource

    // for each resource :
    //  Bind to local store if exist
    //  Bind to distant store if exist
  }

  /**
   *
   */
  sync([bool simulation]){
    log.finest('Sync is not yet implemented');

    /*
    Plusieurs solutions :
      - Recuperer les Pending cote client et serveur, effectuer comparaison et actualiser des deux cotes ==> Moins de charge serveur
      - Envoyer tous les pending cote Serveur qui se charge de comparer et remonte les conflits ==> Meilleur en cas de collaboratif

     */
  }

  /**
   *
   */
  Future<Map<String, String>> getOneById(String resourceType, String id){
    /*
    Si uniquement local store :
      - faire le local
    Si uniquement dist store :
     - faire le distant ASAP et remonter tout de suite si erreur
    Si les deux :
      - Faire le local
      - Ajouter aux taches a traiter
      - Faire le distant en tache de fond et remonter erreur apres plusieurs tentatives espacees dans le temps
     */

    if(getResource(resourceType).hasLocalStore()){
      return waitForInitialization().then((v){
        return this.getResource(resourceType).localStore.get(resourceType, id);
      });
    } else if(getResource(resourceType).hasDistStore()){
      return waitForInitialization().then((v){
        return this.getResource(resourceType).distStore.get(resourceType, id);
      });
    }


    return waitForInitialization().then((v){
      return this.getResource(resourceType).localStore.get(resourceType, id);
    });
  }

  /**
   *
   */
  Future<List<Map<String, String>>> list(String resourceType, [Map param]){
    return waitForInitialization().then((v){
      return this.getResource(resourceType).localStore.list(resourceType);
    });
  }

  /**
   *
   */
  Future<Map<String, String>> save(String resourceType, Map<String, String> object, String id){
    log.finest('save $resourceType / $id / $object');
    //_pendingTasks.add(new Task('add', type, id, object));
    return waitForInitialization().then((v) {
      return this.getResource(resourceType).localStore.save(resourceType, object, id);
    });
  }

  /**
   *
   */
  Future<Map<String, String>> update(String resourceType, Map<String, String> object, String id){
    Map<String, String> newObject = object;
    Map<String, String> oldObject;

    return waitForInitialization().then((v) {
      return this.getResource(resourceType).localStore.update(resourceType, object, id);
    });
  }

  Future<Map<String, String>> delete(String resourceType, String id){
    //_pendingTasks.add(new Task('delete', type, id));
    return this.getResource(resourceType).localStore.delete(resourceType, id);
  }


}