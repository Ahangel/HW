//
//  GHCUserProfilePresenterOutput.h
//  MVPExample
//
//  Created by OUT-Grigorov-KI on 19/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class GHCUserDTO;
@protocol GHCUserProfilePresenterOutput <NSObject>

- (void)fetchComplete:(GHCUserDTO *)user;
- (void)showErrorWith:(NSString *)title message:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
