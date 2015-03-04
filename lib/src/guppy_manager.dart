part of Guppy;

@Injectable()
class GuppyManager {
  final Logger log = new Logger('GuppyManager');
  //String apiRoot;
  final GuppyConfig config;
  final GuppyAbstractLocalStorage localStore;
  final GuppyAbstractDistStorage distantStore;

  //List<Task> _pendingTasks = new List();

  bool isInternetActive = false;
  bool isOpen = false;




  /**
   * Initialisation
   */
  GuppyManager(this.config, [this.localStore, this.distantStore]){
    this.init();
  }

  Future<String> waitForInitialization([Duration timeout, int order]) {
    var completer = new Completer();

    if(this.isOpen){
      //Si c'est configure on passe a la suite
      completer.complete();
    } else {
      //Si ce n'est pas configure on lance un timer
      if(timeout == null){
        timeout = new Duration(milliseconds: 10 );
        order = 1;
      } else {
        timeout = timeout * 2;
        order++;
      }
      var timer = new Timer(timeout, (){
        return waitForInitialization(timeout, order).then( (_) => completer.complete()); });
    }

    return completer.future;
  }


  /**
   *
   */
  Future init(){
    log.finest('init');
    //Instantiation des systemes de stockage
    List<Future> toInit = new List();
    if(this.localStore != null){toInit.add(this.localStore.init());}
    if(this.distantStore != null){toInit.add(this.distantStore.init());}

    return Future.wait(toInit).then((v){
      isOpen = true;
    })
    .catchError((e) => log.severe('Error in Guppy Initialization'));
  }

  /**
   *
   */
  sync([bool simulation]){
    log.finest('Sync is not yet implemented');

    /*
    Plusieurs solutions :
      - Recuperer les Pending cote client et serveur, effectuer comparaison et actualiser des deux cotes ==> Moins de charge serveur
      - Envoyer tous les pending cote Serveur qui se charge de comparer et remonte les conflits ==> Meilleur en cas de collaboratif

     */
  }

  /**
   *
   */
  Future<Map<String, String>> getOneById(String type, String id){
    return waitForInitialization().then((v){
      return localStore.get(type, id);
    });
  }

  /**
   *
   */
  Future<List<Map<String, String>>> list(String type, [Map param]){
    return waitForInitialization().then((v){
      return localStore.list(type);
    });
  }

  /**
   *
   */
  Future<Map<String, String>> save(String type, Map<String, String> object, String id){
    log.finest('save $type / $id / $object');
    //_pendingTasks.add(new Task('add', type, id, object));
    return waitForInitialization().then((v) {
      return localStore.save(type, object, id);
    });
  }

  /**
   *
   */
  Future<Map<String, String>> update(String type, Map<String, String> object, String id){
    Map<String, String> newObject = object;
    Map<String, String> oldObject;

    return waitForInitialization().then((v) {
      return localStore.update(type, object, id);
    });
  }

  Future<Map<String, String>> delete(String type, String id){
    //_pendingTasks.add(new Task('delete', type, id));
    return localStore.delete(type, id);
  }


}