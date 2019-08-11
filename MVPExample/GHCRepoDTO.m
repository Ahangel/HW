//
//  RepoDTO.m
//  MVPExample
//
//  Created by OUT-Grigorov-KI on 09/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import "GHCRepoDTO.h"

@implementation GHCRepoDTO

- (instancetype)initWithData:(NSString *)repoID
                    repoName:(NSString *)repoName
                starsCounter:(NSString *)stargazerCounter
                forksCounter:(NSString *)forksCounter
                    language:(NSString *)language
{
    self = [super init];
    if (self) {
        _repoID = [repoID copy];
        _repoName = [repoName copy];
        _stargazerCounter = [stargazerCounter copy];
        _forksCounter = [forksCounter copy];
        
        if ([language isEqual:@"<null>"]) {
            _language = @"None";
        } else {
            _language = [language copy];
        }
    }
    return self;
}

@end
