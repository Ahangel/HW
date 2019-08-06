//
//  UserDTO.h
//  MVPExample
//
//  Created by Evgeny Shishko on 01/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LoginPresenterInput;
@protocol SearchUserPresenterInput;

NS_ASSUME_NONNULL_BEGIN

@interface UserDTO : NSObject

@property (nonatomic, weak) id<LoginPresenterInput>         loginOutput;
@property (nonatomic, weak) id<SearchUserPresenterInput>    searchUserOutput;
@property (nonatomic, strong) NSDictionary                  *userInfo;
@property (nonatomic, strong) NSString                      *searchUserName;
@property (nonatomic, strong) NSString                      *userName;
@property (nonatomic, strong) NSString                      *userImage;

- (instancetype)initWithUserInfo:(NSDictionary *)userInfo;

- (void)authorization;
- (void)searchUser;

@end

NS_ASSUME_NONNULL_END
