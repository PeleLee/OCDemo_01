//
//  MyMacro.h
//  OCDemo_01
//
//  Created by 0dodo on 2018/5/19.
//  Copyright © 2018年 My. All rights reserved.
//

#ifndef MyMacro_h
#define MyMacro_h

#define k_Appdelegate ((AppDelegate*)[[UIApplication sharedApplication] delegate])
#define k_NotificationCenter [NSNotificationCenter defaultCenter]
#define k_ImageNamed(imageName) [UIImage imageNamed:imageName]

#define k_StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define k_NavBarMaxY (k_StatusBarHeight+44)
#define k_SafeAreaHeight (k_StatusBarHeight>20?34:0)

#endif /* MyMacro_h */
