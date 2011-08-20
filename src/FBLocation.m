//
//  FBLocation.m
//  facebook-ios-sdk
//
//  Created by Andrew Yanok on 8/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FBLocation.h"

@implementation FBLocation
@synthesize locationId, name;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void) dealloc {	
    [locationId release];
	[name release]; 
	[super dealloc];
}

@end
