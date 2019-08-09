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

- (void)searchUserWithName:(NSString *)name {
    
    __weak typeof(self) weakSelf = self;
    
    [self.networkService searchUserWithName:name
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






//- (void)searchUser:(NSString *)name {
//    self.model = [UserDTO new];
//    self.model.searchUserName = name;
//
//    self.model.searchUserOutput = self;
//    [self.model searchUser];
//}
//
//- (void)searchWithError:(NSError *)error {
//    NSString *code = [NSString stringWithFormat:@"Error: %lu", error.code];
//    NSString *message = [error.localizedDescription copy];
//    [self.output showErrorWith:code message:message];
//}
//
//- (void)searchIsComplete {
//    [self.output searchIsComplete];
//}
@end
