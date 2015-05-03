//
//  TitleView.m
//  470Proj
//
//  Created by Justin Guarino on 4/11/15.
//  Copyright (c) 2015 SSU. All rights reserved.
//

#import "EndGameView.h"
#import "HighScoreView.h"

@interface EndGameView () {
    int scoreInt;
    NSString * scoreStr;
}

@property (nonatomic) IBOutlet UIImageView *iV;
@property (nonatomic) NSArray *images;
//@property (nonatomic) UIButton *menuButton;
@property (nonatomic) IBOutlet UITextField *tf;
@property (nonatomic) IBOutlet UIButton *scoreButton;


@end

@implementation EndGameView : UIViewController

-(id) initWithScore: (int) score print: (NSString *) text
{
    if( (self = [super init]) == nil )
        return nil;
    scoreInt = score;
    scoreStr = text;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *backgroundImage = [UIImage imageNamed:@"background"];
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 400, 700)];
    [backgroundView setImage:backgroundImage];
    [self.view addSubview:backgroundView];
    
    self.images = [NSArray arrayWithObjects:[UIImage imageNamed:@"earth_destr0"], [UIImage imageNamed:@"earth_destr0"],
                   [UIImage imageNamed:@"earth_destr1"], [UIImage imageNamed:@"earth_destr2"], [UIImage imageNamed:@"earth_destr3"], [UIImage imageNamed:@"earth_destr4"], [UIImage imageNamed:@"earth_destr5"], [UIImage imageNamed:@"earth_destr6"], [UIImage imageNamed:@"earth_destr7"], [UIImage imageNamed:@"earth_destr8"], [UIImage imageNamed:@"earth_destr9"], [UIImage imageNamed:@"earth_destra"], [UIImage imageNamed:@"earth_destrb"], [UIImage imageNamed:@"earth_destrc"], [UIImage imageNamed:@"earth_destrd"], [UIImage imageNamed:@"earth_destre"], [UIImage imageNamed:@"earth_destrf"], [UIImage imageNamed:@"earth_destrg"], nil];
    
    UIImageView *animView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 400, 700)];
    animView.animationImages=self.images;
    animView.animationDuration=2;
    animView.animationRepeatCount=1;
    [animView startAnimating];
    
    
    [self.view addSubview:animView];
    [self performSelector:@selector(animFinished) withObject:nil
               afterDelay:animView.animationDuration];
    
}




-(void)animFinished
{
    HighScoreView *highscoreView = [[HighScoreView alloc] init];
    [highscoreView setScore: scoreInt print:scoreStr];
    [self.navigationController pushViewController:highscoreView animated:YES];
    /*UIImage *startButtonImage = [UIImage imageNamed:@"menubutton"];
    UIImageView *start = [[UIImageView alloc] initWithFrame:CGRectMake(110, 200, 150, 50)];
    [start setImage:startButtonImage];
    
    [self.view addSubview:start];
    
    self.menuButton = [[UIButton alloc] initWithFrame:CGRectMake(110, 200, 150, 50)];
    [self.menuButton addTarget:self action:@selector(pressedMenu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.menuButton];*/
}
/*
-(void)pressedMenu
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end