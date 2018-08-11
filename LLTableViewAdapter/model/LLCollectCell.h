//
//  LLCollectCell.h
//  Adapter
//
//  Created by ylin.yang on 2016/7/5.
//  Copyright © 2016年 ylin.yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLTableCell.h"
@class LLCollectCell;

typedef void (^CollClick)(LLCollectCell *model, NSIndexPath *index);

/**
 *	@author Y0, 16-07-05 22:07:19
 *
 *	collection cell
 *
 *	@since 1.0
 */
@interface LLCollectCell <DataType: NSObject *>: NSObject

/// kvc 透传数据
@property (strong, nonatomic) NSMutableDictionary *kvcExt;
@property (weak, nonatomic) NSIndexPath *indexPath;
@property (assign, nonatomic) CGSize cellSize;
@property (copy, nonatomic) LLCollectCellActionDefine(cellClick, DataType);
@property (assign, nonatomic) Class cellClazz;

/// cell Identity
@property (copy, nonatomic) NSString *cellIdentity;
/// cell NibName
@property (copy, nonatomic) NSString *cellNibName;

@property (assign, nonatomic) LLCellLoadType loadType;
@property (strong, nonatomic) DataType data;

@end
