//
//  GHCUserProfileViewController.h
//  MVPExample
//
//  Created by OUT-Grigorov-KI on 15/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHCUserProfilePresenterOutput.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHCUserProfileViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, GHCUserProfilePresenterOutput>

- (instancetype)initWithDictionary:(NSDictionary *)userDict;

@end

NS_ASSUME_NONNULL_END
