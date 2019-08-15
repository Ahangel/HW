//
//  GHCUserInfoTableViewCell.m
//  MVPExample
//
//  Created by OUT-Grigorov-KI on 15/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import "GHCUserProfileInfoTableViewCell.h"

@interface GHCUserProfileInfoTableViewCell ()

@property (nonatomic, strong) UIButton  *followersButton;
@property (nonatomic, strong) UIButton  *followingButton;
@property (nonatomic, strong) UILabel   *repositoriesLabel;
@property (nonatomic, strong) UILabel   *starredRepositories;

@end

@implementation GHCUserProfileInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    [self setupFollowersButton];
    [self setupFollowingButton];
    [self setupRepositoriesLabel];
    [self setupStarredRepositories];
}

- (void)setupFollowersButton {
    
    
}

- (void)setupFollowingButton {
    
}

- (void)setupRepositoriesLabel {
    
}

- (void)setupStarredRepositories {
    
}

@end
