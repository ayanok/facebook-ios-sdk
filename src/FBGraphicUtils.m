//
//  FBGraphicUtils.m
//  facebook-ios-sdk
//
//  Created by Andrew Yanok on 9/5/11.
//  Copyright (c) 2011 Andy Yanok. All rights reserved.
//

#import "FBGraphicUtils.h"

@implementation FBGraphicUtils

+ (UIImage*) applicationImage:(id<UIApplicationDelegate>) _delegate frame:(CGRect) _frame {
    UIGraphicsBeginImageContext(_delegate.window.screen.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //Screenshot
    [_delegate.window.layer renderInContext:context];
    
    //Overlay
    UIView *overlay = [[UIView alloc] initWithFrame:_frame];
    overlay.backgroundColor = [UIColor colorWithWhite:0.0 alpha:.6];
    [overlay.layer renderInContext:context];
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

+ (UIImageView*) applicationImageView:(id<UIApplicationDelegate>) _delegate frame:(CGRect) _frame {
    UIGraphicsBeginImageContext(_delegate.window.screen.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //Screenshot
    [_delegate.window.layer renderInContext:context];
    
    //Overlay
    UIView *overlay = [[UIView alloc] initWithFrame:_frame];
    overlay.backgroundColor = [UIColor colorWithWhite:0.0 alpha:.6];
    [overlay.layer renderInContext:context];
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imageForBackgroundView=[[[UIImageView alloc] initWithFrame:_frame] autorelease];
    [imageForBackgroundView setImage:viewImage];
    
    return imageForBackgroundView;
}

@end

void GetRGBA(CGColorRef color, float * r, float * g, float * b, float * a) {
	// Convert the color to RGB color space
	const CGFloat * components = CGColorGetComponents(color);
	int componentCount = CGColorGetNumberOfComponents(color);
	if (componentCount == 2) {
		// Grayscale + Alpha
		*r = components[0];
		*g = components[0];
		*b = components[0];
		*a = components[1];
	} else if (componentCount == 3) {
		// Treat as RGB
		*r = components[0];
		*g = components[1];
		*b = components[2];
		*a = 1;		
	} else if (componentCount == 4){
		// Treat as RGBA
		*r = components[0];
		*g = components[1];
		*b = components[2];
		*a = components[3];		
	} else {
		*r = 0;
		*g = 0;
		*b = 0;
		*a = 0;
	}
}

void drawPlainVerticalGradient(CGContextRef ctx, CGRect rect, UIColor * startColor, UIColor * endColor) {
	// Draws a plain, 2 color fade gradient vertically
	//Draw the gradient as defined
	CGContextSaveGState(ctx);
	
	CGContextClipToRect(ctx, rect);
	
	CGGradientRef myGradient;
	CGColorSpaceRef myColorspace;
	
	size_t num_locations = 2;
	CGFloat locations[2] = { 0.00, 1.0};
	CGFloat components[8]; 
	
	// Get components from UIColor
	GetRGBA([startColor CGColor], components, components + 1, components + 2, components + 3);
	GetRGBA([endColor CGColor], components+4, components + 5, components + 6, components + 7);	
	
	myColorspace = CGColorSpaceCreateWithName((CFStringRef)@"kCGColorSpaceGenericRGB");
	
	myGradient = CGGradientCreateWithColorComponents (myColorspace, components,
													  
													  locations, num_locations);
	CGPoint startPoint, endPoint;
	startPoint.y = rect.origin.y;
	endPoint.y = rect.origin.y+rect.size.height;
	startPoint.x = 0;
	endPoint.x = 0;
	CGContextDrawLinearGradient(ctx,
								myGradient,
								startPoint,
								endPoint,
								kCGGradientDrawsBeforeStartLocation);
	CGContextRestoreGState(ctx);
	CFRelease(myColorspace);
	CFRelease(myGradient);		
}

void AddRoundedRectToPath (CGRect rect, CGContextRef context, float radius)
{
    if (context) {
        rect = CGRectInset(rect, 1.0, 1.0);	
        CGContextSaveGState(context);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, CGRectGetMinX(rect) + radius, CGRectGetMinY(rect));
        CGContextAddArc(context, CGRectGetMaxX(rect) - radius, CGRectGetMinY(rect) + radius, radius, 3 * M_PI / 2, 0, 0);
        CGContextAddArc(context, CGRectGetMaxX(rect) - radius, CGRectGetMaxY(rect) - radius, radius, 0, M_PI / 2, 0);
        CGContextAddArc(context, CGRectGetMinX(rect) + radius, CGRectGetMaxY(rect) - radius, radius, M_PI / 2, M_PI, 0);
        CGContextAddArc(context, CGRectGetMinX(rect) + radius, CGRectGetMinY(rect) + radius, radius, M_PI, 3 * M_PI / 2, 0);	
        CGContextClosePath(context);
    }
}

void StrokeRoundedRect(CGRect rect, CGContextRef context, float radius)
{
	// Inset .5 for "perfect" lines
	rect = CGRectInset(rect, .5, .5);
    CGContextBeginPath(context);
	//CGContextSetGrayFillColor(context, 0.8, 0.5);
	CGContextMoveToPoint(context, CGRectGetMinX(rect) + radius , CGRectGetMinY(rect));
    CGContextAddArc(context, CGRectGetMaxX(rect) - radius, CGRectGetMinY(rect) + radius, radius, 3 * M_PI / 2, 0, 0);
    CGContextAddArc(context, CGRectGetMaxX(rect) - radius, CGRectGetMaxY(rect) - radius, radius, 0, M_PI / 2, 0);
    CGContextAddArc(context, CGRectGetMinX(rect) + radius, CGRectGetMaxY(rect) - radius, radius, M_PI / 2, M_PI, 0);
    CGContextAddArc(context, CGRectGetMinX(rect) + radius, CGRectGetMinY(rect) + radius, radius, M_PI, 3 * M_PI / 2, 0);	
	CGContextClosePath(context);	 
    CGContextStrokePath(context);
}