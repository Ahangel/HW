//
//  RepoDTO.m
//  MVPExample
//
//  Created by OUT-Grigorov-KI on 09/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import "GHCRepoDTO.h"

@implementation GHCRepoDTO

- (instancetype)initWithDictionary:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        _repoID = [[NSString stringWithFormat:@"%@",data[@"id"]] copy];
        _repoName = [[NSString stringWithFormat:@"%@",data[@"name"]] copy];
        _stargazerCounter = [[NSString stringWithFormat:@"%@",data[@"stargazers_count"]] copy];
        _forksCounter = [[NSString stringWithFormat:@"%@",data[@"forks_count"]] copy];
        
        if ([[NSString stringWithFormat:@"%@",data[@"language"]] isEqual:@"<null>"]) {
            _language = @"None";
        } else {
            _language = [[NSString stringWithFormat:@"%@",data[@"language"]] copy];
        }
    }
    return self;
}

@end
