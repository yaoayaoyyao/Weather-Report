//
//  HoursView.m
//  Weather-Report
//
//  Created by 沈君瑶 on 2019/8/10.
//  Copyright © 2019 沈君瑶. All rights reserved.
//

#import "HoursView.h"

@implementation HoursView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    _timeLabel = [[UILabel alloc]init];
    [self addSubview:_timeLabel];
    
    _weatherImageView = [[UIImageView alloc]init];
    [self addSubview:_weatherImageView];
    
    _temLabel = [[UILabel alloc]init];
    [self addSubview:_temLabel];
    
    return self;
}

- (void)layoutSubviews{
    _timeLabel.frame = CGRectMake( 5, 0, 90, 40);
    _timeLabel.textColor = [UIColor whiteColor];
    _timeLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    _timeLabel.textAlignment = UITextAlignmentCenter;
    
    _weatherImageView.frame = CGRectMake( 35, 50, 40, 30);
    
    
    _temLabel.frame = CGRectMake( 25, 90, 50, 40);
    _temLabel.textColor = [UIColor whiteColor];
    _temLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:30];
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
