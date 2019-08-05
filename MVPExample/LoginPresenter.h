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

NS_ASSUME_NONNULL_BEGIN

@interface LoginPresenter : NSObject

@property (nonatomic, weak) id<LoginPresenterOutput> output;

- (void)loginWithUsername:(NSString *)userName password:(NSString *)password;

@end

NS_ASSUME_NONNULL_END
