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
    UILabel *_label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 88, self.view.bounds.size.width, self.view.bounds.size.height - 2 * 88)];
    _label.numberOfLines = 0;
    _label.font = [UIFont systemFontOfSize:30];
    _label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkTKL) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    NSArray *urls = @[
        @"1wo",
        @"1我",
        @"wo1",
        @"我1",
        @"wo 1",
        @"我 1",
    ];
    for (NSString *s in urls) {
        NSScanner *sc = [NSScanner scannerWithString:s];
        int i;
        [sc scanInt:&i];
        NSLog(@"todo  --- %@ ---- %d", s, i);
    }
    
    urls = @[
        @"mg://aaa?b=c",
        @"mg://aaa?b= c",
        @"mg://aaa?b=+c"
    ];
    for (NSString *s in urls) {
        NSURL *url = [NSURL URLWithString:s];
        if (url) {
            NSLog(@"todo --- %@", url);
        }
    }
    
    NSString *s = @"mg://aaa?b=c&d={\"e\": 7}";
    s = [self urlEncodeToString:s];
    NSURLComponents *components = [NSURLComponents componentsWithString:s];
    NSArray *items = components.queryItems;
    NSLog(@"todo --- %@", items);
}

- (NSString *)urlEncodeToString:(NSString *)input {
    if (!input) {
        return @"";
    }
    static NSString * const kGeneralDelimitersToEncode = @":#[]@"; // does not include "?" or "/" due to RFC 3986 - Section 3.4
    static NSString * const kSubDelimitersToEncode = @"!$&'()*+,;=";
    
    NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
    [allowedCharacterSet removeCharactersInString:[kGeneralDelimitersToEncode stringByAppendingString:kSubDelimitersToEncode]];
    return [input stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
}

- (void)checkTKL
{
    
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
    
    /*
     数字
     1          ✅
     11         ✅
     1wo        ✅
     1我        ✅
     wo1        ❎
     我1        ❎
     wo 1       ❎
     我 1        ❎
     */
    
    /*
     链接
     http://www.zutuan.cn       ✅
     http://                    ✅
     https://                   ✅
     http:/                     ✅
     http:                      ❎
     http                       ❎
     p://                       ✅
     p:/                        ✅
     p:                         ❎
     ://                        ❎
     :/                         ❎
     :                          ❎
     //                         ❎
     /                          ❎
     
     我:/                        ✅
     我:/们                      ❎
     我:/ 们                     ✅
     我:/a们                     ❎
     
     我http://www.zutuan.cn们    ❎
     我http://www.zutuan.cn 们   ❎
     我 http://www.zutuan.cn们   ✅
     我 http://www.zutuan.cn 们  ✅
     
     ahttp://www.zutuan.cnb     ✅
     ahttp://www.zutuan.cn b    ✅
     a http://www.zutuan.cnb    ✅
     a http://www.zutuan.cn b   ✅
     
     我ahttp://www.zutuan.cnb   ❎
     我 ahttp://www.zutuan.cnb  ✅
     
     */
    
    /*
     数字+链接
     1我:/ 们                     ✅
     1 我:/ 们                    ✅
     1 我:/们                     ❎
     1 我 :/们                    ❎
     1 我 :/ 们                   ❎
     1 我:/a们                    ❎
     */
    
    /*
     数字必须开头
     正常链接前面但凡有中文(就算不挨着)，需要空格
     最短链接 :/ ，后面必须空格
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
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (isNumber && isUrl) {
                        NSString *s = pasteboard.string;
                        NSLog(@"todo - number & url - %@", s);
                        self->_label.text = s;
                    }
                    else if (isNumber) {
                        NSString *s = pasteboard.string;
                        NSLog(@"todo - number - %@", s);
                        self->_label.text = s;
                    }
                    else if (isUrl) {
                        NSString *s = pasteboard.string;
                        NSLog(@"todo - url - %@", s);
                        self->_label.text = s;
                    }
                    else {
                        self->_label.text = @"没有匹配";
                    }
                });
    };
    
    [pasteboard detectPatternsForPatterns:[NSSet setWithObjects:UIPasteboardDetectionPatternNumber, UIPasteboardDetectionPatternProbableWebURL, UIPasteboardDetectionPatternProbableWebSearch, nil] completionHandler:^(NSSet<UIPasteboardDetectionPattern> * _Nullable set, NSError * _Nullable error) {
        checkBlock(set, 1);
        }];
}

@end
