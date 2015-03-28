library guppy.stores.indexeddb;


//All stores must include this guppy librarys
import 'package:guppy/guppy-stores/guppy-stores.dart';
import 'dart:async';

//Add here specifics librarys for the store
import 'package:logging/logging.dart';
import 'dart:html';
import 'dart:indexed_db' as idb;

/*** Config for Resource ***/
class GuppyIndexedDB_RC extends IGuppyStore_RC{
  /*** Complete this fonction to check the conf ***/
  isValid(){
    if(iDBName == null || iDBName =="") throw('iDBName is not set');

    return true;
  }

  /*** Add here special conf four the store ***/
  String iDBName;
  List indexes;
  bool autoIncrementId = false;

  addIndex(String name, String keyPath, bool unique){
    indexes.add({'name': name, 'keyPath': keyPath, 'unique': unique, 'autoIncrement': true});
  }
}

//
class GuppyIndexedDB extends IGuppyStore{
  final Logger log = new Logger('GuppyIndexedDB');

  String iDBName;
  bool isInitialized = false;


  idb.Database _idb;


  /****************************************************************************************************\
  * API methods
  \****************************************************************************************************/
  GuppyIndexedDB(name) : super(name, StorageType.LOCAL, false){
    this.log.finest('Instanciation de Guppy');
  }

  void setDBName(name){
    this.iDBName = name;
  }

  Future open(){
    log.finest('start of indexedDB initialization');

    this.resources.remove(null);

    return window.indexedDB.open(
        this.iDBName,
        version: 1,
        onUpgradeNeeded: _initializeDatabase)
    .then((db){
      this._idb = db;
      this.isInitialized = true;
      log.finest('indexedDB initialized');
    });
  }

  close([bool eraseData = false]){
    this._idb.close();
  }

/**
 * Initialisation de la base de donnees, appellee en cas de premiere creation ou de montee de version
 */
  void _initializeDatabase(idb.VersionChangeEvent e) {
    log.finest('Versions : ${e.oldVersion} => ${e.newVersion}');
    //log.finest('_initializeDatabase');
    idb.Database db = (e.target as idb.Request).result;

    if(e.oldVersion == 0 ){
      //Premiere creation de la base
      log.finest('There is ${this.resources.length} to Initialize');

      this.resources.forEach((k, GuppyResource o){
        GuppyIndexedDB_RC c = o.getConfOfStore(this);
        log.finest('Initialization of ObjectStore : ${o.name}');
        idb.ObjectStore t = db.createObjectStore(o.name , autoIncrement: c.autoIncrementId);
        if(c.indexes != null){
          c.indexes.forEach((Map i) => t.createIndex(i['name'], i['keyPath'], unique: i['unique']));
        }
      });
    } else if(e.oldVersion != e.newVersion ){
      //Montee de version de la base
      log.finest('difference de versions : ${e.oldVersion} => ${e.newVersion}');
      //TODO Realiser la montee de version
    }
  }

  search(String type, Map<String, String> filters, {Map fields: null, params: null, int start: null, int nb: null}){}
  nuke(){}

  Future<Map<String, String>> get(String type, String id){
    log.finest('_getOneFromDB / $type / $id');

    GuppyResource objStore = this.resources[type];
    if(objStore == null){log.severe('Guppy / IndexedDB / type non exist : $type');}

    var transaction = this._idb.transaction(objStore.name , 'readwrite');
    var objectStore = transaction.objectStore(objStore.name);

    return objectStore.getObject(id).then((v){return v;});

    //return transaction.completed.then((v){return v.;});
  }

  executeIfOpen(Future f){
    if(isInitialized == false){
      Future f = new Future.delayed(new Duration(seconds:4));
      return f.then((r){
        return f;
      });
    } else {
      return f;
    }
  }

  /**
   *
   */
  Stream<Map<String,String>> list(String type, {Map fields: null, params: null, int start: null, int nb: null}){
    log.finest('_getAllFromDB / $type');

    GuppyResource objStore = this.resources[type];
    if(objStore == null){log.severe('Guppy / IndexedDB / type non exist : $type');}

    var transaction = this._idb.transaction(objStore.name, 'readonly');
    var objectStore = transaction.objectStore(objStore.name);

    var cursors = objectStore.openCursor(autoAdvance: true);
    List<Map<String, String>> l = new List<Map<String, String>>();

    return cursors.forEach((v) => l.add(v.value)).then((_){
      return l;
    });
  }

  /**
   *
   */
  Future<Map<String, String>> save(String type, Map<String, String> object, [String id]) {
    log.finest('addInDB $type / $id / $object');

    GuppyResource objStore = this.resources[type];
    if(objStore == null){log.severe('Guppy / IndexedDB / type non exist : $type');}

    var transaction = this._idb.transaction(objStore.name , 'readwrite');
    var objectStore = transaction.objectStore(objStore.name);

    objectStore.add(object, id);

    return transaction.completed.then((_) {
      return id;
    });
  }

  /**
   *
   */
  Future<Map<String, String>> update(String type, Map<String, String> object, String id) {
    log.finest('_updateInDb $type / $id / $object');

    GuppyResource objStore = this.resources[type];
    if(objStore == null){log.severe('Guppy / IndexedDB / type non exist : $type');}

    var transaction = _idb.transaction(objStore.name, 'readwrite');
    transaction.objectStore(objStore.name).put(object, id);

    return transaction.completed;
  }

  /**
   *
   */
  Future delete(String type, String id) {
    log.finest('_deleteFromDB $type / $id');

    GuppyResource objStore = this.resources[type];
    if(objStore == null){log.severe('Guppy / IndexedDB / type non exist : $type');}

    var transaction = _idb.transaction(objStore.name, 'readwrite');
    transaction.objectStore(objStore.name).delete(id);

    return transaction.completed;
  }

  /**
   *
   */
  Future _clearDB([String type]) {
    log.finest('_deleteFromDB $type');

    idb.Transaction transaction;
    // Clear database.
    if(type == null){
      this.resources.forEach((k, GuppyResource e){

        GuppyResource objStore = e;
        if(objStore == null){log.severe('Guppy / IndexedDB / type non exist : $type');}

        transaction = _idb.transaction(objStore.name, 'readwrite');
        transaction.objectStore(objStore.name).clear();
      });
    } else {
      GuppyResource objStore = this.resources[type];
      if(objStore == null){log.severe('Guppy / IndexedDB / type non exist : $type');}

      transaction = _idb.transaction(objStore.name, 'readwrite');
      transaction.objectStore(objStore.name).clear();
    }

    return transaction.completed;
  }
}