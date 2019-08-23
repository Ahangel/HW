//
//  GHCUserProfilePresenter.m
//  MVPExample
//
//  Created by OUT-Grigorov-KI on 19/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import "GHCUserProfilePresenter.h"
#import "GHCNetworkService.h"
#import "GHCUserProfilePresenterOutput.h"

@interface GHCUserProfilePresenter ()

@property (nonatomic, strong) GHCNetworkService *networkService;

@end

@implementation GHCUserProfilePresenter

- (instancetype)init {
    self = [super init];
    if (self) {
        _networkService = [[GHCNetworkService alloc] init];
    }
    return self;
}

- (void)fetchReposWithLogin:(NSString *)login {
    
    __weak typeof(self) weakSelf = self;
    
    [self.networkService fetchRepositoriesWithLogin:login
                                         completion:^(NSArray * _Nullable user, NSError * _Nullable error) {
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
            [strongSelf.output fetchComplete:user];
        });
    }];
}

- (void)fetchFollowersWithLogin:(NSString *)login {
    
    __weak typeof(self) weakSelf = self;
    
    [self.networkService fetchFollowersWithLogin:login
                                         completion:^(NSArray * _Nullable users, NSError * _Nullable error) {
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
                                                 [strongSelf.output fetchFollowersComplete:users];
                                             });
                                         }];
}

- (void)fetchStarredReposWithLogin:(NSString *)login {
    
    __weak typeof(self) weakSelf = self;
    
    [self.networkService fetchStarredReposWithLogin:login
                                         completion:^(NSArray * _Nullable user, NSError * _Nullable error) {
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
                                                 [strongSelf.output fetchStarredReposComplete:user];
                                             });
                                         }];
}

@end
