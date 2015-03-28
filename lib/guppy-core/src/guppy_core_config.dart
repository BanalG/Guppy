part of guppy.core;

class GuppyConfigStore{
  String name;
  StorageType _type;
  IGuppyStore _store;
  Map config;

  GuppyConfigStore(this.name, this._type, this._store, {this.config:null});
}

class GuppyConfigResource{
  String name;
  String store1;
  String store2;

  IGuppyStore store1Config;
  IGuppyStore store2Config;

  GuppyConfigResource(this.name, this.store1, this.store2);
}

class GuppyConfig {
  Map _config;
  Map <String, GuppyConfigStore>    _stores;
  Map <String, GuppyConfigResource> _resources;

  IGuppyStore getResource(String r) => _resources[r];
  List<IGuppyStore> getresources() => _stores.keys;

  ///Return resources that use the store
  Map<String, IGuppyStore> getResourcesWhoUseStore(String store){
     var stores = new Map();
    _resources.forEach((k, v){
      if(v == store) stores[k] = store;
    });
    return stores;
  }

  GuppyConfig(){
    this._config = new Map();

  }

  void set(Map config){
    this._config = config;

    //init Stores

    //init Resources

  }





}
