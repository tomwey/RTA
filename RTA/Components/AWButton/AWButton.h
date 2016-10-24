//
//  AWButton.h
//  RTA
//
//  Created by tangwei1 on 16/10/24.
//  Copyright © 2016年 tomwey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AWButton : UIView

// 默认为NO
@property (nonatomic, assign) BOOL outline;

// 圆角大小，默认为6
@property (nonatomic, assign) CGFloat cornerRadius;

// 按钮是否可以点击，默认为YES
@property (nonatomic, assign) BOOL enabled;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSDictionary *titleAttributes;

- (instancetype)initWithTitle:(NSString *)title color:(UIColor *)bgColor;
+ (instancetype)buttonWithTitle:(NSString *)title color:(UIColor *)bgColor;

/**
 * 注意：参数target不会被强引用
 */
- (void)addTarget:(id)target forAction:(SEL)action;

@end
