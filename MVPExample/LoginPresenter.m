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
#import "NetworkService.h"

@interface LoginPresenter ()

@property (nonatomic, strong) NetworkService *networkService;

@end

@implementation LoginPresenter

- (instancetype)init {
    self = [super init];
    if (self) {
        _networkService = [[NetworkService alloc] init];
    }
    return self;
}

- (void)loginWithUserName:(NSString *)userName password:(NSString *)password {
    
    NSDictionary *userInfo = [[NSDictionary alloc]
                     initWithObjectsAndKeys:
                     userName, @"login",
                     password, @"password", nil];
    
    if ([userInfo[@"password"] isEqualToString:(@"")]) {
        [self.output showErrorWith:@"Error" message:@"No password"];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    
    [self.networkService authorizeWithLogin:userInfo[@"login"]
                                   password:userInfo[@"password"]
                                 completion:^(NSError * _Nullable error) {
                                     
                                     __strong typeof(self) strongSelf = weakSelf;
                                     
                                     if (error) {
                                     
                                         NSString *code = [NSString stringWithFormat:@"Error: %lu", error.code];
                                         NSString *message = [error.localizedDescription copy];
                                         dispatch_async(dispatch_get_main_queue(), ^{
                                             [strongSelf.output showErrorWith:code message:message];
                                         });
                                         return;
                                     }
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                         [strongSelf.output authorizationComplete];
                                     });
                                 }];
}

@end
