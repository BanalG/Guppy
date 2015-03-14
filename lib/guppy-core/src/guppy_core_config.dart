part of guppy.core;

class GuppyConfigStore{
  String name;
  StorageType _type;
  GuppyAbstractStorage _store;
  Map config;

  GuppyConfigStore(this.name, this._type, this._store, {this.config:null});
}

class GuppyConfig {
  Map _config;
  List<GuppyConfigStore>    _stores;
  List<GuppyConfigResource> _resources;

  GuppyConfig(){
    this._config = new Map();

  }

  void set(Map config){
    this._config = config;

    //init Stores

    //init Resources


  }

  Map getLocalStoreConf(){
    return _config['global']['localStore'];
  }

  Map getDistantStoreConf(){
    return _config['global']['distStore'];
  }

  Map getResources(){
    return _config['resources'];
  }
}
