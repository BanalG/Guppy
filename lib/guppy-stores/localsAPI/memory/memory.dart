library guppy.stores.inmemory;

//All stores must include this guppy librarys
import 'package:guppy/guppy-stores/guppy-stores.dart';
import 'dart:async';

//Add here specifics librarys for the store
import 'package:logging/logging.dart';

/*** Config for Resource ***/
class GuppyInMemory_RC extends IGuppyStore_RC{
  /*** Complete this fonction to check the conf ***/
  isValid(){
    return true;
  }

  /*** Add here special conf four the store ***/
}

//
class GuppyInMemoryDB extends IGuppyStore{
  final Logger log = new Logger('GuppyInMemory');

  bool isInitialized = false;

  Map<String, Map<String, Object>> stores = new Map<String, Map<String, Object>>();


  /****************************************************************************************************\
   * API methods
      \****************************************************************************************************/
  GuppyInMemoryDB() : super(false){
    this.log.finest('Instanciation de Guppy In Memory');
  }

  Future open(){
    log.finest('start of memoryDB initialization');
    return new Future.value(true);
  }

  close([bool eraseData = false]){
    return new Future.value(true);
  }



  search(String type, Map<String, String> filters, {Map fields: null, params: null, int start: null, int nb: null}){}
  nuke(){}

  Future<Map<String, String>> get(String type, String id){
    log.finest('$runtimeType get / $type / $id');
    return new Future.value(this.stores[type][id]);
  }

  /**
   *
   */
  Stream<Map<String,String>> list(String type, {Map fields: null, params: null, int start: null, int nb: null}){
    log.finest('list / $type');
    Stream s = new Stream.fromIterable(this.stores[type].values);
    return s;
  }

  /**
   *
   */
  Future<Map<String, String>> save(String type, Map<String, String> object, [String id]) {
    log.finest('save $type / $id / $object');
    this.stores[type][id] = object;
    return new Future.value(this.stores[type][id]);
  }

  /**
   *
   */
  Future<Map<String, String>> update(String type, Map<String, String> object, String id) {
    log.finest('update $type / $id / $object');
    this.stores[type][id] = object;
    return new Future.value(this.stores[type][id]);
  }

  /**
   *
   */
  Future delete(String type, String id) {
    log.finest('update $type / $id');
    var object = this.stores[type][id];
    this.stores[type].remove(id);
    return new Future.value(object);
  }

  /**
   *
   */
  Future _clearDB([String type]) {
    log.finest('_deleteFromDB $type');
    //ToDo Ecrire la function
    return new Future.value(false);
  }
}