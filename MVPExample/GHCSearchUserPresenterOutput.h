//
//  SearchUserPresenterOutput.h
//  MVPExample
//
//  Created by OUT-Grigorov-KI on 06/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GHCUserDTO;

NS_ASSUME_NONNULL_BEGIN

@protocol GHCSearchUserPresenterOutput <NSObject>

- (void)showErrorWith:(NSString *)title message:(NSString *)message;
- (void)searchIsComplete:(GHCUserDTO *)model;

@end

NS_ASSUME_NONNULL_END
