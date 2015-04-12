//
//  TitleView.m
//  470Proj
//
//  Created by Justin Guarino on 4/11/15.
//  Copyright (c) 2015 SSU. All rights reserved.
//

#import "EndGameView.h"

@interface EndGameView () {
    
}

@property (nonatomic) IBOutlet UIImageView *iV;
@property (nonatomic) NSArray *images;
@property (nonatomic) UIButton *menuButton;

@end

@implementation EndGameView : UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //I'm definitely going to need to add more in-between frames to keep it from looking so cheesey... There
    //are also a few frames that need to have the background white cleaned up
    self.images = [NSArray arrayWithObjects:[UIImage imageNamed:@"earth_destr0"], [UIImage imageNamed:@"earth_destr0"],
                   [UIImage imageNamed:@"earth_destr1"], [UIImage imageNamed:@"earth_destr2"], [UIImage imageNamed:@"earth_destr3"], [UIImage imageNamed:@"earth_destr4"], [UIImage imageNamed:@"earth_destr5"], [UIImage imageNamed:@"earth_destr6"], [UIImage imageNamed:@"earth_destr7"], [UIImage imageNamed:@"earth_destr8"], [UIImage imageNamed:@"earth_destr9"], [UIImage imageNamed:@"earth_destra"], nil];
    
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
    UIImage *startButtonImage = [UIImage imageNamed:@"menubutton"];
    UIImageView *start = [[UIImageView alloc] initWithFrame:CGRectMake(110, 200, 150, 50)];
    [start setImage:startButtonImage];
    
    [self.view addSubview:start];
    
    self.menuButton = [[UIButton alloc] initWithFrame:CGRectMake(110, 200, 150, 50)];
    [self.menuButton addTarget:self action:@selector(pressedMenu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.menuButton];
}

-(void)pressedMenu
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end