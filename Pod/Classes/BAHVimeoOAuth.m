//
//  BAHVimeoOAuth.m
//  BAHVimeoOAuth
//
//  Created by BHughes on 1/31/15.
//  Copyright (c) 2015 BHughes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAHVimeoOAuth.h"


@interface BAHVimeoOAuth ()

@end

@implementation BAHVimeoOAuth : NSObject

static NSString *vimeoAuthURL = @"https://api.vimeo.com/oauth/authorize";

- (void)authenticateWithVimeoUsingVimeoClientID:(NSString *)vimeoClientID vimeoAuthorizationHeader:(NSString *)vimeoAuthorizationHeader scope:(NSString *)scope state:(NSString *)state appURLCallBack:(NSString *)appURLCallBack viewController:(id)viewController :(void (^)(BOOL, NSString *))completelion{
    
    if (!scope) {
        scope = @"public";
    }
    
    NSString *authenticateURLString = [NSString stringWithFormat:@"%@?client_id=%@&response_type=code&state=%@&scope=%@&redirect_uri=%@", vimeoAuthURL, vimeoClientID, state, scope, appURLCallBack];
    
    BAHVimeoOAuthViewController *OAuthController = [[BAHVimeoOAuthViewController alloc]init];
    
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:OAuthController];
    
    [viewController presentViewController:navController animated:YES completion:^{
        OAuthController.vimeoAuthorizationHeader = vimeoAuthorizationHeader;
        OAuthController.uriCallBack = appURLCallBack;
        OAuthController.state = state;
        OAuthController.vimeoSender = self;
        [OAuthController.oAuthWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:authenticateURLString]]];
        
    }];
    
    self.completelion = completelion;
    
}

@end