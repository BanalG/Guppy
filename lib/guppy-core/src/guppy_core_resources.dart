part of guppy.core;

class GuppyResource{
  final Logger log = new Logger('GuppyResource');

  final String name;
  Object type;

  GuppyAbstractStorage localStore, distStore;
  Map<GuppyAbstractStorage, GuppyAbstractStoreResource> mapping = new Map();

  GuppyResource(this.name);

  setConfForStore(GuppyAbstractStorage store, GuppyAbstractStoreResource conf){
    if(conf.isValid()) throw('the configuration is invalid');
    mapping[store] = conf;
  }
  getConfOfStore(store) => mapping[store];
  hasConfOfStore(store) => mapping[store] == null ? false : true;

  //forceAsLocal() => this.type = StorageType.LOCAL;
  //forceAsDistant() => this.type = StorageType.DISTANT;

  ///Return true if the ressource is binded to a LocalStore
  bool hasLocalStore(){ return this.localStore == null ? false : true; }

  ///Return true if the ressource is binded to a DistantStore
  bool hasDistStore(){ return this.distStore == null ? false : true; }

}