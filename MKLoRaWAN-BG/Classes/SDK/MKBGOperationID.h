
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
    mk_bg_taskReadDeviceHeartbeatIntervalOperation,   //读取设备心跳间隔
    mk_bg_taskReadOfflineFixStatusOperation,          //读取设备离线定位状态
    
    
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
    mk_bg_taskReadBLEFilterAByPHYOperation,         //读取蓝牙过滤规则1的过滤PHY
    
    mk_bg_taskReadBLEFilterBStatusOperation,        //读取蓝牙过滤规则2的开关状态
    mk_bg_taskReadBLEFilterBDeviceNameOperation,    //读取蓝牙过滤规则2的过滤设备名字
    mk_bg_taskReadBLEFilterBDeviceMacOperation,     //读取蓝牙过滤规则2的过滤设备MAC地址
    mk_bg_taskReadBLEFilterBMajorOperation,         //读取蓝牙过滤规则2的过滤major范围
    mk_bg_taskReadBLEFilterBMinorOperation,         //读取蓝牙过滤规则2的过滤minor范围
    mk_bg_taskReadBLEFilterBRawDataOperation,       //读取蓝牙过滤规则2的过滤原始数据信息
    mk_bg_taskReadBLEFilterBUUIDOperation,          //读取蓝牙过滤规则2的过滤UUID信息
    mk_bg_taskReadBLEFilterBRssiOperation,          //读取蓝牙过滤规则2的过滤rssi
    mk_bg_taskReadBLEFilterBByPHYOperation,         //读取蓝牙过滤规则2的过滤PHY
    
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
    
    
    
    
    
    mk_bg_taskReadDeviceInfoReportIntervalOperation,    //读取设备信息上报间隔
    mk_bg_taskReadDefaultPowerStatusOperation,          //读取设备上电状态
    mk_bg_taskReadTriggerSensitivityOperation,          //读取防拆灵敏度
    mk_bg_taskReadBeaconReportIntervalOperation,        //读取iBeacon数据上报间隔
    mk_bg_taskReadFilterRepeatingDataTypeOperation,     //读取重复数据过滤类型
    mk_bg_taskReadBeaconReportDataTypeOperation,        //读取上报的iBeacon数据类型
    mk_bg_taskReadBeaconReportDataMaxLengthOperation,   //读取iBeacon最大上报数据长度
    mk_bg_taskReadMacAddressOperation,          //读取设备mac地址
    mk_bg_taskReadBeaconReportDataContentOperation, //读取iBeacon上报数据内容选择
    mk_bg_taskReadMacOverLimitScanStatusOperation,  //读取MAC超限开关状态
    mk_bg_taskReadMacOverLimitDurationOperation,    //读取MAC超限间隔
    mk_bg_taskReadMacOverLimitQuantitiesOperation,  //读取MAC超限数量
    mk_bg_taskReadMacOverLimitRSSIOperation,        //读取MAC超限触发RSSI
    

#pragma mark - 蓝牙广播扫描参数
    mk_bg_taskReadDeviceNameOperation,              //读取蓝牙广播名称
    mk_bg_taskReadBroadcastIntervalOperation,       //读取蓝牙广播间隔
    mk_bg_taskReadScanStatusOperation,              //读取蓝牙扫描开关状态
    mk_bg_taskReadScanParamsOperation,              //读取蓝牙扫描参数
    
    
#pragma mark - 设备系统应用信息配置
    mk_bg_taskRestartDeviceOperation,                   //重启设备
    mk_bg_taskFactoryResetOperation,                    //恢复出厂设置
    mk_bg_taskConfigDeviceTimeOperation,                //同步设备时间
    mk_bg_taskConfigTimeZoneOperation,                  //同步时区
    mk_bg_taskConfigPasswordOperation,                  //配置密码
    mk_bg_taskConfigWorkModeOperation,                  //配置工作模式
    mk_bg_taskConfigHeartbeatIntervalOperation,         //配置设备心跳间隔
    mk_bg_taskConfigOfflineFixStatusOperation,          //配置离线定位功能
    
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
    mk_bg_taskConfigBLEFilterAByPHYOperation,           //配置蓝牙过滤规则1的过滤PHY
    
    mk_bg_taskConfigBLEFilterBStatusOperation,          //配置过滤规则2的开关状态
    mk_bg_taskConfigBLEFilterBDeviceNameOperation,      //配置过滤规则2的广播名称
    mk_bg_taskConfigBLEFilterBMacOperation,             //配置过滤规则2的MAC地址
    mk_bg_taskConfigBLEFilterBMajorOperation,           //配置过滤规则2的MAJOR范围
    mk_bg_taskConfigBLEFilterBMinorOperation,           //配置过滤规则2的MINOR范围
    mk_bg_taskConfigBLEFilterBRawDataOperation,         //配置过滤规则2的raw data
    mk_bg_taskConfigBLEFilterBUUIDOperation,            //配置过滤规则2的UUID
    mk_bg_taskConfigBLEFilterBRSSIOperation,            //配置过滤规则2的RSSI
    mk_bg_taskConfigBLEFilterBByPHYOperation,           //配置蓝牙过滤规则2的过滤PHY
    
    
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
    
    
    
    mk_bg_taskConfigConnectNetworkOperation,            //配置设备入网/重启
    mk_bg_taskConfigDeviceInfoReportIntervalOperation,  //配置设备信息上报间隔
    
    mk_bg_taskConfigDefaultPowerStatusOperation,        //配置设备默认上电状态
    mk_bg_taskConfigTriggerSensitivityOperation,        //配置防拆灵敏度
    mk_bg_taskConfigBeaconReportIntervalOperation,      //配置iBeacon数据上报间隔
    mk_bg_taskConfigFilterRepeatingDataTypeOperation,   //配置重复数据过滤规则
    mk_bg_taskConfigBeaconReportDataTypeOperation,      //配置iBeacon数据上报类型
    mk_bg_taskConfigBeaconReportDataMaxLenOperation,    //配置iBeacon数据最大上报长度
    mk_bg_taskConfigBeaconReportDataContentOperation,   //配置iBeacon上报数据内容选择
    mk_bg_taskConfigMacOverLimitScanStatusOperation,    //配置扫描MAC超限开关状态
    mk_bg_taskConfigMacOverLimitDurationOperation,      //配置扫描MAC超限间隔
    mk_bg_taskConfigMacOverLimitQuantitiesOperation,    //配置扫描MAC超限数量
    mk_bg_taskConfigMacOverLimitRssiOperation,          //配置扫描MAC超限触发RSSI
    
#pragma mark - 蓝牙广播扫描参数
    mk_bg_taskConfigDeviceNameOperation,                //配置设备广播名称
    mk_bg_taskConfigDeviceBroadcastIntervalOperation,   //配置广播间隔
    mk_bg_taskConfigScanStatusOperation,                //配置扫描开关
    mk_bg_taskConfigScanParamsOperation,                //配置扫描参数
    
    
#pragma mark - 存储数据协议
    mk_bg_taskReadNumberOfDaysStoredDataOperation,      //读取多少天本地存储的数据
    mk_bg_taskClearAllDatasOperation,                   //清除存储的所有数据
    mk_bg_taskPauseSendLocalDataOperation,              //暂停/恢复数据传输
};
