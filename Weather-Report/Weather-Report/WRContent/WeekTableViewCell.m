//
//  WeekTableViewCell.m
//  Weather-Report
//
//  Created by 沈君瑶 on 2019/8/10.
//  Copyright © 2019 沈君瑶. All rights reserved.
//

#import "WeekTableViewCell.h"

@implementation WeekTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _weekLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_weekLabel];
    
    _weatherImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:_weatherImageView];
    
    _temNowLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_temNowLabel];
    
    _temAllLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_temAllLabel];
    
    return self;
}

- (void)layoutSubviews{
    
    _weekLabel.frame = CGRectMake(20, 5, 80, 40);
    _weekLabel.textColor = [UIColor whiteColor];
    _weekLabel.font = [UIFont fontWithName:@"Helvetica" size:25];
    
    _temNowLabel.frame = CGRectMake(235, 5, 50, 40);
    _temNowLabel.textColor = [UIColor whiteColor];
    _temNowLabel.font = [UIFont fontWithName:@"Helvetica" size:25];
    
    _temAllLabel.frame = CGRectMake(305, 5, 50, 40);
    _temAllLabel.textColor = [UIColor whiteColor];
    _temAllLabel.font = [UIFont fontWithName:@"Helvetica" size:25];
    
    _weatherImageView.frame = CGRectMake( 147.5, 10, 40, 30);
    
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellEditingStyleNone;
}


@end
