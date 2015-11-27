(function() {
  var HyperRequest, StringDecoder, extend, hrquest, http, hyperquest, querystring,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    extend1 = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty,
    indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  extend = require("extend");

  querystring = require("querystring");

  StringDecoder = require('string_decoder').StringDecoder;

  http = require("http");

  hyperquest = require("hyperquest");

  http.globalAgent.maxSockets = 30;

  hrquest = new (HyperRequest = (function(superClass) {
    extend1(HyperRequest, superClass);

    function HyperRequest() {
      this.ERRORS = bind(this.ERRORS, this);
      this._responseHandler = bind(this._responseHandler, this);
      this.prepareOpts = bind(this.prepareOpts, this);
      this.preparePath = bind(this.preparePath, this);
      this.prepareBody = bind(this.prepareBody, this);
      this.request = bind(this.request, this);
      this.defaults = bind(this.defaults, this);
      return HyperRequest.__super__.constructor.apply(this, arguments);
    }

    HyperRequest.prototype.defaults = function() {
      return this.extend(HyperRequest.__super__.defaults.apply(this, arguments), {
        method: "GET",
        payloadMethods: ["POST", "PUT", "PATCH"]
      });
    };

    HyperRequest.prototype.request = function(opt, cb) {
      this.prepareBody(opt, (function(_this) {
        return function(err, _body, _forcedHeaders) {
          var _err, _opts, _path, ref, request;
          if (err) {
            cb(err);
            return;
          }
          try {
            _path = _this.preparePath(opt);
            _opts = _this.prepareOpts(opt, _body, _forcedHeaders);
          } catch (_error) {
            _err = _error;
            cb(_err);
            return;
          }
          _this.log("debug", "run request", [_path, _opts, _body, _body != null ? _body.toString() : void 0]);
          request = hyperquest(_path, _opts);
          _this._responseHandler(cb, request, _path, _opts);
          if (_body != null) {
            request.write(_body);
          }
          if (ref = _opts.method, indexOf.call(_this.config.payloadMethods, ref) >= 0) {
            request.end();
          }
        };
      })(this));
    };

    HyperRequest.prototype.prepareBody = function(opt, cb) {
      var _body, _e, _fHeaders, _sjson;
      _body = null;
      _fHeaders = {};
      if (opt.json != null) {
        if (_.isString(opt.json)) {
          _body = new Buffer(opt.json);
        } else {
          try {
            _sjson = JSON.stringify(opt.json);
          } catch (_error) {
            _e = _error;
            this._handleError(cb, "json-stringify");
            return;
          }
          _body = new Buffer(_sjson);
        }
        _fHeaders["Content-type"] = "application/json";
      } else if (opt.body != null) {
        if (Buffer.isBuffer(opt.body)) {
          _body = opt.body;
        } else if (_.isString(opt.body)) {
          _body = new Buffer(opt.body);
        } else {
          this.log("warning", "used body unlike Buffer or String!", opt.body);
          _body = opt.body;
        }
      }
      if (_body != null ? _body.length : void 0) {
        _fHeaders["Content-length"] = _body.length;
      }
      cb(null, _body, _fHeaders);
    };

    HyperRequest.prototype.preparePath = function(opt) {
      var _qs, _url;
      _url = opt.url || opt.uri || opt.path;
      _qs = "";
      if (opt.qs != null) {
        if (_.isString(opt.qs)) {
          _qs = opt.qs;
        } else {
          _qs = querystring.stringify(opt.qs);
        }
      }
      if (_qs != null ? _qs.length : void 0) {
        if (_url.indexOf("?") < 0) {
          return _url + "?" + _qs;
        } else {
          return _url + "&" + _qs;
        }
      } else {
        return _url;
      }
    };

    HyperRequest.prototype.prepareOpts = function(opt, _body, _forcedHeaders) {
      var _method;
      _method = opt.method || this.config.method;
      if ((_body != null) && indexOf.call(this.config.payloadMethods, _method) < 0) {
        this._handleError(null, "invalid-method");
        return;
      }
      return {
        method: _method,
        headers: this.extend({}, opt.headers || {}, _forcedHeaders)
      };
    };

    HyperRequest.prototype._responseHandler = function(cb, request, _path, _opts) {
      var _body, _err, decoder, res;
      _err = "";
      _body = "";
      res = null;
      decoder = new StringDecoder("utf8");
      request.on("response", (function(_this) {
        return function(response) {
          res = response;
          _this.log("debug", "request response", [_path, _opts, _body, _body != null ? _body.toString() : void 0]);
        };
      })(this));
      request.on("data", (function(_this) {
        return function(chunk) {
          _body += decoder.write(chunk);
        };
      })(this));
      request.on("error", (function(_this) {
        return function(chunk) {
          var ref;
          _this.log("warning", "request error", [chunk.toString()]);
          if ((ref = chunk != null ? chunk.code : void 0) === "ECONNREFUSED" || ref === "EHOSTUNREACH") {
            cb(chunk);
            return;
          }
          _err += chunk;
        };
      })(this));
      request.on("end", (function(_this) {
        return function() {
          var ref;
          _this.log("debug", "request end", [_body, _err]);
          if (_err) {
            cb(_err, res);
            return;
          }
          _this.log("debug", "request result", [_body]);
          if ((_opts != null ? (ref = _opts["Content-type"]) != null ? ref.toLowerCase() : void 0 : void 0) === "application/json") {
            try {
              res.body = JSON.parse(_body);
            } catch (_error) {}
          } else if (_body != null ? _body.length : void 0) {
            res.body = _body;
          }
          cb(null, res);
        };
      })(this));
      request.on("close", (function(_this) {
        return function() {
          _this.log("debug", "request close", [_body, _err]);
        };
      })(this));
    };

    HyperRequest.prototype.ERRORS = function() {
      return this.extend(HyperRequest.__super__.ERRORS.apply(this, arguments), {
        "json-stringify": [500, "Cannot stringify the given `json` data."],
        "invalid-method": [500, "If you pass body data via `body` or `json` you have to use a method of `POST, `PUT` or `PATCH"]
      });
    };

    return HyperRequest;

  })(require("mpbasic")()))();

  module.exports = hrquest.request;

}).call(this);
