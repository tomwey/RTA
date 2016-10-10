//
//  Defines.h
//  deyi
//
//  Created by tangwei1 on 16/9/2.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#ifndef Defines_h
#define Defines_h

#import "AWMacros.h"

#import "AWGeometry.h"

#import "AWUITools.h"

#import "AWTextField.h"

#import "AWTableView.h"

#import "AWHairlineView.h"

#import "AWAPIManager.h"

#import "NSStringAdditions.h"

#import "AWMediator.h"

#import "MBProgressHUD.h"

#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

#define IOS_DEFAULT_NAVBAR_BOTTOM_LINE_COLOR  AWColorFromRGB(163, 164, 165)
#define IOS_DEFAULT_CELL_SEPARATOR_LINE_COLOR AWColorFromRGB(187, 188, 193)

#define MAIN_BG_COLOR         [UIColor whiteColor]
#define NAV_BAR_BG_COLOR      AWColorFromRGB(50, 69, 255)

#define HOME_HAIRLINE_COLOR   MAIN_BG_COLOR//AWColorFromRGB(240, 240, 242)

#import "UIViewController+CreateFactory.h"

// Models
#import "User.h"

// Views
#import "SettingTableHeader.h"

#endif /* Defines_h */
