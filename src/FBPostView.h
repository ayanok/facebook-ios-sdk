//
//  FBPostView.h
//  facebook-ios-sdk
//
//  Created by Andrew Yanok on 9/5/11.
//  Copyright (c) 2011 Andy Yanok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBShadowView : UIView {
@private
    
}
@end

@interface FBPostView : UIView
{
    UITextView *textView;
}

@property (nonatomic, retain) UITextView *textView;

@end
