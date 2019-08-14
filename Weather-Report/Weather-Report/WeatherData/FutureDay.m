//
//  FutureDay.m
//  Weather-Report
//
//  Created by 沈君瑶 on 2019/8/13.
//  Copyright © 2019 沈君瑶. All rights reserved.
//

#import "FutureDay.h"

@implementation FutureDay

- (instancetype)initWithweekString:(NSString *)weekString andwtIconString:(NSString *)wtIconString andwtTempMaxString:(NSString *)wtTempMaxString andwtTempMinString:(NSString *)wtTempMinString andfutureDayLocationString:(NSString *)futureDayLocationString {
    self = [super init];
    
    _futureDayLocationString = futureDayLocationString;
    
    _weekString = weekString;
    _wtIconString = wtIconString;
    _wtTempMaxString = wtTempMaxString;
    _wtTempMinString = wtTempMinString;
    
    return self;
}

@end
