//
//  FBHiddenWebView.m
//  facebook-ios-sdk
//
//  Created by Andrew Yanok on 9/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FBHiddenWebView.h"

@implementation FBHiddenWebView
@synthesize FBHiddenWebViewCallback = _FBHiddenWebViewCallback;

- (id)initWithFrame:(CGRect)frame url:(NSURL*) _url
{
    self = [super initWithFrame:frame];
    if (self) {
        webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        webView.delegate = self;
        webView.scalesPageToFit = YES;
        [self addSubview:webView];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:_url];
        [webView loadRequest:request];
    }
    return self;
}

#pragma mark -
#pragma mark UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *) _webView {
    
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if (_FBHiddenWebViewCallback != nil) {
        _FBHiddenWebViewCallback (nil, error);
    }
}

- (void)webViewDidFinishLoad:(UIWebView *) _webView {
    
    UIGraphicsBeginImageContext(_webView.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //Screenshot
    [_webView.layer renderInContext:context];
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if (_FBHiddenWebViewCallback != nil) {
        _FBHiddenWebViewCallback (viewImage, nil);
    }
}

- (void) dealloc {
    [_FBHiddenWebViewCallback release], _FBHiddenWebViewCallback = nil;
    webView.delegate = nil;
    [webView release], webView = nil;
    [super dealloc];
}

@end
