//
//  GHCSearchPresenter.h
//  MVPExample
//
//  Created by Кирилл Григоров on 18/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class GHCUserDTO;
@protocol GHCSearchPresenterOutput;

@interface GHCSearchPresenter : NSObject

@property (nonatomic, weak)     id<GHCSearchPresenterOutput>    output;
@property (nonatomic, strong)   GHCUserDTO                      *model;

- (void)searchUserWithLogin:(NSString *)userLogin
                       page:(NSUInteger)page;

@end

NS_ASSUME_NONNULL_END
