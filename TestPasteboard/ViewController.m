//
//  ViewController.m
//  TestPasteboard
//
//  Created by jzh on 2020/9/18.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    UILabel *_label1;
    UILabel *_label2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _label1 = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    _label1.backgroundColor = [UIColor redColor];
    [self.view addSubview:_label1];
    
    _label2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
    _label2.backgroundColor = [UIColor redColor];
    [self.view addSubview:_label2];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 500, 100, 100);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"点我哟" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkTKL) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)checkTKL
{
    _label1.text = @"";
    _label2.text = @"";
    
    /*
     復製这条（(aZa0c4wZVKL)）进入【Tao宝】即可
     
     
     
     
     点击链接，即可领取 http://www.h8b16.cn/u/pWn-Dax 快来吧
     
     
     
     復製这条（(aZa0c4wZVKL)）进入【Tao宝】即可

     点击链接，即可领取 http://www.h8b16.cn/u/pWn-Dax 快来吧
     
     
     
     
     8 復製这条（(aZa0c4wZVKL)）进入【Tao宝】即可

     点击链接，即可领取 http://www.h8b16.cn/u/pWn-Dax 快来吧
     
     
     
     復製这条（(aZa0c4wZVKL)）进入【Tao宝】即可 8

     点击链接，即可领取 http://www.h8b16.cn/u/pWn-Dax 快来吧
     
     
     
     復製这条（(aZa0c4wZVKL)）进入【Tao宝】即可
     
     8

     点击链接，即可领取 http://www.h8b16.cn/u/pWn-Dax 快来吧
     
     
     
     8 復製这条（(aZa0c4wZVKL)）:/
     
     
     6（(ewlnc4xMZPO)）:/
     
     
     
     8（(ewlnc4xMZPO)）:/
     
     
     
     8 復製这条（(lYZTc4xqC52)）进入【Tao宝】即可

     点击链接，即可领取 http:// 快来吧
     
     
     6（₪j39pc4xKo9K₪）:/ ，进入【tao宝】，即可🌈 復製这条

     
     
     
     復製这条  6₪j39pc4xKo9K₪:/ ，进入【tao宝】，即可🌈
     
     
     
     
     6復製这条 ₪DbuKc4CQTO6₪:/ ，进入【tao宝】，即可🌈
     
     */
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    void (^checkBlock)(NSSet *set, int type) = ^(NSSet *set, int type) {
            BOOL isNumber = NO, isUrl = NO;
            for (NSString *s in set) {
                if ([s isEqualToString:UIPasteboardDetectionPatternNumber]) {
                    isNumber = YES;
                }
                if ([s isEqualToString:UIPasteboardDetectionPatternProbableWebURL]) {
                    isUrl = YES;
                }
                if ([s isEqualToString:UIPasteboardDetectionPatternProbableWebSearch]) {
//                    NSLog(@"todo --- hehe");
                }
            }
            if (isNumber && isUrl) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSString *s = pasteboard.string;
                    NSLog(@"todo -- %@", s);
                    if (type == 1) {
                        self->_label1.text = @"1";
                    }
                    else if (type == 2) {
                        self->_label2.text = @"2";
                    }
                });
            }
    };
    
    [pasteboard detectPatternsForPatterns:[NSSet setWithObjects:UIPasteboardDetectionPatternNumber, UIPasteboardDetectionPatternProbableWebURL, UIPasteboardDetectionPatternProbableWebSearch, nil] completionHandler:^(NSSet<UIPasteboardDetectionPattern> * _Nullable set, NSError * _Nullable error) {
        checkBlock(set, 1);
        }];
    
    [pasteboard detectPatternsForPatterns:[NSSet setWithObjects:UIPasteboardDetectionPatternNumber, nil] inItemSet:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, 1)] completionHandler:^(NSArray<NSSet<UIPasteboardDetectionPattern> *> * _Nullable set, NSError * _Nullable error) {
        NSLog(@"todo ---- %@", set);
    }];
}

- (void)buttonAction
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    NSLog(@"todo ----- %@", pasteboard.strings);
    pasteboard.strings = @[@"wo", @"111"];
    NSLog(@"todo ----- %@", pasteboard.strings);
}

@end
