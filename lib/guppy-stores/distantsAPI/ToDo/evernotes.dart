library guppy.stores.evernotes;

//All stores must include this guppy librarys
import 'package:guppy/guppy-stores/guppy-stores.dart';

//Add here specifics librarys for the store
import 'package:logging/logging.dart';

class GuppyEvernotes extends GuppyAbstractDistStorage{
  GuppyConfig config;
  Map storeConfig;

  GuppyEvernotes(name, this.storeConfig) : super(name){

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