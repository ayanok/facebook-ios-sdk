//
//  FBEmployer.h
//  facebook-ios-sdk
//
//  Created by Andrew Yanok on 8/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBLocation.h"

@interface FBEmployer : NSObject
{
    NSString *name;
    NSString *position;
    
    NSDate *startDate;
    NSDate *endDate;
    
    FBLocation *location;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *position;
@property (nonatomic, retain) NSDate *startDate;
@property (nonatomic, retain) NSDate *endDate;
@property (nonatomic, retain) FBLocation *location;

@end
