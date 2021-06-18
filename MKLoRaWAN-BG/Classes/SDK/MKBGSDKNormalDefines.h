
#pragma mark ****************************************Enumerate************************************************

#pragma mark - MKBGCentralManager

typedef NS_ENUM(NSInteger, mk_bg_centralConnectStatus) {
    mk_bg_centralConnectStatusUnknow,                                           //未知状态
    mk_bg_centralConnectStatusConnecting,                                       //正在连接
    mk_bg_centralConnectStatusConnected,                                        //连接成功
    mk_bg_centralConnectStatusConnectedFailed,                                  //连接失败
    mk_bg_centralConnectStatusDisconnect,
};

typedef NS_ENUM(NSInteger, mk_bg_centralManagerStatus) {
    mk_bg_centralManagerStatusUnable,                           //不可用
    mk_bg_centralManagerStatusEnable,                           //可用状态
};

#pragma mark - interface

typedef NS_ENUM(NSInteger, mk_bg_filterRulesType) {
    mk_bg_filterRulesClassAType,
    mk_bg_filterRulesClassBType,
};

typedef NS_ENUM(NSInteger, mk_bg_deviceMode) {
    mk_bg_deviceMode_offMode,             //Off mode
    mk_bg_deviceMode_standbyMode,         //Standby mode
    mk_bg_deviceMode_periodicMode,        //Periodic mode
    mk_bg_deviceMode_timingMode,          //Timing mode
    mk_bg_deviceMode_motionMode,          //Motion Mode
};

typedef NS_ENUM(NSInteger, mk_bg_repoweredDefaultMode) {
    mk_bg_repoweredDefaultMode_offMode,             //Off mode
    mk_bg_repoweredDefaultMode_revertToLastMode,    //Revert To Last Mode
};

typedef NS_ENUM(NSInteger, mk_bg_lowPowerPrompt) {
    mk_bg_lowPowerPrompt_fivePercent,
    mk_bg_lowPowerPrompt_tenPercent
};

typedef NS_ENUM(NSInteger, mk_bg_positioningStrategy) {
    mk_bg_positioningStrategy_wifi,
    mk_bg_positioningStrategy_ble,
    mk_bg_positioningStrategy_gps,
    mk_bg_positioningStrategy_wifiAndGps,
    mk_bg_positioningStrategy_bleAndGps,
    mk_bg_positioningStrategy_wifiAndBle,
    mk_bg_positioningStrategy_wifiAndBleAndGps,
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

typedef NS_ENUM(NSInteger, mk_bg_txPower) {
    mk_bg_txPowerNeg40dBm,   //RadioTxPower:-40dBm
    mk_bg_txPowerNeg20dBm,   //-20dBm
    mk_bg_txPowerNeg16dBm,   //-16dBm
    mk_bg_txPowerNeg12dBm,   //-12dBm
    mk_bg_txPowerNeg8dBm,    //-8dBm
    mk_bg_txPowerNeg4dBm,    //-4dBm
    mk_bg_txPower0dBm,       //0dBm
    mk_bg_txPower2dBm,       //2dBm
    mk_bg_txPower3dBm,       //3dBm
    mk_bg_txPower4dBm,       //4dBm
    mk_bg_txPower5dBm,       //5dBm
    mk_bg_txPower6dBm,       //6dBm
    mk_bg_txPower7dBm,       //7dBm
    mk_bg_txPower8dBm,       //8dBm
};

#pragma mark - Protocol

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



@protocol mk_bg_timingModeReportingTimePointProtocol <NSObject>

/// 0~23
@property (nonatomic, assign)NSInteger hour;

/// 0:00   1:15   2:30   3:45
@property (nonatomic, assign)NSInteger minuteGear;

@end



@protocol mk_bg_motionModeEventsProtocol <NSObject>

@property (nonatomic, assign)BOOL notifyEventOnStart;

@property (nonatomic, assign)BOOL fixOnStart;

@property (nonatomic, assign)BOOL notifyEventInTrip;

@property (nonatomic, assign)BOOL fixInTrip;

@property (nonatomic, assign)BOOL notifyEventOnEnd;

@property (nonatomic, assign)BOOL fixOnEnd;

@end

@protocol mk_bg_indicatorSettingsProtocol <NSObject>

@property (nonatomic, assign)BOOL Tamper;
@property (nonatomic, assign)BOOL LowPower;
@property (nonatomic, assign)BOOL InBluetoothFix;
@property (nonatomic, assign)BOOL BTFixSuccessful;
@property (nonatomic, assign)BOOL FailToBTFix;
@property (nonatomic, assign)BOOL InGPSFix;
@property (nonatomic, assign)BOOL GPSFixsuccessful;
@property (nonatomic, assign)BOOL FailToGPSFix;
@property (nonatomic, assign)BOOL InWIFIFix;
@property (nonatomic, assign)BOOL WIFIFixSuccessful;
@property (nonatomic, assign)BOOL FailToWIFIFix;

@end

#pragma mark ****************************************Delegate************************************************

@protocol mk_bg_centralManagerScanDelegate <NSObject>

/// Scan to new device.
/// @param deviceModel device
- (void)mk_bg_receiveDevice:(NSDictionary *)deviceModel;

@optional

/// Starts scanning equipment.
- (void)mk_bg_startScan;

/// Stops scanning equipment.
- (void)mk_bg_stopScan;

@end
