/**
 * 
 *@author steven.yan
 *@date June 4 2014
 *
 */

#import "RefreshPanel.h"

@implementation RefreshPanel
static float kPanelHeight = 50;
static float kMinDragTransHeight = 40;



#pragma mark -
#pragma mark --------------------------初始化 ,销毁-------------------------------
/*------------------------------------------------------------------------------
 |  初始化 ,销毁
 |
 -----------------------------------------------------------------------------*/
- (id)initWithVc:(BaseVc *)vc sv:(UIScrollView *)sv isDropPanel:(BOOL)isDropTag {
    if (self = [super initWithFrame:CGRectMake(0, CGFLOAT_MAX, vc.view.width, kPanelHeight)]) {
        //页面
        self.nrVc = vc;
        //sv
        self.nrSv = sv;
        //-
        [sv addSubview:self];
        
        //控件-------------------------
        int aiLeft = 80;
        //动画图片控件
        int aiWidth = 15;
        int aiHeight = 30;
        CGRect rect = CGRectMake(aiLeft, (self.height - aiHeight)/2, aiWidth, aiHeight);
        UIImageView* iv = [[UIImageView alloc] initWithFrame:rect];
        if (isDropTag) {
            CGAffineTransform form = CGAffineTransformMakeRotation(3.14);
            self.ctrlArrow.transform = form;
        }
        [iv setImage:[UIImage imageNamed:@"frame_list_load_top_arrow"]];
        [self addSubview:iv];
        self.ctrlArrow = iv;
        //指示器
        int aiWh = 24;
        rect = CGRectMake(aiLeft, (self.height-aiWh)/2, aiWh, aiWh);
        UIActivityIndicatorView *a= [[UIActivityIndicatorView alloc] initWithFrame:rect];
        a.hidden = YES;
        [a setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        [a stopAnimating];
        [self addSubview:a];
        self.ctrlIndicator = a;
        //标签
        rect = CGRectMake(0, 0, self.width, 50);
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor darkGrayColor];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        self.ctrlHintLabel = label;
        
        //数据-------------------
        //是否是下拉刷新
        self.isDropTag = isDropTag;
        //是否需要刷新
        self.needRefreshTag = NO;
        //是否加载中
        self.isLoadingTag = NO;
    }
    
    return self;
}



#pragma mark -
#pragma mark ------------------------------方法----------------------------------
/*------------------------------------------------------------------------------
 |  方法
 |
 -----------------------------------------------------------------------------*/
//显示拖拽
-(void)refreshPanelScrollViewDidScroll:(UIScrollView *)sv {
    //容错
    if (self.isLoadingTag) {
        return;
    }
    
    //重置panel位置
    if (self.isDropTag) {
        self.top = -kPanelHeight;
    } else {
        if (sv.contentSize.height <= sv.height) {
            return;
        }
        
        self.top = sv.contentSize.height;
    }
    
    //判断偏移量
    int offset = 0;
    NSString *hint0;
    NSString *hint1;
    if (self.isDropTag) {
        offset = - sv.contentOffset.y;
        hint0 = @"下拉重新刷新";
        hint1 = @"重新载入";
    } else {
        offset = sv.contentOffset.y + sv.height - sv.contentSize.height;
        hint0 = @"上拉加载更多";
        hint1 = @"松开载入更多";
    }
    
    if (offset <= 0) {
        return;
    }
    
    if (sv.isDragging) {
        [UIView animateWithDuration:0.2 animations:^{
            if (offset > kMinDragTransHeight) {
                //是否需要刷新
                self.needRefreshTag = YES;
                self.ctrlHintLabel.text = hint1;
                self.ctrlArrow.transform = CGAffineTransformMakeRotation(-3.14);
            } else {
                //是否需要刷新
                self.needRefreshTag = NO;
                self.ctrlHintLabel.text = hint0;
                self.ctrlArrow.transform = CGAffineTransformMakeRotation(0);
            }
        }];
    }
}

//显示加载
-(void)refreshPanelScrollViewDidEndDragging:(UIScrollView *)sv {
    if (self.needRefreshTag) {
        //是否需要刷新
        self.needRefreshTag = NO;
        //是否正在读取
        self.isLoadingTag = YES;
        //隐藏arrow
        self.ctrlArrow.hidden = YES;
        //设置hint
        self.ctrlHintLabel.text = @"加载中...";
        //启动转子
        [self.ctrlIndicator startAnimating];
        [UIView animateWithDuration:0.4 animations:^{
            if (self.isDropTag) {
                sv.contentInset = UIEdgeInsetsMake(kPanelHeight, 0, 0, 0);
            } else {
                sv.contentInset = UIEdgeInsetsMake(0, 0, kPanelHeight, 0);
            }
        } completion:^(BOOL finished) {
            if (finished) {
                BOOL r = [self.delegate respondsToSelector:@selector(RefreshPanelWhileLoading:)];
                if (r) {
                    [self.delegate RefreshPanelWhileLoading:self];
                }
            }
        }];
    }
}

//加载结束
-(void)finishLoading {
    //取消偏移
    [UIView animateWithDuration:0.2 animations:^{
        self.nrSv.contentInset = UIEdgeInsetsZero;
    } completion:^(BOOL f){
        [self reset];
    }];
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
- (void)reset {
    //显示arrow
    self.ctrlArrow.hidden = NO;
    //停止转子
    [self.ctrlIndicator stopAnimating];
    
    //是否需要刷新
    self.needRefreshTag = NO;
    //是否加载中
    self.isLoadingTag = NO;
    
    self.top = CGFLOAT_MAX;
}



@end
