//
//  SearchUserPresenter.h
//  MVPExample
//
//  Created by OUT-Grigorov-KI on 06/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserDTO.h"
#import "SearchUserPresenterInput.h"

@protocol SearchUserPresenterOutput;

NS_ASSUME_NONNULL_BEGIN

@interface SearchUserPresenter : NSObject 

@property (nonatomic, strong)   UserDTO                         *model;
@property (nonatomic, weak)     id<SearchUserPresenterOutput>   output;

- (void)searchUserWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
