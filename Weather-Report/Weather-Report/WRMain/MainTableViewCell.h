//
//  MainTableViewCell.h
//  Weather-Report
//
//  Created by 沈君瑶 on 2019/8/9.
//  Copyright © 2019 沈君瑶. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UILabel *temperatureLabel;

@end

NS_ASSUME_NONNULL_END
