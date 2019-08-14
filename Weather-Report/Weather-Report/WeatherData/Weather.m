//
//  Weather.m
//  Weather-Report
//
//  Created by 沈君瑶 on 2019/8/12.
//  Copyright © 2019 沈君瑶. All rights reserved.
//

#import "Weather.h"

@implementation Weather

- (instancetype)initWithcond:(NSString *)newcond andtmpNow:(NSString *)newtmpNow andtmpMax:(NSString *)newtmpMax andtmpMin:(NSString *)newtmpMin andcomf:(NSString *)newcomf andlocation:(NSString *)location{
    
    self = [super init];
    
    _location = location;
    
    _cond = newcond;
    _tmpNow = newtmpNow;
    _tmpMax = newtmpMax;
    _tmpMin = newtmpMin;
    _comf = newcomf;
    
    return self;
}

@end
