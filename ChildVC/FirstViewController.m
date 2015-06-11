//
//  FirstViewController.m
//  ChildVC
//
//  Created by Mac-Pro on 15-3-5.
//  Copyright (c) 2015年 shy. All rights reserved.
//

#import "FirstViewController.h"
#import "FirstCell.h"

#define kFirstCell @"firstCell"
#define kScreenWidth     [UIScreen mainScreen].bounds.size.width
#define kScreenHeight    [UIScreen mainScreen].bounds.size.height


/**
 * 收缩功能
 * A.点击section进行收缩
 */
@interface FirstViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *extensionArray;//所有舒展的section

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    {
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor lightGrayColor];
        _extensionArray = [NSMutableArray array];
//        _tableView.editing = YES;
    }
    
}

#pragma mark - UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        case 1:
        {
            if ([_extensionArray containsObject:@(section)])
            {
                return 2;
            }
        }
            break;
        case 2:
        case 3:
            if ([_extensionArray containsObject:@(section)])
            {
                return 3;
            }
        default:
            if ([_extensionArray containsObject:@(section)])
            {
                return 5;
            }
            break;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    view.backgroundColor = [UIColor orangeColor];
    
    //设置数据
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth - 100, 60)];
    [btn setTitle:[NSString stringWithFormat:@"%isection",section] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor yellowColor]];
    btn.tag = section;
    [btn addTarget:self action:@selector(onTouchUpInside: withEvent:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    return view;
}

-(void)onTouchUpInside:(id)sender withEvent:(UIEvent*)event
{
    UIButton *btn = (UIButton *)sender;
    NSLog(@"btn.tag = %i",btn.tag);
    
    
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    NSLog(@"selectIndexSection = %i",indexPath.section);
    
    [self isJudeExtension:btn.tag];
    NSLog(@"%@",_extensionArray);

}

- (void)isJudeExtension:(NSInteger )section
{
    BOOL isExsit = NO;
    for (NSNumber *num in _extensionArray)
    {
        if (num.integerValue == section)
        {
            isExsit = YES;
        }
    }
    
    isExsit?[_extensionArray removeObject:@(section)]:[_extensionArray addObject:@(section)];
    [self.tableView reloadData];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FirstCell *cell = [tableView dequeueReusableCellWithIdentifier:kFirstCell];
    [cell loadData:indexPath];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row != 0;
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UITableViewDelegate
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
