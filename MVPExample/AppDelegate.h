//
//  AppDelegate.h
//  MVPExample
//
//  Created by Evgeny Shishko on 01/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GHCUserProfileViewController;

@class GHCLoginViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow                      *window;
@property (nonatomic, strong) GHCUserProfileViewController  *userInfoVC;

@end

