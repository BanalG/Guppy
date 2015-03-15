part of guppy.core;

/**
 * Class for implement Storages types
 */
abstract class GuppyAbstractStorage{
  final Logger log = new Logger('GuppyAbstractStorage');

  final String name;
  bool _isOpen = false;

  Map<GuppyResource, GuppyAbstractStoreResource> resources;

  GuppyAbstractStorage(this.name);

  /// Add a Ressource to the store, with
  addRessource(GuppyResource resource, [GuppyAbstractStoreResource conf]) {
    //Todo : change var to GuppyResourceConf
    //Check if the resource already exist
    if (this.resources.contains(resource)) {
      throw('resource already exist');
    }
    this.resources.add(resource);
    this.resourcesConfig[resource] = conf;
  }

  /// Open store
  Future open(List<GuppyResource> resources);

  /// Get store status
  bool isOpen() => this._isOpen;

  /// Disconnect the store
  Future close([bool eraseData]);

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


abstract class GuppyAbstractStoreResource{
  Function serializer;
  Function deserializer;
}