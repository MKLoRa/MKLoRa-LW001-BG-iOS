//
//  CTMediator+MKBGAdd.m
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/17.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "CTMediator+MKBGAdd.h"

#import "MKMacroDefines.h"

#import "MKLoRaWANBGModuleKey.h"

@implementation CTMediator (MKBGAdd)

- (UIViewController *)CTMediator_LORAWAN_BG_AboutPage {
    UIViewController *viewController = [self performTarget:kTarget_loRaApp_la_module
                                                    action:kAction_loRaApp_la_aboutPage
                                                    params:@{}
                                         shouldCacheTarget:NO];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        return viewController;
    }
    return [self performTarget:kTarget_loRaApp_bg_module
                        action:kAction_loRaApp_bg_aboutPage
                        params:@{}
             shouldCacheTarget:NO];
}

- (UIViewController *)CTMediator_LORAWAN_BG_ScanPage:(BOOL)needCharging {
    return [self performTarget:kTarget_loRaApp_bg_module
                        action:kAction_loRaApp_bg_scanPage
                        params:@{@"needCharging":@(needCharging),
                                 @"proType":(needCharging ? @"1" : @"0")}
             shouldCacheTarget:NO];
}

#pragma mark - private method
- (UIViewController *)Action_LoRaApp_ViewControllerWithTarget:(NSString *)targetName
                                                       action:(NSString *)actionName
                                                       params:(NSDictionary *)params{
    UIViewController *viewController = [self performTarget:targetName
                                                    action:actionName
                                                    params:params
                                         shouldCacheTarget:NO];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
        // 这里处理异常场景，具体如何处理取决于产品
        return [[UIViewController alloc] init];
    }
}

@end
