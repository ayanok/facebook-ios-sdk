//
//  FBLocation.h
//  facebook-ios-sdk
//
//  Created by Andrew Yanok on 8/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBLocation : NSObject
{
    NSString *locationId;
    NSString *name;
}

@property (nonatomic, retain) NSString *locationId;
@property (nonatomic, retain) NSString *name;

@end
