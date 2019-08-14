//
//  UserDTO.h
//  MVPExample
//
//  Created by Evgeny Shishko on 01/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GHCRepoDTO;

NS_ASSUME_NONNULL_BEGIN

@interface GHCUserDTO : NSObject

@property (nonatomic, copy, readonly) NSString                  *userName;
@property (nonatomic, copy, readonly) NSArray<GHCRepoDTO *>     *repos;

- (instancetype)initWithLogin:(NSString *)login
                       repos:(NSArray<GHCRepoDTO *>*)repos;

@end

NS_ASSUME_NONNULL_END
