//
//  GHCUserProfilePresenter.h
//  MVPExample
//
//  Created by OUT-Grigorov-KI on 19/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GHCUserProfilePresenterOutput;
@class GHCUserDTO;

@interface GHCUserProfilePresenter : NSObject

@property (nonatomic, weak)     id<GHCUserProfilePresenterOutput>    output;
@property (nonatomic, strong)   GHCUserDTO                     *model;

- (void)fetchReposWithLogin:(NSString *)userName;

@end

NS_ASSUME_NONNULL_END
