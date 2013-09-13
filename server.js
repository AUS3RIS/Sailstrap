var forever = require('forever');

function launch(name){
	console.log('Launching: ' + name);
	forever.start( ['coffee', name + '.coffee'], { /* log options */ } )
};

launch('application');