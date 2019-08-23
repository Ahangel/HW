//
//  GHCUsersTableViewController.h
//  MVPExample
//
//  Created by OUT-Grigorov-KI on 23/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHCUsersTableViewController : UITableViewController

- (instancetype)initWithFollowersArray:(NSArray *)followers;

@end

NS_ASSUME_NONNULL_END
