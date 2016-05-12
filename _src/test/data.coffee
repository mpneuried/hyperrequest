utils = require( "./utils" )

randomobj = ( depth = 0, opt = {} )->
	tgrt={}
	for i in [0..utils.randRange(1,( if opt.maxObjSize? then  opt.maxObjSize else 13 ))]
		_key = utils.randomString( utils.randRange(2,32),0 )
		if not tgrt[ _key ]?
			tgrt[ _key ] = randomdata( depth, opt )
	return tgrt

randomdata = ( depth = 0, opt = {} )->
	if depth >= ( if opt.maxDepth? then opt.maxDepth else 2 )
		_i = utils.randRange(1,2)
	else
		_i = utils.randRange(1,4)
		
	_depth = depth + 1
	switch _i
		when 1
			return utils.randomString( utils.randRange(1,( if opt.maxStringLength? then opt.maxStringLength else 1024*5 )), ( if opt.maxComplex? then opt.maxComplex else 3 ) )
		when 2
			return utils.randRange(1,1024*64 )
		when 3
			_arr = []
			for i in [0..utils.randRange(0,13)]
				_arr.push randomdata( _depth, opt )
			return _arr
		when 4
			return randomobj( _depth, opt )
			
module.exports =
	test2: utils.randomString( 1024*1024, 3 )
	test3: randomobj(0, { maxDepth:3 } )
	test4: randomobj(0, { maxDepth:1, maxComplex:3, maxObjSize:5 } )
	test5: randomobj(0, { maxDepth:0, maxComplex:1, maxObjSize:13, maxStringLength:1337 } )
	auth1: [ "foo", "secure42" ]
