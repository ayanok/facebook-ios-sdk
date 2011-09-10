//
//  FBPostViewController.m
//  facebook-ios-sdk
//
//  Created by Andrew Yanok on 9/5/11.
//  Copyright (c) 2011 Andy Yanok. All rights reserved.
//

#import "FBPostViewController.h"
#import "FBPostView.h"
#import "FBGraphicUtils.h"
#import "FBUIButton.h"
#import "FBUIImageView.h"

@interface FBPostViewController (Private)
- (void) handleCompletionWithError:(NSError*) _error;
- (void) authorizeFacebookUser;
- (IBAction) btnCancelPress:(id)sender;
- (IBAction) btnPostPress:(id)sender;
- (void) showImageView:(BOOL) _val;
- (void) animateViewControllerRemoval;
@end

@implementation FBPostViewController
@synthesize facebookAppId, shouldCacheCredentials;
@synthesize FBPostViewControllerCompletionCallback = _FBPostViewControllerCompletionCallback;

- (id) initWithFacebookAppID:(NSString*) _facebookAppId applicationDelegate:(id<UIApplicationDelegate>) _delegate {
    self = [self init];
    if (self) {
        self.facebookAppId = _facebookAppId;
        
        CGRect frame = CGRectMake(0, -20, self.view.bounds.size.width, self.view.bounds.size.height+20);
        backgroundView = [[FBGraphicUtils applicationImageView:_delegate frame:frame] retain];
        backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        backgroundView.alpha = .5;
        [self.view addSubview:backgroundView];
        
        NSInteger xloc = (self.view.bounds.size.width - 310) / 2;
        
        postView = [[FBPostView alloc] initWithFrame:CGRectMake(xloc, 30, 310, 190)];
        postView.alpha = 0.0;
        postView.layer.shadowPath = [[UIBezierPath bezierPathWithRect:postView.frame] CGPath];
        postView.layer.shadowColor = [[UIColor blackColor] CGColor];
        postView.layer.shadowOffset = CGSizeMake(-1, -30);
        postView.layer.shadowRadius = 10;
        postView.layer.shadowOpacity = .8;
        [self.view addSubview:postView];
        
        FBUIButton *btnCancel = [FBUIButton FBButtonWithStyle:FBUIButtonStyleCancel];
        btnCancel.frame = CGRectMake(5, 5, 70, 34);
        [btnCancel addTarget:self action:@selector(btnCancelPress:) forControlEvents:UIControlEventTouchUpInside];
        [postView addSubview:btnCancel];
        
        FBUIButton *btnPost = [FBUIButton FBButtonWithStyle:FBUIButtonStylePost];
        btnPost.frame = CGRectMake(postView.bounds.size.width - 65, 5, 60, 34);
        [btnPost addTarget:self action:@selector(btnPostPress:) forControlEvents:UIControlEventTouchUpInside];
        [postView addSubview:btnPost];
        
        imageView = [[FBUIImageView alloc] initWithFrame:CGRectMake(postView.bounds.size.width - 80, 60, 70, 70)];
        [postView addSubview:imageView];
        
        [self showImageView:NO];
        
        if (accessToken) {
            user = [[FBUser alloc] initWithAppId:self.facebookAppId accessToken:accessToken expirationDate:[NSDate distantFuture]];
        }
        else {
            user = [[FBUser alloc] initWithAppId:self.facebookAppId accessToken:nil expirationDate:nil];
            NSArray *permissions = [NSArray arrayWithObjects:@"publish_stream", nil];
            [user authorizeWithPermissions:permissions delegate:self];
        }
        
    }
    return self;
}

- (id) init {
    self = [super init];
    if (self) {
        
        post = [[FBPost alloc] init];
        shouldCacheCredentials = YES;
        
        NSString *_accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:kFacebookAccessToken];
        if (_accessToken) {
            accessToken = [_accessToken retain];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void) addImage:(UIImage*) _image {
    
    FBPhoto *photo = [[FBPhoto alloc] init];
    photo.image = _image;
    
    [post setPhoto:photo];
    [photo release];
    
    imageView.image = _image;
    [self showImageView:YES];
}

- (void) addURL:(NSURL*) _url {
    [post setLink:[_url absoluteString]];
    
    [self showImageView:YES];
}

- (void) addMessage:(NSString*) _message {
    [post setMessage:_message];
}

- (void) addDescription:(NSString*) _description {
    [post setDescription:_description];
}

- (void) addCaption:(NSString*) _caption {
    [post setCaption:_caption];
}

- (void) addPictureURL:(NSURL*) _pictureURL {
    [post setPictureUrl:[_pictureURL absoluteString]];
    
    [self showImageView:YES];
}

- (void) addTitle:(NSString*) _linktitle {
    [post setLinkName:_linktitle];
}

#pragma mark -
#pragma mark Private Methods

- (void) handleCompletionWithError:(NSError*) _error {
    if (_FBPostViewControllerCompletionCallback != nil) {
        _FBPostViewControllerCompletionCallback (self, _error);
    }
    
    [self animateViewControllerRemoval];
}

- (void) authorizeFacebookUser {
    if (facebookAppId && [facebookAppId length] > 0) {
        [user release], user = nil;
        user = [[FBUser alloc] initWithAppId:self.facebookAppId accessToken:nil expirationDate:nil];
        
        NSArray *permissions = [NSArray arrayWithObjects:@"publish_stream", nil];
        [user authorizeWithPermissions:permissions delegate:self];
    }
    else {
        NSError *error = [NSError errorWithDomain:@"Invalid Facebook Application ID" 
                                             code:1 
                                         userInfo:[NSDictionary dictionaryWithObject:@"Facebook Application ID not provided, or is invalid." 
                                                                              forKey:@"error"]];
        [self handleCompletionWithError:error];
    }
}

- (IBAction) btnCancelPress:(id)sender {
    [self animateViewControllerRemoval];
}

- (IBAction) btnPostPress:(id)sender {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    if (post.link != nil && [post.link length] > 0) {
        post.type = FBPostTypeLink;
    }
    else if (post.photo != nil && post.photo.image != nil) {
        post.type = FBPostTypePhoto;
    }
    else {
        post.type = FBPostTypeStatus;
    }
    
    if ([postView.textView.text length] > 0) {
        post.message = postView.textView.text;
    }
    
    [user createPost:post withCallback:^(FBPost *post, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        [self handleCompletionWithError:error];
    }];
}

- (void) showImageView:(BOOL) _val {
    imageView.hidden = !_val;
    
    if (_val) {
        postView.textView.frame = CGRectMake(0, 44, postView.bounds.size.width-100, postView.bounds.size.height-44);
    }
    else {
        postView.textView.frame = CGRectMake(0, 44, postView.bounds.size.width, postView.bounds.size.height-44);
    }
}

- (void) animateViewControllerRemoval {
    [UIView beginAnimations:@"show" context:nil];
    [UIView animateWithDuration:.3 animations:^{
        [postView.textView resignFirstResponder];
        backgroundView.alpha = .0;
        postView.transform = CGAffineTransformMakeTranslation(0, (self.view.bounds.size.height/2)); 
    } completion:^(BOOL finished) {
        if (finished) {
            [self dismissModalViewControllerAnimated:NO];
        }
    }];
    [UIView commitAnimations];
}

#pragma mark -
#pragma mark FBSessionDelegate

- (void)fbDidLogin {
    //cache accessToken if allowed
    if (shouldCacheCredentials && user.accessToken) {
        [accessToken release], accessToken = nil;
        accessToken = [user.accessToken retain];
        
        [postView.textView becomeFirstResponder];
        
        [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:kFacebookAccessToken];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)fbDidNotLogin:(BOOL)cancelled {
    NSError *error = [NSError errorWithDomain:@"Failed to login into Facebook" 
                                         code:1 userInfo:[NSDictionary dictionaryWithObject:@"Cancelled Facebook Login" forKey:@"error"]];
    [self handleCompletionWithError:error];
}

- (void)fbDidLogout {
    
    
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (accessToken) {
        [postView.textView becomeFirstResponder];
    }
    
    [UIView beginAnimations:@"show" context:nil];
    [UIView animateWithDuration:.3 animations:^{
        postView.alpha = 1.0; 
        backgroundView.alpha = 1.0;
    }];
    [UIView commitAnimations];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) dealloc {
    [backgroundView release], backgroundView = nil;
    [imageView release], imageView = nil;
    [_FBPostViewControllerCompletionCallback release], _FBPostViewControllerCompletionCallback = nil;
    [facebookAppId release], facebookAppId = nil;
    [user release], user = nil;
    [post release], post = nil;
    [accessToken release], accessToken = nil;
    [toUser release], toUser = nil;
    [postView release], postView = nil;
    [super dealloc];
}


@end
