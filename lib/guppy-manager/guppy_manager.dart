part of guppy.core;

class GuppyManager {
  final Logger log = new Logger('GuppyManager');
  //String apiRoot;
  GuppyConfig config;
  GuppyAbstractLocalStorage localStore;
  GuppyAbstractDistStorage distantStore;

  List<GuppyAbstractStorage> stores;
  Map<String, GuppyResource> resources;

  //List<Task> _pendingTasks = new List();

  bool isInternetActive = false;
  bool isOpen = false;

  bool get isOnline => isInternetActive;
  bool get isOffline => !isInternetActive;

  updateOnlineStatus(){

  }

  /**
   * Initialisation
   */
  GuppyManager(/*this.config, [this.localStore, this.distantStore]*/){
    this.init();

    //Register online/offline detection TODO
    //window.onOnline
    //window.onOffline

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
    this.stores.forEach((v){
      toInit.add(v.init(this.resources.values));
    });

    return Future.wait(toInit).then((v){
      isOpen = true;
    })
    .catchError((e) => log.severe('Error in Guppy Initialization'));
  }

  GuppyAbstractStorage addStore(GuppyAbstractStorage store){
    this.stores.add(store);
    return store;
  }

  Future<bool> removeStore(GuppyAbstractStorage store, {eraseData:false}){
    return store.remove(eraseData).then((_){
      this.stores.remove(store);
    });
  }

  GuppyResource addResource(GuppyResource resource){
    this.resources[resource.name] = resource;
    return resource;
  }

  GuppyResource getResource(String resource){
    return this.resources[resource];
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
  Future<Map<String, String>> getOneById(String resourceType, String id){
    /*
    Si uniquement local store :
      - faire le local
    Si uniquement dist store :
     - faire le distant ASAP et remonter tout de suite si erreur
    Si les deux :
      - Faire le local
      - Ajouter aux taches a traiter
      - Faire le distant en tache de fond et remonter erreur apres plusieurs tentatives espacees dans le temps
     */

    if(getResource(resourceType).hasLocalStore()){
      return waitForInitialization().then((v){
        return this.getResource(resourceType).localStore.get(resourceType, id);
      });
    } else if(getResource(resourceType).hasDistStore()){
      return waitForInitialization().then((v){
        return this.getResource(resourceType).distStore.get(resourceType, id);
      });
    }


    return waitForInitialization().then((v){
      return localStore.get(resourceType, id);
    });
  }

  /**
   *
   */
  Future<List<Map<String, String>>> list(String resourceType, [Map param]){
    return waitForInitialization().then((v){
      return localStore.list(resourceType);
    });
  }

  /**
   *
   */
  Future<Map<String, String>> save(String resourceType, Map<String, String> object, String id){
    log.finest('save $resourceType / $id / $object');
    //_pendingTasks.add(new Task('add', type, id, object));
    return waitForInitialization().then((v) {
      return localStore.save(resourceType, object, id);
    });
  }

  /**
   *
   */
  Future<Map<String, String>> update(String resourceType, Map<String, String> object, String id){
    Map<String, String> newObject = object;
    Map<String, String> oldObject;

    return waitForInitialization().then((v) {
      return localStore.update(resourceType, object, id);
    });
  }

  Future<Map<String, String>> delete(String resourceType, String id){
    //_pendingTasks.add(new Task('delete', type, id));
    return localStore.delete(resourceType, id);
  }


}