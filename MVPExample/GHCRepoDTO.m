//
//  RepoDTO.m
//  MVPExample
//
//  Created by OUT-Grigorov-KI on 09/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import "GHCRepoDTO.h"

@implementation GHCRepoDTO

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _repoID = [NSString stringWithFormat:@"%@",dictionary[@"id"]];
        _repoName = [NSString stringWithFormat:@"%@",dictionary[@"name"]];
        _stargazerCounter = [NSString stringWithFormat:@"%@",dictionary[@"stargazers_count"]];
        _forksCounter = [NSString stringWithFormat:@"%@",dictionary[@"forks_count"]];
        
        if ([[NSString stringWithFormat:@"%@",dictionary[@"language"]] isEqual:@"<null>"]) {
            _language = @"None";
        } else {
            _language = [NSString stringWithFormat:@"%@",dictionary[@"language"]];
        }
    }
    return self;
}

@end
