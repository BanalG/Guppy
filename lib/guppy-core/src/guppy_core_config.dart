part of guppy.core;

class GuppyConfig {
  Map _config;
  Map <String, IGuppyStore>    _stores;
  Map <String, Map> _resources;


  GuppyConfig(){
    this._config = new Map();

  }

  void set(Map config){
    this._config = config;
  }

  ///Return resources that use the store
  Map<String, IGuppyStore> getResourcesWhoUseStore(String store){
    var stores = new Map();
    _resources.forEach((k, v){
      if(v == store) stores[k] = store;
    });
    return stores;
  }

  getStoreConfig(String store){
    Map storeConfig = new Map();


    return storeConfig;
  }
  getResourceConfig(){}



}
