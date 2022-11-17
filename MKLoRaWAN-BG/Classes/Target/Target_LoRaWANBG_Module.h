//
//  Target_LoRaWANBG_Module.h
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/17.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Target_LoRaWANBG_Module : NSObject

/// 设备类型选择页面
- (UIViewController *)Action_LoRaWANBG_Module_OptionsController:(NSDictionary *)params;

/// 扫描页面
- (UIViewController *)Action_LoRaWANBG_Module_ScanController:(NSDictionary *)params;

/// 关于页面
- (UIViewController *)Action_LoRaWANBG_Module_AboutController:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
