//
//  GHCUserProfileInfoTableViewCell.m
//  MVPExample
//
//  Created by Кирилл Григоров on 16/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import "GHCUserProfileInfoTableViewCell.h"

@interface GHCUserProfileInfoTableViewCell ()

@property (nonatomic, strong) UIButton  *followersButton;
@property (nonatomic, strong) UIButton  *followingButton;
@property (nonatomic, strong) UILabel   *repositoriesLabel;
@property (nonatomic, strong) UILabel   *starredRepositoriesLabel;

@end

@implementation GHCUserProfileInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                         forIndexPath:(NSUInteger)indexPath
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self && indexPath == 0) {
        [self setupFollowersButton];
        [self setupFollowingButton];
        return self;
    } else if (self && indexPath == 1) {
        [self setupRepositoriesLabel];
        return self;
    } else if (self && indexPath == 2) {
        [self setupStarredRepositories];
        return self;
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
    
    self.followersButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.contentView addSubview:self.followersButton];
    [self.followersButton setTitle:@"Followers" forState:UIControlStateNormal];
    self.followersButton.titleLabel.font = [UIFont systemFontOfSize:18];
    self.followersButton.backgroundColor = UIColor.grayColor;
    self.followersButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [self.followersButton.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor constant:-90],
                                              [self.followersButton.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
                                              [self.followersButton.heightAnchor constraintEqualToConstant:60],
                                              [self.followersButton.widthAnchor constraintEqualToConstant:160]
                                              ]];
    
}

- (void)setupFollowingButton {
    
    self.followingButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.contentView addSubview:self.followingButton];
    [self.followingButton setTitle:@"Following" forState:UIControlStateNormal];
    self.followingButton.titleLabel.font = [UIFont systemFontOfSize:18];
    self.followingButton.backgroundColor = UIColor.grayColor;
    self.followingButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [self.followingButton.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor constant:100],
                                              [self.followingButton.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
                                              [self.followingButton.heightAnchor constraintEqualToConstant:60],
                                              [self.followingButton.widthAnchor constraintEqualToConstant:160]
                                              ]];

}

- (void)setupRepositoriesLabel {
    
    self.repositoriesLabel = [UILabel new];
    [self.contentView addSubview:self.repositoriesLabel];
    self.repositoriesLabel.text = @"Repositories";
    self.repositoriesLabel.backgroundColor = UIColor.grayColor;
    self.repositoriesLabel.font = [UIFont systemFontOfSize:18];
    self.repositoriesLabel.textAlignment = NSTextAlignmentCenter;
    self.repositoriesLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [self.repositoriesLabel.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
                                              [self.repositoriesLabel.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor],
                                              [self.repositoriesLabel.heightAnchor constraintEqualToConstant:80],
                                              [self.repositoriesLabel.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor],
                                              [self.repositoriesLabel.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor]
                                              ]];
}

- (void)setupStarredRepositories {
    
    self.starredRepositoriesLabel = [UILabel new];
    [self.contentView addSubview:self.starredRepositoriesLabel];
    self.starredRepositoriesLabel.text = @"Starred Repositories";
    self.starredRepositoriesLabel.backgroundColor = UIColor.grayColor;
    self.starredRepositoriesLabel.font = [UIFont systemFontOfSize:18];
    self.starredRepositoriesLabel.textAlignment = NSTextAlignmentCenter;
    self.starredRepositoriesLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [self.starredRepositoriesLabel.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
                                              [self.starredRepositoriesLabel.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor],
                                              [self.starredRepositoriesLabel.heightAnchor constraintEqualToConstant:80],
                                              [self.starredRepositoriesLabel.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor],
                                              [self.starredRepositoriesLabel.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor]
                                              ]];
}

@end
