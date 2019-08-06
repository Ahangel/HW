//
//  SearchUserPresenter.m
//  MVPExample
//
//  Created by OUT-Grigorov-KI on 06/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import "SearchUserPresenter.h"

@implementation SearchUserPresenter

- (void)searchUser:(NSString *)name {
    self.model = [UserDTO new];
    self.model.searchUserName = name;
    
    self.model.output = self;
    [self.model searchUser];
}
@end
