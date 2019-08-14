//
//  MainViewController.m
//  Weather-Report
//
//  Created by 沈君瑶 on 2019/8/9.
//  Copyright © 2019 沈君瑶. All rights reserved.
//

#import "MainViewController.h"
#import "SearchViewController.h"
#import "MainTableViewCell.h"
#import "ContentViewController.h"
#import "Weather.h"
#import "FutureDay.h"
#import "FutureHour.h"

@interface MainViewController ()<SearchViewControllerDelegate,UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) UIView *mainFootView;
@property (nonatomic, strong) UIButton *addButton;

@property NSMutableArray *temMutableArray;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *backgroundImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"main.png"]];
    [self.view addSubview:backgroundImageView];

    _mainMutableArray = [[NSMutableArray alloc]init];
    _temMutableArray = [[NSMutableArray alloc]init];
    
    _mainFootView = [[UIView alloc]initWithFrame:CGRectMake( 0, 750, 375, 62)];
    _mainFootView.backgroundColor = [UIColor grayColor];
    _mainFootView.alpha = 0.5;
    [self.view addSubview:_mainFootView];
    _addButton = [[UIButton alloc]initWithFrame:CGRectMake( 320, 12, 32, 32)];
    [_mainFootView addSubview:_addButton];
    [_addButton setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [_addButton addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    
    _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, 750) style:UITableViewStylePlain];
    [self.view addSubview:_mainTableView];
    _mainTableView.backgroundColor = [UIColor clearColor];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
}

# pragma mark -- UIButton
- (void)searchClick{
    SearchViewController *searchViewController = [[SearchViewController alloc]init];
    searchViewController.delegate = self;
    [self presentViewController:searchViewController animated:YES completion:nil];
}

# pragma mark -- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_mainMutableArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainTableViewCell *mainTableViewCell = [[MainTableViewCell alloc]init];
    mainTableViewCell.backgroundColor = [UIColor clearColor];
    mainTableViewCell.selectionStyle = UITableViewCellEditingStyleNone;
    
    mainTableViewCell.locationLabel.text = [_mainMutableArray objectAtIndex:indexPath.row];
    mainTableViewCell.temperatureLabel.text = [_temMutableArray objectAtIndex:indexPath.row];

    return mainTableViewCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ContentViewController *contentViewController = [[ContentViewController alloc]init];
    contentViewController.contentMutableArray = _mainMutableArray;
    contentViewController.contentNumber = indexPath.row;
    contentViewController.nowMutableArray = _nowMutableArray;
    contentViewController.nowWeatherMutableArray = _nowWeatherMutableArray;
    contentViewController.futureDayMutableArray = _futureDayMutableArray;
    contentViewController.futureHourMutableArray = _futureHourMutableArray;
//在跳转钱唤醒主线程
    [self performSelectorOnMainThread:@selector(WakeUpTheMainThread) withObject:nil waitUntilDone:NO];
    [self presentViewController:contentViewController animated:YES completion:nil];
}
//空方法，只是为了唤醒主线程
- (void)WakeUpTheMainThread{
}
- (void)passNSString:(NSString *)str{
    int i;
    for (i = 0; i < [_mainMutableArray count]; i++) {
        if ([str isEqualToString:_mainMutableArray[i]]) {
            break;
        }
    }
    if (i == [_mainMutableArray count]) {
        [_mainMutableArray addObject:str];
    }
//主界面网页请求
    NSString *strMain = [NSString stringWithFormat:@"https://free-api.heweather.com/s6/weather?location=%@&key=9f24a96156ad40cb9db5e064d698081e",str];
    strMain = [strMain stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    NSURL *mainURL = [NSURL URLWithString:strMain];
    NSURLRequest *mainRequest = [NSURLRequest requestWithURL:mainURL];
    NSURLSession *mainSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *mainDataTask = [mainSession dataTaskWithRequest:mainRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            id mainObjc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString *temString = [NSString stringWithFormat:@"%@°C",mainObjc[@"HeWeather6"][0][@"now"][@"tmp"]];
//            NSLog(@"main--%@--%@",str,temString);
            [self->_temMutableArray addObject:temString];
        }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self->_mainTableView reloadData];
        }];
    }];
    [mainDataTask resume];
    
    
//content界面网页请求
    _nowMutableArray = [[NSMutableArray alloc]init];
    _nowWeatherMutableArray = [[NSMutableArray alloc]init];
    _futureDayMutableArray = [[NSMutableArray alloc]init];
    _futureHourMutableArray = [[NSMutableArray alloc]init];
    
    for (int j = 0; j < [_mainMutableArray count]; j++) {
//和风天气API
        NSString *nowContentString = [NSString stringWithFormat:@"https://free-api.heweather.com/s6/weather?location=%@&key=9f24a96156ad40cb9db5e064d698081e",_mainMutableArray[j]];
        nowContentString = [nowContentString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
        NSURL *nowContentURL = [NSURL URLWithString:nowContentString];
        NSURLRequest *nowContentRequest = [NSURLRequest requestWithURL:nowContentURL];
        NSURLSession *nowContentSession = [NSURLSession sharedSession];
        NSURLSessionDataTask *nowContentDataTask = [nowContentSession dataTaskWithRequest:nowContentRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error == nil) {
                id nowContentObjc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSString *strtmp = [NSString stringWithFormat:@"%@°",nowContentObjc[@"HeWeather6"][0][@"now"][@"tmp"]];
//                NSLog(@"Weather--%d--%@--%@", j, self->_mainMutableArray[j],strtmp);
                NSString *strsr = [NSString stringWithFormat:@"上午%@",nowContentObjc[@"HeWeather6"][0][@"daily_forecast"][0][@"sr"]];
                
                int ssHourTime = [[nowContentObjc[@"HeWeather6"][0][@"daily_forecast"][0][@"ss"] substringWithRange:NSMakeRange(0, 2)] intValue];
                int ssMinuteTime = [[nowContentObjc[@"HeWeather6"][0][@"daily_forecast"][0][@"ss"] substringWithRange:NSMakeRange(3, 2)] intValue];
                NSString *strss = [[NSString alloc]init];
                if (ssHourTime < 10) {
                    if (ssMinuteTime < 10) {
                        strss = [NSString stringWithFormat:@"上午0%d:0%d", ssHourTime, ssMinuteTime];
                    } else {
                        strss = [NSString stringWithFormat:@"上午0%d:%d", ssHourTime, ssMinuteTime];
                    }
                } else if (ssHourTime < 13) {
                    if (ssMinuteTime < 10) {
                        strss = [NSString stringWithFormat:@"上午%d:0%d", ssHourTime, ssMinuteTime];
                    } else {
                        strss = [NSString stringWithFormat:@"上午%d:%d", ssHourTime, ssMinuteTime];
                    }
                } else {
                    ssHourTime -= 12;
                    if (ssHourTime < 10) {
                        if (ssMinuteTime < 10) {
                            strss = [NSString stringWithFormat:@"下午0%d:0%d", ssHourTime, ssMinuteTime];
                        } else {
                            strss = [NSString stringWithFormat:@"下午0%d:%d", ssHourTime, ssMinuteTime];
                        }
                    } else {
                        if (ssMinuteTime < 10) {
                            strss = [NSString stringWithFormat:@"下午%d:%0d", ssHourTime, ssMinuteTime];
                        } else {
                            strss = [NSString stringWithFormat:@"下午%d:%d", ssHourTime, ssMinuteTime];
                        }
                    }
                }
                
                NSString *strpop = [NSString stringWithFormat:@"%@%%",nowContentObjc[@"HeWeather6"][0][@"daily_forecast"][0][@"pop"]];
                NSString *strhum = [NSString stringWithFormat:@"%@%%",nowContentObjc[@"HeWeather6"][0][@"daily_forecast"][0][@"hum"]];
                NSString *strWind = [NSString stringWithFormat:@"%@ %@公里/小时",nowContentObjc[@"HeWeather6"][0][@"daily_forecast"][0][@"wind_dir"],nowContentObjc[@"HeWeather6"][0][@"daily_forecast"][0][@"wind_spd"]];
                NSString *strFl = [NSString stringWithFormat:@"%@°",nowContentObjc[@"HeWeather6"][0][@"now"][@"fl"]];
                NSString *strpcpn = [NSString stringWithFormat:@"%@毫米",nowContentObjc[@"HeWeather6"][0][@"daily_forecast"][0][@"pcpn"]];
                NSString *strpres = [NSString stringWithFormat:@"%@百帕",nowContentObjc[@"HeWeather6"][0][@"daily_forecast"][0][@"pres"]];
                NSString *strvis = [NSString stringWithFormat:@"%@公里",nowContentObjc[@"HeWeather6"][0][@"daily_forecast"][0][@"vis"]];
                
                NSMutableArray *now = [[NSMutableArray alloc]initWithObjects: strsr, strss, strpop, strhum, strWind, strFl, strpcpn, strpres, strvis, nowContentObjc[@"HeWeather6"][0][@"daily_forecast"][0][@"uv_index"], self->_mainMutableArray[j], nil];
                [self->_nowMutableArray addObject:now];
                
                Weather *nowWeather = [[Weather alloc]initWithcond:nowContentObjc[@"HeWeather6"][0][@"now"][@"cond_txt"] andtmpNow:strtmp andtmpMax:nowContentObjc[@"HeWeather6"][0][@"daily_forecast"][0][@"tmp_max"] andtmpMin:nowContentObjc[@"HeWeather6"][0][@"daily_forecast"][0][@"tmp_min"] andcomf:nowContentObjc[@"HeWeather6"][0][@"lifestyle"][0][@"txt"] andlocation:self->_mainMutableArray[j]];
                [self->_nowWeatherMutableArray addObject:nowWeather];
            }
        }];
        [nowContentDataTask resume];
        
//NowAPI
        NSString *futureDayContentString = [NSString stringWithFormat:@"http://api.k780.com/?app=weather.realtime&weaid=%@&ag=today,futureDay,lifeIndex,futureHour&appkey=44497&sign=8818ce7afd663dc666ab8ee499f3a163&format=json",_mainMutableArray[j]];
        futureDayContentString = [futureDayContentString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
        NSURL *futureDayContentURL = [NSURL URLWithString:futureDayContentString];
        NSURLRequest *futureDayContentRequest = [NSURLRequest requestWithURL:futureDayContentURL];
        NSURLSession *futureDayContentSession = [NSURLSession sharedSession];
    //FutureDay
        NSURLSessionDataTask *futureDayContentDataTask = [futureDayContentSession dataTaskWithRequest:futureDayContentRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error == nil) {
                id futureDayContentObjc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSMutableArray *futureDayArray = [[NSMutableArray alloc]init];
                for (int i = 0; i < 6; i++) {
                    FutureDay *futureDay = [[FutureDay alloc]initWithweekString:futureDayContentObjc[@"result"][@"futureDay"][i][@"week"] andwtIconString:futureDayContentObjc[@"result"][@"futureDay"][i][@"wtIcon1"] andwtTempMaxString:futureDayContentObjc[@"result"][@"futureDay"][i][@"wtTemp1"] andwtTempMinString:futureDayContentObjc[@"result"][@"futureDay"][i][@"wtTemp2"] andfutureDayLocationString:self->_mainMutableArray[j]];
                    [futureDayArray addObject:futureDay];
                }
                [self->_futureDayMutableArray addObject:futureDayArray];
            }
        }];
        [futureDayContentDataTask resume];
    //FutureHour
        NSURLSessionDataTask *futureHourContentDataTask = [futureDayContentSession dataTaskWithRequest:futureDayContentRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error == nil) {
                id futureHourContentObjc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSMutableArray *futureHourArray = [[NSMutableArray alloc]init];
                
                NSDate *dt = [NSDate date];
                NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
                unsigned unitFlags = NSCalendarUnitHour;
                NSDateComponents *comp = [gregorian components:unitFlags fromDate:dt];
                long int sumHour = comp.hour - 1;
                
                for (int i = 0; i < 24; i++) {
                    sumHour++;
                    if (sumHour == 25) {
                        sumHour = 1;
                    }
                    NSString *strdateYmdh = [[NSString alloc]init];
                    if (sumHour < 13) {
                        strdateYmdh = [NSString stringWithFormat:@"上午%ld时", sumHour];
                    } else {
                        strdateYmdh = [NSString stringWithFormat:@"下午%ld时", sumHour - 12];
                    }
                    if (i == 0) {
                        strdateYmdh = [NSString stringWithFormat:@"现在"];
                    }
                    
                    NSString *strtmp = [NSString stringWithFormat:@"%@°",futureHourContentObjc[@"result"][@"futureHour"][i][@"wtTemp"]];
                    FutureHour *futureHour = [[FutureHour alloc]initWithdateYmdh:strdateYmdh andwtIconString:futureHourContentObjc[@"result"][@"futureHour"][i][@"wtIcon"] andwtTempString:strtmp andfutureHourLocationString:self->_mainMutableArray[j]];
                    [futureHourArray addObject:futureHour];
                }
                [self->_futureHourMutableArray addObject:futureHourArray];
            }
        }];
        [futureHourContentDataTask resume];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    if ([_mainMutableArray count] != 0 && [_nowMutableArray count] != 0 && [_nowWeatherMutableArray count] != 0 && [_futureDayMutableArray count] != 0 && [_futureHourMutableArray count] != 0 && [_temMutableArray count] != 0 ) {
        [_mainTableView reloadData];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
