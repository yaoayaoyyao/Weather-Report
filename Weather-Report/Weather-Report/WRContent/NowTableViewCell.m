//
//  NowTableViewCell.m
//  Weather-Report
//
//  Created by 沈君瑶 on 2019/8/10.
//  Copyright © 2019 沈君瑶. All rights reserved.
//

#import "NowTableViewCell.h"

@implementation NowTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _titleLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_titleLabel];
    
    _conLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_conLabel];
    
    return self;
}

-(void)layoutSubviews {
    _titleLabel.frame = CGRectMake( 20, 10, 335, 20);
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:20];
    
    _conLabel.frame = CGRectMake( 20, 35, 335, 45);
    _conLabel.textColor = [UIColor whiteColor];
    _conLabel.font = [UIFont systemFontOfSize:30];
    
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellEditingStyleNone;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //下分割线
//    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:198/255.0 green:198/255.0 blue:198/255.0 alpha:1].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextStrokeRect(context, CGRectMake( 20, rect.size.height, rect.size.width-40, 1));
}


@end
