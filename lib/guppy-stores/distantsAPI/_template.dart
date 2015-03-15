library guppy.stores.distant_template;

//All stores must include this guppy librarys
import 'package:guppy/guppy-stores/guppy-stores.dart';

//Add here specifics librarys for the store
import 'package:logging/logging.dart';

class GuppyDistantTemplate extends GuppyAbstractStorage{
  GuppyConfig config;
  Map storeConfig;

  GuppyDistantTemplate(name, this.storeConfig) : super(name){

  }

  open(){

  }

  list(String type){

  }

  delete(String type, String id){

  }

  get(String type){

  }

  update(){

  }

  save(){

  }
}