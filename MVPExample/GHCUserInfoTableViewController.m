//
//  UserInfoTableViewController.m
//  MVPExample
//
//  Created by OUT-Grigorov-KI on 08/08/2019.
//  Copyright © 2019 Evgeny Shishko. All rights reserved.
//

#import "GHCUserInfoTableViewController.h"

@interface GHCUserInfoTableViewController ()

@property (nonatomic, copy) NSString                *userName;
@property (nonatomic, copy) NSArray<GHCRepoDTO *>   *repos;

@end

@implementation GHCUserInfoTableViewController

- (instancetype)initWithUserName:(NSString *)userName userRepo:(NSArray<GHCRepoDTO *>*)repos{
    self = [super init];
    if (self) {
        _userName = [userName copy];
        _repos = [repos copy];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[GHCUserInfoTableViewCell class] forCellReuseIdentifier:@"Cell"];
    
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
    
    if (indexPath.section == 0)
    {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellName"];
        cell.textLabel.text = self.userName;
        return cell;
    }
    else {
        GHCUserInfoTableViewCell *cell = [[GHCUserInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        GHCRepoDTO *repo = self.repos[indexPath.row];
        cell.textLabel.text = repo.repoName;
        cell.detailTextLabel.text = repo.language;
        cell.starsCounterLabel.text = [NSString stringWithFormat:@"Stars: %@", repo.stargazerCounter];
        cell.forksCounterLabel.text = [NSString stringWithFormat:@"Forks: %@", repo.forksCounter];
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = UIColor.grayColor;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

@end
