//
//  TableViewAdapter.m
//  GetTV_iOS
//
//  Created by yangyl on 16/7/6.
//  Copyright © 2016年 ylin.yang. All rights reserved.
//

#import "TableViewAdapter.h"
#import "UITableViewCell+Model.h"
#import "NSObject+Clazz.h"
#import "TableSection.h"
#import "TableCell.h"
#import "UIView+Xib.h"

@interface TableViewAdapter()

@end

@implementation TableViewAdapter

- (void)setTableView:(UITableView *)tableView {
    
    if (_tableView == tableView) {
        return;
    }
    _tableView = tableView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (void)reloadData {
    
    [super reloadData];
    [self.tableView reloadData];
}

- (TableSection *)addNewSection {
    
    if (!self.sections) {
        self.sections = [NSMutableArray array];
    }
    TableSection *section = [[TableSection alloc] init];
    [self.sections addObject:section];
    return section;
}

#pragma - mark - UITableViewDelegate
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.sections.count;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.sections[section].datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self getCell:tableView cellForRowAtIndexPath:indexPath dequeue:true];
}

- (UITableViewCell *)getCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath dequeue:(BOOL)dequeue {
    
    TableCell *cellModel = self.sections[indexPath.section].datas[indexPath.row];
    cellModel.indexPath = indexPath;
    UITableViewCell *cell;// = [tableView dequeueReusableCellWithIdentifier:[cellModel.cellClazz className]];
    /// 是否重用
    if (dequeue) {
        cell = [tableView dequeueReusableCellWithIdentifier:[cellModel.cellClazz className]];
        if (!cell) {
            switch (cellModel.loadType) {
                case CellLoadTypeInner:
                    [tableView registerClass:cellModel.cellClazz forCellReuseIdentifier:[cellModel.cellClazz className]];
                    break;
                case CellLoadTypeNib:
                    [tableView registerNib:[UINib nibWithNibName:[cellModel.cellClazz className] bundle:nil] forCellReuseIdentifier:[cellModel.cellClazz className]];
                    break;
                case CellLoadTypeOri:
                    [tableView registerClass:cellModel.cellClazz forCellReuseIdentifier:[cellModel.cellClazz className]];
                    break;
                    
                default:
                    break;
            }
            cell = [tableView dequeueReusableCellWithIdentifier:[cellModel.cellClazz className]];
        }
    } else {
        switch (cellModel.loadType) {
            case CellLoadTypeInner:
                cell = [[cellModel.cellClazz alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:[cellModel.cellClazz className]];
                break;
            case CellLoadTypeNib:{
                cell = [cellModel.cellClazz loadViewFromXib];
            }
                break;
            case CellLoadTypeOri:
                cell = [[cellModel.cellClazz alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:[cellModel.cellClazz className]];
                break;
                
            default:
                break;
        }
    }
    cell.selectionStyle = cellModel.selectionStyle;
    cell.accessoryType = cellModel.accessoryType;
    cell.model = cellModel;
    return cell;
}

/**
 *    cell 的点击事件/
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TableCell *cellModel = self.sections[indexPath.section].datas[indexPath.row];
    cellModel.indexPath = indexPath;
    if (cellModel.deSelectionStyle == DeSelectionStyleNow) {
        [tableView deselectRowAtIndexPath:indexPath animated:true];
    }
    if (cellModel.cellClick) {
        cellModel.cellClick(cellModel, indexPath);
    }
}
//设置每个cell 的高度;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.tableViewDelegate respondsToSelector:_cmd]) {
        CGFloat height = [self.tableViewDelegate tableView:tableView heightForRowAtIndexPath:indexPath];
        if (UITableViewAutomaticDimension != height) {
            return height;
        }
    }
    TableCell *cellModel = self.sections[indexPath.section].datas[indexPath.row];
    cellModel.indexPath = indexPath;
    //[self getCell:tableView cellForRowAtIndexPath:indexPath dequeue:false];
    return cellModel.cellHeight+cellModel.cellSpaceMargin.top+cellModel.cellSpaceMargin.bottom;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (![self.tableViewDelegate respondsToSelector:_cmd]) {
        return nil;
    }
    return [self.tableViewDelegate tableView:tableView viewForHeaderInSection:section];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (![self.tableViewDelegate respondsToSelector:_cmd]) {
        return 0;
    }
    return [self.tableViewDelegate tableView:tableView heightForHeaderInSection:section];
}

#pragma - mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (![self.tableViewDelegate respondsToSelector:_cmd]) {
        return;
    }
    [self.tableViewDelegate scrollViewDidScroll:scrollView];
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    if (![self.tableViewDelegate respondsToSelector:_cmd]) {
        return;
    }
    [self.tableViewDelegate scrollViewDidZoom:scrollView];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    if (![self.tableViewDelegate respondsToSelector:_cmd]) {
        return;
    }
    [self.tableViewDelegate scrollViewWillBeginDragging:scrollView];
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    if (![self.tableViewDelegate respondsToSelector:_cmd]) {
        return;
    }
    [self.tableViewDelegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    
    if (![self.tableViewDelegate respondsToSelector:_cmd]) {
        return;
    }
    [self.tableViewDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
    if (![self.tableViewDelegate respondsToSelector:_cmd]) {
        return;
    }
    [self.tableViewDelegate scrollViewWillBeginDecelerating:scrollView];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (![self.tableViewDelegate respondsToSelector:_cmd]) {
        return;
    }
    [self.tableViewDelegate scrollViewDidEndDecelerating:scrollView];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    if (![self.tableViewDelegate respondsToSelector:_cmd]) {
        return;
    }
    [self.tableViewDelegate scrollViewDidEndScrollingAnimation:scrollView];
}
- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    if (![self.tableViewDelegate respondsToSelector:_cmd]) {
        return nil;
    }
    return [self.tableViewDelegate viewForZoomingInScrollView:scrollView];
}
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view{
    
    if (![self.tableViewDelegate respondsToSelector:_cmd]) {
        return;
    }
    [self.tableViewDelegate scrollViewWillBeginZooming:scrollView withView:view];
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale{
    
    if (![self.tableViewDelegate respondsToSelector:_cmd]) {
        return;
    }
    [self.tableViewDelegate scrollViewDidEndZooming:scrollView withView:view atScale:scale];
}
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    
    if (![self.tableViewDelegate respondsToSelector:_cmd]) {
        return false;
    }
    return [self.tableViewDelegate scrollViewShouldScrollToTop:scrollView];
}
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    
    if (![self.tableViewDelegate respondsToSelector:_cmd]) {
        return;
    }
    [self.tableViewDelegate scrollViewDidScrollToTop:scrollView];
}

@end
