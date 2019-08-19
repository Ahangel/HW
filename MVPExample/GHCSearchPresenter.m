//
//  GHCSearchPresenter.m
//  MVPExample
//
//  Created by Кирилл Григоров on 18/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import "GHCSearchPresenter.h"
#import "GHCNetworkService.h"
#import "GHCUserDTO.h"
#import "GHCSearchPresenterOutput.h"

@interface GHCSearchPresenter ()

@property (nonatomic, strong) GHCNetworkService *networkService;

@end

@implementation GHCSearchPresenter

- (instancetype)init {
    self = [super init];
    if (self) {
        _networkService = [[GHCNetworkService alloc] init];
    }
    return self;
}

- (void)searchUserWithLogin:(NSString *)userLogin
                       page:(NSUInteger)page {
    
    __weak typeof(self) weakSelf = self;
    
    [self.networkService searchUserWithLogin:userLogin
                                        page:page
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
                                         [strongSelf.output searchComplete:users];
                                     });
                                 }];
}

- (void)addUserToSearchArrayWithLogin:(NSString *)userLogin
                                 page:(NSUInteger)page {
    
    __weak typeof(self) weakSelf = self;
    
    [self.networkService searchUserWithLogin:userLogin
                                        page:page
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
                                          [strongSelf.output addingToSearchResult:users];
                                      });
                                  }];
}

@end
