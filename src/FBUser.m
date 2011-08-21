//
//  FBUser.m
//  facebook-ios-sdk
//
//  Created by Andrew Yanok on 8/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FBUser.h"
#import "FBPost.h"

@interface FBUser (Private)
- (void) finishedWithSuccess;
- (void) finishedWithError:(NSError*) _error;
@end

@implementation FBUser
@synthesize accessToken, accessTokenExpirationDate, userId, name, firstName, middleName;
@synthesize lastName, gender, locale, profileLink, username, bio, birthday, email, political;
@synthesize quotes, relationshipStatus, religion, website, interestedIn, education, languages;
@synthesize favoriteAthletes, favoriteTeams, hometown, location, significantOther;

@synthesize FBUserCallback = _FBUserCallback;

- (id) initWithAppId:(NSString*) _appId accessToken:(NSString*) _accessToken expirationDate:(NSDate*) _expirationDate {
    self = [self init];
    if (self) {
        facebook = [[Facebook alloc] initWithAppId:_appId];
        facebook.accessToken = _accessToken;
        facebook.expirationDate = _expirationDate;
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void) authorizeWithPermissions:(NSArray*) _permissions delegate:(id<FBSessionDelegate>) _delegate {
    [facebook authorize:_permissions delegate:_delegate shouldTrySafariOauth:NO];
}

- (void) getBasicUserInfoWithCallback:(void(^)(FBUser *user, NSError* error)) _callback {
    _FBUserCallback = Block_copy(_callback);
    
    NSMutableDictionary *params = [[[NSMutableDictionary alloc] init] autorelease];
    [params setObject:@"id,name" forKey:@"fields"];
    
    [facebook requestWithGraphPath:@"me" andParams:params andHttpMethod:@"GET" andDelegate:self];
    
    /*[facebook requestWithGraphPath:@"me" params:params method:@"GET" callback:^(FBRequest *request, id result, NSError *error) {
        if (!error) {
            NSLog(@"basic info result %@", result);
            [self loadFromDictionary:result];
        }
        else {
            [self performSelectorOnMainThread:@selector(finishedWithError:) withObject:error waitUntilDone:NO];
        }
    }];*/
}

- (void) setAccessToken:(NSString *) _accessToken {
    facebook.accessToken = _accessToken;
}

- (void) setAccessTokenExpirationDate:(NSDate *) _accessTokenExpirationDate {
    facebook.expirationDate = _accessTokenExpirationDate;
}

- (NSString*) accessToken {
    return facebook.accessToken;
}

- (NSDate*) accessTokenExpirationDate {
    return facebook.expirationDate;
}

- (void) loadFromDictionary:(NSDictionary*) _dict {
    if (_dict && [_dict isKindOfClass:[NSDictionary class]]) {
        
        NSString *obj = [_dict objectForKey:@"id"];
        if (obj && [obj isKindOfClass:[NSString class]]) {
            self.userId = obj;
        }
        
        obj = [_dict objectForKey:@"name"];
        if (obj && [obj isKindOfClass:[NSString class]]) {
            self.name = obj;
        }
        
        [self performSelectorOnMainThread:@selector(finishedWithSuccess) withObject:nil waitUntilDone:YES];
    }
}

- (void) createPost:(FBPost*) _post withCallback:(void (^)(FBPost *post, NSError *error)) _callback {
    if (_post && facebook) {
        _post.facebook = facebook;
        [_post createWithCallback:_callback];
    }
}

#pragma mark -
#pragma mark Private Methods

- (void) finishedWithSuccess {
    _FBUserCallback (self, nil);
}

- (void) finishedWithError:(NSError*) _error {
    _FBUserCallback (self, _error);
}

#pragma mark -
#pragma mark FBRequestDelegate

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    _FBUserCallback (self, error);
    
}

- (void)request:(FBRequest *)request didLoad:(id)result {
    [self loadFromDictionary:result];
}

- (void) dealloc {	
    [_FBUserCallback release], _FBUserCallback = nil;
    [facebook release], facebook = nil;
    [accessToken release];
	[accessTokenExpirationDate release];
	[userId release];
	[name release];
	[firstName release];
	[middleName release];
	[lastName release];
	[gender release];
	[locale release];
	[profileLink release];
	[username release];
	[bio release];
	[birthday release];
	[email release];
	[political release];
	[quotes release];
	[relationshipStatus release];
	[religion release];
	[website release];
	[interestedIn release];
	[education release];
	[languages release];
	[favoriteAthletes release];
	[favoriteTeams release];
	[hometown release];
	[location release];
	[significantOther release]; 
	[super dealloc];
}

@end
