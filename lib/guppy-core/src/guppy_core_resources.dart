part of guppy.core;

class GuppyResource{
  final Logger log = new Logger('GuppyResource');

  final String name;
  Object type;

  GuppyStore localStore, onlineStore;
  Map<GuppyStore, GuppyStore_RC> mapping = new Map();

  GuppyResource(this.name);

  /** Manage configurations for Store **/
  setConfForStore(GuppyStore store, GuppyStore_RC conf){
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
  bool hasOnlineStore(){ return this.onlineStore == null ? false : true; }

}