//
//  FutureDay.h
//  Weather-Report
//
//  Created by 沈君瑶 on 2019/8/13.
//  Copyright © 2019 沈君瑶. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FutureDay : NSObject

@property NSString *futureDayLocationString;

@property NSString *weekString;
@property NSString *wtIconString;
@property NSString *wtTempMaxString;
@property NSString *wtTempMinString;

- (instancetype)initWithweekString:(NSString *)weekString andwtIconString:(NSString *)wtIconString andwtTempMaxString:(NSString *)wtTempMaxString andwtTempMinString:(NSString *)wtTempMinString andfutureDayLocationString:(NSString *)futureDayLocationString;

@end

NS_ASSUME_NONNULL_END
