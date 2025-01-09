//
//  MKBGScanController.h
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/20.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseViewController.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBGScanController : MKBaseViewController

/// 0:LW001-BG PRO -A     1:LW001-BG PRO -B
@property (nonatomic, assign)NSInteger proType;

/// YES: V2充电版本     NO:V1 + V2非充电版
@property (nonatomic, assign)BOOL needCharging;

@end

NS_ASSUME_NONNULL_END
