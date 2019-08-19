//
//  LoginPresenter.h
//  MVPExample
//
//  Created by Evgeny Shishko on 01/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHCLoginViewController.h"

@protocol GHCLoginPresenterOutput;
@class GHCUserDTO;

NS_ASSUME_NONNULL_BEGIN

@interface GHCLoginPresenter : NSObject 

@property (nonatomic, weak)     id<GHCLoginPresenterOutput>    output;
@property (nonatomic, strong)   GHCUserDTO                     *model;

- (void)loginWithUserName:(NSString *)userName password:(NSString *)password;

@end

NS_ASSUME_NONNULL_END
