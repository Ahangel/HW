//
//  GHCSearchPresenterOutput.h
//  MVPExample
//
//  Created by Кирилл Григоров on 18/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class GHCUserDTO;

@protocol GHCSearchPresenterOutput <NSObject>

- (void)searchComplete:(NSArray *)users;
- (void)showErrorWith:(NSString *)title message:(NSString *)message;
- (void)addingToSearchResult:(NSArray *)users;

@end

NS_ASSUME_NONNULL_END
