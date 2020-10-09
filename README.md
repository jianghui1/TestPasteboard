##### iOS 14 新增剪切板权限

随着 iOS 14 的发布，剪切板的滥用也被大家所知晓。凡是 APP 读取剪切板内容，系统都会在顶部弹出提醒，而且这个提醒不能够关闭。这样，大家在使用 APP 的过程中就能够看到哪些 APP 使用了剪切板。

众所周知，淘宝 APP 在各个社交平台传播分享是通过淘口令的，被分享者通过复制淘口令打开淘宝 APP 可以定位到分享的商品，完成购买。而这个步骤就是通过读取剪切板内容实现的。那么，在 iOS 14 上，只要启动淘宝，就会出现系统提示，淘宝读取了剪切板内容。

##### 淘口令适配 iOS 14

前段时间，淘宝发布了新版本，并公布了新的淘口令规则：数字+淘口令+链接。

为什么要这样做呢？

因为随着 iOS 14 对剪切板隐私的保护，新增加了两个 API `detectPatternsForPatterns:completionHandler:` `detectPatternsForPatterns:inItemSet:completionHandler:` 来判断剪切板中的内容格式，使用这两个 API 不会触发系统剪切板提示，但是也拿不到剪切板的具体内容。

所以，淘口令的适配使用了这两个 API，来判断剪切板内容是否符合淘口令规则。

但是这两个 API 只是暴露了三种规则：数字`UIPasteboardDetectionPatternNumber`、链接`UIPasteboardDetectionPatternProbableWebURL`、搜索内容`UIPasteboardDetectionPatternProbableWebSearch`。所以淘宝也只能使用这些规则。为了保证读取淘口令的精确度，便使用了数字+链接两种方式匹配，降低读取剪切板的错误率。不过，最终识别出了淘口令，读取内容还是需要使用其他 API，仍然会出现系统提醒。

可能很多人以为淘宝这个规则是通过正则表达式实现的。其实，苹果这两个 API 的判断规则是不支持正则表达式的。而且它的匹配规则具体没法知晓，比如数字的判定，一段文字开头是数字可以识别，中间有数字就识别不出来。又比如链接的匹配，正常 http:// 的链接可以识别，其他 scheme 比如 taobao:// 也可以识别，甚至 :/ 都可以识别。

如果根据目前了解的信息来看的话，淘宝应该就是这样实现的，但是不排除其他骚操作。不过，有一说一，淘宝对于淘口令的适配真的是费了一番功夫的。

##### 下面是我猜测实现的代码，测试了不同种类的口令，发现与淘宝效果一致。

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
