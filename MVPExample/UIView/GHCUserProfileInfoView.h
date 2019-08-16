//
//  GHCUserProfileInfoView.h
//  MVPExample
//
//  Created by OUT-Grigorov-KI on 15/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHCUserProfileInfoView : UIView

@property (nonatomic, strong) UIStackView   *userProfileInfo;

- (instancetype)initWithUserName:(NSString *)userName
                       userLogin:(NSString *)userLogin
                       userImage:(UIImage *)userImage;

@end

NS_ASSUME_NONNULL_END
