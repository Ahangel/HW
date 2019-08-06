//
//  SearchUserPresenter.m
//  MVPExample
//
//  Created by OUT-Grigorov-KI on 06/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import "SearchUserPresenter.h"
#import "SearchUserPresenterOutput.h"

@implementation SearchUserPresenter

- (void)searchUser:(NSString *)name {
    self.model = [UserDTO new];
    self.model.searchUserName = name;
    
    self.model.searchUserOutput = self;
    [self.model searchUser];
}

- (void)searchWithError:(NSError *)error {
    NSString *code = [NSString stringWithFormat:@"Error: %lu", error.code];
    NSString *message = [error.localizedDescription copy];
    [self.output showErrorWith:code message:message];
}

- (void)searchIsComplete {
    
}
@end
