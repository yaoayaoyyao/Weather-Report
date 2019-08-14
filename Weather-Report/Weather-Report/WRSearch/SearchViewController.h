//
//  SearchViewController.h
//  Weather-Report
//
//  Created by 沈君瑶 on 2019/8/8.
//  Copyright © 2019 沈君瑶. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol SearchViewControllerDelegate <NSObject>
- (void)passNSString:(NSString *)str;

@end

@interface SearchViewController : UIViewController

@property NSMutableArray *searchMutableArray;
@property id<SearchViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
