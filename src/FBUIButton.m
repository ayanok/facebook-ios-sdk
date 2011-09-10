//
//  FBUIButton.m
//  facebook-ios-sdk
//
//  Created by Andrew Yanok on 9/5/11.
//  Copyright (c) 2011 Andy Yanok. All rights reserved.
//

#import "FBUIButton.h"
#import "FBGraphicUtils.h"

@implementation FBUIButton
@synthesize style;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+ (id) FBButtonWithStyle:(FBUIButtonStyle) _style {
    FBUIButton *btn = [[[FBUIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)] autorelease];
    btn.style = _style;
    return btn;
}

- (void) setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setNeedsDisplay];
}

- (void) setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    AddRoundedRectToPath(rect, context, 6.0);
    CGContextClip(context);
    
    if (style == FBUIButtonStyleCancel) {
        
        drawPlainVerticalGradient(context, rect
                                  ,[UIColor colorWithRed:0.988 green:0.988 blue:0.988 alpha:1.0]
                                  , [UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.0]);
        
        CGContextSaveGState(context);
        [[UIColor colorWithRed:0.588 green:0.588 blue:0.588 alpha:1.0] set];
        CGContextSetLineWidth(context, 1.0);
        
        CGRect strokeRect = rect;
        strokeRect.origin.x = 1;
        strokeRect.origin.y = 1;
        strokeRect.size.width = rect.size.width - 2;
        strokeRect.size.height = rect.size.height - 2;
        
        StrokeRoundedRect(strokeRect, context, 6.0);
        CGContextRestoreGState(context);
        
        CGContextSetShadowWithColor(context, CGSizeMake(-.5, -.5), 0.0, [[UIColor colorWithRed:0.706 green:0.706 blue:0.706 alpha:1.0]CGColor]);
        
        UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:13.0];
        [[UIColor colorWithRed:0.588 green:0.588 blue:0.588 alpha:1.0] set];
        NSString *text = @"Cancel";
        CGSize textSize = [text sizeWithFont:font];
        NSInteger textYloc = (rect.size.height - font.lineHeight) / 2;
        NSInteger textXloc = (rect.size.width - textSize.width) / 2;
        [text drawAtPoint:CGPointMake(textXloc, textYloc) withFont:font];
        
        
    }
    else {
        
        drawPlainVerticalGradient(context, rect
                                  , [UIColor colorWithRed:0.412 green:0.604 blue:0.992 alpha:1.0]
                                  , [UIColor colorWithRed:0.157 green:0.396 blue:0.886 alpha:1.0]);
        
        CGContextSaveGState(context);
        [[UIColor colorWithRed:0.271 green:0.392 blue:0.718 alpha:1.0] set];
        CGContextSetLineWidth(context, 1.0);
        
        CGRect strokeRect = rect;
        strokeRect.origin.x = 1;
        strokeRect.origin.y = 1;
        strokeRect.size.width = rect.size.width - 2;
        strokeRect.size.height = rect.size.height - 2;
        
        StrokeRoundedRect(strokeRect, context, 6.0);
        CGContextRestoreGState(context);
        
        CGContextSetShadowWithColor(context, CGSizeMake(-.5, -1.0), 0.0, [[UIColor darkGrayColor]CGColor]);
        
        UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:13.0];
        [[UIColor whiteColor] set];
        NSString *text = @"Post";
        CGSize textSize = [text sizeWithFont:font];
        NSInteger textYloc = (rect.size.height - font.lineHeight) / 2;
        NSInteger textXloc = (rect.size.width - textSize.width) / 2;
        [text drawAtPoint:CGPointMake(textXloc, textYloc) withFont:font];
        
        
    }
    
    if (self.highlighted) {
        [[UIColor colorWithWhite:0.0 alpha:.2] set];
        CGContextFillRect(context, rect);
    }
    
    CGContextRestoreGState(context);
}

@end
