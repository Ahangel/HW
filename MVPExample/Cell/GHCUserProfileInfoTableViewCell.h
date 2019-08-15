//
//  GHCUserProfileInfoTableViewCell.h
//  MVPExample
//
//  Created by Кирилл Григоров on 16/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHCUserProfileInfoTableViewCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                 forIndexPath:(NSUInteger)indexPath;

@end

NS_ASSUME_NONNULL_END
