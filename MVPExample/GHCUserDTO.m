//
//  UserDTO.m
//  MVPExample
//
//  Created by Evgeny Shishko on 01/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import "GHCUserDTO.h"
#import "GHCRepoDTO.h"

@interface GHCUserDTO ()

@end

@implementation GHCUserDTO

- (instancetype)initWithUser:(NSString *)name repos:(NSArray<GHCRepoDTO *>*)repos {
    self = [super init];
    if (self) {
        _userName = [name copy];
        _repos = [repos copy];
    }
    return self;
}





@end
