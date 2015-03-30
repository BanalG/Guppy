part of guppy.stores.indexeddb;


/*** Special config for the store ***/
class GuppyIndexedDB_RC{
  isValid(){
    if(iDBName == null || iDBName =="") throw('iDBName is not set');

    return true;
  }

  /** global conf **/
  String iDBName;
  bool autoIncrementId = false;


  /** resources conf **/
  List indexes;



}