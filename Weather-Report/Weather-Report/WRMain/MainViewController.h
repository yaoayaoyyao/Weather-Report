//
//  MainViewController.h
//  Weather-Report
//
//  Created by 沈君瑶 on 2019/8/9.
//  Copyright © 2019 沈君瑶. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainViewController : UIViewController

@property (nonatomic, copy)NSMutableArray *mainMutableArray;
@property NSMutableArray *nowMutableArray;
@property NSMutableArray *nowWeatherMutableArray;
@property NSMutableArray *futureDayMutableArray;
@property NSMutableArray *futureHourMutableArray;

@end

NS_ASSUME_NONNULL_END
