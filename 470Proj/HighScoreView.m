//
//  HighScoreView.m
//  470Proj
//
//  Created by Helen San, Brandon Mondo, Justin Guarino on 5/2/15.
//  Copyright (c) 2015 SSU. All rights reserved.
//

#import "HighScoreView.h"


@interface HighScoreView () {
    int scoreInt;
    NSString * scoreStr;
}

@property (nonatomic) UIButton *menuButton;
@property (nonatomic) UIAlertView *alert;

@end

@implementation HighScoreView

-(id) initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self) {
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = NO;
        self.objectsPerPage = 10;
        self.title = @"High Scores";
        UIView * headerView;
        headerView=[[UIView alloc]init];
        headerView.frame = CGRectMake(0,0,320,60);
        headerView.frame = CGRectMake(0,0,320,60);
        UILabel *statuslabel=[[UILabel alloc]initWithFrame:CGRectMake(10,15,320,40)];
        statuslabel.font = [UIFont boldSystemFontOfSize:30];
        statuslabel.text = @"High Scores";
        statuslabel.backgroundColor=[UIColor clearColor];
        [headerView addSubview:statuslabel];
        self.tableView.tableHeaderView = headerView;
    }
    [self animFinished];
    return self;
}

-(void) setScore: (int) time print: (NSString *) text {
    scoreInt = time;
    scoreStr = text;
    [self enterNewScore];
}

-(PFQuery *) queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:@"Highscores"];
    // if ([self.objects count] == 0) {
    //     query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    // }
    [query orderByDescending:@"scoreInt"];
    return query;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    NSString * score = [object objectForKey:@"score"];
    NSString * username = [object objectForKey:@"username"];
    cell.textLabel.text = username;
    cell.detailTextLabel.text = score;
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}

-(void)animFinished
{
    UIImage *startButtonImage = [UIImage imageNamed:@"menubutton"];
    UIImageView *start = [[UIImageView alloc] initWithFrame:CGRectMake(220, 10, 150, 50)];
    [start setImage:startButtonImage];
    
    [self.view addSubview:start];
    
    self.menuButton = [[UIButton alloc] initWithFrame:CGRectMake(220, 10, 150, 50)];
    [self.menuButton addTarget:self action:@selector(pressedMenu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.menuButton];
}

-(void)pressedMenu
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void) enterNewScore
{
    if (scoreStr != nil) {
        NSString * msg1 = [@"Your time score was " stringByAppendingString:scoreStr];
        self.alert = [[UIAlertView alloc] initWithTitle: msg1 message:@"Enter a username to submit your score to the high scores list:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Enter", nil];
        self.alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [self.alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != [alertView cancelButtonIndex]) {
        [self submitToDB];
    }
}


-(void) submitToDB
{
    UITextField *textfield =  [self.alert textFieldAtIndex: 0];
    if (scoreStr == nil || [[textfield text] isEqualToString: @""])
        return;
    PFObject *scoreObject = [PFObject objectWithClassName:@"Highscores"];
    scoreObject[@"username"] = textfield.text;
    scoreObject[@"scoreInt"] = @(scoreInt);
    scoreObject[@"score"] = scoreStr;
    [scoreObject saveInBackground];
}


@end
