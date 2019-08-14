//
//  SearchUserPresenter.m
//  MVPExample
//
//  Created by OUT-Grigorov-KI on 06/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import "GHCSearchUserPresenter.h"
#import "GHCSearchUserPresenterOutput.h"
#import "GHCNetworkService.h"
#import "GHCUserDTO.h"

@interface GHCSearchUserPresenter ()

@property (nonatomic, strong) GHCNetworkService *networkService;

@end

@implementation GHCSearchUserPresenter

- (instancetype)init {
    self = [super init];
    if (self) {
        _networkService = [GHCNetworkService new];
    }
    return self;
}

- (void)searchUserWithName:(NSString *)login {
    
    __weak typeof(self) weakSelf = self;
    
    [self.networkService searchUserWithLogin:login
                                 completion:^(GHCUserDTO *model, NSError * _Nullable error) {
                                     
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
                                         [strongSelf.output searchIsComplete:model];
                                     });
                                 }];
}

@end
