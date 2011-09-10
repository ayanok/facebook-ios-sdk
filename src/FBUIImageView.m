//
//  FBUIImageView.m
//  facebook-ios-sdk
//
//  Created by Andrew Yanok on 9/5/11.
//  Copyright (c) 2011 Andy Yanok. All rights reserved.
//

#import "FBUIImageView.h"
#import "FBGraphicUtils.h"

@implementation FBUIImageView
@synthesize image;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void) setImage:(UIImage *) _image {
    if (_image != image) {
        [image release], image = nil;
        image = [_image retain];
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    AddRoundedRectToPath(rect, context, 6.0);
    CGContextClip(context);
    
    drawPlainVerticalGradient(context, rect
                              , [UIColor colorWithRed:0.953 green:0.953 blue:0.953 alpha:1.0]
                              , [UIColor colorWithRed:0.725 green:0.725 blue:0.725 alpha:1.0]);
    
    if (image) {
        [image drawInRect:rect];
    }
    
    CGContextSaveGState(context);
    [[UIColor colorWithRed:0.588 green:0.588 blue:0.588 alpha:1.0] set];
    CGContextSetLineWidth(context, 2.0);
    
    CGRect strokeRect = rect;
    strokeRect.origin.x = 1;
    strokeRect.origin.y = 1;
    strokeRect.size.width = rect.size.width - 2;
    strokeRect.size.height = rect.size.height - 2;
    
    StrokeRoundedRect(strokeRect, context, 6.0);
    CGContextRestoreGState(context);
    
    CGContextRestoreGState(context);
}

- (void) dealloc {
    [image release], image = nil;
    [super dealloc];
}


@end
