//
//  FBUser.h
//  facebook-ios-sdk
//
//  Created by Andrew Yanok on 8/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Facebook.h"
#import "FBLocation.h"
#import "FBEmployer.h"

@interface FBUser : NSObject
{
@public
    NSString *accessToken;
    NSDate *accessTokenExpirationDate;
    
    NSString *userId;
    NSString *name;
    NSString *firstName;
    NSString *middleName;
    NSString *lastName;
    NSString *gender;
    NSString *locale;
    NSString *profileLink;
    NSString *username;
    NSString *bio;
    NSString *birthday;
    NSString *email;
    NSString *political;
    NSString *quotes;
    NSString *relationshipStatus;
    NSString *religion;
    NSString *website;
    
    NSArray *interestedIn;
    NSArray *education;
    NSArray *languages;
    NSArray *favoriteAthletes;
    NSArray *favoriteTeams;
    
    FBLocation *hometown;
    FBLocation *location;
    
    FBUser *significantOther;
    
    //TODO: Add Connections
@private
    Facebook *facebook;
    
}

@property (copy) void (^FBUserCallback)(FBUser*, NSError*);

@property (nonatomic, retain) NSString *accessToken;
@property (nonatomic, retain) NSDate *accessTokenExpirationDate;
@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *middleName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *gender;
@property (nonatomic, retain) NSString *locale;
@property (nonatomic, retain) NSString *profileLink;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *bio;
@property (nonatomic, retain) NSString *birthday;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *political;
@property (nonatomic, retain) NSString *quotes;
@property (nonatomic, retain) NSString *relationshipStatus;
@property (nonatomic, retain) NSString *religion;
@property (nonatomic, retain) NSString *website;
@property (nonatomic, retain) NSArray *interestedIn;
@property (nonatomic, retain) NSArray *education;
@property (nonatomic, retain) NSArray *languages;
@property (nonatomic, retain) NSArray *favoriteAthletes;
@property (nonatomic, retain) NSArray *favoriteTeams;
@property (nonatomic, retain) FBLocation *hometown;
@property (nonatomic, retain) FBLocation *location;
@property (nonatomic, retain) FBUser *significantOther;

- (id) initWithAppId:(NSString*) _appId accessToken:(NSString*) _accessToken expirationDate:(NSDate*) _expirationDate;
- (void) authorizeWithPermissions:(NSArray*) _permissions delegate:(id<FBSessionDelegate>) _delegate;
- (void) getBasicUserInfoWithCallback:(void(^)(FBUser *user, NSError* error)) _callback;
- (void) loadFromDictionary:(NSDictionary*) _dict;


@end
