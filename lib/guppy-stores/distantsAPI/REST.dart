library guppy.stores.rest;

//All stores must include this guppy librarys
import 'package:guppy/guppy-stores/guppy-stores.dart';

//Add here specifics librarys for the store
import 'package:logging/logging.dart';

class GuppyRest extends GuppyAbstractDistStorage{
  GuppyConfig config;
  Map storeConfig;

  GuppyRest(name, this.storeConfig) : super(name){

  }

  init(){

  }

  list(){

  }

  delete(){

  }

  get(){

  }

  update(){

  }

  save(){

  }
}
/*

/****************************************************************************************************\
 * Webservice
 \****************************************************************************************************/
  Future _getOneByWS(){}
  Future _getAllByWS(){}
  Future _addByWS(){}
  Future _updateByWS(){}
  Future _deleteByWS(){}




  */