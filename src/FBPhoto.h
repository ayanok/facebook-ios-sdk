//
//  FBPhoto.h
//  facebook-ios-sdk
//
//  Created by Andrew Yanok on 9/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FBPhoto : NSObject
{
    NSString *photoId;
    UIImage *image;
}

@property (nonatomic, retain) NSString *photoId;
@property (nonatomic, retain) UIImage *image;

@end
