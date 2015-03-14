part of guppy.core;

class GuppyResource{
  final Logger log = new Logger('GuppyResource');
  String name;
  bool isAutoIncrementKey;
  List<Map> indexes;

  GuppyAbstractLocalStorage localStore;
  GuppyAbstractDistStorage distStore;

  GuppyResource(
      this.name,
      {
      this.localStore: null,
      this.distStore: null,
      this.isAutoIncrementKey: false,
      this.indexes: null
      });

  bool hasLocalStore(){ return this.localStore == null ? false : true; }
  bool hasDistStore(){ return this.distStore == null ? false : true; }

}