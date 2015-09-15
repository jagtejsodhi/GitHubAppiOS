//
//  RepoResultsViewController.m
//  GithubDemo
//
//  Created by Nicholas Aiwazian on 9/15/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "RepoResultsViewController.h"
#import "MBProgressHUD.h"
#import "GithubRepo.h"
#import "GithubRepoSearchSettings.h"
#import "RepoResultsTableViewCell.h"
#import "UIImageView+AFNetworking.h"


@interface RepoResultsViewController ()
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) GithubRepoSearchSettings *searchSettings;
@property (weak, nonatomic) IBOutlet UITableView *repoResultsTableView;
@property (nonatomic, strong) NSArray *gitRepos;
@end

@implementation RepoResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchSettings = [[GithubRepoSearchSettings alloc] init];
    
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    [self.searchBar sizeToFit];
    self.navigationItem.titleView = self.searchBar;
    
    self.repoResultsTableView.delegate = self;
    self.repoResultsTableView.dataSource = self;
    
    [self doSearch];
}

- (void)doSearch {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [GithubRepo fetchRepos:self.searchSettings successCallback:^(NSArray *repos) {
        self.gitRepos = repos;
        for (GithubRepo *repo in repos) {
            NSLog(@"%@", [NSString stringWithFormat:
                   @"Name:%@\n\tStars:%ld\n\tForks:%ld,Owner:%@\n\tAvatar:%@\n\tDescription:%@",
                          repo.name,
                          repo.stars,
                          repo.forks,
                          repo.ownerHandle,
                          repo.ownerAvatarURL,
                          repo.repoDescription
                   ]);
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        [self.repoResultsTableView reloadData];
    }];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [self.searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    [self.searchBar setShowsCancelButton:NO animated:YES];
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = @"";
    [searchBar resignFirstResponder];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.searchSettings.searchString = searchBar.text;
    [searchBar resignFirstResponder];
    [self doSearch];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.gitRepos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RepoResultsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"com.jagtej.sodhi.reporesultscell" forIndexPath:indexPath];
    
    //setup cell items here
    cell.name.text = [self.gitRepos[indexPath.row] name];
    cell.owner.text = [self.gitRepos[indexPath.row] ownerHandle];
    cell.repoDescription.text = [self.gitRepos[indexPath.row] repoDescription];
    
    NSURL* avatarUrl = [NSURL URLWithString:[self.gitRepos[indexPath.row] ownerAvatarURL]];
    [cell.ownerAvatar setImageWithURL:avatarUrl];
    
    cell.starCount.text = [NSString stringWithFormat:@"%ld", [self.gitRepos[indexPath.row] stars]];
    cell.forkCount.text = [NSString stringWithFormat:@"%ld", [self.gitRepos[indexPath.row] forks]];
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
