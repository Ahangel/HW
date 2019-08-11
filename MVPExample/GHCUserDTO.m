//
//  UserDTO.m
//  MVPExample
//
//  Created by Evgeny Shishko on 01/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import "GHCUserDTO.h"
#import "GHCRepoDTO.h"

@implementation GHCUserDTO

- (instancetype)initWithUser:(NSString*)userName
                       repos:(NSArray<GHCRepoDTO *>*)repos
{
    self = [super init];
    if (self) {
        _repos = [repos copy];
        _userName = [userName copy];
    }
    return self;
}

@end
