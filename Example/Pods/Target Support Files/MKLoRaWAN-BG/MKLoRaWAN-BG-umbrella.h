#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "MKBGApplicationModule.h"
#import "MKBGConnectModel.h"
#import "CTMediator+MKBGAdd.h"
#import "MKBGTextButtonCell.h"
#import "MKBGNormalAdopter.h"
#import "MKBGAboutController.h"
#import "MKBGActiveStateController.h"
#import "MKBGActiveStateDataModel.h"
#import "MKBGAuxoliaryController.h"
#import "MKBGAuxoliaryDataModel.h"
#import "MKBGAxisSettingController.h"
#import "MKBGAxisSettingDataModel.h"
#import "MKBGBlePositionController.h"
#import "MKBGBlePositionDataModel.h"
#import "MKBGFilterConditionCell.h"
#import "MKBGBleSettingsController.h"
#import "MKBGBleSettingsDataModel.h"
#import "MKBGBroadcastSettingsController.h"
#import "MKBGBroadcastSettingsModel.h"
#import "MKBGDeviceInfoController.h"
#import "MKBGDeviceInfoModel.h"
#import "MKBGDeviceModeController.h"
#import "MKBGDeviceController.h"
#import "MKBGDevicePageModel.h"
#import "MKBGDownlinkController.h"
#import "MKBGFilterConditionController.h"
#import "MKBGFilterConditionModel.h"
#import "MKBGFilterByPHYCell.h"
#import "MKBGGeneralController.h"
#import "MKBGGeneralDataModel.h"
#import "MKBGGpsPositionController.h"
#import "MKBGGpsPositionDataModel.h"
#import "MKBGIndicatorSettingsController.h"
#import "MKBGIndicatorSettingsModel.h"
#import "MKBGLoRaAppSettingController.h"
#import "MKBGLoRaAppSettingModel.h"
#import "MKBGLoRaController.h"
#import "MKBGLoRaPageModel.h"
#import "MKBGLoRaSettingController.h"
#import "MKBGLoRaSettingModel.h"
#import "MKBGManDownController.h"
#import "MKBGManDownDataModel.h"
#import "MKBGMotionModeController.h"
#import "MKBGMotionModeModel.h"
#import "MKBGOnOffSettingsController.h"
#import "MKBGOnOffDataModel.h"
#import "MKBGPeriodicModeController.h"
#import "MKBGPeriodicModeModel.h"
#import "MKBGPositionController.h"
#import "MKBGScanController.h"
#import "MKBGScanPageModel.h"
#import "MKBGScanPageCell.h"
#import "MKBGTabBarController.h"
#import "MKBGTimingModeController.h"
#import "MKBGTimingModeModel.h"
#import "MKBGReportTimePointCell.h"
#import "MKBGTimingModeAddCell.h"
#import "MKBGVibrationController.h"
#import "MKBGVibrationDataModel.h"
#import "MKBGWifiPositionController.h"
#import "MKBGWifiPositionDataModel.h"
#import "CBPeripheral+MKBGAdd.h"
#import "MKBGCentralManager.h"
#import "MKBGInterface+MKBGConfig.h"
#import "MKBGInterface.h"
#import "MKBGOperation.h"
#import "MKBGOperationID.h"
#import "MKBGPeripheral.h"
#import "MKBGSDK.h"
#import "MKBGSDKDataAdopter.h"
#import "MKBGSDKNormalDefines.h"
#import "MKBGTaskAdopter.h"
#import "Target_LoRaWANBG_Module.h"

FOUNDATION_EXPORT double MKLoRaWAN_BGVersionNumber;
FOUNDATION_EXPORT const unsigned char MKLoRaWAN_BGVersionString[];

