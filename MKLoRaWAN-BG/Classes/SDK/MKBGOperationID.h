
typedef NS_ENUM(NSInteger, mk_bg_taskOperationID) {
    mk_bg_defaultTaskOperationID,
    
#pragma mark - Read
    mk_bg_taskReadBatteryPowerOperation,       //电池电量
    mk_bg_taskReadDeviceModelOperation,        //读取产品型号
    mk_bg_taskReadFirmwareOperation,           //读取固件版本
    mk_bg_taskReadHardwareOperation,           //读取硬件类型
    mk_bg_taskReadSoftwareOperation,           //读取软件版本
    mk_bg_taskReadManufacturerOperation,       //读取厂商信息
    mk_bg_taskReadDeviceTypeOperation,         //读取产品类型
    
#pragma mark - 密码特征
    mk_bg_connectPasswordOperation,             //连接设备时候发送密码
    
#pragma mark - 设备系统应用信息读取
    mk_bg_taskReadTimeZoneOperation,                  //读取时区
    mk_bg_taskReadPasswordOperation,                  //读取密码
    mk_bg_taskReadWorkModeOperation,                  //读取设备工作模式
    mk_bg_taskReadRepoweredDefaultModeOperation,      //读取设备上电后模式
    mk_bg_taskReadDeviceHeartbeatIntervalOperation,   //读取设备心跳间隔
    mk_bg_taskReadOffByMagnetStatusOperation,         //读取磁簧开关关机功能
    mk_bg_taskReadShutdownPayloadStatusOperation,     //读取关机信息上报
    mk_bg_taskReadOfflineFixStatusOperation,          //读取设备离线定位状态
    mk_bg_taskReadLowPowerParamsOperation,            //读取低电参数
    mk_bg_taskReadIndicatorSettingsOperation,         //读取指示灯功能
    mk_bg_taskReadTemperatureOfChipOperation,         //读取芯片温度
    mk_bg_taskReadCurrentSystemTimeZoneTimeOperation,   //读取当前系统时区时间
    mk_bg_taskReadBatteryLevelOperation,              //读取电池电量
    mk_bg_taskReadMacAddressOperation,                  //读取设备Mac地址
    mk_bg_taskReadPCBAStatusOperation,                  //读取产测标志
    mk_bg_taskReadSelftestStatusOperation,              //读取自检故障
    mk_bg_taskReadOnOffMethodOperation,                 //读取磁簧开关机方式
    mk_bg_taskReadBatteryInformationOperation,      //读取电池电量消耗
    mk_bg_taskReadLastCycleBatteryInformationOperation, //读取上一周期电池电量消耗
    mk_bg_taskReadAllCycleBatteryInformationOperation,  //读取所有周期电池电量消耗
    mk_bg_taskReadLowPowerPayloadStatusOperation,   //读取低电触发心跳开关状态
    mk_bg_taskReadLowPowerPromptOperation,          //读取低电百分比
    mk_bg_taskReadAutoPowerOnAfterChargingOperation,    //读取充电自动开机功能
    
#pragma mark - 模式相关参数
    mk_bg_taskReadPeriodicModePositioningStrategyOperation,         //读取定期模式定位策略
    mk_bg_taskReadPeriodicModeReportIntervalOperation,              //读取定期模式上报间隔
    mk_bg_taskReadTimingModePositioningStrategyOperation,           //读取定时模式定位策略
    mk_bg_taskReadTimingModeReportingTimePointOperation,            //读取定时模式时间点
    mk_bg_taskReadMotionModeEventsOperation,                        //读取运动模式事件
    mk_bg_taskReadMotionModeNumberOfFixOnStartOperation,            //读取运动开始定位上报次数
    mk_bg_taskReadMotionModePosStrategyOnStartOperation,            //读取运动开始定位策略
    mk_bg_taskReadMotionModeReportIntervalInTripOperation,          //读取运动中定位间隔
    mk_bg_taskReadMotionModePosStrategyInTripOperation,             //读取运动中定位策略
    mk_bg_taskReadMotionModeTripEndTimeoutOperation,                //读取运动结束判断时间
    mk_bg_taskReadMotionModeNumberOfFixOnEndOperation,              //读取运动结束定位次数
    mk_bg_taskReadMotionModeReportIntervalOnEndOperation,           //读取运动结束定位间隔
    mk_bg_taskReadMotionModePosStrategyOnEndOperation,              //读取运动结束定位策略
    mk_bg_taskReadDownlinkForPositioningStrategyOperation,          //读取下行请求定位策略
    
#pragma mark - 定位参数
    mk_bg_taskReadWifiPositioningTimeoutOperation,    //读取WIFI定位超时时间
    mk_bg_taskReadWifiNumberOfBSSIDOperation,         //读取WIFI定位成功BSSID数量
    mk_bg_taskReadBLEPositioningTimeoutOperation,     //读取BLE定位超时时间
    mk_bg_taskReadBLENumberOfMacOperation,            //读取蓝牙定位成功MAC数量
    
    
#pragma mark - 蓝牙过滤规则
    mk_bg_taskReadBLELogicalRelationshipOperation,  //读取两种蓝牙过滤规则关系
    mk_bg_taskReadBLEFilterAStatusOperation,        //读取蓝牙过滤规则1的开关状态
    mk_bg_taskReadBLEFilterADeviceNameOperation,    //读取蓝牙过滤规则1的过滤设备名字
    mk_bg_taskReadBLEFilterADeviceMacOperation,     //读取蓝牙过滤规则1的过滤设备MAC地址
    mk_bg_taskReadBLEFilterAMajorOperation,         //读取蓝牙过滤规则1的过滤major范围
    mk_bg_taskReadBLEFilterAMinorOperation,         //读取蓝牙过滤规则1的过滤minor范围
    mk_bg_taskReadBLEFilterARawDataOperation,       //读取蓝牙过滤规则1的过滤原始数据信息
    mk_bg_taskReadBLEFilterAUUIDOperation,          //读取蓝牙过滤规则1的过滤UUID信息
    mk_bg_taskReadBLEFilterARssiOperation,          //读取蓝牙过滤规则1的过滤rssi
    
    mk_bg_taskReadBLEFilterBStatusOperation,        //读取蓝牙过滤规则2的开关状态
    mk_bg_taskReadBLEFilterBDeviceNameOperation,    //读取蓝牙过滤规则2的过滤设备名字
    mk_bg_taskReadBLEFilterBDeviceMacOperation,     //读取蓝牙过滤规则2的过滤设备MAC地址
    mk_bg_taskReadBLEFilterBMajorOperation,         //读取蓝牙过滤规则2的过滤major范围
    mk_bg_taskReadBLEFilterBMinorOperation,         //读取蓝牙过滤规则2的过滤minor范围
    mk_bg_taskReadBLEFilterBRawDataOperation,       //读取蓝牙过滤规则2的过滤原始数据信息
    mk_bg_taskReadBLEFilterBUUIDOperation,          //读取蓝牙过滤规则2的过滤UUID信息
    mk_bg_taskReadBLEFilterBRssiOperation,          //读取蓝牙过滤规则2的过滤rssi
    
#pragma mark - GPS定位参数读取
    mk_bg_taskReadGpsColdStardTimeOperation,        //读取GPS冷启动超时时间
    mk_bg_taskReadGpsCoarseAccuracyMaskOperation,   //读取GPS粗定位精度
    mk_bg_taskReadGpsFineAccuracyTargetOperation,   //读取GPS精确定位精度
    mk_bg_taskReadGpsCoarseTimeOperation,           //读取GPS粗定位超时时间
    mk_bg_taskReadGpsFineTimeOperation,             //读取GPS精确定位超时时间
    mk_bg_taskReadGpsPDOPLimitOperation,            //读取GPS位置精度因子
    mk_bg_taskReadGpsFixModeOperation,              //读取GPS搜星模式
    mk_bg_taskReadGpsModeOperation,                 //读取GPS模式
    mk_bg_taskReadGpsTimeBudgetOperation,           //读取GPS定位预算
    mk_bg_taskReadGpsAutonomousAidingStatusOperation,   //读取GPS辅助定位状态
    mk_bg_taskReadGpsAdingAccuracyOperation,        //读取GPS辅助定位精度
    mk_bg_taskReadGpsAidingTimeOperation,           //读取GPS辅助定位超时时间
    mk_bg_taskReadGpsExtremeModeStatusOperation,    //读取GPS上传数据类型
    
#pragma mark - 设备LoRa参数读取
    mk_bg_taskReadLorawanRegionOperation,       //读取LoRaWAN频段
    mk_bg_taskReadLorawanModemOperation,        //读取LoRaWAN入网类型
    mk_bg_taskReadLorawanNetworkStatusOperation,    //读取LoRaWAN网络状态
    mk_bg_taskReadLorawanDEVEUIOperation,           //读取LoRaWAN DEVEUI
    mk_bg_taskReadLorawanAPPEUIOperation,           //读取LoRaWAN APPEUI
    mk_bg_taskReadLorawanAPPKEYOperation,           //读取LoRaWAN APPKEY
    mk_bg_taskReadLorawanDEVADDROperation,          //读取LoRaWAN DEVADDR
    mk_bg_taskReadLorawanAPPSKEYOperation,          //读取LoRaWAN APPSKEY
    mk_bg_taskReadLorawanNWKSKEYOperation,          //读取LoRaWAN NWKSKEY
    mk_bg_taskReadLorawanMessageTypeOperation,      //读取上行数据类型
    mk_bg_taskReadLorawanCHOperation,               //读取LoRaWAN CH
    mk_bg_taskReadLorawanDROperation,               //读取LoRaWAN DR
    mk_bg_taskReadLorawanUplinkStrategyOperation,   //读取LoRaWAN数据发送策略
    mk_bg_taskReadLorawanDutyCycleStatusOperation,      //读取dutycyle
    mk_bg_taskReadLorawanDevTimeSyncIntervalOperation,  //读取devtime指令同步间隔
    mk_bg_taskReadLorawanReconnectIntervalOperation,    //读取定时重连时间
    
#pragma mark - 读取蓝牙配置参数
    mk_bg_taskReadBeaconModeStatusOperation,            //读取Beacon开关使能状态
    mk_bg_taskReadBeaconAdvIntervalOperation,           //读取Beacon广播间隔
    mk_bg_taskReadDeviceConnectableOperation,           //读取蓝牙可连接状态
    mk_bg_taskReadDeviceBroadcastTimeoutOperation,      //读取蓝牙配置模式下广播超时时间
    mk_bg_taskReadBeaconProximityUUIDOperation,         //读取UUID
    mk_bg_taskReadBeaconMajorOperation,                 //读取Major
    mk_bg_taskReadBeaconMinorOperation,                 //读取Minor
    mk_bg_taskReadMeasuredPowerOperation,               //读取Measured Power (RSSI@1m)
    mk_bg_taskReadTxPowerOperation,                     //读取蓝牙TX power
    mk_bg_taskReadDeviceNameOperation,                  //读取广播名称
    mk_bg_taskReadScanningPHYTypeOperation,             //读取蓝牙扫描phy选择
    
    
#pragma mark - 辅助功能参数读取
    mk_bg_taskReadThreeAxisWakeupConditionsOperation,       //读取三轴唤醒条件
    mk_bg_taskReadThreeAxisMotionParametersOperation,       //读取运动检测判断
    mk_bg_taskReadVibrationDetectionStatusOperation,        //读取震动检测使能
    mk_bg_taskReadVibrationThresholdsOperation,             //读取震动检测阈值
    mk_bg_taskReadVibrationDetectionReportIntervalOperation,    //读取震动上发间隔
    mk_bg_taskReadVibrationTimeoutOperation,                //读取震动次数判断间隔
    mk_bg_taskReadManDownDetectionOperation,                //读取闲置功能使能
    mk_bg_taskReadIdleDetectionTimeoutOperation,            //读取闲置超时时间
    mk_bg_taskReadTamperAlarmStatusOperation,               //读取防拆报警使能
    mk_bg_taskReadActiveStateCountStatusOperation,          //读取活动记录使能
    mk_bg_taskReadActiveStateTimeoutOperation,              //读取活动判定间隔
    
#pragma mark - 设备系统应用信息配置
    mk_bg_taskRestartDeviceOperation,                   //重启设备
    mk_bg_taskFactoryResetOperation,                    //恢复出厂设置
    mk_bg_taskConfigDeviceTimeOperation,                //同步设备时间
    mk_bg_taskConfigTimeZoneOperation,                  //同步时区
    mk_bg_taskConfigPasswordOperation,                  //配置密码
    mk_bg_taskConfigWorkModeOperation,                  //配置工作模式
    mk_bg_taskConfigRepoweredDefaultModeOperation,      //配置设备上电后模式
    mk_bg_taskConfigHeartbeatIntervalOperation,         //配置设备心跳间隔
    mk_bg_taskConfigOffByMagnetStatusOperation,         //配置磁簧开关关机功能
    mk_bg_taskConfigShutdownPayloadStatusOperation,     //配置关机信息上报
    mk_bg_taskConfigOfflineFixStatusOperation,          //配置离线定位功能
    mk_bg_taskConfigLowPowerPayloadOperation,           //配置低电参数
    mk_bg_taskConfigIndicatorSettingsOperation,         //配置指示灯功能
    mk_bg_taskConfigOnOffMethodOperation,               //配置磁簧开关机方式
    mk_bg_taskBatteryResetOperation,                    //清除电池电量数据
    mk_bg_taskConfigLowPowerPayloadStatusOperation,     //配置低电触发心跳开关状态
    mk_bg_taskConfigLowPowerPromptOperation,            //配置低电百分比
    mk_bg_taskConfigAutoPowerOnAfterChargingOperation,  //配置充电自动开机功能
    
#pragma mark - 配置模式相关参数
    mk_bg_taskConfigPeriodicModePositioningStrategyOperation,       //配置定期模式定位策略
    mk_bg_taskConfigPeriodicModeReportIntervalOperation,            //配置定期模式上报间隔
    mk_bg_taskConfigTimingModePositioningStrategyOperation,         //配置定时模式定位策略
    mk_bg_taskConfigTimingModeReportingTimePointOperation,          //配置定时模式时间点
    mk_bg_taskConfigMotionModeEventsOperation,                      //配置运动模式事件
    mk_bg_taskConfigMotionModeNumberOfFixOnStartOperation,          //配置运动开始定位上报次数
    mk_bg_taskConfigMotionModePosStrategyOnStartOperation,          //配置运动开始定位策略
    mk_bg_taskConfigMotionModeReportIntervalInTripOperation,        //配置运动中定位间隔
    mk_bg_taskConfigMotionModePosStrategyInTripOperation,           //配置运动中定位策略
    mk_bg_taskConfigMotionModeTripEndTimeoutOperation,              //配置运动结束判断时间
    mk_bg_taskConfigMotionModeNumberOfFixOnEndOperation,            //配置运动结束定位次数
    mk_bg_taskConfigMotionModeReportIntervalOnEndOperation,         //配置运动结束定位间隔
    mk_bg_taskConfigMotionModePosStrategyOnEndOperation,            //配置运动结束定位策略
    mk_bg_taskConfigDownlinkForPositioningStrategyOperation,        //配置下行请求定位策略
    
    
#pragma mark - 配置定位参数
    mk_bg_taskConfigWifiPositioningTimeoutOperation,    //配置WIFI定位超时时间
    mk_bg_taskConfigWifiNumberOfBSSIDOperation,         //配置WIFI定位成功BSSID数量
    mk_bg_taskConfigBLEPositioningTimeoutOperation,     //配置WIFI定位超时时间
    mk_bg_taskConfigBLENumberOfMacOperation,            //配置蓝牙定位成功MAC数量
    
    
#pragma mark - 配置蓝牙过滤规则
    mk_bg_taskConfigBLELogicalRelationshipOperation,    //配置蓝牙过滤规则开关逻辑
    mk_bg_taskConfigBLEFilterAStatusOperation,          //配置过滤规则1的开关状态
    mk_bg_taskConfigBLEFilterADeviceNameOperation,      //配置过滤规则1的广播名称
    mk_bg_taskConfigBLEFilterAMacOperation,             //配置过滤规则1的MAC地址
    mk_bg_taskConfigBLEFilterAMajorOperation,           //配置过滤规则1的MAJOR范围
    mk_bg_taskConfigBLEFilterAMinorOperation,           //配置过滤规则1的MINOR范围
    mk_bg_taskConfigBLEFilterARawDataOperation,         //配置过滤规则1的raw data
    mk_bg_taskConfigBLEFilterAUUIDOperation,            //配置过滤规则1的UUID
    mk_bg_taskConfigBLEFilterARSSIOperation,            //配置过滤规则1的RSSI
    
    mk_bg_taskConfigBLEFilterBStatusOperation,          //配置过滤规则2的开关状态
    mk_bg_taskConfigBLEFilterBDeviceNameOperation,      //配置过滤规则2的广播名称
    mk_bg_taskConfigBLEFilterBMacOperation,             //配置过滤规则2的MAC地址
    mk_bg_taskConfigBLEFilterBMajorOperation,           //配置过滤规则2的MAJOR范围
    mk_bg_taskConfigBLEFilterBMinorOperation,           //配置过滤规则2的MINOR范围
    mk_bg_taskConfigBLEFilterBRawDataOperation,         //配置过滤规则2的raw data
    mk_bg_taskConfigBLEFilterBUUIDOperation,            //配置过滤规则2的UUID
    mk_bg_taskConfigBLEFilterBRSSIOperation,            //配置过滤规则2的RSSI
    
    
#pragma mark - GPS定位参数设置
    mk_bg_taskConfigGpsColdStardTimeOperation,          //配置GPS冷启动超时时间
    mk_bg_taskConfigGpsCoarseAccuracyMaskOperation,     //配置GPS粗定位精度
    mk_bg_taskConfigGpsFineAccuracyTargetOperation,     //配置GPS精确定位精度
    mk_bg_taskConfigGpsCoarseTimeOperation,             //配置GPS粗定位超时时间
    mk_bg_taskConfigGpsFineTimeOperation,               //配置GPS精确定位超时时间
    mk_bg_taskConfigGpsPDOPLimitOperation,              //配置GPS位置精度因子
    mk_bg_taskConfigGpsFixModeOperation,                //配置GPS搜星模式
    mk_bg_taskConfigGpsModeOperation,                   //配置GPS模式
    mk_bg_taskConfigGpsTimeBudgetOperation,             //配置GPS定位预算
    mk_bg_taskConfigGpsAutonomousAidingStatusOperation, //配置GPS辅助定位状态
    mk_bg_taskConfigGpsAdingAccuracyOperation,          //配置GPS辅助定位精度
    mk_bg_taskConfigGpsAidingTimeOperation,             //配置GPS辅助定位超时时间
    mk_bg_taskConfigGpsExtremeModeStatusOperation,      //配置GPS上传数据类型
    
#pragma mark - 设备LoRa参数配置
    mk_bg_taskConfigRegionOperation,                    //配置LoRaWAN的region
    mk_bg_taskConfigModemOperation,                     //配置LoRaWAN的入网类型
    mk_bg_taskConfigDEVEUIOperation,                    //配置LoRaWAN的devEUI
    mk_bg_taskConfigAPPEUIOperation,                    //配置LoRaWAN的appEUI
    mk_bg_taskConfigAPPKEYOperation,                    //配置LoRaWAN的appKey
    mk_bg_taskConfigDEVADDROperation,                   //配置LoRaWAN的DevAddr
    mk_bg_taskConfigAPPSKEYOperation,                   //配置LoRaWAN的APPSKEY
    mk_bg_taskConfigNWKSKEYOperation,                   //配置LoRaWAN的NwkSKey
    mk_bg_taskConfigMessageTypeOperation,               //配置LoRaWAN的message type
    mk_bg_taskConfigCHValueOperation,                   //配置LoRaWAN的CH值
    mk_bg_taskConfigDRValueOperation,                   //配置LoRaWAN的DR值
    mk_bg_taskConfigUplinkStrategyOperation,            //配置LoRaWAN数据发送策略
    mk_bg_taskConfigDutyCycleStatusOperation,           //配置LoRaWAN的duty cycle
    mk_bg_taskConfigTimeSyncIntervalOperation,          //配置LoRaWAN的同步指令间隔
    mk_bg_taskConfigReconnectIntervalOperation,         //配置LoRaWAN定时重连时间
    
#pragma mark - 配置蓝牙参数
    mk_bg_taskConfigBeaconModeStatusOperation,          //配置Beacon开关状态
    mk_bg_taskConfigBeaconAdvIntervalOperation,         //配置Beacon广播间隔
    mk_bg_taskConfigDeviceConnectableOperation,         //配置蓝牙可连接状态
    mk_bg_taskConfigDeviceBroadcastTimeoutOperation,    //配置蓝牙配置模式下广播超时时间
    mk_bg_taskConfigBeaconProximityUUIDOperation,       //配置UUID
    mk_bg_taskConfigBeaconMajorOperation,               //配置Beacon的Major
    mk_bg_taskConfigBeaconMinorOperation,               //配置Beacon的Minor
    mk_bg_taskConfigMeasuredPowerOperation,             //配置Measured Power (RSSI@1m)
    mk_bg_taskConfigTxPowerOperation,                   //配置蓝牙TX power
    mk_bg_taskConfigDeviceNameOperation,                //配置广播名称
    mk_bg_taskConfigScanningPHYTypeOperation,           //配置Scanning Type/PHY
    
#pragma mark - 辅助功能参数设置
    mk_bg_taskConfigThreeAxisWakeupConditionsOperation,         //配置三轴唤醒条件
    mk_bg_taskConfigThreeAxisMotionParametersOperation,         //配置运动检测判断
    mk_bg_taskConfigVibrationDetectionStatusOperation,          //配置震动检测使能
    mk_bg_taskConfigVibrationThresholdsOperation,               //配置震动检测阈值
    mk_bg_taskConfigVibrationDetectionReportIntervalOperation,  //配置震动上发间隔
    mk_bg_taskConfigVibrationTimeoutOperation,                  //配置震动次数判断间隔
    mk_bg_taskConfigManDownDetectionStatusOperation,            //配置闲置功能使能
    mk_bg_taskConfigIdleDetectionTimeoutOperation,              //配置闲置超时时间
    mk_bg_taskConfigTamperAlarmStatusOperation,                 //配置防拆报警使能
    mk_bg_taskConfigActiveStateCountStatusOperation,            //配置活动记录使能
    mk_bg_taskConfigActiveStateTimeoutOperation,                //配置活动判定间隔
    mk_bg_taskConfigIdleStutasResetOperation,                   //配置闲置清除
    
#pragma mark - 存储数据协议
    mk_bg_taskReadNumberOfDaysStoredDataOperation,      //读取多少天本地存储的数据
    mk_bg_taskClearAllDatasOperation,                   //清除存储的所有数据
    mk_bg_taskPauseSendLocalDataOperation,              //暂停/恢复数据传输
};
