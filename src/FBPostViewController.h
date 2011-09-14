//
//  FBPostViewController.h
//  facebook-ios-sdk
//
//  Created by Andrew Yanok on 9/5/11.
//  Copyright (c) 2011 Andy Yanok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBPost.h"
#import "FBUser.h"

@class FBPostView;
@class FBShadowView;
@class FBUIImageView;
@class FBBackgroundView;
@class FBHiddenWebView;

#define kFacebookAccessToken @"FACEBOOK-ACCESS-TOKEN"

@interface FBPostViewController : UIViewController <FBSessionDelegate>
{
@public
    NSString *facebookAppId;
    BOOL shouldCacheCredentials;
    
@private
    FBPost *post;
    FBUser *user;
    FBUser *toUser;
    NSString *accessToken;
    
    FBBackgroundView *backgroundView;
    FBUIImageView *imageView;
    FBPostView *postView;
    FBHiddenWebView *hiddenWebView;
}

@property (nonatomic, retain) NSString *facebookAppId;
@property (nonatomic, assign) BOOL shouldCacheCredentials;

@property (copy) void (^FBPostViewControllerCompletionCallback) (FBPostViewController*, NSError*);

- (id) initWithFacebookAppID:(NSString*) _facebookAppId applicationDelegate:(id<UIApplicationDelegate>) _delegate;
- (void) addImage:(UIImage*) _image;
- (void) addURL:(NSURL*) _url;
- (void) addMessage:(NSString*) _message;
- (void) addDescription:(NSString*) _description;
- (void) addCaption:(NSString*) _caption;
- (void) addPictureURL:(NSURL*) _pictureURL;
- (void) addTitle:(NSString*) _title;

@end
