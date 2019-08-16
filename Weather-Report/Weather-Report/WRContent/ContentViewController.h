//
//  ContentViewController.h
//  Weather-Report
//
//  Created by 沈君瑶 on 2019/8/10.
//  Copyright © 2019 沈君瑶. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContentViewController : UIViewController

@property NSMutableArray *contentMutableArray;
@property NSMutableArray *futureHourMutableArray;
@property NSMutableArray *futureDayMutableArray;
@property NSMutableArray *nowMutableArray;
@property NSMutableArray *nowWeatherMutableArray;

@property (nonatomic, assign) NSInteger contentNumber;

@end

NS_ASSUME_NONNULL_END
