//
//  FBVideo.m
//  facebook-ios-sdk
//
//  Created by Andrew Yanok on 9/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FBVideo.h"
#import "FBUser.h"

@implementation FBVideo
@synthesize videoId, fromUser, tags, name, description, pictureUrl, embedHTML, iconUrl, sourceUrl, createDate;


- (void) dealloc {	
    [videoId release];
	[fromUser release];
	[tags release];
	[name release];
	[description release];
	[pictureUrl release];
	[embedHTML release];
	[iconUrl release];
	[sourceUrl release];
	[createDate release]; 
	[super dealloc];
}

@end
