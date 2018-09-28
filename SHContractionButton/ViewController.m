//
//  ViewController.m
//  SHContractionButton
//
//  Created by joyshow on 2018/9/28.
//  Copyright © 2018年 石虎. All rights reserved.
//

#import "ViewController.h"
#import "SHExpansionButton.h"

@interface ViewController ()<SHExpansionButtonDelegate>
{
    NSArray             *_titleArray;
    BOOL                 _isHorizontal;
    SHExpansionButton   *_sh_expansionButton;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addSh_expansionButton];
}

- (void)addSh_expansionButton{
    
    _isHorizontal = NO;
    _titleArray = @[@"红色",@"蓝色",@"绿色",@"黄色",@"紫色"];
    _sh_expansionButton = [[SHExpansionButton alloc]initWithTitleArray:_titleArray delegate:self];
    
    _sh_expansionButton.frame = CGRectMake(20, 150, 70, 40);
    _sh_expansionButton.titleArray = _titleArray;
    [_sh_expansionButton setTitle:@"红色" forState:UIControlStateNormal];
    _sh_expansionButton.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_sh_expansionButton];
}

#pragma mark - <SHExpansionButtonDelegate>
- (void)sh_expansionButton:(SHExpansionButton *)button clickButtonAtIndex:(int)index{
    
    NSArray *colorArray = @[[UIColor redColor],[UIColor blueColor],[UIColor greenColor],[UIColor yellowColor],[UIColor purpleColor]];
    self.view.backgroundColor = colorArray[index];
    [button setTitle:_titleArray[index] forState:UIControlStateNormal];
    
}

- (IBAction)changeDirection:(UIButton *)sender {//改变方向
    if (_isHorizontal == YES) {
        _sh_expansionButton.directionType = kSH_HorizontalDirection;
    }else{
        _sh_expansionButton.directionType = kSH_VerticalDirection;
    }
    _isHorizontal = !_isHorizontal;
}

@end
