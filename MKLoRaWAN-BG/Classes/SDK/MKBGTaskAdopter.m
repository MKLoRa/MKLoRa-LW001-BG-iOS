//
//  MKBGTaskAdopter.m
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/17.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKBGTaskAdopter.h"

#import <CoreBluetooth/CoreBluetooth.h>

#import "MKBLEBaseSDKAdopter.h"
#import "MKBLEBaseSDKDefines.h"

#import "MKBGOperationID.h"

@implementation MKBGTaskAdopter

+ (NSDictionary *)parseReadDataWithCharacteristic:(CBCharacteristic *)characteristic {
    NSData *readData = characteristic.value;
    NSLog(@"+++++%@-----%@",characteristic.UUID.UUIDString,readData);
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A19"]]) {
        //电池电量
        NSString *content = [MKBLEBaseSDKAdopter hexStringFromData:readData];
        NSString *battery = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
        return [self dataParserGetDataSuccess:@{@"batteryPower":battery} operationID:mk_bg_taskReadBatteryPowerOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A24"]]) {
        //产品型号
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"modeID":tempString} operationID:mk_bg_taskReadDeviceModelOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A26"]]) {
        //firmware
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"firmware":tempString} operationID:mk_bg_taskReadFirmwareOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A27"]]) {
        //hardware
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"hardware":tempString} operationID:mk_bg_taskReadHardwareOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A28"]]) {
        //soft ware
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"software":tempString} operationID:mk_bg_taskReadSoftwareOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A29"]]) {
        //manufacturerKey
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"manufacturer":tempString} operationID:mk_bg_taskReadManufacturerOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        //密码相关
        NSString *content = [MKBLEBaseSDKAdopter hexStringFromData:readData];
        NSString *state = @"";
        if (content.length == 10) {
            state = [content substringWithRange:NSMakeRange(8, 2)];
        }
        return [self dataParserGetDataSuccess:@{@"state":state} operationID:mk_bg_connectPasswordOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA02"]]) {
        return [self parseCustomData:readData];
    }
    return @{};
}

+ (NSDictionary *)parseWriteDataWithCharacteristic:(CBCharacteristic *)characteristic {
    mk_bg_taskOperationID operationID = mk_bg_defaultTaskOperationID;
    return [self dataParserGetDataSuccess:@{@"result":@(YES)} operationID:operationID];
}

#pragma mark - 数据解析
+ (NSDictionary *)parseCustomData:(NSData *)readData {
    NSString *readString = [MKBLEBaseSDKAdopter hexStringFromData:readData];
    if (![[readString substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"ed"]) {
        return @{};
    }
    NSInteger dataLen = [MKBLEBaseSDKAdopter getDecimalWithHex:readString range:NSMakeRange(6, 2)];
    if (readData.length != dataLen + 4) {
        return @{};
    }
    NSString *flag = [readString substringWithRange:NSMakeRange(2, 2)];
    NSString *cmd = [readString substringWithRange:NSMakeRange(4, 2)];
    NSString *content = [readString substringWithRange:NSMakeRange(8, dataLen * 2)];
    if ([flag isEqualToString:@"00"]) {
        //读取
        return [self parseCustomReadData:content cmd:cmd data:readData];
    }
    if ([flag isEqualToString:@"01"]) {
        return [self parseCustomConfigData:content cmd:cmd];
    }
    return @{};
}

+ (NSDictionary *)parseCustomReadData:(NSString *)content cmd:(NSString *)cmd data:(NSData *)data{
    mk_bg_taskOperationID operationID = mk_bg_defaultTaskOperationID;
    NSDictionary *resultDic = @{};
    if ([cmd isEqualToString:@"04"]) {
        //读取设备当前时区
        resultDic = @{
            @"timeZone":[MKBLEBaseSDKAdopter signedHexTurnString:content],
        };
        operationID = mk_bg_taskReadTimeZoneOperation;
    }else if ([cmd isEqualToString:@"05"]) {
        //读取设备连接密码
        NSData *passwordData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
        NSString *password = [[NSString alloc] initWithData:passwordData encoding:NSUTF8StringEncoding];
        resultDic = @{
            @"password":(MKValidStr(password) ? password : @""),
        };
        operationID = mk_bg_taskReadPasswordOperation;
    }else if ([cmd isEqualToString:@"06"]) {
        //读取工作模式
        NSString *mode = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"mode":mode,
        };
        operationID = mk_bg_taskReadWorkModeOperation;
    }else if ([cmd isEqualToString:@"08"]) {
        //读取心跳间隔
        NSString *interval = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"interval":interval,
        };
        operationID = mk_bg_taskReadDeviceHeartbeatIntervalOperation;
    }else if ([cmd isEqualToString:@"0b"]) {
        //读取设备离线定位状态
        BOOL isOn = [content isEqualToString:@"01"];
        resultDic = @{
            @"isOn":@(isOn),
        };
        operationID = mk_bg_taskReadOfflineFixStatusOperation;
    }else if ([cmd isEqualToString:@"30"]) {
        //读取WIFI定位超时时间
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bg_taskReadWifiPositioningTimeoutOperation;
    }else if ([cmd isEqualToString:@"31"]) {
        //读取WIFI定位成功BSSID数量
        resultDic = @{
            @"number":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bg_taskReadWifiNumberOfBSSIDOperation;
    }else if ([cmd isEqualToString:@"32"]) {
        //读取BLE定位超时时间
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bg_taskReadBLEPositioningTimeoutOperation;
    }else if ([cmd isEqualToString:@"33"]) {
        //读取BLE定位成功Mac数量
        resultDic = @{
            @"number":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bg_taskReadBLENumberOfMacOperation;
    }else if ([cmd isEqualToString:@"34"]) {
        //读取蓝牙过滤规则开关与或逻辑
        resultDic = @{
            @"type":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bg_taskReadBLELogicalRelationshipOperation;
    }else if ([cmd isEqualToString:@"35"]) {
        //读取蓝牙过滤规则1开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_bg_taskReadBLEFilterAStatusOperation;
    }else if ([cmd isEqualToString:@"36"]) {
        //读取蓝牙过滤规则1的过滤广播名称
        NSString *rule = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
        NSString *deviceName = @"";
        if ([rule integerValue] > 0 && content.length > 2) {
            deviceName = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(5, data.length - 5)] encoding:NSUTF8StringEncoding];
        }
        if (!MKValidStr(deviceName)) {
            deviceName = @"";
        }
        resultDic = @{
            @"rule":rule,
            @"deviceName":deviceName,
        };
        operationID = mk_bg_taskReadBLEFilterADeviceNameOperation;
    }else if ([cmd isEqualToString:@"37"]) {
        //读取蓝牙过滤规则1过滤的mac地址
        NSString *rule = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
        NSString *macAddress = @"";
        if ([rule integerValue] > 0 && content.length > 2) {
            macAddress = [content substringWithRange:NSMakeRange(2, content.length - 2)];
        }
        resultDic = @{
            @"rule":rule,
            @"macAddress":macAddress
        };
        operationID = mk_bg_taskReadBLEFilterADeviceMacOperation;
    }else if ([cmd isEqualToString:@"38"]) {
        //读取蓝牙过滤规则1过滤的major范围
        NSString *rule = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
        NSString *majorLow = @"";
        NSString *majorHigh = @"";
        if ([rule integerValue] > 0 && content.length == 10) {
            majorLow = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 4)];
            majorHigh = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(6, 4)];
        }
        resultDic = @{
            @"rule":rule,
            @"majorLow":majorLow,
            @"majorHigh":majorHigh,
        };
        operationID = mk_bg_taskReadBLEFilterAMajorOperation;
    }else if ([cmd isEqualToString:@"39"]) {
        //读取蓝牙过滤规则1过滤的minor范围
        NSString *rule = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
        NSString *minorLow = @"";
        NSString *minorHigh = @"";
        if ([rule integerValue] > 0 && content.length == 10) {
            minorLow = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 4)];
            minorHigh = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(6, 4)];
        }
        resultDic = @{
            @"rule":rule,
            @"minorLow":minorLow,
            @"minorHigh":minorHigh,
        };
        operationID = mk_bg_taskReadBLEFilterAMinorOperation;
    }else if ([cmd isEqualToString:@"3a"]) {
        //读取蓝牙过滤规则1过滤的原始数据
        NSString *rule = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
        NSMutableArray *filterList = [NSMutableArray array];
        if ([rule integerValue] > 0) {
            NSInteger subIndex = 2;
            //最多五条过滤数据
            for (NSInteger i = 0; i < 5; i ++) {
                NSInteger index0Len = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(subIndex, 2)];
                NSString *index0Data = [content substringWithRange:NSMakeRange(subIndex + 2, index0Len * 2)];
                
                NSDictionary *index0Dic = @{
                    @"dataType":[index0Data substringWithRange:NSMakeRange(0, 2)],
                    @"minIndex":[MKBLEBaseSDKAdopter getDecimalStringWithHex:index0Data range:NSMakeRange(2, 2)],
                    @"maxIndex":[MKBLEBaseSDKAdopter getDecimalStringWithHex:index0Data range:NSMakeRange(4, 2)],
                    @"rawData":[index0Data substringFromIndex:6],
                    @"index":@(i),
                };
                [filterList addObject:index0Dic];
                subIndex += (index0Data.length + 2);
                if (subIndex >= content.length) {
                    break;
                }
            }
        }
        resultDic = @{
            @"rule":rule,
            @"filterList":filterList,
        };
        operationID = mk_bg_taskReadBLEFilterARawDataOperation;
    }else if ([cmd isEqualToString:@"3b"]) {
        //读取蓝牙过滤规则1过滤的UUID
        NSString *rule = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
        NSString *uuid = @"";
        if ([rule integerValue] > 0 && content.length > 2) {
            uuid = [content substringWithRange:NSMakeRange(2, content.length - 2)];
        }
        resultDic = @{
            @"rule":rule,
            @"uuid":uuid
        };
        operationID = mk_bg_taskReadBLEFilterAUUIDOperation;
    }else if ([cmd isEqualToString:@"3c"]) {
        //读取蓝牙过滤规则1过滤的RSSI
        NSNumber *rssi = [MKBLEBaseSDKAdopter signedHexTurnString:content];
        resultDic = @{
            @"rssi":rssi,
        };
        operationID = mk_bg_taskReadBLEFilterARssiOperation;
    }else if ([cmd isEqualToString:@"3d"]) {
        //读取蓝牙过滤规则1过滤PHY
        BOOL isOn = [[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"];
        NSString *type = @"";
        if (isOn && content.length == 4) {
            type = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
        }
        resultDic = @{
            @"isOn":@(isOn),
            @"type":type,
        };
        operationID = mk_bg_taskReadBLEFilterAByPHYOperation;
    }else if ([cmd isEqualToString:@"3e"]) {
        //读取蓝牙过滤规则2开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_bg_taskReadBLEFilterBStatusOperation;
    }else if ([cmd isEqualToString:@"3f"]) {
        //读取蓝牙过滤规则2的过滤广播名称
        NSString *rule = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
        NSString *deviceName = @"";
        if ([rule integerValue] > 0 && content.length > 2) {
            deviceName = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(5, data.length - 5)] encoding:NSUTF8StringEncoding];
        }
        if (!MKValidStr(deviceName)) {
            deviceName = @"";
        }
        resultDic = @{
            @"rule":rule,
            @"deviceName":deviceName,
        };
        operationID = mk_bg_taskReadBLEFilterBDeviceNameOperation;
    }else if ([cmd isEqualToString:@"40"]) {
        //读取蓝牙过滤规则2过滤的mac地址
        NSString *rule = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
        NSString *macAddress = @"";
        if ([rule integerValue] > 0 && content.length > 2) {
            macAddress = [content substringWithRange:NSMakeRange(2, content.length - 2)];
        }
        resultDic = @{
            @"rule":rule,
            @"macAddress":macAddress
        };
        operationID = mk_bg_taskReadBLEFilterBDeviceMacOperation;
    }else if ([cmd isEqualToString:@"41"]) {
        //读取蓝牙过滤规则2过滤的major范围
        NSString *rule = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
        NSString *majorLow = @"";
        NSString *majorHigh = @"";
        if ([rule integerValue] > 0 && content.length == 10) {
            majorLow = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 4)];
            majorHigh = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(6, 4)];
        }
        resultDic = @{
            @"rule":rule,
            @"majorLow":majorLow,
            @"majorHigh":majorHigh,
        };
        operationID = mk_bg_taskReadBLEFilterBMajorOperation;
    }else if ([cmd isEqualToString:@"42"]) {
        //读取蓝牙过滤规则2过滤的minor范围
        NSString *rule = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
        NSString *minorLow = @"";
        NSString *minorHigh = @"";
        if ([rule integerValue] > 0 && content.length == 10) {
            minorLow = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 4)];
            minorHigh = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(6, 4)];
        }
        resultDic = @{
            @"rule":rule,
            @"minorLow":minorLow,
            @"minorHigh":minorHigh,
        };
        operationID = mk_bg_taskReadBLEFilterBMinorOperation;
    }else if ([cmd isEqualToString:@"43"]) {
        //读取蓝牙过滤规则2过滤的原始数据
        NSString *rule = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
        NSMutableArray *filterList = [NSMutableArray array];
        if ([rule integerValue] > 0) {
            NSInteger subIndex = 2;
            //最多五条过滤数据
            for (NSInteger i = 0; i < 5; i ++) {
                NSInteger index0Len = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(subIndex, 2)];
                NSString *index0Data = [content substringWithRange:NSMakeRange(subIndex + 2, index0Len * 2)];
                
                NSDictionary *index0Dic = @{
                    @"dataType":[index0Data substringWithRange:NSMakeRange(0, 2)],
                    @"minIndex":[MKBLEBaseSDKAdopter getDecimalStringWithHex:index0Data range:NSMakeRange(2, 2)],
                    @"maxIndex":[MKBLEBaseSDKAdopter getDecimalStringWithHex:index0Data range:NSMakeRange(4, 2)],
                    @"rawData":[index0Data substringFromIndex:6],
                    @"index":@(i),
                };
                [filterList addObject:index0Dic];
                subIndex += (index0Data.length + 2);
                if (subIndex >= content.length) {
                    break;
                }
            }
        }
        resultDic = @{
            @"rule":rule,
            @"filterList":filterList,
        };
        operationID = mk_bg_taskReadBLEFilterBRawDataOperation;
    }else if ([cmd isEqualToString:@"44"]) {
        //读取蓝牙过滤规则2过滤的UUID
        NSString *rule = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
        NSString *uuid = @"";
        if ([rule integerValue] > 0 && content.length > 2) {
            uuid = [content substringWithRange:NSMakeRange(2, content.length - 2)];
        }
        resultDic = @{
            @"rule":rule,
            @"uuid":uuid
        };
        operationID = mk_bg_taskReadBLEFilterBUUIDOperation;
    }else if ([cmd isEqualToString:@"45"]) {
        //读取蓝牙过滤规则2过滤的RSSI
        NSNumber *rssi = [MKBLEBaseSDKAdopter signedHexTurnString:content];
        resultDic = @{
            @"rssi":rssi,
        };
        operationID = mk_bg_taskReadBLEFilterBRssiOperation;
    }else if ([cmd isEqualToString:@"46"]) {
        //读取蓝牙过滤规则2过滤PHY
        BOOL isOn = [[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"];
        NSString *type = @"";
        if (isOn && content.length == 4) {
            type = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
        }
        resultDic = @{
            @"isOn":@(isOn),
            @"type":type,
        };
        operationID = mk_bg_taskReadBLEFilterBByPHYOperation;
    }else if ([cmd isEqualToString:@"47"]) {
        //读取GPS冷启动超时时间
        resultDic = @{
            @"time":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bg_taskReadGpsColdStardTimeOperation;
    }else if ([cmd isEqualToString:@"48"]) {
        //读取GPS粗定位精度
        resultDic = @{
            @"value":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bg_taskReadGpsCoarseAccuracyMaskOperation;
    }else if ([cmd isEqualToString:@"49"]) {
        //读取GPS精确定位精度
        resultDic = @{
            @"value":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bg_taskReadGpsFineAccuracyTargetOperation;
    }else if ([cmd isEqualToString:@"4a"]) {
        //读取GPS粗定位超时时间
        resultDic = @{
            @"time":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bg_taskReadGpsCoarseTimeOperation;
    }else if ([cmd isEqualToString:@"4b"]) {
        //读取GPS精确定位超时时间
        resultDic = @{
            @"time":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bg_taskReadGpsFineTimeOperation;
    }else if ([cmd isEqualToString:@"4c"]) {
        //读取GPS位置精度因子
        resultDic = @{
            @"value":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bg_taskReadGpsPDOPLimitOperation;
    }else if ([cmd isEqualToString:@"4d"]) {
        //读取GPS搜星模式
        resultDic = @{
            @"type":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bg_taskReadGpsFixModeOperation;
    }else if ([cmd isEqualToString:@"4e"]) {
        //读取GPS模式
        resultDic = @{
            @"type":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bg_taskReadGpsModeOperation;
    }else if ([cmd isEqualToString:@"4f"]) {
        //读取GPS定位预算
        resultDic = @{
            @"time":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bg_taskReadGpsTimeBudgetOperation;
    }else if ([cmd isEqualToString:@"50"]) {
        //读取GPS辅助定位状态
        BOOL isOn = [content isEqualToString:@"01"];
        resultDic = @{
            @"isOn":@(isOn),
        };
        operationID = mk_bg_taskReadGpsAutonomousAidingStatusOperation;
    }else if ([cmd isEqualToString:@"51"]) {
        //读取GPS辅助定位精度
        resultDic = @{
            @"value":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bg_taskReadGpsAdingAccuracyOperation;
    }else if ([cmd isEqualToString:@"52"]) {
        //读取GPS辅助定位超时时间
        resultDic = @{
            @"time":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bg_taskReadGpsAidingTimeOperation;
    }else if ([cmd isEqualToString:@"53"]) {
        //读取GPS上传数据类型
        BOOL extremeMode = [content isEqualToString:@"01"];
        resultDic = @{
            @"extremeMode":@(extremeMode),
        };
        operationID = mk_bg_taskReadGpsExtremeModeStatusOperation;
    }else if ([cmd isEqualToString:@"60"]) {
        //读取LoRaWAN频段
        resultDic = @{
            @"region":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bg_taskReadLorawanRegionOperation;
    }else if ([cmd isEqualToString:@"61"]) {
        //读取LoRaWAN入网类型
        resultDic = @{
            @"modem":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bg_taskReadLorawanModemOperation;
    }else if ([cmd isEqualToString:@"62"]) {
        //读取LoRaWAN网络状态
        resultDic = @{
            @"status":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bg_taskReadLorawanNetworkStatusOperation;
    }else if ([cmd isEqualToString:@"63"]) {
        //读取LoRaWAN DEVEUI
        resultDic = @{
            @"devEUI":content,
        };
        operationID = mk_bg_taskReadLorawanDEVEUIOperation;
    }else if ([cmd isEqualToString:@"64"]) {
        //读取LoRaWAN APPEUI
        resultDic = @{
            @"appEUI":content
        };
        operationID = mk_bg_taskReadLorawanAPPEUIOperation;
    }else if ([cmd isEqualToString:@"65"]) {
        //读取LoRaWAN APPKEY
        resultDic = @{
            @"appKey":content
        };
        operationID = mk_bg_taskReadLorawanAPPKEYOperation;
    }else if ([cmd isEqualToString:@"66"]) {
        //读取LoRaWAN DEVADDR
        resultDic = @{
            @"devAddr":content
        };
        operationID = mk_bg_taskReadLorawanDEVADDROperation;
    }else if ([cmd isEqualToString:@"67"]) {
        //读取LoRaWAN APPSKEY
        resultDic = @{
            @"appSkey":content
        };
        operationID = mk_bg_taskReadLorawanAPPSKEYOperation;
    }else if ([cmd isEqualToString:@"68"]) {
        //读取LoRaWAN nwkSkey
        resultDic = @{
            @"nwkSkey":content
        };
        operationID = mk_bg_taskReadLorawanNWKSKEYOperation;
    }else if ([cmd isEqualToString:@"69"]) {
        //读取LoRaWAN 上行数据类型
        resultDic = @{
            @"messageType":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bg_taskReadLorawanMessageTypeOperation;
    }else if ([cmd isEqualToString:@"6a"]) {
        //读取LoRaWAN CH
        resultDic = @{
            @"CHL":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)],
            @"CHH":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)]
        };
        operationID = mk_bg_taskReadLorawanCHOperation;
    }else if ([cmd isEqualToString:@"6b"]) {
        //读取LoRaWAN DR
        resultDic = @{
            @"DR":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bg_taskReadLorawanDROperation;
    }else if ([cmd isEqualToString:@"6c"]) {
        //读取LoRaWAN 数据发送策略
        BOOL isOn = ([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"]);
        NSString *transmissions = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
        NSString *DRL = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 2)];
        NSString *DRH = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(6, 2)];
        resultDic = @{
            @"isOn":@(isOn),
            @"transmissions":transmissions,
            @"DRL":DRL,
            @"DRH":DRH,
        };
        operationID = mk_bg_taskReadLorawanUplinkStrategyOperation;
    }else if ([cmd isEqualToString:@"6d"]) {
        //读取LoRaWAN duty cycle
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_bg_taskReadLorawanDutyCycleStatusOperation;
    }else if ([cmd isEqualToString:@"6e"]) {
        //读取LoRaWAN devtime指令同步间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bg_taskReadLorawanDevTimeSyncIntervalOperation;
    }else if ([cmd isEqualToString:@"6f"]) {
        //读取LoRaWAN 定时重连时间
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bg_taskReadLorawanReconnectIntervalOperation;
    }else if ([cmd isEqualToString:@"07"]) {
        //读取iBeacon数据上报间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bg_taskReadBeaconReportIntervalOperation;
    }else if ([cmd isEqualToString:@"09"]) {
        //读取重复数据过滤类型
        resultDic = @{
            @"type":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bg_taskReadFilterRepeatingDataTypeOperation;
    }else if ([cmd isEqualToString:@"0a"]) {
        //读取上报的iBeacon数据类型
        NSString *state = [MKBLEBaseSDKAdopter binaryByhex:content];
        BOOL unknown = [[state substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL iBeacon = [[state substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL eddystone = [[state substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        resultDic = @{
            @"unknown":@(unknown),
            @"iBeacon":@(iBeacon),
            @"eddystone":@(eddystone),
        };
        operationID = mk_bg_taskReadBeaconReportDataTypeOperation;
    }else if ([cmd isEqualToString:@"0b"]) {
        //读取上报的iBeacon最大数据长度
        resultDic = @{
            @"type":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bg_taskReadBeaconReportDataMaxLengthOperation;
    }else if ([cmd isEqualToString:@"0d"]) {
        //读取mac地址
        NSString *macAddress = [NSString stringWithFormat:@"%@:%@:%@:%@:%@:%@",[content substringWithRange:NSMakeRange(0, 2)],[content substringWithRange:NSMakeRange(2, 2)],[content substringWithRange:NSMakeRange(4, 2)],[content substringWithRange:NSMakeRange(6, 2)],[content substringWithRange:NSMakeRange(8, 2)],[content substringWithRange:NSMakeRange(10, 2)]];
        operationID = mk_bg_taskReadMacAddressOperation;
        resultDic = @{@"macAddress":[macAddress uppercaseString]};
    }else if ([cmd isEqualToString:@"0e"]) {
        //读取iBeacon上报数据内容选择
        NSString *state = [MKBLEBaseSDKAdopter binaryByhex:content];
        BOOL response = [[state substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
        BOOL broadcast = [[state substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
        BOOL rssi = [[state substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
        BOOL mac = [[state substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
        BOOL timestamp = [[state substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
        resultDic = @{
            @"response":@(response),
            @"broadcast":@(broadcast),
            @"rssi":@(rssi),
            @"mac":@(mac),
            @"timestamp":@(timestamp),
        };
        operationID = mk_bg_taskReadBeaconReportDataContentOperation;
    }else if ([cmd isEqualToString:@"0f"]) {
        //读取扫描MAC超限开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_bg_taskReadMacOverLimitScanStatusOperation;
    }else if ([cmd isEqualToString:@"10"]) {
        //读取扫描MAC超限间隔
        resultDic = @{
            @"duration":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bg_taskReadMacOverLimitDurationOperation;
    }else if ([cmd isEqualToString:@"11"]) {
        //读取扫描MAC超限数量
        resultDic = @{
            @"quantities":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bg_taskReadMacOverLimitQuantitiesOperation;
    }else if ([cmd isEqualToString:@"12"]) {
        //读取扫描MAC超限RSSI
        resultDic = @{
            @"rssi":[MKBLEBaseSDKAdopter signedHexTurnString:content],
        };
        operationID = mk_bg_taskReadMacOverLimitRSSIOperation;
    }else if ([cmd isEqualToString:@"50"]) {
        //读取蓝牙名称
        NSData *nameData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
        NSString *deviceName = [[NSString alloc] initWithData:nameData encoding:NSUTF8StringEncoding];
        resultDic = @{
            @"deviceName":(MKValidStr(deviceName) ? deviceName : @""),
        };
        operationID = mk_bg_taskReadDeviceNameOperation;
    }else if ([cmd isEqualToString:@"51"]) {
        //读取蓝牙广播间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_bg_taskReadBroadcastIntervalOperation;
    }else if ([cmd isEqualToString:@"52"]) {
        //读取蓝牙扫描开关状态
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_bg_taskReadScanStatusOperation;
    }else if ([cmd isEqualToString:@"53"]) {
        //读取扫描参数
        NSString *scanWindow = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
        resultDic = @{
            @"scanWindow":scanWindow,
        };
        operationID = mk_bg_taskReadScanParamsOperation;
    }
    return [self dataParserGetDataSuccess:resultDic operationID:operationID];
}

+ (NSDictionary *)parseCustomConfigData:(NSString *)content cmd:(NSString *)cmd {
    mk_bg_taskOperationID operationID = mk_bg_defaultTaskOperationID;
    BOOL success = [content isEqualToString:@"01"];
    if ([cmd isEqualToString:@"01"]) {
        //重启设备
        operationID = mk_bg_taskRestartDeviceOperation;
    }else if ([cmd isEqualToString:@"02"]) {
        //设置时间同步
        operationID = mk_bg_taskFactoryResetOperation;
    }else if ([cmd isEqualToString:@"03"]) {
        //设置时间同步
        operationID = mk_bg_taskConfigDeviceTimeOperation;
    }else if ([cmd isEqualToString:@"04"]) {
        //设置时区
        operationID = mk_bg_taskConfigTimeZoneOperation;
    }else if ([cmd isEqualToString:@"05"]) {
        //设置连接密码
        operationID = mk_bg_taskConfigPasswordOperation;
    }else if ([cmd isEqualToString:@"06"]) {
        //设置工作模式
        operationID = mk_bg_taskConfigWorkModeOperation;
    }else if ([cmd isEqualToString:@"08"]) {
        //设置心跳间隔
        operationID = mk_bg_taskConfigHeartbeatIntervalOperation;
    }else if ([cmd isEqualToString:@"0b"]) {
        //设置离线定位功能
        operationID = mk_bg_taskConfigOfflineFixStatusOperation;
    }else if ([cmd isEqualToString:@"30"]) {
        //设置WIFI定位超时时间
        operationID = mk_bg_taskConfigWifiPositioningTimeoutOperation;
    }else if ([cmd isEqualToString:@"31"]) {
        //设置WIFI定位成功BSSID数量
        operationID = mk_bg_taskConfigWifiNumberOfBSSIDOperation;
    }else if ([cmd isEqualToString:@"32"]) {
        //设置BLE定位超时时间
        operationID = mk_bg_taskConfigBLEPositioningTimeoutOperation;
    }else if ([cmd isEqualToString:@"33"]) {
        //设置BLE定位成功Mac数量
        operationID = mk_bg_taskConfigBLENumberOfMacOperation;
    }else if ([cmd isEqualToString:@"34"]) {
        //配置蓝牙过滤规则开关逻辑
        operationID = mk_bg_taskConfigBLELogicalRelationshipOperation;
    }else if ([cmd isEqualToString:@"35"]) {
        //配置过滤规则1的开关状态
        operationID = mk_bg_taskConfigBLEFilterAStatusOperation;
    }else if ([cmd isEqualToString:@"36"]) {
        //配置过滤规则1的广播名称
        operationID = mk_bg_taskConfigBLEFilterADeviceNameOperation;
    }else if ([cmd isEqualToString:@"37"]) {
        //配置过滤规则1的MAC地址
        operationID = mk_bg_taskConfigBLEFilterAMacOperation;
    }else if ([cmd isEqualToString:@"38"]) {
        //配置过滤规则1的MAJOR范围
        operationID = mk_bg_taskConfigBLEFilterAMajorOperation;
    }else if ([cmd isEqualToString:@"39"]) {
        //配置过滤规则1的MINOR范围
        operationID = mk_bg_taskConfigBLEFilterAMinorOperation;
    }else if ([cmd isEqualToString:@"3a"]) {
        //配置过滤规则1的raw data
        operationID = mk_bg_taskConfigBLEFilterARawDataOperation;
    }else if ([cmd isEqualToString:@"3b"]) {
        //配置过滤规则1的UUID
        operationID = mk_bg_taskConfigBLEFilterAUUIDOperation;
    }else if ([cmd isEqualToString:@"3c"]) {
        //配置过滤规则1的RSSI
        operationID = mk_bg_taskConfigBLEFilterARSSIOperation;
    }else if ([cmd isEqualToString:@"3d"]) {
        //配置过滤规则1PHY
        operationID = mk_bg_taskConfigBLEFilterAByPHYOperation;
    }else if ([cmd isEqualToString:@"3e"]) {
        //配置过滤规则2的开关状态
        operationID = mk_bg_taskConfigBLEFilterBStatusOperation;
    }else if ([cmd isEqualToString:@"3f"]) {
        //配置过滤规则2的广播名称
        operationID = mk_bg_taskConfigBLEFilterBDeviceNameOperation;
    }else if ([cmd isEqualToString:@"40"]) {
        //配置过滤规则2的MAC地址
        operationID = mk_bg_taskConfigBLEFilterBMacOperation;
    }else if ([cmd isEqualToString:@"41"]) {
        //配置过滤规则2的MAJOR范围
        operationID = mk_bg_taskConfigBLEFilterBMajorOperation;
    }else if ([cmd isEqualToString:@"42"]) {
        //配置过滤规则2的MINOR范围
        operationID = mk_bg_taskConfigBLEFilterBMinorOperation;
    }else if ([cmd isEqualToString:@"43"]) {
        //配置过滤规则2的raw data
        operationID = mk_bg_taskConfigBLEFilterBRawDataOperation;
    }else if ([cmd isEqualToString:@"44"]) {
        //配置过滤规则2的UUID
        operationID = mk_bg_taskConfigBLEFilterBUUIDOperation;
    }else if ([cmd isEqualToString:@"45"]) {
        //配置过滤规则2的RSSI
        operationID = mk_bg_taskConfigBLEFilterBRSSIOperation;
    }else if ([cmd isEqualToString:@"46"]) {
        //配置过滤规则2PHY
        operationID = mk_bg_taskConfigBLEFilterBByPHYOperation;
    }else if ([cmd isEqualToString:@"47"]) {
        //配置GPS冷启动超时时间
        operationID = mk_bg_taskConfigGpsColdStardTimeOperation;
    }else if ([cmd isEqualToString:@"48"]) {
        //配置GPS粗定位精度
        operationID = mk_bg_taskConfigGpsCoarseAccuracyMaskOperation;
    }else if ([cmd isEqualToString:@"49"]) {
        //配置GPS精确定位精度
        operationID = mk_bg_taskConfigGpsFineAccuracyTargetOperation;
    }else if ([cmd isEqualToString:@"4a"]) {
        //配置GPS粗定位超时时间
        operationID = mk_bg_taskConfigGpsCoarseTimeOperation;
    }else if ([cmd isEqualToString:@"4b"]) {
        //配置GPS精确定位超时时间
        operationID = mk_bg_taskConfigGpsFineTimeOperation;
    }else if ([cmd isEqualToString:@"4c"]) {
        //配置GPS位置精度因子
        operationID = mk_bg_taskConfigGpsPDOPLimitOperation;
    }else if ([cmd isEqualToString:@"4d"]) {
        //配置GPS搜星模式
        operationID = mk_bg_taskConfigGpsFixModeOperation;
    }else if ([cmd isEqualToString:@"4e"]) {
        //配置GPS模式
        operationID = mk_bg_taskConfigGpsModeOperation;
    }else if ([cmd isEqualToString:@"4f"]) {
        //配置GPS定位预算
        operationID = mk_bg_taskConfigGpsTimeBudgetOperation;
    }else if ([cmd isEqualToString:@"50"]) {
        //配置GPS辅助定位状态
        operationID = mk_bg_taskConfigGpsAutonomousAidingStatusOperation;
    }else if ([cmd isEqualToString:@"51"]) {
        //配置GPS辅助定位精度
        operationID = mk_bg_taskConfigGpsAdingAccuracyOperation;
    }else if ([cmd isEqualToString:@"52"]) {
        //配置GPS辅助定位超时时间
        operationID = mk_bg_taskConfigGpsAidingTimeOperation;
    }else if ([cmd isEqualToString:@"53"]) {
        //配置GPS上传数据类型
        operationID = mk_bg_taskConfigGpsExtremeModeStatusOperation;
    }else if ([cmd isEqualToString:@"60"]) {
        //region
        operationID = mk_bg_taskConfigRegionOperation;
    }else if ([cmd isEqualToString:@"61"]) {
        //modem
        operationID = mk_bg_taskConfigModemOperation;
    }else if ([cmd isEqualToString:@"63"]) {
        //devEUI
        operationID = mk_bg_taskConfigDEVEUIOperation;
    }else if ([cmd isEqualToString:@"64"]) {
        //appEUI
        operationID = mk_bg_taskConfigAPPEUIOperation;
    }else if ([cmd isEqualToString:@"65"]) {
        //appKey
        operationID = mk_bg_taskConfigAPPKEYOperation;
    }else if ([cmd isEqualToString:@"66"]) {
        //devAddr
        operationID = mk_bg_taskConfigDEVADDROperation;
    }else if ([cmd isEqualToString:@"67"]) {
        //appSkey
        operationID = mk_bg_taskConfigAPPSKEYOperation;
    }else if ([cmd isEqualToString:@"68"]) {
        //nwkSkey
        operationID = mk_bg_taskConfigNWKSKEYOperation;
    }else if ([cmd isEqualToString:@"69"]) {
        //message type
        operationID = mk_bg_taskConfigMessageTypeOperation;
    }else if ([cmd isEqualToString:@"6a"]) {
        //CH
        operationID = mk_bg_taskConfigCHValueOperation;
    }else if ([cmd isEqualToString:@"6b"]) {
        //DR
        operationID = mk_bg_taskConfigDRValueOperation;
    }else if ([cmd isEqualToString:@"6c"]) {
        //LoRaWAN数据发送策略
        operationID = mk_bg_taskConfigUplinkStrategyOperation;
    }else if ([cmd isEqualToString:@"6d"]) {
        //duty cycle
        operationID = mk_bg_taskConfigDutyCycleStatusOperation;
    }else if ([cmd isEqualToString:@"6e"]) {
        //sync time interval
        operationID = mk_bg_taskConfigTimeSyncIntervalOperation;
    }else if ([cmd isEqualToString:@"6f"]) {
        //LoRaWAN定时重连时间
        operationID = mk_bg_taskConfigReconnectIntervalOperation;
    }else if ([cmd isEqualToString:@"07"]) {
        //设置iBeacon数据上报间隔
        operationID = mk_bg_taskConfigBeaconReportIntervalOperation;
    }else if ([cmd isEqualToString:@"09"]) {
        //配置重复数据过滤规则
        operationID = mk_bg_taskConfigFilterRepeatingDataTypeOperation;
    }else if ([cmd isEqualToString:@"0a"]) {
        //设置iBeacon数据上报类型
        operationID = mk_bg_taskConfigBeaconReportDataTypeOperation;
    }else if ([cmd isEqualToString:@"0e"]) {
        //配置iBeacon上报数据内容选择
        operationID = mk_bg_taskConfigBeaconReportDataContentOperation;
    }else if ([cmd isEqualToString:@"0f"]) {
        //配置扫描MAC超限开关
        operationID = mk_bg_taskConfigMacOverLimitScanStatusOperation;
    }else if ([cmd isEqualToString:@"10"]) {
        //配置扫描MAC超限间隔
        operationID = mk_bg_taskConfigMacOverLimitDurationOperation;
    }else if ([cmd isEqualToString:@"11"]) {
        //配置扫描MAC超限数量
        operationID = mk_bg_taskConfigMacOverLimitQuantitiesOperation;
    }else if ([cmd isEqualToString:@"12"]) {
        //配置扫描MAC超限RSSI
        operationID = mk_bg_taskConfigMacOverLimitRssiOperation;
    }else if ([cmd isEqualToString:@"50"]) {
        //配置广播名称
        operationID = mk_bg_taskConfigDeviceNameOperation;
    }else if ([cmd isEqualToString:@"51"]) {
        //配置广播间隔
        operationID = mk_bg_taskConfigDeviceBroadcastIntervalOperation;
    }else if ([cmd isEqualToString:@"52"]) {
        //配置扫描开关
        operationID = mk_bg_taskConfigScanStatusOperation;
    }else if ([cmd isEqualToString:@"53"]) {
        //配置扫描参数
        operationID = mk_bg_taskConfigScanParamsOperation;
    }else if ([cmd isEqualToString:@"a0"]) {
        //读取多少天本地存储的数据
        operationID = mk_bg_taskReadNumberOfDaysStoredDataOperation;
    }else if ([cmd isEqualToString:@"a1"]) {
        //清除存储的所有数据
        operationID = mk_bg_taskClearAllDatasOperation;
    }else if ([cmd isEqualToString:@"a2"]) {
        //暂停/恢复数据传输
        operationID = mk_bg_taskPauseSendLocalDataOperation;
    }
    return [self dataParserGetDataSuccess:@{@"success":@(success)} operationID:operationID];
}

#pragma mark -

+ (NSDictionary *)dataParserGetDataSuccess:(NSDictionary *)returnData operationID:(mk_bg_taskOperationID)operationID{
    if (!returnData) {
        return @{};
    }
    return @{@"returnData":returnData,@"operationID":@(operationID)};
}

@end
