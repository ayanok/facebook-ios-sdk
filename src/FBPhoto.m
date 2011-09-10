//
//  FBPhoto.m
//  facebook-ios-sdk
//
//  Created by Andrew Yanok on 9/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FBPhoto.h"

@implementation FBPhoto
@synthesize photoId, image;





- (void) dealloc {	
    [photoId release];
    [image release];
	[super dealloc];
}

@end
