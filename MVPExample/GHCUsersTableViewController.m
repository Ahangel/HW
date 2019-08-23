//
//  GHCUsersTableViewController.m
//  MVPExample
//
//  Created by OUT-Grigorov-KI on 23/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import "GHCUsersTableViewController.h"

@interface GHCUsersTableViewController ()

@property (nonatomic, strong) NSArray *followers;

@end

@implementation GHCUsersTableViewController


- (instancetype)initWithFollowersArray:(NSArray *)followers
{
    self = [super init];
    if (self) {
        _followers = followers;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.navigationItem.title = @"Followers";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.followers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (!cell) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
        cell.textLabel.text = self.followers[indexPath.row];
        return cell;
    }
    cell.textLabel.text = self.followers[indexPath.row];
    return cell;
}

@end
