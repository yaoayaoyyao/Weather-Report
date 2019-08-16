//
//  ContentHeadView.m
//  Weather-Report
//
//  Created by 沈君瑶 on 2019/8/9.
//  Copyright © 2019 沈君瑶. All rights reserved.
//

#import "ContentHeadView.h"

@implementation ContentHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    _locationLabel = [[UILabel alloc]init];
    [self addSubview:_locationLabel];
    
    _temperatureLabel = [[UILabel alloc]init];
    [self addSubview:_temperatureLabel];
    
    _weatherLabel = [[UILabel alloc]init];
    [self addSubview:_weatherLabel];
    
    _timeLabel = [[UILabel alloc]init];
    [self addSubview:_timeLabel];
    
    _todayLabel = [[UILabel alloc]init];
    [self addSubview:_todayLabel];
    
    _tmpMax = [[UILabel alloc]init];
    [self addSubview:_tmpMax];
    
    _tmpMin = [[UILabel alloc]init];
    [self addSubview:_tmpMin];
    
    return self;
}

- (void)layoutSubviews{
    
    _locationLabel.frame = CGRectMake(87, 0, 201, 50);
    _locationLabel.textColor = [UIColor whiteColor];
    _locationLabel.textAlignment = NSTextAlignmentCenter;
    _locationLabel.font = [UIFont systemFontOfSize:35];
    
    _temperatureLabel.frame = CGRectMake(112, 70, 151, 130);
    _temperatureLabel.textColor = [UIColor whiteColor];
    _temperatureLabel.font = [UIFont systemFontOfSize:90];
    _temperatureLabel.textAlignment = NSTextAlignmentCenter;

    _weatherLabel.frame = CGRectMake(162, 50, 51, 20);
    _weatherLabel.textColor = [UIColor whiteColor];
    _weatherLabel.font = [UIFont systemFontOfSize:20];
    _weatherLabel.textAlignment = NSTextAlignmentCenter;

    NSDate *dt = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned unitFlags = NSCalendarUnitWeekday;
    NSDateComponents *comp = [gregorian components:unitFlags fromDate:dt];
    NSArray *weekArray = [NSArray arrayWithObjects:@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日",nil];

    _timeLabel.frame = CGRectMake(20, 200, 80, 40);
    NSString *strWeek = [NSString stringWithFormat:@"%@",weekArray[comp.weekday - 2]];
    _timeLabel.text = strWeek;
    _timeLabel.textColor = [UIColor whiteColor];
    _timeLabel.font = [UIFont fontWithName:@"Helvetica" size:25];
    
    _todayLabel.frame = CGRectMake(100, 208, 50, 30);
    _todayLabel.text = @"今天";
    _todayLabel.textColor = [UIColor whiteColor];
    _todayLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
    
    _tmpMax.frame = CGRectMake(235, 200, 50, 40);
    _tmpMax.font = [UIFont fontWithName:@"Helvetica" size:25];
    _tmpMax.textColor = [UIColor whiteColor];
    
    _tmpMin.frame = CGRectMake(305, 200, 50, 40);
    _tmpMin.font = [UIFont fontWithName:@"Helvetica" size:25];
    _tmpMin.textColor = [UIColor whiteColor];
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
