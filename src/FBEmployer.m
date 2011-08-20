//
//  FBEmployer.m
//  facebook-ios-sdk
//
//  Created by Andrew Yanok on 8/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FBEmployer.h"

@implementation FBEmployer
@synthesize name, position, startDate, endDate, location;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void) dealloc {	
    [name release];
	[position release];
	[startDate release];
	[endDate release];
	[location release]; 
	[super dealloc];
}

@end
