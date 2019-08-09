//
//  SearchUserPresenter.h
//  MVPExample
//
//  Created by OUT-Grigorov-KI on 06/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHCUserDTO.h"

@protocol GHCSearchUserPresenterOutput;

NS_ASSUME_NONNULL_BEGIN

@interface GHCSearchUserPresenter : NSObject 

@property (nonatomic, strong)   GHCUserDTO                         *model;
@property (nonatomic, weak)     id<GHCSearchUserPresenterOutput>   output;

- (void)searchUserWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
