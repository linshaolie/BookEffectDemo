//
//  ViewController.m
//  BookEffectDemo
//
//  Created by Shaolie on 16/4/15.
//  Copyright © 2016年 LinShaoLie. All rights reserved.
//

#import "ViewController.h"

#import "SLBooksView.h"
#import "utils.h"
#import "BookView.h"
#import "BookView2.h"

//#define RANDOM_COLOR [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1]

@interface ViewController ()<BooksViewDataSource>

@property(nonatomic, strong) NSArray *models;

@property(nonatomic, strong) SLBooksView *booksView;
@property(nonatomic, strong)NSMutableDictionary<NSString*, NSMutableArray*> *pageViews;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  _booksView = [[SLBooksView alloc] initWithFrame:RECT(0, 0, S_W, S_H)];
  _booksView.dataSource = self;
  [self.view addSubview:_booksView];

  [self loadData];
}

- (void)loadData {
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    _models = @[@{@"title":@"第一章 汽车", @"type":@"Chapter",
                  @"color":[UIColor colorWithRed:0.1 green:0.7 blue:0.4 alpha:1]},
//                @{@"title":@"迈凯伦P1", @"type":@"Content",
//                  @"imageURL":@"http://pic31.nipic.com/20130624/8821914_104949466000_2.jpg"},
//                @{@"title":@"牧马人", @"type":@"Content",
//                  @"imageURL":@"http://pic4.nipic.com/20090924/3308315_095324041734_2.jpg"},
//                @{@"title":@"奥迪TT", @"type":@"Content",
//                  @"imageURL":@"http://pic4.nipic.com/20091117/3376018_110331702620_2.jpg"},
                
                @{@"title":@"第二章 飞机", @"type":@"Chapter",
                  @"color":[UIColor colorWithRed:0.1 green:0.3 blue:0.9 alpha:1]},
//                @{@"title":@"战斗机", @"type":@"Content",
//                  @"imageURL":@"http://pic40.nipic.com/20140416/6608733_194650033000_2.jpg"},
//                @{@"title":@"直升机", @"type":@"Content",
//                  @"imageURL":@"http://www.afinance.cn/new/UploadFiles_2266/201112/20111209201248787.jpg"},
                
                @{@"title":@"第三章 星球", @"type":@"Chapter",
                  @"color":[UIColor colorWithRed:0.3 green:0.6 blue:0.9 alpha:1]},
                @{@"title":@"第四章 未知", @"type":@"Chapter",
                  @"color":[UIColor colorWithRed:0.7 green:0.3 blue:0.8 alpha:1]},
                @{@"title":@"谢谢", @"type":@"Chapter",
                  @"color":[UIColor colorWithRed:0.4 green:0.6 blue:0.7 alpha:1]}];
    
    _pageViews = nil;
    for (int i = 0; i < _models.count; i++) {
      NSDictionary *model = _models[i];
      NSString *type = model[@"type"];
      PageView *pageView = nil;
      if ([type isEqualToString:@"Chapter"]) {
        pageView = [BookView bookViewWithSize:SIZE(S_W, S_H)];
      } else {
        pageView = [BookView2 bookViewWithSize:SIZE(S_W, S_H)];
      }
      if (!self.pageViews[type]) {
        NSMutableArray *arr = [NSMutableArray new];
        [self.pageViews setObject:arr forKey:type];
      }
      
      if (self.pageViews[type].count < 3) {
        [self.pageViews[type] addObject:pageView];
      }
    }
    
    [_booksView reloadData];
  });
}

- (NSMutableDictionary<NSString*, NSMutableArray*> *)pageViews {
  if (!_pageViews) {
    _pageViews = [NSMutableDictionary new];
  }
  return _pageViews;
}

#pragma mark - BooksView Data Sourc

- (NSInteger)numberOfPageInBooksView:(SLBooksView *)booksView {
  return _models.count;
}

- (PageView *)booksView:(SLBooksView *)booksView pageViewBeforePageView:(PageView *__nullable)bookView {
  NSInteger idx = bookView ? bookView.index-1 : 0;
  NSDictionary *model = _models[idx];
  NSString *type = model[@"type"];
  BookView *preView = self.pageViews[type][idx % self.pageViews[type].count];
  [preView setupWithModel:model];
  
  return preView;
}

- (PageView *)booksView:(SLBooksView *)booksView pageViewAfterPageView:(PageView *)bookView {
  NSInteger idx = bookView.index + 1;
  NSDictionary *model = _models[idx];
  NSString *type = model[@"type"];
  BookView *nextView =  self.pageViews[type][idx % self.pageViews[type].count];
  [nextView setupWithModel:model];
  
  return nextView;
}



@end
