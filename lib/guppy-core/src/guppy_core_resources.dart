part of guppy.core;

class GuppyResource{
  final Logger log = new Logger('GuppyResource');

  final String name;

  GuppyResource(this.name);

  /* ORM */
  Object type;


  /* Stores */
  IGuppyStore store1;
  IGuppyStore_RC _store1Conf;
  IGuppyStore_RC get localStoreConf => _store1Conf;
  set localStoreConf(IGuppyStore_RC conf){
    if(conf.isValid()) throw('the configuration is invalid');
    this.localStoreConf = conf;
  }

  IGuppyStore store2;
  IGuppyStore_RC _store2Conf;
  IGuppyStore_RC get onlineStoreConf => _store2Conf;
  set onlineStoreConf(IGuppyStore_RC conf){
    if(conf.isValid()) throw('the configuration is invalid');
    this.onlineStoreConf = conf;
  }

  IGuppyStore_RC getConfOfStore(IGuppyStore store){
    if(store == store1) return this.localStoreConf;
    if(store == store2) return this.onlineStoreConf;
    return null;
  }

  bool hasConfOfStore(store){
    if(store == store1 && this.localStoreConf != null ) return true;
    if(store == store2 && this.onlineStoreConf != null ) return true;
    return false;
  }

  ///Return true if the ressource is binded to a LocalStore
  bool hasLocalStore(){ return this.store1 == null ? false : true; }

  ///Return true if the ressource is binded to a DistantStore
  bool hasOnlineStore(){ return this.store2 == null ? false : true; }

}