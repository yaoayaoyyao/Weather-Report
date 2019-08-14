//
//  ContentHeadView.h
//  Weather-Report
//
//  Created by 沈君瑶 on 2019/8/9.
//  Copyright © 2019 沈君瑶. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContentHeadView : UIView

@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UILabel *temperatureLabel;
@property (nonatomic, strong) UILabel *weatherLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *todayLabel;
@property (nonatomic, strong) UILabel *tmpMax;
@property (nonatomic, strong) UILabel *tmpMin;

@end

NS_ASSUME_NONNULL_END
