
//
//  MPTableHeadView.m
//  tableview顶部banner上下拉伸缩
//
//  Created by plum on 17/9/9.
//  Copyright © 2017年 plum. All rights reserved.
//

#import "MPTableHeadView.h"
#import "UIViewExt.h"
#import "NSString+MK.h"

@interface MPTableHeadView ()

@end

@implementation MPTableHeadView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initView];
        
    }
    return self;
}
#pragma mark - Private
- (void)initView
{
    
    CGFloat left = 20;
    CGFloat width = self.width - left*2;
    CGFloat top = headH +20;
    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(left, top, width, 0)];
    NSString *str = @"当一个app启动后,代码区,常量区,全局区大小都是已经固定的,因此指向这些区的指针不会产生崩溃性的错误,而堆区和栈区是时时刻刻变化的(堆得创建和销毁,栈的弹入和弹出),所以当使用一个指针指向这个2区里面内存的时候,一定要注意内存是否已经被释放,否则会产生程序崩溃(即野指针报错)";
    
    contentLabel.attributedText = [str strWithLineSpace:4.0];
    contentLabel.numberOfLines = 0;
    contentLabel.font = [UIFont systemFontOfSize:16];
    contentLabel.textColor = [UIColor blackColor];
    [self addSubview:contentLabel];
    
    [contentLabel sizeToFit];
    
    self.height = contentLabel.bottom +50;
    
}
#pragma mark - Getter

#pragma mark - Setter
@end
