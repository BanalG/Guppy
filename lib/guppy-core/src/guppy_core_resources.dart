part of guppy.core;

class GuppyResource{
  final Logger log = new Logger('GuppyResource');
  final String name;

  GuppyAbstractStorage localStore, distStore;
  Map<GuppyAbstractStorage, GuppyAbstractStoreResource> mapping = new Map();

  GuppyResource(this.name);

  ///Return true if the ressource is binded to a LocalStore
  bool hasLocalStore(){ return this.localStore == null ? false : true; }

  ///Return true if the ressource is binded to a DistantStore
  bool hasDistStore(){ return this.distStore == null ? false : true; }

}