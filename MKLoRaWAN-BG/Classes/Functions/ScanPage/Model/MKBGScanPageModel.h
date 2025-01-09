//
//  MKBGScanPageModel.h
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/20.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CBPeripheral;
@interface MKBGScanPageModel : NSObject

/// 设备类型    00: V1版本    20:V2非充电版   21:V2充电版
@property (nonatomic, copy)NSString *deviceType;

@property (nonatomic, strong)CBPeripheral *peripheral;

/// Current rssi of the device
@property (nonatomic, assign)NSInteger rssi;

/// Device name
@property (nonatomic, copy)NSString *deviceName;

@property (nonatomic, copy)NSString *macAddress;

@property (nonatomic, copy)NSString *voltage;

/// cell上面显示的时间
@property (nonatomic, copy)NSString *scanTime;

/**
 上一次扫描到的时间
 */
@property (nonatomic, copy)NSString *lastScanDate;

/**
 当前model所在的row
 */
@property (nonatomic, assign)NSInteger index;

/// 设备可连接状态
@property (nonatomic, assign)BOOL connectable;

@property (nonatomic, strong)NSNumber *txPower;

/// 上一条lora payload到当前广播时刻这个时间段内是否有移动（比如0表示未移动，1表示有移动）。
@property (nonatomic, assign)BOOL moved;

/// 闲置状态：指示产品是否处于闲置
@property (nonatomic, assign)BOOL idle;

/// 产品物理防拆开关的状态，指示设备此时是否被拆卸。
@property (nonatomic, assign)BOOL disassembled;

/// 低电状态：如果此时产品电压低于设定的低电电压值，则认为产品处于低电状态
@property (nonatomic, assign)BOOL lowBattery;

/// 工作模式:0(待机)，1(定期)，2(定时)，3(运动)。
@property (nonatomic, assign)BOOL workState;

@end

NS_ASSUME_NONNULL_END
