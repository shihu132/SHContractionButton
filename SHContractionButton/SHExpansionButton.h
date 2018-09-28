//
//  SHExpansionButton.h
//  SHContractionButton
//
//  Created by joyshow on 2018/9/28.
//  Copyright © 2018年 石虎. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SHDirectionType) {
    kSH_HorizontalDirection = 0,                         // 水平方向
    kSH_VerticalDirection,                               // 竖直方向
    
};

@class SHExpansionButton;

@protocol SHExpansionButtonDelegate <NSObject>

- (void)sh_expansionButton:(SHExpansionButton *)button clickButtonAtIndex:(int)index;

@end

@interface SHExpansionButton : UIButton

- (instancetype)initWithTitleArray:(NSArray *)titleArray delegate:(id<SHExpansionButtonDelegate>)delegate;

@property (nonatomic, assign) SHDirectionType directionType;
@property (nonatomic, strong) NSArray *titleArray;

@end
