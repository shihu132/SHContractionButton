//
//  SHExpansionButton.m
//  SHContractionButton
//
//  Created by joyshow on 2018/9/28.
//  Copyright © 2018年 石虎. All rights reserved.
//

#import "SHExpansionButton.h"


#define INTERVAL  5 //修改button之间的间隔
#define JSWeak(var, weakVar) __weak __typeof(&*var) weakVar = var
#define JSStrong_DoNotCheckNil(weakVar, _var) __typeof(&*weakVar) _var = weakVar
#define JSWeakSelf      JSWeak(self, __weakSelf);

@interface SHExpansionButton ()

@property (nonatomic,strong) NSMutableArray *buttonArray;
@property (nonatomic,assign) NSInteger buttonCount;
@property (nonatomic,assign) id<SHExpansionButtonDelegate> delegate;
@end

@implementation SHExpansionButton

- (instancetype)initWithTitleArray:(NSArray *)titleArray delegate:(id<SHExpansionButtonDelegate>)delegate{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        self.buttonCount = titleArray.count;
        self.delegate = delegate;
        self.titleArray = titleArray;
        [self loadSubview];
        
        [self addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)loadSubview{//创建子button
    
    _buttonArray = [[NSMutableArray alloc] initWithCapacity:_buttonCount];
    for (int i = 0; i<_buttonCount; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectZero;
        button.tag = i;
        
        [button addTarget:self action:@selector(subButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.hidden = YES;
        [_buttonArray addObject:button];
    }
}

- (void)buttonClick{
    
    for (int i = 0; i<_buttonCount; i++) {//初始化子button的位置。
        UIButton *but = [_buttonArray objectAtIndex:i];
        [self.superview addSubview:but];
        but.hidden = NO;
        but.frame = self.frame;
    }
    JSWeakSelf
    [UIView animateWithDuration:0.5 animations:^{//开始展开动画
        for (int i = 0; i<__weakSelf.buttonCount; i++) {
            UIButton *but = [__weakSelf.buttonArray objectAtIndex:i];
            
            [but setTitle:__weakSelf.titleArray[i] forState:UIControlStateNormal];
            //--------------- 可修改button字体颜色 ---------------
            //[but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            
            if (self.directionType == kSH_HorizontalDirection) {
                but.frame = CGRectMake(self.frame.origin.x+i*(INTERVAL+self.frame.size.width), self.frame.origin.y, self.frame.size.width, self.frame.size.height);
            }else{
                but.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y+i*(INTERVAL+self.frame.size.height), self.frame.size.width, self.frame.size.height);
            }
            
        }
    }];
    
}

- (void)subButtonClick:(UIButton *)sender{
    
    JSWeakSelf
    [UIView animateWithDuration:0.5 animations:^{//收起动画
        for (int i = 0; i<__weakSelf.buttonCount; i++) {
            UIButton *but = [__weakSelf.buttonArray objectAtIndex:i];
            but.frame = self.frame;
        }
    } completion:^(BOOL finished) {
        for (int i = 0; i<__weakSelf.buttonCount; i++) {
            UIButton *but = [__weakSelf.buttonArray objectAtIndex:i];
            but.hidden = YES;
            [but removeFromSuperview];
        }
    }];
    
    //调用delegate方法
    [_delegate sh_expansionButton:self clickButtonAtIndex:(int)sender.tag];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
    for (UIButton *but in _buttonArray) {
        but.backgroundColor = backgroundColor;
    }
}

@end
