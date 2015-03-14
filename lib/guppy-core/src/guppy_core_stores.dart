part of guppy.core;

/**
 * Class for implement Storages types
 */
abstract class GuppyAbstractStorage{
  final Logger log = new Logger('GuppyAbstractStorage');

  final String name;
  final StorageType guppyStoreType;
  bool _initializationState = false;

  List<GuppyResource> resource;
  GuppyConfig config;

  GuppyAbstractStorage(this.name, this.guppyStoreType){
  }

  /// Open store
  Future open(List<GuppyResource> resources);

  /// Close store. If eraseData = true, then data must be erased in the store
  Future close(bool eraseData);

  //get store status
  bool isOpen() => this._initializationState;
  Future waitOpening(){
  }

  /// List all or search
  Stream<Map<String, String>>       list(String type, {Map fields:null, num limit:null, params:null});
  Stream<Map<String, String>>       search(String type, Map filters, {fields:null, limit:null, params:null});

  /// Classicals Atomic CRUD fonctions
  Future<Map<String, String>>       save(String type, Map<String, String> object, [String id]);
  Future<Map<String, String>>       get(String type, String id);
  Future<Map<String, String>>       update(String type, Map<String, String> object, String id);
  Future<Map<String, String>>       delete(String type, String id);

  /// Extended CRUD Functions, optional
  Stream<String>                    getByKeys(String type, List<String> id){return null;}
  Stream<String>                    getByValue(String type, String field, List<String> value){return null;}
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