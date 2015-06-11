//
//  ViewController.m
//  ChildVC
//
//  Created by Mac-Pro on 15-3-5.
//  Copyright (c) 2015年 shy. All rights reserved.
//

#import "ViewController.h"

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "NaviViewController.h"

#define kFirstVC    @"first_VC"
#define kSecondVC   @"second_VC"
#define kThirdVC    @"third_VC"
#define kFouthVaVC  @"nav_VC"

#define kFourthVC   @"fourth_VC"


@interface ViewController ()
{
    
}

@property (strong, nonatomic) IBOutlet UIView *containView;

@property (strong, nonatomic) IBOutlet UISegmentedControl *selectSegmtControl;

@property (strong, nonatomic) FirstViewController *firstVC;
@property (strong, nonatomic) SecondViewController *secondVC;
@property (strong, nonatomic) ThirdViewController *thirdVC;
@property (strong, nonatomic) NaviViewController *navc;

@property (strong, nonatomic) FourthViewController *fourthVC;

@property (strong, nonatomic) UIViewController *currentVC;

@property (strong, nonatomic) NSMutableArray *vcsArray;

- (IBAction)changSeg:(UISegmentedControl *)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    {
        _vcsArray = [NSMutableArray array];
        
        _firstVC = [self.storyboard instantiateViewControllerWithIdentifier:kFirstVC];
        _secondVC = [self.storyboard instantiateViewControllerWithIdentifier:kSecondVC];
        _thirdVC = [self.storyboard instantiateViewControllerWithIdentifier:kThirdVC];
        
        _navc = [self.storyboard instantiateViewControllerWithIdentifier:kFouthVaVC];
        
        _fourthVC = [self.storyboard instantiateViewControllerWithIdentifier:kFourthVC];
        
        [_vcsArray addObjectsFromArray:@[_firstVC,_secondVC,_thirdVC,_navc]];
        
        [self addChildViewController:_firstVC];
        [self addChildViewController:_secondVC];
        [self addChildViewController:_thirdVC];
        _currentVC = _firstVC;
        
        //1
        [self.containView addSubview:_firstVC.view];
    }
}

- (void)swapFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController
{
    //removeFromParentViewController在移除child前不会调用willMoveToParentViewController，所以要显示调用
    //2
    [fromViewController willMoveToParentViewController:nil];
    
    [self addChildViewController:toViewController];
    [self transitionFromViewController:fromViewController
                      toViewController:toViewController
                              duration:0
                            options:UIViewAnimationOptionTransitionCrossDissolve animations:nil
                            completion:^(BOOL finished) {
                              [fromViewController removeFromParentViewController];
                               //addChildViewController 不会调用didMoveToParentViewController，所以要显示调用
                                //3
                               [toViewController didMoveToParentViewController:self];
                                
                                self.currentVC = toViewController;
    }];
}



#pragma mark - SystomMethod
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changSeg:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex) {
        case 0:
        {
            _firstVC.view.frame = self.containView.bounds;
            [self swapFromViewController:self.currentVC toViewController:_firstVC];
        }
            break;
        case 1:
        {
            _secondVC.view.frame = self.containView.bounds;
            [self swapFromViewController:self.currentVC toViewController:_secondVC];
        }
            break;
        case 2:
        {
            _thirdVC.view.frame = self.containView.bounds;
            [self swapFromViewController:self.currentVC toViewController:_thirdVC];
        }
            break;
        case 3:
        {
            _navc.view.frame = self.containView.bounds;
            [self swapFromViewController:self.currentVC toViewController:_navc];
        }
            break;
        default:
            break;
    }
}


@end
