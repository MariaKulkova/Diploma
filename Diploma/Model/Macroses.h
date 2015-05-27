//
//  Macroses.h
//  Copyright (c) 2015 Maria. All rights reserved.
//

#define STRINGIFY(x) @#x

#define Key(class, key)    STRINGIFY(key)
#define ClassReuseID(x) NSStringFromClass([x class])
#define UIColorFromHEX(rgbValue) [UIColor colorWithRed:((double)((rgbValue & 0xFF0000) >> 16))/255. green:((double)((rgbValue & 0xFF00) >> 8))/255. blue:((double)(rgbValue & 0xFF))/255. alpha:1.]

