should = require('should')

Module = require( "../." ) 

_moduleInst = null

# TODO spin up a express server and test the module

describe "----- hyperrequest TESTS -----", ->

	before ( done )->
		_moduleInst = new Module()
		# TODO add initialisation Code
		done()
		return

	after ( done )->
		#  TODO teardown
		done()
		return

	describe 'Main Tests', ->

		# Implement tests cases here
		it "first test", ( done )->
			done()
			return

		return
	return