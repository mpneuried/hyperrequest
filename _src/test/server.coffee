should = require('should')
express = require( "express" )
bodyParser = require('body-parser')

jsonParser = bodyParser.json()
urlencodedParser = bodyParser.urlencoded({ extended: false })
morgan = require('morgan')

testData = require( "./data" )

app = express()
app.use(morgan('dev'))

app.get "/test1", ( req, res )->
	res.status(200).send( "OK" )
	return
	
app.get "/test2", ( req, res )->
	res.status(200).send( testData.test2 )
	return
	
app.get "/test3", ( req, res )->
	res.status(200).json( testData.test3 )
	return

app.post "/test4", jsonParser, ( req, res )->
	try
		req.should.have.property( "body" )
		req.body.should.eql( testData.test4 )
	catch _err
		console.error _err
		res.status( 500 ).send( _err )
		return
	res.status(200).send( "OK" )
	return

app.get "/test5", urlencodedParser, ( req, res )->
	_resp = {}
	for _k, _v of req.query
		if _v.match( /^\d+$/ )
			_resp[ _k ] = parseInt( _v, 10 )
		else
			_resp[ _k ] = _v
	res.status(200).json( _resp )
	return

app.put "/test6", jsonParser, ( req, res )->
	try
		req.should.have.property( "body" )
		req.body.should.eql( testData.test4 )
	catch _err
		console.error _err
		res.status( 500 ).send( _err )
		return
	res.status(200).send( "OK" )
	return
	
app.delete "/test7", urlencodedParser, ( req, res )->
	_resp = {}
	for _k, _v of req.query
		if _v.match( /^\d+$/ )
			_resp[ _k ] = parseInt( _v, 10 )
		else
			_resp[ _k ] = _v
	res.status(200).json( _resp )
	return
	
app.post "/test8", urlencodedParser, jsonParser, ( req, res )->
	_resp = {}
	for _k, _v of req.query
		if _v.match( /^\d+$/ )
			_resp[ _k ] = parseInt( _v, 10 )
		else
			_resp[ _k ] = _v
		
	try
		req.should.have.property( "body" )
		req.body.should.eql( testData.test4 )
	catch _err
		console.error _err
		res.status( 500 ).send( _err )
		return
		
	res.status(200).json( _resp )
	return

server = app.listen 8042, ->
	port = server.address().port
	console.log( "Listening on port %s", port )
	return

module.exports = server
