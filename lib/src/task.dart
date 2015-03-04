part of guppy;

@Injectable()
class Task{
  final Logger log = new Logger('Task');
  DateTime TS;
  String idOfObject;
  String typeOfObject;
  String typeOfAction;
  Map newValue;
  Map oldValue;
  bool _isSynced = false;

  Task(this.typeOfAction, this.typeOfObject, this.idOfObject, [this.newValue = null, this.oldValue = null, this._isSynced = false]);

  hasBeenSynced(){
    this._isSynced = true;
  }

  //Faire un JSON Diff pour n'enregistrer que les modifications

  Task.fromJson(Map m): this(
      m['id'],
      m['objectType'],
      m['actionType'],
      m['newValue'],
      m['oldValue'],
      m['isSynced']
  );

  Map toJson(Task t){
    return {
        'id'          : t.idOfObject,
        'objectType'  : t.typeOfObject,
        'actionType'  : t.typeOfAction,
        'newValue'    : t.newValue,
        'oldValue'    : t.oldValue,
        'isSynced'    : t._isSynced
    };
  }
}

@Injectable()
class GuppyTasks{
//Initialisation des pendingTasks
//_indexedDB.objectsStores['Task'] = new ObjectStoreConf('Task', 'TasksStore', indexes:[{'name':'PENDING', 'keyPath':'id', 'unique':false}]);
//Si montee de version des Pending Tasks, le faire ici

}