library guppy.manager;

import 'dart:async';
import 'package:logging/logging.dart';
import 'package:guppy/guppy-core/guppy_core.dart';

import 'package:guppy/guppy-core/src/store/guppy-stores.dart';


class GuppyManager extends IGuppyStore { //dispatcher
  final Logger log = new Logger('GuppyManager');
  GuppyConfig config;

  /*** Task Manager ***/
  //Todo TaskManager

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


  /*** Manage Guppy Event Stream ***/
  bool _isStreamActive = false;
  bool get isStreamActive => _isStreamActive;
  get getStream => GuppyStream.stream;

  StreamController GuppyStream = new StreamController();

  Stream initEventsStream(){
    GuppyStream = new StreamController();
    _isStreamActive = true;
    return GuppyStream.stream;
  }

  /*** controls ***/
  //isAvailable

  /// Check if all stores are open
  bool isOpen() => _isOpen;
  bool _isOpen = false;

  /**
   * Initialisation
   */
  GuppyManager(/*this.config, [this.localStore, this.distantStore]*/){

    // Register GuppyStream events
    GuppyStream.stream.listen((v) => log.finest('stream : $v'));

  }

  Future<String> waitForInitialization([Duration timeout, int order]) {
    var completer = new Completer();

    if(this.isOpen()){
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
      new Timer(timeout, (){
        return waitForInitialization(timeout, order).then( (_) => completer.complete()); });
    }

    return completer.future;
  }


  /**
   *
   */
  Future open() async {
    log.finest('init');
    //Instantiation des systemes de stockage
    List<Future> toInit = new List();

    //If there is no store
    if(this.config.stores.length == 0 ){
      throw('There is no store. Please add store(s) and call init again');
      return null;
    }

    this.config.stores.forEach((v){
    toInit.add(v.open());
    });

    return Future.wait(toInit)
      .then((v) =>  _isOpen = true)
      .catchError((e) => log.severe('Error in Guppy Initialization'));
  }

  Future close(){

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
  Future<Map<String, String>> get(String resourceType, String id){
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

    if(this.config.getResource(resourceType).hasLocalStore()){
      return waitForInitialization().then((v){
        return this.config.getResource(resourceType).store1.get(resourceType, id);
      });
    } else if(this.config.getResource(resourceType).hasOnlineStore()){
      return waitForInitialization().then((v){
        return this.config.getResource(resourceType).store2.get(resourceType, id);
      });
    }


    return waitForInitialization().then((v){
      return this.config..getResource(resourceType).store1.get(resourceType, id);
    });
  }

  /**
   *
   */
  Future<List<Map<String, String>>> list(String resourceType, [Map param]){
    return waitForInitialization().then((v){
      return this.config.getResource(resourceType).store1.list(resourceType);
    });
  }

  /**
   *
   */
  Future<Map<String, String>> save(String resourceType, Map<String, String> object, String id){
    log.finest('save $resourceType / $id / $object');
    //_pendingTasks.add(new Task('add', type, id, object));
    return waitForInitialization().then((v) {
      return this.config.getResource(resourceType).store1.save(resourceType, object, id);
    });
  }

  /**
   *
   */
  Future<Map<String, String>> update(String resourceType, Map<String, String> object, String id){
    return waitForInitialization().then((v) {
      return this.config.getResource(resourceType).store1.update(resourceType, object, id);
    });
  }

  Future<Map<String, String>> delete(String resourceType, String id){
    //_pendingTasks.add(new Task('delete', type, id));
    return this.config.getResource(resourceType).store1.delete(resourceType, id);
  }


}