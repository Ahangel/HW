//
//  GHCSearchViewController.h
//  MVPExample
//
//  Created by Кирилл Григоров on 18/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHCSearchPresenterOutput.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHCSearchViewController : UIViewController <UITableViewDelegate, GHCSearchPresenterOutput, UITableViewDataSource, UISearchBarDelegate>

@end

NS_ASSUME_NONNULL_END
