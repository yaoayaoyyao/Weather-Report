//
//  FutureHour.m
//  Weather-Report
//
//  Created by 沈君瑶 on 2019/8/14.
//  Copyright © 2019 沈君瑶. All rights reserved.
//

#import "FutureHour.h"

@implementation FutureHour

- (instancetype)initWithdateYmdh:(NSString *)dateYmdh andwtIconString:(NSString *)wtIconString andwtTempString:(NSString *)wtTempString andfutureHourLocationString:(NSString *)futureHourLocationString{
    self = [super init];
    
    _futureHourLocationString = futureHourLocationString;
    
    _dateYmdh = dateYmdh;
    _wtIconString = wtIconString;
    _wtTempString = wtTempString;
    
    return self;
}

@end
