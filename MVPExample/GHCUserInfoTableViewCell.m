//
//  GHCUserInfoTableViewCell.m
//  MVPExample
//
//  Created by OUT-Grigorov-KI on 11/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import "GHCUserInfoTableViewCell.h"

@implementation GHCUserInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

#pragma mark - Setup Views

- (void)setupViews {
    [self setupForksCounterLabel];
    [self setupStarsCounterLabel];
}

- (void)setupStarsCounterLabel {
    
    self.starsCounterLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.starsCounterLabel];
    
    self.starsCounterLabel.backgroundColor = UIColor.clearColor;
    self.starsCounterLabel.textAlignment = NSTextAlignmentLeft;
    self.starsCounterLabel.font = [UIFont systemFontOfSize:13];
    [self.starsCounterLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.starsCounterLabel.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor constant:80],
                                              [self.starsCounterLabel.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
                                              [self.starsCounterLabel.heightAnchor  constraintEqualToConstant:40],
                                              [self.starsCounterLabel.widthAnchor   constraintEqualToConstant:60]
                                              ]];
}

- (void)setupForksCounterLabel {
    
    self.forksCounterLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.forksCounterLabel];
    
    self.forksCounterLabel.backgroundColor = UIColor.clearColor;
    self.forksCounterLabel.textAlignment = NSTextAlignmentLeft;
    self.forksCounterLabel.font = [UIFont systemFontOfSize:13];
    [self.forksCounterLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.forksCounterLabel.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor constant:150],
                                              [self.forksCounterLabel.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
                                              [self.forksCounterLabel.heightAnchor  constraintEqualToConstant:40],
                                              [self.forksCounterLabel.widthAnchor   constraintEqualToConstant:60]
                                              ]];
}

@end
