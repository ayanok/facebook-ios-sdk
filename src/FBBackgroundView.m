//
//  FBBackgroundView.m
//  facebook-ios-sdk
//
//  Created by Andrew Yanok on 9/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FBBackgroundView.h"

@implementation FBBackgroundView
@synthesize imageView, overlay;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        [self addSubview:imageView];
        
        overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        overlay.backgroundColor = [UIColor colorWithWhite:0.0 alpha:.2];
        [self addSubview:overlay];
    }
    return self;
}

- (void) dealloc {
    [overlay release], overlay = nil;
    [imageView release], imageView = nil;
    [super dealloc];
}

@end
