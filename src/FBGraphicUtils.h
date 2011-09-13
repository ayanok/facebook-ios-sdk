//
//  FBGraphicUtils.h
//  facebook-ios-sdk
//
//  Created by Andrew Yanok on 9/5/11.
//  Copyright (c) 2011 Andy Yanok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface FBGraphicUtils : NSObject
{
    
}

+ (UIImage*) applicationImage:(id<UIApplicationDelegate>) _delegate frame:(CGRect) _frame;
+ (UIImageView*) applicationImageView:(id<UIApplicationDelegate>) _delegate frame:(CGRect) _frame;

@end

void GetRGBA(CGColorRef color, float * r, float * g, float * b, float * a);
void drawPlainVerticalGradient(CGContextRef ctx, CGRect rect, UIColor * startColor, UIColor * endColor);
void AddRoundedRectToPath (CGRect rect, CGContextRef context, float radius);
void StrokeRoundedRect(CGRect rect, CGContextRef context, float radius);