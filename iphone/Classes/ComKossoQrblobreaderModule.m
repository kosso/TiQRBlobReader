/**
 * QRBlobReader
 *
 * Created by Kosso
 * Copyright (c) 2016 . All rights reserved.
 */

#import "ComKossoQrblobreaderModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"


@implementation ComKossoQrblobreaderModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"2a042f96-fbe3-4c33-8cb4-9c37c6336564";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"com.kosso.qrblobreader";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];

	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably

	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs

/*
 
    // JavaScript usage:
    var qr = require("com.kosso.qrblobreader");
 
    // required
    var blob = an image TiBlob ... eg: event.media from the photo picker...
    // required
    var callback = function(e){
        console.log(e);
    };
 
    // detect QR code in image blob
    qr.detectCode( blob, callback );
 
*/

- (void) detectQRCode:(id)args {
    if ([args count] == 2) {

        TiBlob *inputImageBlob = [args objectAtIndex:0];
        KrollCallback *cb = [args objectAtIndex:1];
        ENSURE_TYPE(cb, KrollCallback);
    
        //NSLog(@"[INFO] blob.mimeType %@", inputImageBlob.mimeType);
        //NSLog(@"[INFO] blob.image %@", inputImageBlob.image);
        
        CIImage *cIImage = [[CIImage alloc] initWithImage:inputImageBlob.image];
        CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];

        NSString * message = nil;
        
        if (detector != nil) {
            NSArray<CIFeature*> *features = [detector featuresInImage:cIImage];
            for (id feature in features) {
                message = ((CIQRCodeFeature *)feature).messageString;
            }
            //NSLog(@"[INFO] features : %@", message);
            if(message!=nil){

                NSDictionary *cbArgs = @{
                                         @"code": message
                                         };
                [self _fireEventToListener:@"success" withObject:cbArgs listener:cb thisObject:nil];
            } else {
                NSDictionary *cbArgs = @{
                                         @"message": @"no code"
                                         };
                [self _fireEventToListener:@"error" withObject:cbArgs listener:cb thisObject:nil];
            }
        } else {
            NSLog(@"[INFO] QR detector is nil!");
        }
    }
}



@end
