//
//  RepoResultsTableViewCell.h
//  GithubDemo
//
//  Created by Jagtej Sodhi on 9/15/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RepoResultsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *owner;
@property (weak, nonatomic) IBOutlet UIImageView *ownerAvatar;
@property (weak, nonatomic) IBOutlet UILabel *starCount;
@property (weak, nonatomic) IBOutlet UILabel *forkCount;
@property (weak, nonatomic) IBOutlet UILabel *repoDescription;

@end
