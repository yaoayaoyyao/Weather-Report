//
//  ContentViewController.m
//  Weather-Report
//
//  Created by 沈君瑶 on 2019/8/10.
//  Copyright © 2019 沈君瑶. All rights reserved.
//

#import "ContentViewController.h"
#import "ContentView.h"
#import "FutureDay.h"
#import "FutureHour.h"
#import "Weather.h"

@interface ContentViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *contentScrollView;

@property (nonatomic, strong) UIView *contentFootView;
@property (nonatomic, strong) UIButton *contentButton;
@property (nonatomic, strong) UIPageControl *contentPageControl;

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *backgroundImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background.png"]];
    [self.view addSubview:backgroundImageView];
    
    _contentFootView = [[UIView alloc]initWithFrame:CGRectMake( 0, 750, 375, 62)];
    _contentFootView.backgroundColor = [UIColor grayColor];
    _contentFootView.alpha = 0.5;
    [self.view addSubview:_contentFootView];
    _contentButton = [[UIButton alloc]initWithFrame:CGRectMake( 320, 12, 32, 32)];
    [_contentFootView addSubview:_contentButton];
    [_contentButton setImage:[UIImage imageNamed:@"biao.png"] forState:UIControlStateNormal];
    [_contentButton addTarget:self action:@selector(mainClick) forControlEvents:UIControlEventTouchUpInside];
    
    _contentPageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(87, 16, 201, 30)];
    _contentPageControl.numberOfPages = [_contentMutableArray count];
    _contentPageControl.currentPage = _contentNumber;
    [_contentPageControl addTarget:self action:@selector(pageClick:) forControlEvents:UIControlEventTouchUpInside];
    [_contentFootView addSubview:_contentPageControl];
    
    _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 375, 750)];
    _contentScrollView.delegate = self;
    [self.view addSubview:_contentScrollView];
    //监控目前滚动的位置
    [_contentScrollView setContentOffset:CGPointMake(375 * _contentNumber, 0) animated:YES];
    _contentScrollView.tag = 101;
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.contentSize = CGSizeMake(375 * [_contentMutableArray count], 750);
    
    for (int i = 0; i < [_contentMutableArray count]; i++) {
        NSMutableArray *nowRight = [[NSMutableArray alloc]init];
        for (int k = 0; k < [_nowMutableArray count]; k++) {
            nowRight = _nowMutableArray[k];
            if ([nowRight[10] isEqualToString:_contentMutableArray[i]]) {
                break;
            }
        }
        
        Weather *weatherRight = [[Weather alloc]init];
        for (int k = 0; k < [_nowWeatherMutableArray count]; k++) {
            weatherRight = _nowWeatherMutableArray[k];
            if ([weatherRight.location isEqualToString:_contentMutableArray[i]]) {
                break;
            }
        }
        
        NSMutableArray *futureDayRight = [[NSMutableArray alloc]init];
        for (int k = 0; k < [_futureDayMutableArray count]; k++) {
            NSMutableArray *futureDayArray = _futureDayMutableArray[k];
            int j;
            for (j = 0; j < [futureDayArray count]; j++) {
                FutureDay *day = [[FutureDay alloc]init];
                day = futureDayArray[j];
                if ([day.futureDayLocationString isEqualToString:_contentMutableArray[i]]) {
                    futureDayRight = [futureDayArray mutableCopy];
                    break;
                }
            }
            if (j != [futureDayArray count]) {
                break;
            }
        }
        
        NSMutableArray *futureHourRight = [[NSMutableArray alloc]init];
        for (int k = 0; k < [_futureHourMutableArray count]; k++) {
            NSMutableArray *futureHourArray = _futureHourMutableArray[k];
            int j;
            for (j = 0; j < [futureHourArray count]; j++) {
                FutureHour *hour = [[FutureHour alloc]init];
                hour = futureHourArray[j];
                if ([hour.futureHourLocationString isEqualToString:_contentMutableArray[i]]) {
                    futureHourRight = [futureHourArray mutableCopy];
                    break;
                }
            }
            if (j != [futureHourArray count]) {
                break;
            }
        }
        
        ContentView *contentView = [[ContentView alloc]initWithFrame:CGRectMake(375 * i, 0, 375, 750) andLocation:_contentMutableArray[i] andnowMutableArray:nowRight andnowWeather:weatherRight andfutureDayMutableArray:futureDayRight andfutureHourMutableArray:futureHourRight];
        
        [_contentScrollView addSubview:contentView];
    }
}

# pragma mark -- MainViewController
- (void)mainClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

# pragma mark -- UIPageControl
- (void)pageClick:(UIPageControl *)page{
    [_contentScrollView setContentOffset:CGPointMake(375 * page.currentPage, 0) animated:YES];
}

# pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.tag == 101) {
        _contentPageControl.currentPage = scrollView.contentOffset.x / 375;
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
