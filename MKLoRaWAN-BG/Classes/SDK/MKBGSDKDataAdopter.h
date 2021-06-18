//
//  MKBGSDKDataAdopter.h
//  MKLoRaWAN-BG
//
//  Created by aa on 2021/6/10.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKBGSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKBGSDKDataAdopter : NSObject

/**
 二进制转换成十六进制
 
 @param binary 二进制数
 @return 十六进制数
 */
+ (NSString *)getHexByBinary:(NSString *)binary;

/// 将一个十进制的数据转换成对应byteLen字节长度的十六进制数据，
/*
 [MKBGSDKDataAdopter fetchHexValue:10 byteLen:4] ==>@"0000000a"
 [MKBGSDKDataAdopter fetchHexValue:10 byteLen:1] ==>@"0a"
 */
/// @param value 十进制
/// @param byteLen 字节长度
+ (NSString *)fetchHexValue:(unsigned long)value byteLen:(NSInteger)len;

/// 将对应的定位策略转换成命令string
/// @param strategy 定位策略
+ (NSString *)fetchPositioningStrategyCommand:(mk_bg_positioningStrategy)strategy;

/// 将设备工作模式转换成对应的命令string
/// @param deviceMode 工作模式
+ (NSString *)fetchDeviceModeValue:(mk_bg_deviceMode)deviceMode;

/// 将Gps搜星模式转换成对应的命令string
/// @param mode mode
+ (NSString *)fetchGpsFixModeValue:(mk_bg_gpsFixMode)mode;

/// 将Gps模式转换成对应的命令string
/// @param mode mode
+ (NSString *)fetchGpsModeValue:(mk_bg_gpsMode)mode;

+ (NSString *)lorawanRegionString:(mk_bg_loraWanRegion)region;

/// 判定是否符合raw数据过滤规则
/// @param protocol protocol
+ (BOOL)isConfirmRawFilterProtocol:(id <mk_bg_BLEFilterRawDataProtocol>)protocol;

/// 获取定时模式时间点命令string,如果返回@""空字符串则表示dataList数据有问题，否则返回对应的string

/// @param dataList 最多10个，可以为空
+ (NSString *)fetchTimingModeReportingTimePoint:(NSArray <mk_bg_timingModeReportingTimePointProtocol>*)dataList;

/// 解析定时模式下面的时间点列表
/// @param content 原始数据
+ (NSArray <NSDictionary *>*)parseTimingModeReportingTimePoint:(NSString *)content;

+ (NSString *)fetchTxPower:(mk_bg_txPower)txPower;

/// 读取回来两个字节的数据转换为对应的状态标志
/// @param content content
+ (NSDictionary *)fetchIndicatorSettings:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
