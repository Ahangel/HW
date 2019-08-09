//
//  RepoDTO.h
//  MVPExample
//
//  Created by OUT-Grigorov-KI on 09/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHCRepoDTO : NSObject

@property (nonatomic, assign) NSUInteger    repoID;
@property (nonatomic, copy) NSString        *repoName;
@property (nonatomic, assign) NSUInteger    stargazerCounter;
@property (nonatomic, assign) NSUInteger    forksCounter;

@end

NS_ASSUME_NONNULL_END
