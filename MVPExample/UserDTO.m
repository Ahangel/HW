//
//  UserDTO.m
//  MVPExample
//
//  Created by Evgeny Shishko on 01/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import "UserDTO.h"

@interface UserDTO ()

@end

@implementation UserDTO

- (instancetype)initWithUser:(NSString *)name repos:(NSArray *)repos {
    self = [super init];
    if (self) {
        _userName = [name copy];
        _repos = [repos copy];
    }
    return self;
}





@end
