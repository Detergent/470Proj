//
//  HighScoreView.m
//  470Proj
//
//  Created by Helen San on 5/2/15.
//  Copyright (c) 2015 SSU. All rights reserved.
//

#import "HighScoreView.h"


@interface HighScoreView () {
    int scoreInt;
    NSString * scoreStr;
}

@property (nonatomic) IBOutlet UITextField *tf;
@property (nonatomic) IBOutlet UIButton *scoreButton;
@property (nonatomic) UIButton *menuButton;
@property (nonatomic) IBOutlet UIButton *exit;
@property (nonatomic) UITextView *v;

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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    NSString * score = [object objectForKey:@"score"];
    NSString * username = [object objectForKey:@"username"];
    NSString * text = [username stringByAppendingString:@"      "];
    text = [text stringByAppendingString:score];
    cell.textLabel.text = text;
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
    self.v = [[UITextView alloc] initWithFrame:CGRectMake(5, 100, 365, 250)];
    self.v.backgroundColor = [UIColor blackColor];
    
    UITextView * one = [[UITextView alloc] initWithFrame:CGRectMake(30, 40, 300, 30)];
    one.backgroundColor = [UIColor blackColor];
    one.textColor = [UIColor whiteColor];
    one.font = [UIFont systemFontOfSize:20];
    one.text = @"Your time score was";
    [self.v addSubview:one];
    
    UITextView * two = [[UITextView alloc] initWithFrame:CGRectMake(30, 70, 300, 30)];
    two.backgroundColor = [UIColor blackColor];
    two.textColor = [UIColor whiteColor];
    two.font = [UIFont systemFontOfSize:20];
    two.text = scoreStr;
    [self.v addSubview:two];
    
    UITextView * three = [[UITextView alloc] initWithFrame:CGRectMake(30, 120, 300, 60)];
    three.backgroundColor = [UIColor blackColor];
    three.textColor = [UIColor whiteColor];
    three.font = [UIFont systemFontOfSize:20];
    three.text = @"Enter a username to submit your time to the highscores list:";
    [self.v addSubview:three];
    
    [self.view addSubview:self.v];
    
    self.tf = [[UITextField alloc] initWithFrame:CGRectMake(50, 300, 180, 30)];
    self.tf.backgroundColor = [UIColor whiteColor];
    self.tf.textColor = [UIColor blackColor];
    self.tf.font = [UIFont systemFontOfSize:18];
    self.tf.borderStyle = 1;
    self.tf.delegate = self;
    [self.view addSubview: self.tf];
    
    self.scoreButton = [[UIButton alloc] initWithFrame:CGRectMake(250, 300, 70, 30)];
    [self.scoreButton addTarget:self action:@selector(submitToDB) forControlEvents:UIControlEventTouchUpInside];
    self.scoreButton.backgroundColor = [UIColor orangeColor];
    [self.scoreButton setTitle:@"submit" forState:UIControlStateNormal];
    self.scoreButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:self.scoreButton];
    
    self.exit = [[UIButton alloc] initWithFrame:CGRectMake(340, 120, 20, 20)];
    [self.exit addTarget:self action:@selector(exitSubmit) forControlEvents:UIControlEventTouchUpInside];
    [self.exit setTitle:@"X" forState:UIControlStateNormal];
    self.exit.titleLabel.font = [UIFont systemFontOfSize:26];
    [self.view addSubview:self.exit];
    
    
}

-(void) exitSubmit
{
    [self.exit setAlpha: 0];
    [self.exit removeFromSuperview];
    [self.scoreButton setAlpha:0];
    [self.scoreButton removeFromSuperview];
    [self.tf setAlpha:0];
    [self.tf removeFromSuperview];
    [self.v setAlpha: 0];
    [self.v removeFromSuperview];
}

-(void) submitToDB
{
    if (scoreInt == nil || [[self.tf text] isEqualToString: @""])
        return;
    PFObject *scoreObject = [PFObject objectWithClassName:@"Highscores"];
    scoreObject[@"username"] = [self.tf text];
    scoreObject[@"scoreInt"] = @(scoreInt);
    scoreObject[@"score"] = scoreStr;
    [scoreObject saveInBackground];
    self.tf.text = @"";
    [self exitSubmit];
}


@end
