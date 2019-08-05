//
//  LoginPresenter.m
//  MVPExample
//
//  Created by Evgeny Shishko on 01/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import "LoginPresenter.h"
#import "LoginPresenterOutput.h"

@implementation LoginPresenter

- (void)loginWithUsername:(NSString *)userName password:(NSString *)password {
    [self.output authorizationComplete];
}

@end
