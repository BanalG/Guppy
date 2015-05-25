# Guppy



A CRUD storage engine which make it easy to build web app with offline capabilities.

Each resource can have is own store. For example for an appointments service with three Objects :

* user preferences
* events
* contacts

See how you can store them :

* user preferences are locally saved in localstorage, and remotely on your service store
* events are locally saved in indexedDB, and remotely in a calendar service
* contacts are locally saved in indexedDB, and remotely in a Google contacts service

> Development in progress, don't use it now !

based over four modules :

* __guppy-core__, which contains core methods used by the three others
* __guppy-stores__, which contains many stores and will grow day after day *(please help !)*
* __guppy-manager__, which is the oil between the two firsts components
* __guppy-orm__, for those who want higher level of abstraction *(end 2015 I hope)*

[![Build Status](https://travis-ci.org/banalg/guppy.svg)](https://travis-ci.org/banalg/guppy)
    
    ToDo Use http://shields.io/

## Usage
### A simple usage example
#### A/ choose wich datas to save in each storetype



#### B/ code
##### 1/ Add Stores

    ToDo

##### 2/ Add Resources

    ToDo

##### 3/ Initialize Guppy

    ToDo

##### 4/ Use Guppy

    ToDo

### How to use with AngularDart

    ToDo


## Help extending Guppy
Anyone can extend Guppy by adding stores. Please pull request !

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

## Thanks
Freely inspired by :

- [lawndart]
- [hammock]
- [harvest]




[tracker]: https://github.com/banalg/guppy/issues
[lawndart]: https://pub.dartlang.org/packages/lawndart
[hammock]: https://pub.dartlang.org/packages/hammock
[harvest]: https://pub.dartlang.org/packages/harvest