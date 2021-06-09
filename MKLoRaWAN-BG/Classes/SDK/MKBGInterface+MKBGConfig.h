//
//  MKBGInterface+MKBGConfig.h
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/17.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKBGInterface.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, mk_bg_deviceMode) {
    mk_bg_deviceMode_offMode,             //Off mode
    mk_bg_deviceMode_standbyMode,         //Standby mode
    mk_bg_deviceMode_periodicMode,        //Periodic mode
    mk_bg_deviceMode_timingMode,          //Timing mode
    mk_bg_deviceMode_motionMode,          //Motion Mode
};

typedef NS_ENUM(NSInteger, mk_bg_BLELogicalRelationship) {
    mk_bg_BLELogicalRelationshipOR,
    mk_bg_BLELogicalRelationshipAND
};

typedef NS_ENUM(NSInteger, mk_bg_filterRules) {
    mk_bg_filterRules_off,
    mk_bg_filterRules_forward,          //Filter data forward
    mk_bg_filterRules_reverse,          //Filter data in reverse
};

typedef NS_ENUM(NSInteger, mk_bg_filterByPHYMode) {
    mk_bg_filterByPHYMode_1MPHY,
    mk_bg_filterByPHYMode_2MPHY,
    mk_bg_filterByPHYMode_codedPHY,
};

typedef NS_ENUM(NSInteger, mk_bg_gpsFixMode) {
    mk_bg_gpsFixMode_2d,
    mk_bg_gpsFixMode_3d,
    mk_bg_gpsFixMode_auto,
};

typedef NS_ENUM(NSInteger, mk_bg_gpsMode) {
    mk_bg_gpsMode_portable,
    mk_bg_gpsMode_stationary,
    mk_bg_gpsMode_pedestrian,
    mk_bg_gpsMode_automotive,
    mk_bg_gpsMode_atSea,
    mk_bg_gpsMode_airborneLessThan1g,
    mk_bg_gpsMode_airborneLessThan2g,
    mk_bg_gpsMode_airborneLessThan4g,
    mk_bg_gpsMode_wrist,
    mk_bg_gpsMode_bike,
};

typedef NS_ENUM(NSInteger, mk_bg_loraWanRegion) {
    mk_bg_loraWanRegionAS923,
    mk_bg_loraWanRegionAU915,
    mk_bg_loraWanRegionCN470,
    mk_bg_loraWanRegionCN779,
    mk_bg_loraWanRegionEU433,
    mk_bg_loraWanRegionEU868,
    mk_bg_loraWanRegionKR920,
    mk_bg_loraWanRegionIN865,
    mk_bg_loraWanRegionUS915,
    mk_bg_loraWanRegionRU864,
};

typedef NS_ENUM(NSInteger, mk_bg_loraWanModem) {
    mk_bg_loraWanModemABP,
    mk_bg_loraWanModemOTAA,
};

typedef NS_ENUM(NSInteger, mk_bg_loraWanMessageType) {
    mk_bg_loraWanUnconfirmMessage,          //Non-acknowledgement frame.
    mk_bg_loraWanConfirmMessage,            //Confirm the frame.
};

@protocol mk_bg_BLEFilterRawDataProtocol <NSObject>

/// The currently filtered data type, refer to the definition of different Bluetooth data types by the International Bluetooth Organization, 1 byte of hexadecimal data
@property (nonatomic, copy)NSString *dataType;

/// Data location to start filtering.
@property (nonatomic, assign)NSInteger minIndex;

/// Data location to end filtering.
@property (nonatomic, assign)NSInteger maxIndex;

/// The currently filtered content. The data length should be maxIndex-minIndex, if maxIndex=0&&minIndex==0, the item length is not checked whether it meets the requirements.MAX length:29 Bytes
@property (nonatomic, copy)NSString *rawData;

@end

@interface MKBGInterface (MKBGConfig)

/// Restart the device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_restartDeviceWithSucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Reset.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_factoryResetWithSucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Sync device time.
/// @param timestamp UTC
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configDeviceTime:(unsigned long)timestamp
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the current time zone to the device.
/// @param timeZone Time Zone(-12~12)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configTimeZone:(NSInteger)timeZone
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure device connection password.
/// @param password 8-character ascii code
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configPassword:(NSString *)password
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the working mode of the device.
/// @param deviceMode device mode
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configWorkMode:(mk_bg_deviceMode)deviceMode
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the heartbeat packet interval of the device.
/// @param interval 300s~86400s
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configHeartbeatInterval:(long long)interval
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

///  Whether to enable positioning when the device fails to connect to the Lorawan network.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configOfflineFix:(BOOL)isOn
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the WIFI positioning timeout.
/// @param interval 1~5.   unit : 2s.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configWifiPositioningTimeout:(NSInteger)interval
                               sucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the number of BSSIDs with successful WIFI positioning.
/// @param number 1~5.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configWifiNumberOfBSSID:(NSInteger)number
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the BLE positioning timeout.
/// @param interval 1~10s.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configBLEPositioningTimeout:(NSInteger)interval
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the number of mac address with successful BLE positioning.
/// @param number 1~5.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configBLENumberOfMac:(NSInteger)number
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ****************************************蓝牙过滤规则************************************************

/// Configure the logical relationship between the two sets of filtering rules, the two sets of rules can be OR and and.
/// @param ship ship
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configBLELogicalRelationship:(mk_bg_BLELogicalRelationship)ship
                               sucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure filter rule switch status.
/// @param type rule1 or rule2
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configBLEFilterStatusWithType:(mk_bg_filterRulesType)type
                                    isOn:(BOOL)isOn
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the filtered device name.
/// @param type rule1 or rule2
/// @param rules rules
/// @param deviceName 1~29 ascii characters.If rules == mk_bg_filterRules_off, it can be empty.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configBLEFilterDeviceNameWithType:(mk_bg_filterRulesType)type
                                       rules:(mk_bg_filterRules)rules
                                  deviceName:(NSString *)deviceName
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the filtered device mac.
/// @param type rule1 or rule2
/// @param rules rules
/// @param mac 1Byte ~ 6Byte.If rules == mk_bg_filterRules_off, it can be empty.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configBLEFilterDeviceMacWithType:(mk_bg_filterRulesType)type
                                      rules:(mk_bg_filterRules)rules
                                        mac:(NSString *)mac
                                   sucBlock:(void (^)(void))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the filtered MAJOR range.
/// @param type rule1 or rule2
/// @param rules rules
/// @param majorMin 0~65535
/// @param majorMax majorMin ~ 65535
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configBLEFilterDeviceMajorWithType:(mk_bg_filterRulesType)type
                                        rules:(mk_bg_filterRules)rules
                                     majorMin:(NSInteger)majorMin
                                     majorMax:(NSInteger)majorMax
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the filtered MAINOR range.
/// @param type rule1 or rule2
/// @param rules rules
/// @param minorMin 0~65535
/// @param minorMax minorMin ~ 65535
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configBLEFilterDeviceMinorWithType:(mk_bg_filterRulesType)type
                                        rules:(mk_bg_filterRules)rules
                                     minorMin:(NSInteger)minorMin
                                     minorMax:(NSInteger)minorMax
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure filtered raw data.
/// @param type rule1 or rule2
/// @param rules rules
/// @param rawDataList Filter rules, up to five groups of filters.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configBLEFilterDeviceRawDataWithType:(mk_bg_filterRulesType)type
                                          rules:(mk_bg_filterRules)rules
                                    rawDataList:(NSArray <mk_bg_BLEFilterRawDataProtocol> *)rawDataList
                                       sucBlock:(void (^)(void))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure filtered UUID.
/// @param type rule1 or rule2
/// @param rules rules
/// @param uuid 1Byte ~ 16Byte.If rules == mk_bg_filterRules_off, it can be empty.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configBLEFilterDeviceUUIDWithType:(mk_bg_filterRulesType)type
                                       rules:(mk_bg_filterRules)rules
                                        uuid:(NSString *)uuid
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure filtered RSSI.
/// @param type rule1 or rule2
/// @param rssi -127dBm~0dBm
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configBLEFilterDeviceRSSIWithType:(mk_bg_filterRulesType)type
                                        rssi:(NSInteger)rssi
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure filter by PHY.
/// @param type rule1 or rule2
/// @param isOn isOn
/// @param phyMode Only for isOn = YES.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configBLEFilterDeviceByPHYWithType:(mk_bg_filterRulesType)type
                                         isOn:(BOOL)isOn
                                      phyMode:(mk_bg_filterByPHYMode)phyMode
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ****************************************GPS定位参数************************************************

/// Configure GPS cold start time.
/// @param time 3Mins~15Mins
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configGpsColdStardTime:(NSInteger)time
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure GPS coarse positioning accuracy.
/// @param value 5~100m
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configGpsCoarseAccuracyMask:(NSInteger)value
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure GPS precise positioning accuracy.
/// @param value 5~100m
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configGpsFineAccuracyTarget:(NSInteger)value
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure GPS coarse positioning timeout time.
/// @param time 1~7620s.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configGpsCoarseTime:(NSInteger)time
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure GPS precise positioning timeout time.
/// @param time 0~76200s.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configGpsFineTime:(NSInteger)time
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure GPS PDOP Limit.
/// @param value 25~100
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configGpsPDOPLimit:(NSInteger)value
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure GPS Fix Mode.
/// @param mode mode
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configGpsFixMode:(mk_bg_gpsFixMode)mode
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure GPS Mode.
/// @param mode mode
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configGpsMode:(mk_bg_gpsMode)mode
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure GPS Time Budget.
/// @param time 0~76200s
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configGpsTimeBudget:(long long)time
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure GPS Autonomous Aiding Switch Status.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configGpsAutonomousAidingStatus:(BOOL)isOn
                                  sucBlock:(void (^)(void))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure GPS Ading Accuracy.
/// @param value 5~1000m.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configGpsAdingAccuracy:(NSInteger)value
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure GPS Aiding Timeout.
/// @param time 1~7620s.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configGpsAidingTime:(NSInteger)time
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure GPS Extreme mode Switch Status.When Extrme Mode is on, the reported GPS data  will be shortened to achieve the maximum transmission distance.
/// @param extremeMode extremeMode
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configGpsExtremeModeStatus:(BOOL)extremeMode
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ****************************************设备lorawan信息设置************************************************

/// Configure the region information of LoRaWAN.
/// @param region region
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configRegion:(mk_bg_loraWanRegion)region
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure LoRaWAN network access type.
/// @param modem modem
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configModem:(mk_bg_loraWanModem)modem
              sucBlock:(void (^)(void))sucBlock
           failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the DEVEUI of LoRaWAN.
/// @param devEUI Hexadecimal characters, length must be 16.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configDEVEUI:(NSString *)devEUI
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the APPEUI of LoRaWAN.
/// @param appEUI Hexadecimal characters, length must be 16.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configAPPEUI:(NSString *)appEUI
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the APPKEY of LoRaWAN.
/// @param appKey Hexadecimal characters, length must be 32.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configAPPKEY:(NSString *)appKey
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the DEVADDR of LoRaWAN.
/// @param devAddr Hexadecimal characters, length must be 8.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configDEVADDR:(NSString *)devAddr
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the APPSKEY of LoRaWAN.
/// @param appSkey Hexadecimal characters, length must be 32.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configAPPSKEY:(NSString *)appSkey
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the NWKSKEY of LoRaWAN.
/// @param nwkSkey Hexadecimal characters, length must be 32.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configNWKSKEY:(NSString *)nwkSkey
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the message type of LoRaWAN.
/// @param messageType messageType
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configMessageType:(mk_bg_loraWanMessageType)messageType
                    sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the CH of LoRaWAN.
/// @param chlValue Minimum value of CH.0 ~ 95
/// @param chhValue Maximum value of CH. chlValue ~ 95
/// @param sucBlock Success callback
/// @param failedBlock  Failure callback
+ (void)bg_configCHL:(NSInteger)chlValue
                 CHH:(NSInteger)chhValue
            sucBlock:(void (^)(void))sucBlock
         failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the DR of LoRaWAN.
/// @param drValue 0~15
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configDR:(NSInteger)drValue
           sucBlock:(void (^)(void))sucBlock
        failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure LoRaWAN uplink data sending strategy.
/// @param isOn ADR is on.
/// @param twice Whether the data is sent twice.
/// @param DRL 0~15
/// @param DRH DRL~15
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configUplinkStrategy:(BOOL)isOn
                          twice:(BOOL)twice
                            DRL:(NSInteger)DRL
                            DRH:(NSInteger)DRH
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;

/// It is only used for EU868,CN779, EU433,AS923,KR920,IN865,and RU864. Off: The uplink report interval will not be limit by region freqency. On:The uplink report interval will be limit by region freqency.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configDutyCycleStatus:(BOOL)isOn
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Time Sync Interval.
/// @param interval 0h~255h.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configTimeSyncInterval:(NSInteger)interval
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure LoRaWAN timing reconnection Interval.
/// @param interval 0Day~30Days.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_configReconnectInterval:(NSInteger)interval
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
