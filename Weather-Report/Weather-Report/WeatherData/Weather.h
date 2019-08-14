//
//  Weather.h
//  Weather-Report
//
//  Created by 沈君瑶 on 2019/8/12.
//  Copyright © 2019 沈君瑶. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Weather : NSObject

@property NSString *location;

@property NSString *cond;
@property NSString *tmpNow;
@property NSString *tmpMax;
@property NSString *tmpMin;

@property NSString *comf;

- (instancetype)initWithcond:(NSString *)newcond andtmpNow:(NSString *)newtmpNow andtmpMax:(NSString *)newtmpMax andtmpMin:(NSString *)newtmpMin andcomf:(NSString *)newcomf andlocation:(NSString *)location;

@end

NS_ASSUME_NONNULL_END
