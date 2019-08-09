//
//  UserInfoTableViewController.h
//  MVPExample
//
//  Created by OUT-Grigorov-KI on 08/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHCUserInfoTableViewController : UITableViewController

- (instancetype)initWithUserName:(NSString *)userName userRepo:(NSArray *)repos;

@end

NS_ASSUME_NONNULL_END
