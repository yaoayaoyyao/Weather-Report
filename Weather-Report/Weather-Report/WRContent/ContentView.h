//
//  ContentView.h
//  Weather-Report
//
//  Created by 沈君瑶 on 2019/8/10.
//  Copyright © 2019 沈君瑶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentHeadView.h"
#import "Weather.h"

NS_ASSUME_NONNULL_BEGIN

@interface ContentView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, strong) UIScrollView *hoursScrollView;
@property (nonatomic, strong) ContentHeadView *contentHeadView;
@property NSMutableArray *futureHourMutableArray;
@property NSMutableArray *futureDayMutableArray;
@property NSMutableArray *nowMutableArray;
@property Weather *nowWeather;
@property NSMutableArray *nowNameMutableArray;

- (instancetype)initWithFrame:(CGRect)frame andLocation:(NSString *)location andnowMutableArray:(NSMutableArray *)nowMutableArray andnowWeather:(Weather *)nowWeather andfutureDayMutableArray:(NSMutableArray *)futureDayMutableArray andfutureHourMutableArray:(NSMutableArray *)futureHourMutableArray;

@end

NS_ASSUME_NONNULL_END
