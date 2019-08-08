//
//  UserInfoTableViewController.m
//  MVPExample
//
//  Created by OUT-Grigorov-KI on 08/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import "UserInfoTableViewController.h"

@interface UserInfoTableViewController ()

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSArray *repos;

@end

@implementation UserInfoTableViewController

- (instancetype)initWithUserName:(NSString *)userName userRepo:(NSArray *)repos{
    self = [super init];
    if (self) {
        _userName = [userName copy];
        _repos = [repos copy];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
    {
        return 1;
    }
    return self.repos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    if (indexPath.section == 0)
    {
        cell.textLabel.text = self.userName;
    }
    else {
        cell.textLabel.text = self.repos[indexPath.row];
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = UIColor.grayColor;
    return view;
}

@end
