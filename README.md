hyperrequest
============

[![Build Status](https://secure.travis-ci.org/mpneuried/hyperrequest.png?branch=master)](http://travis-ci.org/mpneuried/hyperrequest)
[![Build Status](https://david-dm.org/mpneuried/hyperrequest.png)](https://david-dm.org/mpneuried/hyperrequest)
[![NPM version](https://badge.fury.io/js/hyperrequest.png)](http://badge.fury.io/js/hyperrequest)

A wrapper arround hyperquest to handle the results

[![NPM](https://nodei.co/npm/hyperrequest.png?downloads=true&stars=true)](https://nodei.co/npm/hyperrequest/)

## Install

```
  npm install hyperrequest
```

## Usage

**Basic example**
```js
var hrrequest = require( "hyperrequest" );

hrrequest( { url: "http://www.exapme.com" }, function( err, resp ){
    /*handle response*/
});
```

**Detailed example**

```js
var hrrequest = require( "hyperrequest" );

var opts = {
    url: "http://www.myapi.com/path/api/v1", // The path to request including `http://`. Alternative keys : `uri` or `path`
    method: "POST", // http method
    headers: { // http headers object
        "Content-type": "application/json"
    },
    json: { "foo": 23, "bar": [ 42, "buzz" ] }, // Only relevant for method `POST, `PUT` or `PATCH`. This will be stringified before transmission.
    body: "ABC" // // Only relevant if `json` is not defined and for method `POST, `PUT` or `PATCH`.
};

hrrequest( opts, function( err, resp ){
    if( err ){
        // handle the error
        return
    }
    // the result is a regular node-js response object.
    console.log( resp.body ) // The result will be placed inside `body`. If the content-type is `application/json` it tries to parse it and returns the parsed data
    
});
```

**Options** 

- **url** : *( `String` required )* The path to request including `http://`. Alternative keys : `uri` or `path`
- **method** : *( `String` optional: default = `GET`; )* The http method
- **headers** : *( `Object` optional )* The http headers object
- **json** : *( `Any` optional )* JSON data to send. This will be stringified and used as body before transmission. Only relevant for method `POST, `PUT` or `PATCH`. 
- **body** : *( `String|Buffer` optional )* Body data to send. Only relevant if `json` is not defined and for method `POST, `PUT` or `PATCH`.
- **auth** : *( `Object` optional )* Add an basic header authentication.
    - **auth.(user|username)** : *( `String` )* The username for the authentication.
    - **auth.(pass|password)** : *( `String` )* The password for the authentication.

## Todos

 * more Tests ;-)

## Release History
|Version|Date|Description|
|:--:|:--:|:--|
|0.1.1|2016-05-25|fixed handling of empty content 204|
|0.1.0|2016-05-12|Added option to use basic auth. Updated dependencies and dev environment with docker tests for a list of node versions, removed Code docs from repository|
|0.0.4|2015-12-01|removed deprecated dependency; added code docs|
|0.0.3|2015-11-30|Bugfixes; Optimizations; Added tests; Added docs|
|0.0.2|2015-11-27|Small bugfix|
|0.0.1|2015-11-27|Initial commit|

[![NPM](https://nodei.co/npm-dl/hyperrequest.png?months=6)](https://nodei.co/npm/hyperrequest/)

> Initially Generated with [generator-mpnodemodule](https://github.com/mpneuried/generator-mpnodemodule)

## Other projects

|Name|Description|
|:--|:--|
|[**node-cache**](https://github.com/tcs-de/nodecache)|Simple and fast NodeJS internal caching. Node internal in memory cache like memcached.|
|[**rsmq**](https://github.com/smrchy/rsmq)|A really simple message queue based on redis|
|[**redis-heartbeat**](https://github.com/mpneuried/redis-heartbeat)|Pulse a heartbeat to redis. This can be used to detach or attach servers to nginx or similar problems.|
|[**systemhealth**](https://github.com/mpneuried/systemhealth)|Node module to run simple custom checks for your machine or it's connections. It will use [redis-heartbeat](https://github.com/mpneuried/redis-heartbeat) to send the current state to redis.|
|[**rsmq-cli**](https://github.com/mpneuried/rsmq-cli)|a terminal client for rsmq|
|[**rest-rsmq**](https://github.com/smrchy/rest-rsmq)|REST interface for.|
|[**nsq-logger**](https://github.com/mpneuried/nsq-logger)|Nsq service to read messages from all topics listed within a list of nsqlookupd services.|
|[**nsq-topics**](https://github.com/mpneuried/nsq-topics)|Nsq helper to poll a nsqlookupd service for all it's topics and mirror it locally.|
|[**nsq-nodes**](https://github.com/mpneuried/nsq-nodes)|Nsq helper to poll a nsqlookupd service for all it's nodes and mirror it locally.|
|[**nsq-watch**](https://github.com/mpneuried/nsq-watch)|Watch one or many topics for unprocessed messages.|
|[**redis-sessions**](https://github.com/smrchy/redis-sessions)|An advanced session store for NodeJS and Redis|
|[**connect-redis-sessions**](https://github.com/mpneuried/connect-redis-sessions)|A connect or express middleware to simply use the [redis sessions](https://github.com/smrchy/redis-sessions). With [redis sessions](https://github.com/smrchy/redis-sessions) you can handle multiple sessions per user_id.|
|[**redis-notifications**](https://github.com/mpneuried/redis-notifications)|A redis based notification engine. It implements the rsmq-worker to safely create notifications and recurring reports.|
|[**hyperrequest**](https://github.com/mpneuried/hyperrequest)|A wrapper around [hyperquest](https://github.com/substack/hyperquest) to handle the results|
|[**task-queue-worker**](https://github.com/smrchy/task-queue-worker)|A powerful tool for background processing of tasks that are run by making standard http requests
|[**soyer**](https://github.com/mpneuried/soyer)|Soyer is small lib for server side use of Google Closure Templates with node.js.|
|[**grunt-soy-compile**](https://github.com/mpneuried/grunt-soy-compile)|Compile Goggle Closure Templates ( SOY ) templates including the handling of XLIFF language files.|
|[**backlunr**](https://github.com/mpneuried/backlunr)|A solution to bring Backbone Collections together with the browser fulltext search engine Lunr.js|
|[**domel**](https://github.com/mpneuried/domel)|A simple dom helper if you want to get rid of jQuery|
|[**obj-schema**](https://github.com/mpneuried/obj-schema)|Simple module to validate an object by a predefined schema|


## The MIT License (MIT)

Copyright © 2015 M. Peter, http://www.tcs.de

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
