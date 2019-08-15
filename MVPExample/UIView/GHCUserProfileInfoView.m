//
//  GHCUserProfileInfoView.m
//  MVPExample
//
//  Created by OUT-Grigorov-KI on 15/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import "GHCUserProfileInfoView.h"

@interface GHCUserProfileInfoView ()

@property (nonatomic, strong) UIImageView   *userProfileImage;
@property (nonatomic, strong) UILabel       *userNameLabel;
@property (nonatomic, strong) UILabel       *userLoginLabel;
@property (nonatomic, strong) UIView        *containerView;

@end

@implementation GHCUserProfileInfoView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    
    self.userProfileInfo = [UIStackView new];
    [self createUserProfileImage];
    [self createUserNameLabel];
    [self createUserLoginLabel];
    [self addSubview:self.userProfileInfo];
    
    [self.userProfileInfo setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.userProfileInfo.axis = UILayoutConstraintAxisVertical;
    self.userProfileInfo.distribution = UIStackViewDistributionEqualSpacing;
    self.userProfileInfo.alignment = UIStackViewAlignmentCenter;
    self.userProfileInfo.spacing = 10;
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.userProfileInfo.topAnchor       constraintEqualToAnchor:self.topAnchor],
                                              [self.userProfileInfo.leadingAnchor   constraintEqualToAnchor:self.leadingAnchor],
                                              [self.userProfileInfo.trailingAnchor  constraintEqualToAnchor:self.trailingAnchor],
                                              [self.userProfileInfo.bottomAnchor    constraintLessThanOrEqualToAnchor:self.bottomAnchor]
                                              ]];
    
}

- (void)createUserNameLabel {
    
    self.userNameLabel = [UILabel new];
    self.userNameLabel.text = @"Bill Gates";
    self.userNameLabel.backgroundColor = UIColor.clearColor;
    self.userNameLabel.font = [UIFont systemFontOfSize:20];
    [self.userNameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.userProfileInfo addArrangedSubview:self.userNameLabel];
    
    [self.userNameLabel.centerXAnchor constraintEqualToAnchor:self.userProfileInfo.centerXAnchor].active = YES;
    [self.userNameLabel.heightAnchor constraintEqualToConstant:30].active = YES;

}

- (void)createUserLoginLabel {
    
    self.userLoginLabel = [UILabel new];
    self.userLoginLabel.text = @"iwannaflywithyou";
    self.userLoginLabel.backgroundColor = UIColor.clearColor;
    [self.userLoginLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.userProfileInfo addArrangedSubview:self.userLoginLabel];
    [self.userLoginLabel.centerXAnchor constraintEqualToAnchor:self.userProfileInfo.centerXAnchor].active = YES;
}

- (void)createUserProfileImage {
    
    [self createContainerView];
    
    self.userProfileImage = [UIImageView new];
    [self.userProfileImage setImage:[UIImage imageNamed:@"267px-Bill_Gates_2018"]];
    [self.containerView addSubview:self.userProfileImage];
    self.userProfileImage.layer.masksToBounds = YES;
    self.userProfileImage.layer.cornerRadius = 90;
    self.userProfileImage.layer.borderColor = UIColor.darkGrayColor.CGColor;
    self.userProfileImage.layer.borderWidth = 3;
    self.userProfileImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.userProfileImage setTranslatesAutoresizingMaskIntoConstraints:NO];

    [self.userProfileImage.centerXAnchor    constraintEqualToAnchor:self.containerView.centerXAnchor].active = YES;
    [self.userProfileImage.centerYAnchor    constraintEqualToAnchor:self.containerView.centerYAnchor].active = YES;
    [self.userProfileImage.heightAnchor     constraintEqualToConstant:180].active = YES;
    [self.userProfileImage.widthAnchor      constraintEqualToConstant:180].active = YES;
}

- (void)createContainerView {
    
    self.containerView = [UIView new];
    [self.userProfileInfo addArrangedSubview:self.containerView];
    [self.containerView.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [self.containerView.layer setShadowRadius:4.0f];
    [self.containerView.layer setShadowOffset:CGSizeMake(0, -3)];
    [self.containerView.layer setShadowOpacity:0.5f];
    [self.containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.containerView.centerXAnchor constraintEqualToAnchor:self.userProfileInfo.centerXAnchor].active = YES;
    [self.containerView.topAnchor constraintEqualToAnchor:self.userProfileInfo.topAnchor].active = YES;
    [self.containerView.heightAnchor constraintEqualToConstant:180].active = YES;
    [self.containerView.widthAnchor constraintEqualToConstant:180].active = YES;
}

@end
