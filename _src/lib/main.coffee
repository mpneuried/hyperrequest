# # HyperRequest

# ### extends [NPM:MPBasic](https://cdn.rawgit.com/mpneuried/mpbaisc/master/_docs/index.coffee.html)

#
# ### Exports: *Function*
#
# A wrapper arround hyperquest to handle http requests
# This is a drop in replacement to replace the request module with te hyperquest module to solve the limit of five concurrent connections.
# 

# node modules
querystring = require( "querystring" )
StringDecoder = require('string_decoder').StringDecoder
http = require( "http" )

# npm modules
hyperquest = require( "hyperquest" )

# additional upgrade the max sockets. 
http.globalAgent.maxSockets = 30

isString = ( vr )->
	return typeof vr is 'string' or vr instanceof String

hrquest = new ( class HyperRequest extends require( "mpbasic" )()
	defaults: =>
		@extend super,
			method: "GET"
			payloadMethods: [ "POST", "PUT", "PATCH" ]

	request: ( opt, cb )=>
		
		@prepareBody opt, ( err, _body, _forcedHeaders )=>
			if err
				cb( err )
				return
			try
				_path = @preparePath( opt )
				_opts = @prepareOpts( opt, _body, _forcedHeaders )
			catch _err
				cb( _err )
				return

			@debug "run request", _path, _opts, _body, _body?.toString()
			request = hyperquest( _path, _opts )

			@_responseHandler( cb, request, _path, _opts )

			if _body?
				request.write( _body )
			
			if _opts.method in @config.payloadMethods
				request.end()

			return
		return

	prepareBody: ( opt, cb )=>
		_body = null
		_fHeaders = {}

		if opt.json?
		# prepare raw body
			if isString( opt.json )
				_body = new Buffer( opt.json )
			else

				try
					_sjson = JSON.stringify( opt.json )
				catch _e
					@_handleError( cb, "json-stringify" )
					return

				_body = new Buffer( _sjson )

			_fHeaders[ "Content-type" ] = "application/json"

		else if opt.body?
		# prepare raw body
			if Buffer.isBuffer( opt.body )
				_body = opt.body
			else if isString( opt.body )
				_body = new Buffer( opt.body )
			else
				@warning "used body unlike Buffer or String!", opt.body
				_body = opt.body

		if _body?.length
			_fHeaders[ "Content-length" ] = _body.length

		cb( null, _body, _fHeaders )
		return

	preparePath: ( opt )=>
		_url = opt.url or opt.uri or opt.path
		_qs = ""
		if opt.qs?
			if isString( opt.qs )
				_qs = opt.qs
			else
				_qs = querystring.stringify( opt.qs )

		if _qs?.length
			if _url.indexOf( "?" ) < 0
				return _url + "?" + _qs
			else
				return _url + "&" + _qs
		else
			return _url

	prepareOpts: ( opt, _body, _forcedHeaders )=>
		_method = opt.method?.toUpperCase() or @config.method
		if _body? and _method not in @config.payloadMethods
			@_handleError( null, "invalid-method" )
			return

		# ig the auth option is set convert it to a BAsic athentication header
		if opt?.auth?
			_user = opt.auth.user or opt.auth.username
			_pw = opt.auth.pass or opt.auth.password or ""
			if _user?
				_enc = new Buffer( ( _user + ":" + _pw ), "utf8" ).toString( "base64" )
				_forcedHeaders[ "Authorization" ] = "Basic " + _enc

		method: _method
		headers: @extend( {}, opt.headers or {}, _forcedHeaders )

	_responseHandler: ( cb, request, _path, _opts )=>
		_err = ""
		_body = ""
		res = null
		decoder = new StringDecoder( "utf8" )

		request.on "response", ( response )=>
			res = response
			@debug "request response", _path, _opts, _body, _body?.toString()
			return

		request.on "data", ( chunk )->
			_body += decoder.write( chunk )
			return

		request.on "error", ( chunk )=>
			@warning "request error", chunk.toString()
			if chunk?.code in [ "ECONNREFUSED", "EHOSTUNREACH" ]
				cb( chunk )
				return
			_err += chunk
			return

		request.on "end", =>
			@debug "request end", _body, _err
			if _err
				cb( _err, res )
				return

			@debug "request result", _body
			if _opts?[ "Content-type" ]?.toLowerCase() is "application/json" or res.headers["content-type"].indexOf( "application/json" ) >= 0
				try
					res.body = JSON.parse( _body )
			else if _body?.length
				res.body = _body

			cb( null, res )
			return

		request.on "close", =>
			@debug "request close", _body, _err
			return
		
		return

	ERRORS: =>
		@extend super,
			"json-stringify": [ 500, "Cannot stringify the given `json` data." ]
			"invalid-method": [ 500, "If you pass body data via `body` or `json` you have to use a method of `POST, `PUT` or `PATCH`" ]
)()

module.exports = hrquest.request
