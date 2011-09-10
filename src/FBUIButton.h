//
//  FBUIButton.h
//  facebook-ios-sdk
//
//  Created by Andrew Yanok on 9/5/11.
//  Copyright (c) 2011 Andy Yanok. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    FBUIButtonStyleCancel = 0,
    FBUIButtonStylePost = 1
} FBUIButtonStyle;

@interface FBUIButton : UIControl
{
    FBUIButtonStyle style;
}

@property (nonatomic, assign) FBUIButtonStyle style;

+ (id) FBButtonWithStyle:(FBUIButtonStyle) _style;

@end
