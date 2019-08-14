//
//  MainTableViewCell.m
//  Weather-Report
//
//  Created by 沈君瑶 on 2019/8/9.
//  Copyright © 2019 沈君瑶. All rights reserved.
//

#import "MainTableViewCell.h"

@implementation MainTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _timeLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_timeLabel];
    
    _locationLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_locationLabel];
    
    _temperatureLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_temperatureLabel];
    
    return self;
}

- (void)layoutSubviews{
    
    NSDate *dt = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *comp = [gregorian components:unitFlags fromDate:dt];
    
    _timeLabel.frame = CGRectMake(10, 10, 260, 30);
    _timeLabel.textColor = [UIColor whiteColor];
    NSString *str = [[NSString alloc]init];
    if (comp.hour < 10) {
        if (comp.minute < 10) {
            str = [NSString stringWithFormat:@"上午0%ld:0%ld", comp.hour, comp.minute];
        } else {
            str = [NSString stringWithFormat:@"上午0%ld:%ld", comp.hour, comp.minute];
        }
    } else if (comp.hour < 13) {
        if (comp.minute < 10) {
            str = [NSString stringWithFormat:@"上午%ld:0%ld", comp.hour, comp.minute];
        } else {
            str = [NSString stringWithFormat:@"上午%ld:%ld", comp.hour, comp.minute];
        }
    } else {
        comp.hour -= 12;
        if (comp.hour < 10) {
            if (comp.minute < 10) {
                str = [NSString stringWithFormat:@"下午0%ld:0%ld", comp.hour, comp.minute];
            } else {
                str = [NSString stringWithFormat:@"下午0%ld:%ld", comp.hour, comp.minute];
            }
        } else {
            if (comp.minute < 10) {
                str = [NSString stringWithFormat:@"下午%ld:%0ld", comp.hour, comp.minute];
            } else {
                str = [NSString stringWithFormat:@"下午%ld:%ld", comp.hour, comp.minute];
            }
        }
    }
    
    _timeLabel.text = str;
    _timeLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:23];
    
    _locationLabel.frame = CGRectMake(10, 50, 260, 50);
    _locationLabel.textColor = [UIColor whiteColor];
    _locationLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:35];
    
    _temperatureLabel.frame = CGRectMake(220, 10, 135, 90);
    _temperatureLabel.textColor = [UIColor whiteColor];
    _temperatureLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:60];
    
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //下分割线
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:198/255.0 green:198/255.0 blue:198/255.0 alpha:1].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, 1));
}




@end
