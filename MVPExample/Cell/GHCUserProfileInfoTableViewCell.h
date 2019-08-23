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

@property (nonatomic, strong)   UIButton    *followersButton;
@property (nonatomic, strong)   UIButton    *followingButton;

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
             followersCounter:(NSString *)followersCounter
             followingCounter:(NSString *)followingCounter
          repositoriesCounter:(NSString *)repositoriesCounter
   starredRepositoriesCounter:(NSString *)starredRepositoriesCounter
                 forIndexPath:(NSUInteger)indexPath;

@end

NS_ASSUME_NONNULL_END
