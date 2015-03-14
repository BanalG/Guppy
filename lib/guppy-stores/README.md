# Guppy-Store

Part of [Guppy][guppy], a storage engine which make it easy to build web app with offline capabilities.

Stores can work without using Guppy

> Development in progress, don't use it now

[![Build Status](https://travis-ci.org/banalg/guppy.svg)](https://travis-ci.org/banalg/guppy)

## Usage
To use with Guppy, see [Guppy][guppy] help
Else, a simple usage sample :

    Map myStoreConf = new Map({ToDo})
    GuppyAbstractLocalStorage myStore = new GuppyIndexedDB();
    GuppyIndexedDB.init().then((_){
        GuppyIndexedDB.list();
    }

Each store implements those async methods :

* __Initialisation, closing and survey of the store__
    * open _: Initialisation of the Store._
    * isOpen _: Check if the store car be used._
    * close _: Close the store._
    * nuke _: Erase all datas of the store (Use with caution)._
    * getStream _: A Stream wich return all messages._
* __Get many items__
    * list _: List all or a limited number of items._
    * search _: Search one or many items with criterias._
* __Basic CRUD operations__
    * save _: ._
    * get _: ._
    * update _: ._
    * delete _: ._
* __Extended CRUD Operations__ _(Optional. If not implemented by the Store, the abstract method has a workaround with using the Basic CRUD Operations)_
    * saveManyByKeys _: ._
    * getManyByKeys _: ._
    * updateManyByKeys _: ._
    * deleteManyByKeys _: ._

Most methods return a Future, like open and save. Methods that would return many things, like list, return a Stream.

You must call open() before you can use the database.

## Stores availables
### Browser stores
* Indexed DB
* Memory

### Distants Stores
* REST

## Help adding stores ! Feel free to contribute
Anyone can extend Guppy by adding stores. Please pull request !
Many services can be plugged to Guppy. Feel free to add your owns !

### How to create a store
1. Copy the file _template.dart
2. Do what you do the best : Developp !
3. Do the less interesting but certainly more important : Test !
4. Send a pull request

### Below some inspiration of needed stores

#### Browser stores
* LocalStorage
* Chrome Storage
* Chrome FileSystemAPI
* WebSQL
* AutomaticStore (like [LawnDart][lawndart])

#### Distants stores
* FileStorage
    * GoogleDrive
    * Box
* Specifics developments
    * REST API
    * WebSocket API
    *
* SaaS Notes managers
    * Evernotes
    * Trello
    * Evernotes
* Saas Events managers
    * GoogleCalendar
* Others Saas
    * Github
    *
* And many others !

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

## Thanks
Freely inspired by :

- [lawndart]
- [hammock]
- [harvest]




[tracker]: https://github.com/banalg/guppy/issues

[guppy]: https://github.com/banalg/guppy

[lawndart]: https://pub.dartlang.org/packages/lawndart
[hammock]: https://pub.dartlang.org/packages/hammock
[harvest]: https://pub.dartlang.org/packages/harvest