// This is a test harness for your module
// You should do something interesting in this harness
// to test out the module and to provide instructions
// to users on how to use it by example.


// open a single window
var win = Ti.UI.createWindow({
	backgroundColor:'white'
});
var label = Ti.UI.createLabel();
win.add(label);
win.open();

// TODO: write your module tests here
var qrblobreader = require('com.kosso.qrblobreader');
Ti.API.info("module is => " + qrblobreader);

var qrCallback = function(event){

	console.log('code callback: ', event);

	if(event.type == 'success'){
		// 
		console.log('CODE: ', event.code);
	} else {
	// No code
	}

};

// open photo picker
Titanium.Media.openPhotoGallery({
	success:function(event){

		console.log(event.media.mimeType);  

		try{

			qrblobreader.detectQRCode(event.media, qrCallback);

		}
		catch(e){       
			console.log('error: ',e);
		};
	},
	cancel:function(){
	},
	error:function(error){
	},
	allowEditing:true,
	mediaTypes: [Titanium.Media.MEDIA_TYPE_PHOTO]
});


