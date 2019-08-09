//
//  UserInfoPresenter.h
//  MVPExample
//
//  Created by OUT-Grigorov-KI on 08/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHCUserInfoTableViewController.h"


@protocol GHCUserInfoPresenterOutput;
@class GHCUserDTO;

NS_ASSUME_NONNULL_BEGIN

@interface GHCUserInfoPresenter : NSObject 

@property (nonatomic, strong)   GHCUserDTO                     *model;
@property (nonatomic, weak)     id<GHCUserInfoPresenterOutput> output;

@end

NS_ASSUME_NONNULL_END
