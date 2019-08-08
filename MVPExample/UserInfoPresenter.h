//
//  UserInfoPresenter.h
//  MVPExample
//
//  Created by OUT-Grigorov-KI on 08/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoTableViewController.h"
#import "UserInfoPresenterInput.h"

@protocol UserInfoPresenterOutput;
@class UserDTO;

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoPresenter : NSObject 

@property (nonatomic, strong)   UserDTO                     *model;
@property (nonatomic, weak)     id<UserInfoPresenterOutput> output;

@end

NS_ASSUME_NONNULL_END
