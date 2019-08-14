//
//  ContentView.m
//  Weather-Report
//
//  Created by 沈君瑶 on 2019/8/10.
//  Copyright © 2019 沈君瑶. All rights reserved.
//

#import "ContentView.h"
#import "WeekTableViewCell.h"
#import "NowTableViewCell.h"
#import "FutureDay.h"
#import "FutureHour.h"
#import "HoursView.h"

static NSString *weekString = @"weekCell";
static NSString *comfString = @"comfCell";
static NSString *nowString = @"nowCell";

@implementation ContentView

- (instancetype)initWithFrame:(CGRect)frame andLocation:(NSString *)location andnowMutableArray:(NSMutableArray *)nowMutableArray andnowWeather:(Weather *)nowWeather andfutureDayMutableArray:(NSMutableArray *)futureDayMutableArray andfutureHourMutableArray:(NSMutableArray *)futureHourMutableArray {
    self = [super initWithFrame:frame];
    
    _nowNameMutableArray = [[NSMutableArray alloc]initWithObjects:@"日出", @"日落", @"降雨概率", @"湿度", @"风", @"体感温度", @"降水量", @"气压", @"能见度", @"紫外线指数", nil];

    _contentTableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
    _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
    _contentTableView.backgroundColor = [UIColor clearColor];
    [_contentTableView registerClass:[WeekTableViewCell class] forCellReuseIdentifier:weekString];
    [_contentTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:comfString];
    [_contentTableView registerClass:[NowTableViewCell class] forCellReuseIdentifier:nowString];
    _contentTableView.showsVerticalScrollIndicator = NO;
    _contentTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self addSubview:_contentTableView];

    _contentHeadView = [[ContentHeadView alloc]init];
    _contentHeadView.frame = CGRectMake(0, 0, 375, 270);
    _contentHeadView.backgroundColor = [UIColor clearColor];
    _contentHeadView.locationLabel.text = location;
    
    _nowMutableArray = nowMutableArray;
    _nowWeather = nowWeather;
    _futureDayMutableArray = futureDayMutableArray;
    _futureHourMutableArray = futureHourMutableArray;
    
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    _contentHeadView.weatherLabel.text = _nowWeather.cond;
    _contentHeadView.temperatureLabel.text = _nowWeather.tmpNow;
    _contentHeadView.tmpMax.text = _nowWeather.tmpMax;
    _contentHeadView.tmpMin.text = _nowWeather.tmpMin;
    
    _hoursScrollView = [[UIScrollView alloc]init];
    _hoursScrollView.frame = CGRectMake( 0, 270, 375, 130);
    _hoursScrollView.contentSize = CGSizeMake(100 * 24, 130);
    _hoursScrollView.backgroundColor = [UIColor clearColor];
    _hoursScrollView.showsVerticalScrollIndicator = NO;
    _hoursScrollView.showsHorizontalScrollIndicator = NO;
    for (int i = 0; i < [_futureHourMutableArray count]; i++) {
        FutureHour *futureHour = [[FutureHour alloc]init];
        futureHour = _futureHourMutableArray[i];
        
        HoursView *hoursView = [[HoursView alloc]init];
        hoursView.frame = CGRectMake(100 * i, 0, 100, 130);
        [_hoursScrollView addSubview:hoursView];
        
        hoursView.timeLabel.text = futureHour.dateYmdh;
        hoursView.weatherImageView.image = [UIImage imageNamed:futureHour.wtIconString];
        hoursView.temLabel.text = futureHour.wtTempString;
    }

    UIView *contentView = [[UIView alloc]init];
    contentView.backgroundColor = [UIColor clearColor];
    contentView.frame = CGRectMake(0, 0, 375, 400);
    [contentView addSubview:_contentHeadView];
    [contentView addSubview:_hoursScrollView];
    _contentTableView.tableHeaderView = contentView;
}

# pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 6;
    } else if (section == 1){
        return 1;
    } else{
        return 10;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 50;
    } else if (indexPath.section == 1) {
        return 90;
    } else {
        return 85;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        WeekTableViewCell *weekTableViewCell = [_contentTableView dequeueReusableCellWithIdentifier:weekString forIndexPath:indexPath];
        FutureDay *futureDay = [[FutureDay alloc]init];
        futureDay = _futureDayMutableArray[indexPath.row];
        
        weekTableViewCell.weekLabel.text = futureDay.weekString;
        weekTableViewCell.temNowLabel.text = futureDay.wtTempMaxString;
        weekTableViewCell.temAllLabel.text = futureDay.wtTempMinString;
        weekTableViewCell.weatherImageView.image = [UIImage imageNamed:futureDay.wtIconString];
        return weekTableViewCell;
    } else if (indexPath.section == 1) {
        UITableViewCell *comfTableViewCell = [_contentTableView dequeueReusableCellWithIdentifier:comfString forIndexPath:indexPath];
        comfTableViewCell.textLabel.text = _nowWeather.comf;
        comfTableViewCell.textLabel.textColor = [UIColor whiteColor];
        comfTableViewCell.textLabel.numberOfLines = 0;
        comfTableViewCell.backgroundColor = [UIColor clearColor];
        comfTableViewCell.selectionStyle = UITableViewCellEditingStyleNone;
        return comfTableViewCell;
        
    } else {
        NowTableViewCell *nowTableViewCell = [_contentTableView dequeueReusableCellWithIdentifier:nowString forIndexPath:indexPath];
        nowTableViewCell.titleLabel.text = [_nowNameMutableArray objectAtIndex:indexPath.row];
        nowTableViewCell.conLabel.text = [_nowMutableArray objectAtIndex:indexPath.row];
        return nowTableViewCell;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
