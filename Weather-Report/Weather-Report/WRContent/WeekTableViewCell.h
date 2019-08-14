//
//  WeekTableViewCell.h
//  Weather-Report
//
//  Created by 沈君瑶 on 2019/8/10.
//  Copyright © 2019 沈君瑶. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeekTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *weekLabel;
@property (nonatomic, strong) UIImageView *weatherImageView;
@property (nonatomic, strong) UILabel *temNowLabel;
@property (nonatomic, strong) UILabel *temAllLabel;

@end

NS_ASSUME_NONNULL_END
