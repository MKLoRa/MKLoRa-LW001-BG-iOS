//
//  MKBGSDKDataAdopter.m
//  MKLoRaWAN-BG
//
//  Created by aa on 2021/6/10.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKBGSDKDataAdopter.h"

#import "MKBLEBaseSDKDefines.h"
#import "MKBLEBaseSDKAdopter.h"

@implementation MKBGSDKDataAdopter

+ (NSString *)fetchPositioningStrategyCommand:(mk_bg_positioningStrategy)strategy {
    switch (strategy) {
        case mk_bg_positioningStrategy_wifi:
            return @"01";
        case mk_bg_positioningStrategy_ble:
            return @"02";
        case mk_bg_positioningStrategy_gps:
            return @"04";
        case mk_bg_positioningStrategy_wifiAndGps:
            return @"05";
        case mk_bg_positioningStrategy_bleAndGps:
            return @"06";
        case mk_bg_positioningStrategy_wifiAndBle:
            return @"03";
        case mk_bg_positioningStrategy_wifiAndBleAndGps:
            return @"07";
    }
}

+ (NSString *)fetchDeviceModeValue:(mk_bg_deviceMode)deviceMode {
    switch (deviceMode) {
        case mk_bg_deviceMode_offMode:
            return @"00";
        case mk_bg_deviceMode_standbyMode:
            return @"01";
        case mk_bg_deviceMode_periodicMode:
            return @"02";
        case mk_bg_deviceMode_timingMode:
            return @"03";
        case mk_bg_deviceMode_motionMode:
            return @"04";
    }
}

+ (NSString *)fetchGpsFixModeValue:(mk_bg_gpsFixMode)mode {
    switch (mode) {
        case mk_bg_gpsFixMode_2d:
            return @"00";
        case mk_bg_gpsFixMode_3d:
            return @"01";
        case mk_bg_gpsFixMode_auto:
            return @"02";
    }
}

+ (NSString *)fetchGpsModeValue:(mk_bg_gpsMode)mode {
    switch (mode) {
        case mk_bg_gpsMode_portable:
            return @"00";
        case mk_bg_gpsMode_stationary:
            return @"01";
        case mk_bg_gpsMode_pedestrian:
            return @"02";
        case mk_bg_gpsMode_automotive:
            return @"03";
        case mk_bg_gpsMode_atSea:
            return @"04";
        case mk_bg_gpsMode_airborneLessThan1g:
            return @"05";
        case mk_bg_gpsMode_airborneLessThan2g:
            return @"06";
        case mk_bg_gpsMode_airborneLessThan4g:
            return @"07";
        case mk_bg_gpsMode_wrist:
            return @"08";
        case mk_bg_gpsMode_bike:
            return @"09";
    }
}

+ (NSString *)lorawanRegionString:(mk_bg_loraWanRegion)region {
    switch (region) {
        case mk_bg_loraWanRegionAS923:
            return @"00";
        case mk_bg_loraWanRegionAU915:
            return @"01";
        case mk_bg_loraWanRegionCN470:
            return @"02";
        case mk_bg_loraWanRegionCN779:
            return @"03";
        case mk_bg_loraWanRegionEU433:
            return @"04";
        case mk_bg_loraWanRegionEU868:
            return @"05";
        case mk_bg_loraWanRegionKR920:
            return @"06";
        case mk_bg_loraWanRegionIN865:
            return @"07";
        case mk_bg_loraWanRegionUS915:
            return @"08";
        case mk_bg_loraWanRegionRU864:
            return @"09";
    }
}

+ (BOOL)isConfirmRawFilterProtocol:(id <mk_bg_BLEFilterRawDataProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_bg_BLEFilterRawDataProtocol)]) {
        return NO;
    }
    if (!MKValidStr(protocol.dataType) || protocol.dataType.length != 2 || ![MKBLEBaseSDKAdopter checkHexCharacter:protocol.dataType]) {
        return NO;
    }
    if (protocol.minIndex == 0 && protocol.maxIndex == 0) {
        if (!MKValidStr(protocol.rawData) || protocol.rawData.length > 58 || ![MKBLEBaseSDKAdopter checkHexCharacter:protocol.rawData] || (protocol.rawData.length % 2 != 0)) {
            return NO;
        }
        return YES;
    }
    if (protocol.minIndex < 0 || protocol.minIndex > 62 || protocol.maxIndex < 0 || protocol.maxIndex > 62) {
        return NO;
    }
    
    if (protocol.maxIndex < protocol.minIndex) {
        return NO;
    }
    if (!MKValidStr(protocol.rawData) || protocol.rawData.length > 58 || ![MKBLEBaseSDKAdopter checkHexCharacter:protocol.rawData]) {
        return NO;
    }
    NSInteger totalLen = (protocol.maxIndex - protocol.minIndex + 1) * 2;
    if (protocol.rawData.length != totalLen) {
        return NO;
    }
    return YES;
}

+ (NSString *)fetchTimingModeReportingTimePoint:(NSArray <mk_bg_timingModeReportingTimePointProtocol>*)dataList {
    if (dataList.count > 10) {
        return @"";
    }
    if (!MKValidArray(dataList)) {
        return @"00";
    }
    NSString *len = [MKBLEBaseSDKAdopter fetchHexValue:dataList.count byteLen:1];
    NSString *resultString = len;
    for (NSInteger i = 0; i < dataList.count; i ++) {
        id <mk_bg_timingModeReportingTimePointProtocol>data = dataList[i];
        if (data.hour < 0 || data.hour > 23 || data.minuteGear < 0 || data.minuteGear > 3) {
            return @"";
        }
        NSInteger timeValue = 0;
        if (data.hour == 0 && data.minuteGear == 0) {
            timeValue = 96;
        }else {
            timeValue = 4 * data.hour + data.minuteGear;
        }
        NSString *timeString = [MKBLEBaseSDKAdopter fetchHexValue:timeValue byteLen:1];
        resultString = [resultString stringByAppendingString:timeString];
    }
    return resultString;
}

+ (NSArray <NSDictionary *>*)parseTimingModeReportingTimePoint:(NSString *)content {
    if (!MKValidStr(content) || content.length < 2) {
        return @[];
    }
    if ([content isEqualToString:@"00"]) {
        return @[];
    }
    NSInteger totalByte = content.length / 2;
    NSMutableArray *tempList = [NSMutableArray array];
    
    for (NSInteger i = 0; i < totalByte; i ++) {
        NSString *tempString = [content substringWithRange:NSMakeRange(i * 2, 2)];
        NSInteger tempValue = [MKBLEBaseSDKAdopter getDecimalWithHex:tempString range:NSMakeRange(0, tempString.length)];
        NSInteger hour = 0;
        NSInteger minuteGear = 0;
        if (tempValue < 96) {
            //如果是96，表示00:00
            hour = tempValue / 4;
            minuteGear = tempValue % 4;
        }
        [tempList addObject:@{
            @"hour":@(hour),
            @"minuteGear":@(minuteGear),
        }];
    }
    
    return tempList;
}

+ (NSString *)fetchTxPower:(mk_bg_txPower)txPower {
    switch (txPower) {
        case mk_bg_txPower8dBm:
            return @"08";
        case mk_bg_txPower7dBm:
            return @"07";
        case mk_bg_txPower6dBm:
            return @"06";
        case mk_bg_txPower5dBm:
            return @"05";
        case mk_bg_txPower4dBm:
            return @"04";
        case mk_bg_txPower3dBm:
            return @"03";
        case mk_bg_txPower2dBm:
            return @"02";
        case mk_bg_txPower0dBm:
            return @"00";
        case mk_bg_txPowerNeg4dBm:
            return @"fc";
        case mk_bg_txPowerNeg8dBm:
            return @"f8";
        case mk_bg_txPowerNeg12dBm:
            return @"f4";
        case mk_bg_txPowerNeg16dBm:
            return @"f0";
        case mk_bg_txPowerNeg20dBm:
            return @"ec";
        case mk_bg_txPowerNeg40dBm:
            return @"d8";
    }
}

+ (NSDictionary *)fetchIndicatorSettings:(NSString *)content {
    NSString *binaryHigh = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(0, 2)]];
    NSString *binaryLow = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(2, 2)]];
    BOOL Tamper = [[binaryLow substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
    BOOL LowPower = [[binaryLow substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
    BOOL InBluetoothFix = [[binaryLow substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
    BOOL BTFixSuccessful = [[binaryLow substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
    BOOL FailToBTFix = [[binaryLow substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"];
    BOOL InGPSFix = [[binaryLow substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"];
    BOOL GPSFixsuccessful = [[binaryLow substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"];
    BOOL FailToGPSFix = [[binaryLow substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"];
    BOOL InWIFIFix = [[binaryHigh substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
    BOOL WIFIFixSuccessful = [[binaryHigh substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"];
    BOOL FailToWIFIFix = [[binaryHigh substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"];
    return @{
        @"Tamper":@(Tamper),
        @"LowPower":@(LowPower),
        @"InBluetoothFix":@(InBluetoothFix),
        @"BTFixSuccessful":@(BTFixSuccessful),
        @"FailToBTFix":@(FailToBTFix),
        @"InGPSFix":@(InGPSFix),
        @"GPSFixsuccessful":@(GPSFixsuccessful),
        @"FailToGPSFix":@(FailToGPSFix),
        @"InWIFIFix":@(InWIFIFix),
        @"WIFIFixSuccessful":@(WIFIFixSuccessful),
        @"FailToWIFIFix":@(FailToWIFIFix),
    };
}

+ (NSString *)fetchPHYTypeString:(mk_bg_PHYMode)mode {
    switch (mode) {
        case mk_bg_PHYMode_BLE4:
            return @"00";
        case mk_bg_PHYMode_BLE5:
            return @"01";
        case mk_bg_PHYMode_CodedBLE5:
            return @"02";
        case mk_bg_PHYMode_BLE4AndBLE5:
            return @"03";
    }
}

+ (NSString *)fetchOnOffMethodString:(mk_bg_OnOffMethod)method {
    switch (method) {
        case mk_bg_OnOffMethod_multipleApproaches:
            return @"00";
        case mk_bg_OnOffMethod_continuousApproach:
            return @"01";
    }
}

@end
