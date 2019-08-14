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

@property (nonatomic, copy) NSString    *repoID;
@property (nonatomic, copy) NSString    *repoName;
@property (nonatomic, copy) NSString    *stargazerCounter;
@property (nonatomic, copy) NSString    *forksCounter;
@property (nonatomic, copy) NSString    *language;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end

NS_ASSUME_NONNULL_END
