//
//  WYSignView.m
//  weyoung
//
//  Created by gongxin on 2019/1/15.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import "WYSignView.h"
#import "NSString+Extension.h"
@interface WYSignView ()

@property(nonatomic,strong)UIImageView * bgImageView;
@property(nonatomic,strong)UIImageView * grassView;
@property(nonatomic,strong)UILabel * dayLabel;
@property(nonatomic,strong)UILabel * weekLabel;
@property(nonatomic,strong)UILabel * monthLabel;
@property(nonatomic,strong)UILabel * infoLabel;
@property(nonatomic,strong)UIButton * signButton;
@property(nonatomic,strong)LOTAnimationView * childAnimation;
@property(nonatomic,strong)NSArray * infoArray;

@end
@implementation WYSignView

-(id)init{

    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        
        [self addSubview:self.bgImageView];
        [self addSubview:self.childAnimation];
        [self addSubview:self.dayLabel];
        [self addSubview:self.weekLabel];
        [self addSubview:self.monthLabel];
        [self addSubview:self.infoLabel];
        [self addSubview:self.signButton];
        [self addSubview:self.grassView];
        [self.childAnimation play];
        [self initData];

    }
    return self;
}

-(void)initData
{

    _infoArray = @[@"世界最⼤大的遗憾是我们能好好开始，却没能好好的告别。",@"后来的我们什什么都有了了，却没有了了我们。",@"世界最⼤大的遗憾是我们能好好开始，却没能好好的告别。",@"致友谊，致爱情，致我⾄至今最⼤大的冒险——向他⼈人敞开⼼心扉。",@"做废物是极需要天赋的，我们普通⼈人只配好好活着。",@"不不要因为⾛走得太远，忘了了我们为什什么出发",@"总得活下去，怨也活下去，不不怨也活下去，不不如不不怨的好。怨多了了，⼈人快⽼老老。",@"梦想就是梦⾥里里⾯面想做的事情，醒来以后努⼒力力实现它。",@"千万不不要以为疲惫⽣生活和英雄梦想之间，只隔着⼀夜暴暴富的距离。",@"⼈人类活动促成了了⻝⾷食物的相聚，⻝⾷食物的离合，也在调动⼈人类的聚散，⻄西⽅方⼈人称作“命运”，中国⼈人叫它“缘分”。",@"我想和你互相浪费，⼀一起虚度短的沉默，⻓长的⽆无意义，⼀一起消磨精致⽽而苍⽼老老的宇宙",@"⼤大学给我最切肤的教训，就是远离⼤大道理理，听从内⼼心的真实。",@"若有⼈人能让你体会到⼼心碎狂喜和⼀一败涂地，那伟⼤大的并不不是他⽽而是你⾃自⼰己。",@"有懂得悲观的乐观才是豁达的 ，如果只是乐观那不不过浅薄的乐观⽽而已。",@"对⽣生命⽽而⾔言，接纳是最好的温柔，不不论是接纳⼀个⼈人的出现，还是接纳⼀个⼈人的 从此不不⻅见。",@"如果有什什么是⼥女女孩要懂的道理理，那么应该是，爱情是你的社交⽣生活，⽽而不不是⽣生活， 结婚⽣生⼦子是你的⼈人⽣生选择，⽽而不不是你的⼈人⽣生。",@"对于这个世界，你相当的古怪;对于我，你⼀点也不不奇怪;对于这个世界，你是⼀个麻烦;对于我，你就是整个世界。》",@"来到⾃自我意识的边疆，看到⽗父亲坐在云端抽烟，他说孩⼦子去和昨天和解吧，就想 我们从前那样，⽤用⽆无限适⽤用于未来的⽅方法，置换体内星⾠辰辰河流。",@"即便便亿万⼈人沉陷于黯淡的岁⽉月，⼀个单独的⼈人，只要他是真正单独的，也可以像 萤⽕火⾍虫跳舞⼀般顾⾃自⽣生存下去。",@"那天你⽤用⼀块红布，蒙住了了双眼也蒙住了了天。 你问我看⻅见了了什什么，我说我看⻅见了了 幸福》",@"我和这个世界不不熟。这并⾮非是我绝望的原因。我依旧有很多热情，给分开，给死 亡，给昨天，给安寂。我和这个世界不不熟。这并⾮非是我虚假的原因。我依旧有很 多真诚，离不不开，放不不下，活下去，爱得起。",@"一切都是命运，⼀切都是烟云，⼀切都是没有结局的开始，⼀切都是稍纵即逝的 追寻。⼀切欢乐都没有微笑，⼀切苦难都没有泪痕，⼀切语⾔言都是重复，⼀切爱 情都在⼼心⾥里里。",@"我们就是⼀个把事情搞得很⼤大，搞得超级⼤大的乐团，如此⽽而已",@"在这段不不断失去的⽇日⼦子中，如果说我还得到过什什么，应该就是:⼈人⽣生总有那么⼀点来不不及，这么⼀种近似于认命的教训吧。",@"让我崩溃的从来不不是天⼤大的事，碰到天⼤大的事我反倒坚强着呢，让我崩溃的，永 远都是那些细碎⽽而恶⼼心的⼩小事和屁事，它们堆叠在⼀起，让我把世界⼜又恨了了⼀遍",@"任何⼀样东⻄西，你渴望拥有它，它就盛开。⼀旦你拥有它，它就凋谢。",@"有很想⾛走的路路，却是不不能⾛走的路路;有⼀一个说好不不⻅见的⼈人，却是最想⻅见的⼈人;有件 事要我别做，却⾮非常想做，那就是⼈人⽣生，是思念，那就是你。",@"⽼老老⼈人的眼睛是⼲干枯的，只会⼼心上流泪",@"有些笑容背后是紧咬⽛牙关的灵魂。",@"世界上存在这样的关系，你最好的朋友就是你最强⼤大的敌⼈人，这是每个⼈人⾃自我隐瞒的秘密——友谊不不只关于爱，也关于恨",@"想要唱⾸首歌，去唱哭别⼈人，最后却是我，满脸泪痕",@"⼈人⽣生总是这么痛苦吗?还是只有⼩小时候是这样?”“总是如此。",@"时间是世界上⼀一切成就的⼟土壤。时间给空想者痛苦，给创造者幸福。",@"为什什么遇到如此强⼤大的敌⼈人你也不不愿逃跑?那是因为身后，有⾄至爱之⼈人。",@"睡眠，在夜⾥里里是个岛，⼈人得渡到那⼉儿去寻求安全。渡不不过去的，譬如我，就在夜 ⾥里里成了了所有⼈人的异类。",@"你终于知道，当你发脾⽓气的时候，明明不不是为了了什什么重要的事，却有⼀一个⼈人把它 当成⼀一回事，那些⽇日⼦子是多么地甜蜜。",@"一个⼈人越是随遇⽽而安，那他的随需也就要随之越少;需要越少，幸福那就多了了!"];
    int value = arc4random() % [_infoArray count];
    self.infoLabel.text = self.infoArray[value];
    NSString * time = [NSString getNowTimeTimestamp];
    NSString * month =[NSString timeToMonth:time];
    NSString * year = [NSString timeToYear:time];
    NSString * my = [NSString stringWithFormat:@"%@%@",[NSString exchangeToEngMonth:month],year];
    self.monthLabel.text= my;
    self.dayLabel.text = [NSString timeToDay:time];
    self.weekLabel.text = [NSString weekdayStringFromDate:[NSDate date]];
//
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.bgImageView.frame= self.bounds;
    self.childAnimation.frame = self.bounds;
    self.dayLabel.frame = CGRectMake(25, KNaviBarHeight+7, 53, 62);
    self.weekLabel.frame = CGRectMake(CGRectGetMaxX(self.dayLabel.frame)+8.5, KNaviBarHeight+23, 42, 20);
    self.monthLabel.frame = CGRectMake(CGRectGetMaxX(self.dayLabel.frame)+4.5, CGRectGetMaxY(self.weekLabel.frame), 50, 14);
    self.infoLabel.frame = CGRectMake(25, 127+KNaviBarHeight, KScreenWidth-50, 84);
    self.signButton.frame = CGRectMake(KScreenWidth/2-75, CGRectGetMaxY(self.infoLabel.frame), 150, 40);
    self.grassView.frame =  CGRectMake(0, KScreenHeight-125, 211, 125);
    
}

-(UILabel*)dayLabel
{
    if (!_dayLabel) {
        _dayLabel = [[UILabel alloc]init];
        _dayLabel.font = [UIFont fontWithName:TextFontName_Light size:44];
        _dayLabel.textColor = [UIColor whiteColor];
        _dayLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _dayLabel;
    
}

-(UILabel*)weekLabel
{
    if (!_weekLabel) {
        _weekLabel = [[UILabel alloc]init];
        _weekLabel.font = [UIFont fontWithName:TextFontName_Light size:14];
        _weekLabel.textColor = [UIColor whiteColor];
        _weekLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _weekLabel;
    
}

-(UILabel*)monthLabel
{
    if (!_monthLabel) {
        _monthLabel = [[UILabel alloc]init];
        _monthLabel.font = [UIFont fontWithName:TextFontName size:10];
        _monthLabel.textColor = [UIColor whiteColor];
        _monthLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _monthLabel;
    
}

-(UILabel*)infoLabel
{
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc]init];
        _infoLabel.font = [UIFont fontWithName:TextFontName_Light size:16];
        _infoLabel.textColor = [UIColor whiteColor];
        _infoLabel.textAlignment = NSTextAlignmentCenter;
        _infoLabel.numberOfLines= 2;
    }
    return _infoLabel;
    
}

-(UIButton*)signButton
{
    if (!_signButton) {
        _signButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _signButton.layer.masksToBounds = YES;
        _signButton.layer.borderWidth = 0.5;
        _signButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _signButton.layer.cornerRadius = 20;
        [_signButton setTitle:@"晚安签到" forState:UIControlStateNormal];
        _signButton.titleLabel.font = [UIFont fontWithName:TextFontName_Light size:14];
        [_signButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        @weakify(self);
        [[_signButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
        
            [self remoteSign];
            self.signButton.userInteractionEnabled = NO;
            NSString * fname = (KScreenHeight<812)?@"first_walk":@"first_walk_x";
            NSString *filePath = [[NSBundle mainBundle] pathForResource:fname ofType:@"json"];
            NSArray *components = [filePath componentsSeparatedByString:@"/"];
            NSString * name = [components lastObject];
            [self.childAnimation setAnimation:name];
            [self.childAnimation play];
            [self backToHomePage];
        }];
    }
    return _signButton;
    
}

-(void)remoteSign
{

    NSDictionary * dict = @{@"interface":@"User@signIn"};
    WYHttpRequest *request = [[WYHttpRequest alloc]init];
    [request requestWithPragma:dict showLoading:NO];
    request.successBlock = ^(id  _Nonnull response) {
        
    };
    
    request.failureDataBlock = ^(id  _Nonnull error) {
        
    };
    
}

-(void)backToHomePage
{
    __weak typeof(self)weakSelf = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        weakSelf.signButton.userInteractionEnabled = YES;
        if (weakSelf.delegate) {
            [weakSelf.delegate signHide];
        }
        [weakSelf removeFromSuperview];
    
    });
    
   
}

-(UIImageView*)bgImageView
{
    if (!_bgImageView) {
        _bgImageView= [[UIImageView alloc]init];
        NSString * iname = (IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs_Max== YES)?@"home_sign_bg_iphonex":@"home_sign_bg";
        _bgImageView.image = [UIImage imageNamed:iname];
        
    }
    return _bgImageView;
}

-(UIImageView*)grassView
{
    if(!_grassView)
    {
        _grassView = [[UIImageView alloc]init];
        _grassView.image = [UIImage imageNamed:@"home_sign_grass"];
    }
    return _grassView;
}

-(LOTAnimationView *)childAnimation
{
    if (!_childAnimation) {
        
        NSString * fname = (KScreenHeight<812)?@"first_wait":@"first_wait_x";
        NSString *filePath = [[NSBundle mainBundle] pathForResource:fname ofType:@"json"];
        NSArray *components = [filePath componentsSeparatedByString:@"/"];
        NSString * name = [components lastObject];
        _childAnimation = [LOTAnimationView animationNamed:name];
        _childAnimation.contentMode = UIViewContentModeScaleAspectFit;
        _childAnimation.loopAnimation = YES;
      
    }
    return _childAnimation;
}


@end
