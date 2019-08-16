//
//  GHCUserProfileInfoTableViewCell.m
//  MVPExample
//
//  Created by Кирилл Григоров on 16/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import "GHCUserProfileInfoTableViewCell.h"

@interface GHCUserProfileInfoTableViewCell ()

@property (nonatomic, strong)   UIButton    *followersButton;
@property (nonatomic, strong)   UIButton    *followingButton;
@property (nonatomic, strong)   UILabel     *repositoriesLabel;
@property (nonatomic, strong)   UILabel     *starredRepositoriesLabel;
@property (nonatomic, copy)     NSString    *followersCounter;
@property (nonatomic, copy)     NSString    *followingCounter;
@property (nonatomic, copy)     NSString    *repositoriesCounter;
@property (nonatomic, copy)     NSString    *starredRepositoriesCounter;

@end

@implementation GHCUserProfileInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
             followersCounter:(NSString *)followersCounter
             followingCounter:(NSString *)followingCounter
          repositoriesCounter:(NSString *)repositoriesCounter
   starredRepositoriesCounter:(NSString *)starredRepositoriesCounter
                 forIndexPath:(NSUInteger)indexPath
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self && indexPath == 0) {
        
        _followersCounter = followersCounter;
        _followingCounter = followingCounter;
        
        [self setupFollowersButton];
        [self setupFollowingButton];
        return self;
        
    } else if (self && indexPath == 1) {
        _repositoriesCounter = repositoriesCounter;
        [self setupRepositoriesLabel];
        return self;
        
    } else if (self && indexPath == 2) {
        _starredRepositoriesCounter = starredRepositoriesCounter;
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
    [self.followersButton setTitle:[NSString stringWithFormat:@"%@ Followers", self.followersCounter] forState:UIControlStateNormal];
    self.followersButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.followersButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    self.followersButton.backgroundColor = UIColor.clearColor;
    self.followersButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [self.followersButton.leftAnchor      constraintEqualToAnchor:self.contentView.leftAnchor],
                                              [self.followersButton.rightAnchor     constraintEqualToAnchor:self.contentView.centerXAnchor],
                                              [self.followersButton.centerYAnchor   constraintEqualToAnchor:self.contentView.centerYAnchor],
                                              ]];
    
}

- (void)setupFollowingButton {
    
    self.followingButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.contentView addSubview:self.followingButton];
    [self.followingButton setTitle:[NSString stringWithFormat:@"%@ Following", self.followingCounter] forState:UIControlStateNormal];
    self.followingButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.followingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.followingButton.backgroundColor = UIColor.clearColor;
    self.followingButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [self.followingButton.leftAnchor      constraintEqualToAnchor:self.contentView.centerXAnchor],
                                              [self.followingButton.rightAnchor     constraintEqualToAnchor:self.contentView.rightAnchor],
                                              [self.followingButton.centerYAnchor   constraintEqualToAnchor:self.contentView.centerYAnchor],
                                              [self.followingButton.heightAnchor    constraintEqualToConstant:60],
                                              ]];

}

- (void)setupRepositoriesLabel {
    
    self.repositoriesLabel = [UILabel new];
    [self.contentView addSubview:self.repositoriesLabel];
    self.repositoriesLabel.text = [NSString stringWithFormat:@"%@ Repositories", self.repositoriesCounter];
    self.repositoriesLabel.backgroundColor = UIColor.clearColor;
    self.repositoriesLabel.font = [UIFont systemFontOfSize:18];
    self.repositoriesLabel.textAlignment = NSTextAlignmentCenter;
    self.repositoriesLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [self.repositoriesLabel.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
                                              [self.repositoriesLabel.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor],
                                              [self.repositoriesLabel.heightAnchor  constraintEqualToConstant:80],
                                              [self.repositoriesLabel.leftAnchor    constraintEqualToAnchor:self.contentView.leftAnchor],
                                              [self.repositoriesLabel.rightAnchor   constraintEqualToAnchor:self.contentView.rightAnchor]
                                              ]];
}

- (void)setupStarredRepositories {
    
    self.starredRepositoriesLabel = [UILabel new];
    [self.contentView addSubview:self.starredRepositoriesLabel];
    self.starredRepositoriesLabel.text = [NSString stringWithFormat:@"%@ Starred Repositories", self.starredRepositoriesCounter];
    self.starredRepositoriesLabel.backgroundColor = UIColor.clearColor;
    self.starredRepositoriesLabel.font = [UIFont systemFontOfSize:18];
    self.starredRepositoriesLabel.textAlignment = NSTextAlignmentCenter;
    self.starredRepositoriesLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [self.starredRepositoriesLabel.centerYAnchor  constraintEqualToAnchor:self.contentView.centerYAnchor],
                                              [self.starredRepositoriesLabel.centerXAnchor  constraintEqualToAnchor:self.contentView.centerXAnchor],
                                              [self.starredRepositoriesLabel.heightAnchor   constraintEqualToConstant:80],
                                              [self.starredRepositoriesLabel.leftAnchor     constraintEqualToAnchor:self.contentView.leftAnchor],
                                              [self.starredRepositoriesLabel.rightAnchor    constraintEqualToAnchor:self.contentView.rightAnchor]
                                              ]];
}

@end
