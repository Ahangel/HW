//
//  LoginPresenter.h
//  MVPExample
//
//  Created by Evgeny Shishko on 01/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginViewController.h"


@protocol LoginPresenterOutput;
@class UserDTO;

NS_ASSUME_NONNULL_BEGIN

@interface LoginPresenter : NSObject 

@property (nonatomic, weak)     id<LoginPresenterOutput>    output;
@property (nonatomic, strong)   UserDTO                     *model;

- (void)loginWithUserName:(NSString *)userName password:(NSString *)password;

@end

NS_ASSUME_NONNULL_END
