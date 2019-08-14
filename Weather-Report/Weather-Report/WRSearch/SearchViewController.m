//
//  SearchViewController.m
//  Weather-Report
//
//  Created by 沈君瑶 on 2019/8/8.
//  Copyright © 2019 沈君瑶. All rights reserved.
//

#import "SearchViewController.h"

static NSString *strCell = @"strCell";

@interface SearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *searchTableView;


@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *backgroundImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search.png"]];
    [self.view addSubview:backgroundImageView];
    
    _searchMutableArray = [[NSMutableArray alloc]init];
    
    _searchTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, 375, 712) style:UITableViewStylePlain];
    [_searchTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:strCell];
    _searchTableView.delegate = self;
    _searchTableView.dataSource = self;
    _searchTableView.backgroundColor = [UIColor clearColor];
    _searchTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_searchTableView];
    
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 375, 100)];
    _searchBar.alpha = 0.5;
    _searchBar.showsCancelButton = YES;
    _searchBar.delegate = self;
    _searchBar.enablesReturnKeyAutomatically = NO;
    _searchBar.tintColor = [UIColor whiteColor];
//成为键盘的第一响应者
    [_searchBar becomeFirstResponder];
//通过KVC拿到textField
    UITextField *searchTextField = [_searchBar valueForKey:@"searchField"];
    searchTextField.backgroundColor = [UIColor colorWithRed:0.17f green:0.17f blue:0.15f alpha:1.00f];
    
    [self.view addSubview:_searchBar];
}

# pragma mark -- UISearchBarDelegate
//当文字改变时触发
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [_searchMutableArray removeAllObjects];
    NSString *strFind = [NSString stringWithFormat:@"https://search.heweather.net/find?location=%@&key=9f24a96156ad40cb9db5e064d698081e",searchText];
    strFind = [strFind stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    NSURL *searchURL = [NSURL URLWithString:strFind];
    NSURLRequest *searchRequest = [NSURLRequest requestWithURL:searchURL];
    NSURLSession *searchSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *searchDataTask = [searchSession dataTaskWithRequest:searchRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            id searchObjc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            for (int i = 0; i < [searchObjc[@"HeWeather6"][0][@"basic"] count]; i++) {
                [self->_searchMutableArray addObject:searchObjc[@"HeWeather6"][0][@"basic"][i][@"location"]];
            }
        }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self->_searchTableView reloadData];
        }];
    }];
    [searchDataTask resume];
}
//点击“取消”按钮触发
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

# pragma mark -- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_searchMutableArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [_searchTableView dequeueReusableCellWithIdentifier:strCell forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellEditingStyleNone;

    cell.textLabel.text = [_searchMutableArray objectAtIndex:indexPath.row];
    
    cell.backgroundColor = [UIColor clearColor];

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_delegate respondsToSelector:@selector(passNSString:)]) {
        [_delegate passNSString:_searchMutableArray[indexPath.row]];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    [_searchBar resignFirstResponder];
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
