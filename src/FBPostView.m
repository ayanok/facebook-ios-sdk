//
//  FBPostView.m
//  facebook-ios-sdk
//
//  Created by Andrew Yanok on 9/5/11.
//  Copyright (c) 2011 Andy Yanok. All rights reserved.
//

#import "FBPostView.h"
#import "FBGraphicUtils.h"

@implementation FBShadowView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void) drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    AddRoundedRectToPath(rect, context, 8.0);
    CGContextClip(context);
    
    [[UIColor colorWithWhite:0.0 alpha:.3] set];
    CGContextFillRect(context, rect);
    
    CGContextRestoreGState(context);
}

- (void) dealloc {
    [super dealloc];
}

@end

@interface FBPostView (Private)
@end

@implementation FBPostView
@synthesize textView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 44, self.bounds.size.width-100, self.bounds.size.height - 44)];
        textView.backgroundColor = [UIColor clearColor];
        textView.font = [UIFont fontWithName:@"HelveticaNeue" size:15.0];
        textView.textColor = [UIColor colorWithRed:0.110 green:0.110 blue:0.110 alpha:1.0];
        [self addSubview:textView];
    }
    return self;
}


#pragma mark -
#pragma mark Private Methods

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    AddRoundedRectToPath(rect, context, 8.0);
    CGContextClip(context);
    
    //gradient background
    drawPlainVerticalGradient(context, rect
                              , [UIColor colorWithRed:0.953 green:0.953 blue:0.953 alpha:1.0]
                              , [UIColor colorWithRed:0.725 green:0.725 blue:0.725 alpha:1.0]);
    

    //Add dashed line
    [[UIColor colorWithRed:0.824 green:0.592 blue:0.592 alpha:1.0] set];
    CGContextMoveToPoint(context, 0, 44);
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), 44);
    CGFloat lengths[] = {2.0, 3.0};
    CGContextSetLineDash(context, 4.0, lengths, 2);
    CGContextStrokePath(context);
    
    CGContextRestoreGState(context);
    
    //Add lines
    [[UIColor colorWithRed:0.671 green:0.671 blue:0.671 alpha:.7] set];
    CGContextSetLineWidth(context, 1.0);
    
    NSInteger lineYloc = 71;
    
    CGContextMoveToPoint(context, 0, lineYloc);
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), lineYloc);
    CGContextStrokePath(context);
    
    lineYloc = lineYloc + 20;
    
    CGContextMoveToPoint(context, 0, lineYloc);
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), lineYloc);
    CGContextStrokePath(context);
    
    lineYloc = lineYloc + 20;
    
    CGContextMoveToPoint(context, 0, lineYloc);
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), lineYloc);
    CGContextStrokePath(context);
    
    lineYloc = lineYloc + 20;
    
    CGContextMoveToPoint(context, 0, lineYloc);
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), lineYloc);
    CGContextStrokePath(context);
    
    lineYloc = lineYloc + 20;
    
    CGContextMoveToPoint(context, 0, lineYloc);
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), lineYloc);
    CGContextStrokePath(context);
    
    lineYloc = lineYloc + 20;
    
    CGContextMoveToPoint(context, 0, lineYloc);
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), lineYloc);
    CGContextStrokePath(context);
    
    //Stroke the rect
    [[UIColor colorWithRed:0.396 green:0.396 blue:0.396 alpha:1.0] set];
    StrokeRoundedRect(rect, context, 8.0);
    
    //Show Text
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, CGSizeMake(-1.0, -1.0), 0.0, [[UIColor colorWithRed:0.706 green:0.706 blue:0.706 alpha:1.0]CGColor]);
    
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0];
    [[UIColor colorWithRed:0.467 green:0.467 blue:0.467 alpha:1.0] set];
    NSString *text = @"Post";
    CGSize textSize = [text sizeWithFont:font];
    NSInteger textXloc = (rect.size.width - textSize.width) / 2;
    [text drawAtPoint:CGPointMake(textXloc, 10) withFont:font];
    
    CGContextRestoreGState(context);

}

- (void) dealloc {
    [textView release], textView = nil;
    [super dealloc];
}

@end
