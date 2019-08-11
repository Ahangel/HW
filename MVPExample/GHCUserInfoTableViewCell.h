//
//  GHCUserInfoTableViewCell.h
//  MVPExample
//
//  Created by OUT-Grigorov-KI on 11/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHCUserInfoTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *starsCounterLabel;
@property (nonatomic, strong) UILabel *forksCounterLabel;

@end

NS_ASSUME_NONNULL_END
