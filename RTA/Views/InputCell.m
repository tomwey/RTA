//
//  InputCell.m
//  RTA
//
//  Created by tangwei1 on 16/10/27.
//  Copyright © 2016年 tomwey. All rights reserved.
//

#import "InputCell.h"
#import "Defines.h"

@interface InputCell ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel     *titleLabel;

@property (nonatomic, strong) NSString *iconImage;

@end

@implementation InputCell

- (instancetype)initWithIcon:(NSString *)iconName title:(NSString *)title
{
    if ( self = [super init] ) {
        self.title = title;
        self.iconImage = iconName;
    }
    return self;
}

- (void)setIconImage:(NSString *)iconImage
{
    _iconImage = iconImage;
    
    self.iconView.image = AWImageNoCached(_iconImage);
//    [self.iconView sizeToFit];
    self.iconView.frame = CGRectMake(0, 0, 18, 18);
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.titleLabel.text = title;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.iconView.center = CGPointMake(self.iconView.width / 2, self.height / 2);
    self.titleLabel.frame = CGRectMake(self.iconView.right + 10,
                                       0, self.width - self.iconView.width - 10,
                                       self.height);
}

- (UIImageView *)iconView
{
    if ( !_iconView ) {
        _iconView = AWCreateImageView(nil);
        [self addSubview:_iconView];
    }
    return _iconView;
}

- (UILabel *)titleLabel
{
    if ( !_titleLabel ) {
        _titleLabel = AWCreateLabel(CGRectZero, nil,
                                    NSTextAlignmentLeft,
                                    AWSystemFontWithSize(15, NO),
                                    [UIColor blackColor]);
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (void)setTitleAttributes:(NSDictionary *)titleAttributes
{
    _titleAttributes = titleAttributes;
    
    [self updateTitleLabel];
}

- (void)updateTitleLabel
{
    if ( self.titleAttributes[NSFontAttributeName] ) {
        self.titleLabel.font = self.titleAttributes[NSFontAttributeName];
    }
    
    if ( self.titleAttributes[NSForegroundColorAttributeName] ) {
        self.titleLabel.textColor = self.titleAttributes[NSForegroundColorAttributeName];
    }
}

@end
