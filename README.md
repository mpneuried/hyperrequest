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

## Todos

 * more Tests ;-)

## Release History
|Version|Date|Description|
|:--:|:--:|:--|
|0.0.3|2015-11-30|Bugfix; optimizations; Added tests|
|0.0.2|2015-11-27|Small bugfix|
|0.0.1|2015-11-27|Initial commit|

[![NPM](https://nodei.co/npm-dl/hyperrequest.png?months=6)](https://nodei.co/npm/hyperrequest/)

> Initially Generated with [generator-mpnodemodule](https://github.com/mpneuried/generator-mpnodemodule)

## The MIT License (MIT)

Copyright © 2015 M. Peter, http://www.tcs.de

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
