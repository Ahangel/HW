//
//  LoginPresenter.m
//  MVPExample
//
//  Created by Evgeny Shishko on 01/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import "LoginPresenter.h"
#import "LoginPresenterOutput.h"
#import "UserDTO.h"

@implementation LoginPresenter

- (void)loginWithUsername:(NSString *)userName password:(NSString *)password {
    
    NSDictionary *userInfo = [[NSDictionary alloc]
                     initWithObjectsAndKeys:
                     userName, @"login",
                     password, @"password", nil];
    if ([userInfo[@"password"] isEqualToString:(@"")]) {
        [self.output showErrorWith:@"Error" message:@"No password"];
        return;
    }
    
    self.model = [[UserDTO alloc] initWithUserInfo:userInfo];
    self.model.loginOutput = self;
    [self.model authorization];
}

- (void)authorizationComplete {
    [self.output authorizationComplete];
}
- (void)authorizationWithError:(NSError *)error
{
    NSString *code = [NSString stringWithFormat:@"Error: %lu", error.code];
    NSString *message = [error.localizedDescription copy];
    [self.output showErrorWith:code message:message];
}

@end
