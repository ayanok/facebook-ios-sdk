//
//  FBVideo.h
//  facebook-ios-sdk
//
//  Created by Andrew Yanok on 9/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FBUser;

@interface FBVideo : NSObject
{
    NSString *videoId;
    FBUser *fromUser;
    NSArray *tags;
    NSString *name;
    NSString *description;
    NSString *pictureUrl;
    NSString *embedHTML;
    NSString *iconUrl;
    NSString *sourceUrl;
    NSDate *createDate;
}

@property (nonatomic, retain) NSString *videoId;
@property (nonatomic, retain) FBUser *fromUser;
@property (nonatomic, retain) NSArray *tags;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *pictureUrl;
@property (nonatomic, retain) NSString *embedHTML;
@property (nonatomic, retain) NSString *iconUrl;
@property (nonatomic, retain) NSString *sourceUrl;
@property (nonatomic, retain) NSDate *createDate;

@end
