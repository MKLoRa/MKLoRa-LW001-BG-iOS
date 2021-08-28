//
//  MKBGTabBarController.m
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/20.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKBGTabBarController.h"

#import "MKMacroDefines.h"
#import "MKBaseNavigationController.h"

#import "MKAlertController.h"

#import "MKBGLoRaController.h"
#import "MKBGPositionController.h"
#import "MKBGGeneralController.h"
#import "MKBGDeviceController.h"

#import "MKBGCentralManager.h"

@interface MKBGTabBarController ()

/// 当触发
/// 01:表示连接成功后，1分钟内没有通过密码验证（未输入密码，或者连续输入密码错误）认为超时，返回结果， 然后断开连接
/// 02:修改密码成功后，返回结果，断开连接
/// 03:连续三分钟设备没有数据通信断开，返回结果，断开连接
/// 04:重启设备，就不需要显示断开连接的弹窗了，只需要显示对应的弹窗
@property (nonatomic, assign)BOOL disconnectType;

@end

@implementation MKBGTabBarController

- (void)dealloc {
    NSLog(@"MKBGTabBarController销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (![[self.navigationController viewControllers] containsObject:self]){
        [[MKBGCentralManager shared] disconnect];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubPages];
    [self addNotifications];
}

- (void)addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(gotoScanPage)
                                                 name:@"mk_bg_popToRootViewControllerNotification"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dfuUpdateComplete)
                                                 name:@"mk_bg_centralDeallocNotification"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(centralManagerStateChanged)
                                                 name:mk_bg_centralManagerStateChangedNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(disconnectTypeNotification:)
                                                 name:mk_bg_deviceDisconnectTypeNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceConnectStateChanged)
                                                 name:mk_bg_peripheralConnectStateChangedNotification
                                               object:nil];
}

#pragma mark - notes
- (void)gotoScanPage {
    @weakify(self);
    [self dismissViewControllerAnimated:YES completion:^{
        @strongify(self);
        if ([self.delegate respondsToSelector:@selector(mk_bg_needResetScanDelegate:)]) {
            [self.delegate mk_bg_needResetScanDelegate:NO];
        }
    }];
}

- (void)dfuUpdateComplete {
    @weakify(self);
    [self dismissViewControllerAnimated:YES completion:^{
        @strongify(self);
        if ([self.delegate respondsToSelector:@selector(mk_bg_needResetScanDelegate:)]) {
            [self.delegate mk_bg_needResetScanDelegate:YES];
        }
    }];
}

- (void)disconnectTypeNotification:(NSNotification *)note {
    NSString *type = note.userInfo[@"type"];
    //02:修改密码成功后，返回结果，断开连接
    //03:连续两分钟设备没有数据通信断开，返回结果，断开连接
    //04:重启设备
    self.disconnectType = YES;
    if ([type isEqualToString:@"02"]) {
        [self showAlertWithMsg:@"Password changed successfully! Please reconnect the device." title:@"Change Password"];
        return;
    }
    if ([type isEqualToString:@"03"]) {
        [self showAlertWithMsg:@"No data communication for 3 minutes, the device is disconnected." title:@""];
        return;
    }
    if ([type isEqualToString:@"04"]) {
        [self showAlertWithMsg:@"Reboot successfully!Please reconnect the device." title:@"Dismiss"];
        return;
    }
}

- (void)centralManagerStateChanged{
    if (self.disconnectType) {
        return;
    }
    if ([MKBGCentralManager shared].centralStatus != mk_bg_centralManagerStatusEnable) {
        [self showAlertWithMsg:@"The current system of bluetooth is not available!" title:@"Dismiss"];
    }
}

- (void)deviceConnectStateChanged {
     if (self.disconnectType) {
        return;
    }
    [self showAlertWithMsg:@"The device is disconnected." title:@"Dismiss"];
    return;
}

#pragma mark - private method
- (void)showAlertWithMsg:(NSString *)msg title:(NSString *)title{
    MKAlertController *alertController = [MKAlertController alertControllerWithTitle:title
                                                                             message:msg
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    @weakify(self);
    UIAlertAction *moreAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        [self gotoScanPage];
    }];
    [alertController addAction:moreAction];
    
    //让setting页面推出的alert消失
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mk_bg_needDismissAlert" object:nil];
    //让所有MKPickView消失
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mk_customUIModule_dismissPickView" object:nil];
    [self performSelector:@selector(presentAlert:) withObject:alertController afterDelay:1.2f];
}

- (void)presentAlert:(UIAlertController *)alert {
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)loadSubPages {
    MKBGLoRaController *loraPage = [[MKBGLoRaController alloc] init];
    loraPage.tabBarItem.title = @"LORA";
    loraPage.tabBarItem.image = LOADICON(@"MKLoRaWAN-BG", @"MKBGTabBarController", @"bg_lora_tabBarUnselected.png");
    loraPage.tabBarItem.selectedImage = LOADICON(@"MKLoRaWAN-BG", @"MKBGTabBarController", @"bg_lora_tabBarSelected.png");
    MKBaseNavigationController *advNav = [[MKBaseNavigationController alloc] initWithRootViewController:loraPage];

    MKBGPositionController *scannerPage = [[MKBGPositionController alloc] init];
    scannerPage.tabBarItem.title = @"POSITION";
    scannerPage.tabBarItem.image = LOADICON(@"MKLoRaWAN-BG", @"MKBGTabBarController", @"bg_position_tabBarUnselected.png");
    scannerPage.tabBarItem.selectedImage = LOADICON(@"MKLoRaWAN-BG", @"MKBGTabBarController", @"bg_position_tabBarSelected.png");
    MKBaseNavigationController *scannerNav = [[MKBaseNavigationController alloc] initWithRootViewController:scannerPage];

    MKBGGeneralController *setting = [[MKBGGeneralController alloc] init];
    setting.tabBarItem.title = @"GENERAL";
    setting.tabBarItem.image = LOADICON(@"MKLoRaWAN-BG", @"MKBGTabBarController", @"bg_setting_tabBarUnselected.png");
    setting.tabBarItem.selectedImage = LOADICON(@"MKLoRaWAN-BG", @"MKBGTabBarController", @"bg_setting_tabBarSelected.png");
    MKBaseNavigationController *settingPage = [[MKBaseNavigationController alloc] initWithRootViewController:setting];
    
    MKBGDeviceController *deviceInfo = [[MKBGDeviceController alloc] init];
    deviceInfo.tabBarItem.title = @"DEVICE";
    deviceInfo.tabBarItem.image = LOADICON(@"MKLoRaWAN-BG", @"MKBGTabBarController", @"bg_device_tabBarUnselected.png");
    deviceInfo.tabBarItem.selectedImage = LOADICON(@"MKLoRaWAN-BG", @"MKBGTabBarController", @"bg_device_tabBarSelected.png");
    MKBaseNavigationController *deviceInfoPage = [[MKBaseNavigationController alloc] initWithRootViewController:deviceInfo];
    
    self.viewControllers = @[advNav,scannerNav,settingPage,deviceInfoPage];
}

@end
