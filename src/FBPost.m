//
//  FBPost.m
//  facebook-ios-sdk
//
//  Created by Andrew Yanok on 8/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FBPost.h"

@interface FBPost (Private)
- (void) createStatusPost;
- (void) createLinkPost;
- (void) createPhotoPost;
- (void) createVideoPost;
@end

@implementation FBPost
@synthesize objectId, postId, fromUser, message, pictureUrl, link, linkName;
@synthesize caption, description, sourceUrl, iconUrl, createDate, updatedDate;
@synthesize toUsers, properties, cntLikes, cntComments, type, facebook, targetFeedUserId;
@synthesize photo, video;

@synthesize FBPostCreateCallback = _FBPostCreateCallback;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void) createWithCallback:(void (^)(FBPost *post, NSError *error)) _callback {
    _FBPostCreateCallback = Block_copy(_callback);
    
    if (targetFeedUserId == nil)
        targetFeedUserId = @"me";
    
    if (facebook) {
        switch (self.type) {
            case FBPostTypeStatus:
                [self createStatusPost];
                break;
            case FBPostTypeLink:
                [self createLinkPost];
                break;
            case FBPostTypePhoto:
                [self createPhotoPost];
                break;
            case FBPostTypeVideo:
                break;
            default:
                break;
        }
    }
}

#pragma mark -
#pragma mark Private Methods

- (void) createStatusPost {
    if (targetFeedUserId && message) {
        NSMutableDictionary *params = [[[NSMutableDictionary alloc] init] autorelease];
        [params setObject:self.message forKey:@"message"];
        
        NSString *method = [NSString stringWithFormat:@"%@/feed", targetFeedUserId];
        [facebook requestWithGraphPath:method params:params method:@"POST" callback:^(FBRequest *request, id result, NSError *error) {
            _FBPostCreateCallback (self, error);
        }];
    }
}

- (void) createLinkPost {
    if (targetFeedUserId && link) {
        NSMutableDictionary *params = [[[NSMutableDictionary alloc] init] autorelease];
        
        [params setObject:self.link forKey:@"link"];
        
        if (message)
            [params setObject:self.message forKey:@"message"];
        
        if (caption)
            [params setObject:self.caption forKey:@"caption"];
        
        if (description)
            [params setObject:self.description forKey:@"description"];
        
        if (linkName)
            [params setObject:self.linkName forKey:@"name"];
        
        
        NSString *method = [NSString stringWithFormat:@"%@/feed", targetFeedUserId];
        [facebook requestWithGraphPath:method params:params method:@"POST" callback:^(FBRequest *request, id result, NSError *error) {
            _FBPostCreateCallback (self, error);
        }];
    }
}

- (void) createPhotoPost {
    if (targetFeedUserId && photo) {
        NSMutableDictionary *params = [[[NSMutableDictionary alloc] init] autorelease];
        
        [params setObject:self.photo.image forKey:@"source"];
        
        if (message)
            [params setObject:self.message forKey:@"message"];
        
        NSString *method = [NSString stringWithFormat:@"%@/photos", targetFeedUserId];
        [facebook requestWithGraphPath:method params:params method:@"POST" callback:^(FBRequest *request, id result, NSError *error) {
            _FBPostCreateCallback (self, error);
        }];
    }
}

- (void) createVideoPost {
    if (targetFeedUserId && video) {
        NSMutableDictionary *params = [[[NSMutableDictionary alloc] init] autorelease];
        
        [params setObject:self.photo.image forKey:@"source"];
        
        if (linkName)
            [params setObject:self.linkName forKey:@"title"];
        
        if (caption)
            [params setObject:self.caption forKey:@"description"];
        
        NSString *method = [NSString stringWithFormat:@"%@/videos", targetFeedUserId];
        [facebook requestWithGraphPath:method params:params method:@"POST" callback:^(FBRequest *request, id result, NSError *error) {
            _FBPostCreateCallback (self, error);
        }];
    }
}


- (void) dealloc {	
    [video release], video = nil;
    [targetFeedUserId release], targetFeedUserId = nil;
    [facebook release], facebook = nil;
    [_FBPostCreateCallback release], _FBPostCreateCallback = nil;
    [photo release];
    [objectId release];
	[postId release];
	[fromUser release];
	[message release];
	[pictureUrl release];
	[link release];
	[linkName release];
	[caption release];
	[description release];
	[sourceUrl release];
	[iconUrl release];
	[createDate release];
	[updatedDate release];
	[toUsers release];
	[properties release]; 
	[super dealloc];
}

@end
