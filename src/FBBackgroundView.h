//
//  FBBackgroundView.h
//  facebook-ios-sdk
//
//  Created by Andrew Yanok on 9/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBBackgroundView : UIView
{
    UIImageView *imageView;
    UIView *overlay;
}

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UIView *overlay;

@end
