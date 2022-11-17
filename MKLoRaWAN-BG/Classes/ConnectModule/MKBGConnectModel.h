//
//  MKBGConnectModel.h
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/17.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CBPeripheral;
@interface MKBGConnectModel : NSObject

@property (nonatomic, copy, readonly)NSString *firmware;

/// 0:LW001-BG PRO (L)   1:LW001-BG PRO (M)
@property (nonatomic, assign)NSInteger proType;

+ (MKBGConnectModel *)shared;

/// 连接设备
/// @param peripheral 设备
/// @param password 密码
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
- (void)connectDevice:(CBPeripheral *)peripheral
             password:(NSString *)password
             sucBlock:(void (^)(void))sucBlock
          failedBlock:(void (^)(NSError *error))failedBlock;

/// 判断设备固件版本是否是V1.0.7以上，V1.0.7新增功能如下
/*
 1、debugger功能
 2、自检状态功能
 3、新增弹簧开关机方式选择
 */
- (BOOL)firmwareVersion107;

@end

NS_ASSUME_NONNULL_END
