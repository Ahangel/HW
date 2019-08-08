//
//  SearchUserPresenterOutput.h
//  MVPExample
//
//  Created by OUT-Grigorov-KI on 06/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserDTO;

NS_ASSUME_NONNULL_BEGIN

@protocol SearchUserPresenterOutput <NSObject>

- (void)showErrorWith:(NSString *)title message:(NSString *)message;
- (void)searchIsComplete:(UserDTO *)model;

@end

NS_ASSUME_NONNULL_END
