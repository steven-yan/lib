/**
 *
 *  plugInMgrCell
 *  @author steven
 *  @date   July 2 2014
 *
 **/

#import "plugInMgrCell.h"
#import "ZipFile.h"
#import "FileInZipInfo.h"
#import "ZipReadStream.h"

@implementation plugInMgrCell
static int kVerticalMargin = 8;
static int kContentHeight = 60;




#pragma mark -
#pragma mark --------------------------初始化 ,销毁-------------------------------
/*------------------------------------------------------------------------------
 |  初始化 ,销毁
 |
 -----------------------------------------------------------------------------*/
- (id)initWithVc:(BaseVC *)vc {
    if (self = [super initWithFrame:CGRectMake(0, 0, vc.view.width, kContentHeight + 2 * kVerticalMargin)]) {
        //页面
        self.nrVc = vc;
        //-
        
        //控件-------------------
        //边框------
        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(6, kVerticalMargin, self.width - 12, kContentHeight)];
        bg.layer.cornerRadius = 6;
        bg.layer.borderWidth = 1.0;
        bg.layer.borderColor = [UIColor colorWithHexStr:@"#abc1cf"].CGColor;
        [self addSubview:bg];
        self.ctrlBg = bg;
        
        //图片------
        UIImageView *v = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 45, 45)];
        v.layer.cornerRadius = 3;
        v.layer.masksToBounds = YES;
        v.backgroundColor = [UIColor clearColor];
        v.centerY = bg.height / 2;
        [bg addSubview:v];
        self.ctrlImg = v;
        
        //插件名字
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, 90, 20)];
        name.left = v.right + 10;
        [bg addSubview:name];
        self.ctrlLabelName = name;
        
        //版本号------
        //hint
        UILabel *hint = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 15)];
        hint.left = v.right + 10;
        hint.bottom = self.ctrlBg.height - 5;
        hint.backgroundColor = [UIColor clearColor];
        hint.text = @"版本号:";
        hint.font = [UIFont systemFontOfSize:12];
        [bg addSubview:hint];
        self.ctrlLabelVerHint = hint;
        //版本
        UILabel *ver = [[UILabel alloc] initWithFrame:CGRectMake(0, hint.top, 100, 15)];
        ver.left = hint.right + 5;
        ver.backgroundColor = [UIColor clearColor];
        ver.font = [UIFont systemFontOfSize:12];
        [bg addSubview:ver];
        self.ctrlLabelVer = ver;
        
        //按钮
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
        btn.right = bg.right - 15;
        btn.centerY = bg.height / 2;
        [btn addTarget:self action:@selector(btnClicked:)];
        [btn setTitle:@"下载" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor redColor];
        [bg addSubview:btn];
        self.ctrlBtn = btn;
        
        //进度条
        UIProgressView *pv = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        pv.hidden = YES;
        pv.left = v.right + 10;
        pv.centerY = bg.height - 12;
        [bg addSubview:pv];
        self.ctrlPv = pv;
        
        //数据-------------------
        self.downloadState = STATE_NONE;
    }
    
    return self;
}



#pragma mark -
#pragma mark ------------------------------方法----------------------------------
/*------------------------------------------------------------------------------
 |  方法
 |
 -----------------------------------------------------------------------------*/
+ (float)CellHeight {
    return kContentHeight + 2 * kVerticalMargin;
}

//刷新
- (void)refreshCellWith:(UIImage *)img name:(NSString *)name version:(NSString *)ver pluginUrl:(NSString *)pluginUrl {
    //插件图像
    if (img) {
        [self.ctrlImg setImage:img];
    } else {
        [self.ctrlImg setImage:[UIImage imageNamed:@"MessageView"]];
    }
    
    //插件名
    self.plugInName = name;
    //最新版本号
    self.latestVer = ver;
    //下载地址
    self.latestVerUrl = pluginUrl;
    
    //height
    self.height = [plugInMgrCell CellHeight];
}



#pragma mark -
#pragma mark ------------------------------其他----------------------------------
/*------------------------------------------------------------------------------
 |  其他
 |
 -----------------------------------------------------------------------------*/
- (void)btnClicked:(UIButton *)btn {
    if (self.downloadState == STATE_NO_VER || self.downloadState == STATE_UPDATE) {
        //下载
        [self downloadPlugInSkin];
    } else if (self.downloadState == STATE_DOWNLOADING) {
        
    } else if (self.downloadState == STATE_DOWNLOADED) {
        
    }
    
    //检测版本号
    
}

- (void)downloadPlugInSkin {
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //创建webView目录
    NSString *fileDir = [paths objectAtIndex:0];
    fileDir = [fileDir stringByAppendingPathComponent:@"webView"];
    if ([fm fileExistsAtPath:fileDir] == NO) {
        [fm createDirectoryAtPath:fileDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *zipFile = [fileDir stringByAppendingPathComponent:@"webView.zip"];
    
    //下载压缩包
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:@"http://172.16.8.180/html.zip"]];
    [request setDownloadDestinationPath:zipFile];
    [request setDownloadProgressDelegate:self.ctrlPv];
    [request startAsynchronous];

    //更新状态
    [self changeState:STATE_DOWNLOADED];
    
    [request setCompletionBlock:^{
        //更新状态
        [self changeState:STATE_DOWNLOADING];
        
        //解压
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //解压文件
            ZipFile *zf = [[ZipFile alloc] initWithFileName:zipFile mode:ZipFileModeUnzip];
            [zf goToFirstFileInZip];
            
            do {
                //获取文件信息
                FileInZipInfo *info = [zf getCurrentFileInZipInfo];
                
                //创建目录
                if ([info.name hasSuffix:@"/"]) {
                    NSString *newDirPath= [fileDir stringByAppendingPathComponent:info.name];
                    [fm createDirectoryAtPath:newDirPath withIntermediateDirectories:YES attributes:nil error:nil];
                    continue;
                }
                
                //创建文件
                ZipReadStream *zipStream = [zf readCurrentFileInZip];
                NSMutableData *data = [[NSMutableData alloc] initWithLength:info.length];
                [zipStream readDataWithBuffer:data];
                NSError *error;
                [fm createFileAtPath:[fileDir stringByAppendingPathComponent:info.name] contents:data attributes:nil];
                
                if (error) {
                    NSLog(@"unzip file %@ failed, info:%@", info.name, [error localizedDescription]);
                }
                
                [zipStream finishedReading];
                
                
            } while ([zf goToNextFileInZip]);
            
            [zf close];
        });
    }];
    
    [request setFailedBlock:^{
        NSLog(@"download file nerror");
    }];
}

//改变状态
- (void)changeState:(State_T)state {
    self.downloadState = state;
    [self updateViewWithState:state];
}

//改变view
- (void)updateViewWithState:(State_T)state {
    if (state == STATE_NO_VER) {
        //显示隐藏
        self.ctrlLabelVer.hidden = NO;
        self.ctrlLabelVerHint.hidden = NO;
        self.ctrlPv.hidden = YES;
        
        //btn
        [self.ctrlBtn setTitle:@"下载" forState:UIControlStateNormal];
    } else if (state == STATE_DOWNLOADING) {
        //初始化Pv
        [self.ctrlPv setProgress:0 animated:NO];
        //显示隐藏
        self.ctrlLabelVer.hidden = YES;
        self.ctrlLabelVerHint.hidden = YES;
        self.ctrlPv.hidden = NO;
        
        //btn
        [self.ctrlBtn setTitle:@"下载中" forState:UIControlStateNormal];
    } else if (state == STATE_UPDATE) {
        //初始化Pv
        [self.ctrlPv setProgress:0 animated:NO];
        //显示隐藏
        self.ctrlLabelVer.hidden = YES;
        self.ctrlLabelVerHint.hidden = YES;
        self.ctrlPv.hidden = NO;
        
        //btn
        [self.ctrlBtn setTitle:@"更新" forState:UIControlStateNormal];
    }
}



@end
