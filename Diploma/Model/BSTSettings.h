//
//  BSTSettings.h
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "nsuserdefaults-helper.h"
#import "nsuserdefaults-macros.h"


#define SK static NSString *const

#define USER_SETTINGS APP_SETTINGS "user/"

SK kSettingsFanWireHeaders = @ APP_SETTINGS "authHeaders";

// All per-user settings. Remove and re-initialize them all for new user
SK kSettingsUserConfigs = @ USER_SETTINGS;
SK kSettingsUsername    = @ USER_SETTINGS "username";
