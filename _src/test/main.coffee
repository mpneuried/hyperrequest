should = require('should')

hrr = require( "../." )

testData = require( "./data" )

_moduleInst = null
testServer = require( "./server" )

PORT = testServer.address().port

# TODO spin up a express server and test the module

describe "----- hyperrequest TESTS -----", ->

	before ( done )->
		# _moduleInst = new Module()
		# 
		# testServer = exec 'node test/server.js'
		# 
		# testServer.stderr.on "data", ( data )->
		# 	console.log "TEST-SERVER-ERROR", data
		# 	return
		# 	
		# testServer.on "exit", ( data )->
		# 	console.log "\t###\n\nTEST SERVER EXIT.\n\tEventually already running\n\t###\n\n", data
		# 	done()
		# 	return
		# 	
		setTimeout( done, 500 )
		return

	after ( done )->
		done()
		return

	describe 'Main Tests', ->

		# Implement tests cases here
		it "get", ( done )->
			opts =
				uri: "http://localhost:#{PORT}/test1"
			
			hrr opts, ( err, resp )->
				throw err if err
				resp.should.have.property( "body" )
				resp.body.should.equal( "OK" )
				done()
				return
			return
		
		# Implement tests cases here
		it "get with large response", ( done )->
			opts =
				uri: "http://localhost:#{PORT}/test2"
			
			hrr opts, ( err, resp )->
				throw err if err
				resp.should.have.property( "body" )
				resp.body.should.equal( testData.test2 )
				done()
				return
			return
		
		it "get with large json response", ( done )->
			opts =
				uri: "http://localhost:#{PORT}/test3"
				headers:
					"Content-type": "application/json"
			
			hrr opts, ( err, resp )->
				throw err if err
				resp.should.have.property( "body" )
				resp.body.should.eql( testData.test3 )
				done()
				return
			return
		
		it "post large json data", ( done )->
			opts =
				uri: "http://localhost:#{PORT}/test4"
				method: "POST"
				headers:
					"Content-type": "application/json"
				json: testData.test4
			
			hrr opts, ( err, resp )->
				throw err if err
				resp.should.have.property( "body" )
				resp.body.should.equal( "OK" )
				done()
				return
			return
		
		it "get with large url-query", ( done )->
			opts =
				uri: "http://localhost:#{PORT}/test5/"
				qs:
					testData.test5
			
			hrr opts, ( err, resp )->
				throw err if err
				resp.should.have.property( "body" )
				resp.body.should.eql( testData.test5 )
				done()
				return
			return
		
		it "put large json data", ( done )->
			opts =
				uri: "http://localhost:#{PORT}/test6"
				method: "Put"
				headers:
					"Content-type": "application/json"
				json: testData.test4
			
			hrr opts, ( err, resp )->
				throw err if err
				resp.should.have.property( "body" )
				resp.body.should.equal( "OK" )
				done()
				return
			return
		
		it "delete with large url-query", ( done )->
			opts =
				uri: "http://localhost:#{PORT}/test7"
				method: "delete"
				qs:
					testData.test5
			
			hrr opts, ( err, resp )->
				throw err if err
				resp.should.have.property( "body" )
				resp.body.should.eql( testData.test5 )
				done()
				return
			return
		
		it "post with large url-query and body", ( done )->
			opts =
				uri: "http://localhost:#{PORT}/test8"
				method: "Post"
				json: testData.test4
				qs:
					testData.test5
			
			hrr opts, ( err, resp )->
				throw err if err
				resp.should.have.property( "body" )
				resp.body.should.eql( testData.test5 )
				done()
				return
			return

		it "post with auth and body", ( done )->
			opts =
				uri: "http://localhost:#{PORT}/test9"
				method: "Post"
				json: testData.test4
				auth:
					user: testData.auth1[0]
					pass: testData.auth1[1]
				qs:
					testData.test5
			
			hrr opts, ( err, resp )->
				throw err if err
				resp.should.have.property( "body" )
				resp.body.should.eql( testData.test5 )
				done()
				return
			return

		it "post with auth and body but different auth syntax", ( done )->
			opts =
				uri: "http://localhost:#{PORT}/test9"
				method: "Post"
				json: testData.test4
				auth:
					username: testData.auth1[0]
					password: testData.auth1[1]
				qs:
					testData.test5
			
			hrr opts, ( err, resp )->
				throw err if err
				resp.should.have.property( "body" )
				resp.body.should.eql( testData.test5 )
				done()
				return
			return

		return
	return



	
