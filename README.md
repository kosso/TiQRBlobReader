# TiQRBlobReader

Appcelerator Titanium module to detect a QR code in a TiBlob image.


## Usage:

```
    var qr = require("com.kosso.qrblobreader");
 
    // required
    var blob = an image TiBlob ... eg: event.media from the photo picker...
    // required
    var callback = function(e){
        
        console.log(e);

        if(e.code){
        	console.log('Code detected: ', e.code);
        }

    };
 
    // detect QR code in image blob
    qr.detectCode( blob, callback );

```

See exmaple.

-------------------

@Kosso : March 28, 2016