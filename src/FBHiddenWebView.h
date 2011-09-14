//
//  FBHiddenWebView.h
//  facebook-ios-sdk
//
//  Created by Andrew Yanok on 9/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBHiddenWebView : UIView <UIWebViewDelegate>
{
    UIWebView *webView;
}

@property (copy) void (^FBHiddenWebViewCallback)(UIImage*,NSError*);

- (id)initWithFrame:(CGRect)frame url:(NSURL*) _url;

@end
