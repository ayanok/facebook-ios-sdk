//
//  FBPost.h
//  facebook-ios-sdk
//
//  Created by Andrew Yanok on 8/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBUser.h"
#import "FBPhoto.h"
#import "FBVideo.h"

/*
    NOTE: Currently uploading video's is not supported.
 
*/

typedef enum {
    FBPostTypeStatus = 0,
    FBPostTypeLink = 1,
    FBPostTypePhoto = 2,
    FBPostTypeVideo = 3
} FBPostType;

@interface FBPost : NSObject
{
    NSString *objectId;
    NSString *postId;
    FBUser *fromUser;
    NSString *targetFeedUserId;
    NSString *message;
    NSString *pictureUrl;
    NSString *link;
    NSString *linkName;
    NSString *caption;
    NSString *description;
    NSString *sourceUrl;
    NSString *iconUrl;
    
    NSDate *createDate;
    NSDate *updatedDate;
    
    NSArray *toUsers;
    NSArray *properties;
    
    NSInteger cntLikes;
    NSInteger cntComments;
    FBPostType type;
    
    FBPhoto *photo;
    FBVideo *video;
    
    Facebook *facebook;
    
    //TODO: Add Privacy
    //TODO: Add Application
}

@property (nonatomic, retain) NSString *objectId;
@property (nonatomic, retain) NSString *postId;
@property (nonatomic, retain) FBUser *fromUser;
@property (nonatomic, retain) NSString *targetFeedUserId;
@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) NSString *pictureUrl;
@property (nonatomic, retain) NSString *link;
@property (nonatomic, retain) NSString *linkName;
@property (nonatomic, retain) NSString *caption;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *sourceUrl;
@property (nonatomic, retain) NSString *iconUrl;
@property (nonatomic, retain) NSDate *createDate;
@property (nonatomic, retain) NSDate *updatedDate;
@property (nonatomic, retain) NSArray *toUsers;
@property (nonatomic, retain) NSArray *properties;
@property (nonatomic, assign) NSInteger cntLikes;
@property (nonatomic, assign) NSInteger cntComments;
@property (nonatomic, assign) FBPostType type;
@property (nonatomic, retain) FBPhoto *photo;
@property (nonatomic, retain) FBVideo *video;

@property (nonatomic, retain) Facebook *facebook;

@property (copy) void (^FBPostCreateCallback)(FBPost*, NSError*);

- (void) createWithCallback:(void (^)(FBPost *post, NSError *error)) _callback;

@end
