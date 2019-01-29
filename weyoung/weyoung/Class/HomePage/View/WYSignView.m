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
    
//    • 给⾃自⼰己⼀一个deadline是很重要的。不不管⾃自⼰己有多么不不安，多么紧张，但是到了了那个 时候你就⼀一定要上场。⼈人⽣生⼤大抵都是这样吧。 ———坂本⻰龙⼀一
//    • 做废物是极需要天赋的，我们普通⼈人只配好好活着。 ——李李诞
//    • 可不不可以等等我，等我幡然醒悟，等我明辨是⾮非，等我说服⾃自⼰己，等我爬出悬崖。
//    等我缝好胸腔，来看你。 ——张嘉佳 《从你的全世界路路过》 “你叫胡⼴广⽣生?我叫⻢马嘉旗。”
//    •
//    “我想陪你⾛走过剩下的桥。” ——《⽆无名之辈》
//    • 在所谓⼈人世间摸爬滚打⾄至今， 我唯⼀一愿意视为真理理的，就只有这⼀一句句话: ⼀一切都 会过去的。 ——太宰治《⼈人间失格》
//    • ⽤用⼗十倍苦⼼心做突出⼀一个，正常⼈人够我富议论性么 ——陈奕迅《浮夸》
//    • 致友谊，致爱情，致我⾄至今最⼤大的冒险——向他⼈人敞开⼼心扉。
//    ——《瑞克和莫蒂》
//    • 原来我们都是这样⻓长⼤大的啊，没有怀孕、堕胎、出⾛走、死亡，却看到⾃自⼰己展览了了
//    ⼀一场⻘青春的斩⾸首示众。 ———《狗⼗十三》
//    • 我再也不不会把⾃自⼰己，愚蠢的交给过去
//    我的⽣生活和我的想法，从此相隔了了万⾥里里
//    • 可能忙了了⼜又忙可能伤了了⼜又伤 可能⽆无数眼泪在夜晚尝了了⼜又尝 可是换来成⻓长 可是换来希望
//    ———李李志《寻找》
//    如今我站在台上 和你⼀一起分享 ———吴⻘青峰《⼗十年年⼀一刻》
//    • 忍耐不不是美德，把忍耐当成美德是这个伪善的世界维持它扭曲的秩序的⽅方式，⽣生
//    ⽓气才是美德。——林林奕含《房思琪的初恋乐园》
//    • 现在进⼊入⽼老老年年，她开始过上了了另⼀一种⽣生活，那是年年轻时别⼈人不不允许她过的，她⾃自
//    ⼰己也不不愿意过的⽣生活。——埃莱娜 费兰特《失踪的孩⼦子》
//    • 后来的我们什什么都有了了，却没有了了我们。———《后来的我们》
//
//    • 愿我们耐得住寂寞，经得起流年年，既能朝九晚五，⼜又能浪迹天涯，最终成为那个 侠客。——孙晴悦《⼆二⼗十⼏几岁没有⼗十年年》
//    • 世界最⼤大的遗憾是我们能好好开始，却没能好好的告别。 ——刘同《你的孤独虽 败犹荣》
//    • ⾃自嘲，是化解窘境的最好武器器。把姿态放低，那些想让你尴尬的⼈人还能怎样? ——杨澜《世界很⼤大幸好有你》
//    • 你以为⾃自⼰己还有⼤大把的时间去做⼀一些事，可最终要做的时候却发现已经来不不及 了了。 ——克莉丝汀·汉娜《再⻅见，萤⽕火⾍虫⼩小巷》
//    • 成熟意味着镇静⾃自若地接受⽣生活的波折，要在实际⽣生活和理理论之间划出⼀一道界 限。 ——埃莱娜·费兰特《离开的，留留下的》
//    • 耗费⽣生命中最美好的时光去挣钱，为了了享受最不不宝贵的时间⾥里里那⼀一点⼉儿可疑的⾃自 由。 ——亨利利·⼤大卫·梭罗《瓦尔登湖》
//    • 他不不知道前⾯面会怎么样，但⾄至少要⽐比抛在后⾯面的过去好。 ——J.K.罗琳《哈利利波 特》
//    • 都看得很明⽩白，都活得很不不明⽩白。 ——李李诞《笑场》
//    • ⼈人⼀一辈⼦子，总有些不不体⾯面的时刻会永远留留在脑海海⾥里里。——朗·霍尔 丹丹佛·摩尔《世界
//    上的另⼀一个你》
//    • 不不要因为⾛走得太远，忘了了我们为什什么出发。 ——柴静《看⻅见》
//    • 永远不不要为你所爱的⼈人过多付出，除⾮非你做得到永远不不去提及。——慕⾔言歌《你
//    的善良必须有点锋芒》
//    • 总得活下去，怨也活下去，不不怨也活下去，不不如不不怨的好。怨多了了，⼈人快⽼老老。
//    ——蔡澜《我决定活得有趣》
//
//
//    •
//    • ⼀一⽣生太短 ⼀一瞬好⻓长
//    我们哭着醒来 ⼜又哭着遗忘
//    幸好啊 你的⼿手曾落在我肩膀 ——⽑毛不不易易《⽆无问》
//    • 梦想就是梦⾥里里⾯面想做的事情，醒来以后努⼒力力实现它。——易易烊千玺
//    • “死亡”才是对⽣生命最精准的教育，它可以照亮我们，和逼我们去改变那些我们⾃自以
//    为是的陋陋习。——邱晨
//    • 千万不不要以为疲惫⽣生活和英雄梦想之间，只隔着⼀一夜暴暴富的距离。——詹⻘青云
//    • 结婚，就是办家族企业，签的，是⼀一张终⽣生批发的期货合同，双⽅方⼀一起拿起⾃自⼰己
//    的资源办企业，这个时候男⼥女女双⽅方给出来的资源包是不不⼀一样的，有身体、有⽣生育
//    能⼒力力、有容颜、有家庭关系、有⾃自⼰己未来的增⻓长潜⼒力力。——薛兆丰
//    • ⼈人类活动促成了了⻝⾷食物的相聚，⻝⾷食物的离合，也在调动⼈人类的聚散，⻄西⽅方⼈人称作“命
//    运”，中国⼈人叫它“缘分”。——《⾆舌尖上的中国2》
//    • 转眼如隔世，已是很多年年
//    前路路遥⽆无可期，后路路渐远
//    看那物是⼈人⾮非，已时过镜迁 ——丢⽕火⻋车《如斯》
//    • 我想和你互相浪费，⼀一起虚度短的沉默，⻓长的⽆无意义，⼀一起消磨精致⽽而苍⽼老老的宇
//    宙。——程璧《我想和你虚度时光》
//    • ⼤大学给我最切肤的教训，就是远离⼤大道理理，听从内⼼心的真实。——吴浩然《烬余
//    录》
//    • 若有⼈人能让你体会到⼼心碎狂喜和⼀一败涂地，那伟⼤大的并不不是他⽽而是你⾃自⼰己。
//    ——琦殿
//    • 恋爱最珍贵的纪念品，从来就不不是那些，你送我的⼿手表和项链，甚⾄至也不不是那些
//    甜蜜的短信和合照。是你留留在我身上的，如同河流留留给⼭山川的，那些你对我造成
//    的改变。——蔡康永
//    • 我们最⼤大的不不同在于我底⾊色悲凉 ，⼤大家好像都觉得悲凉是特别苦的词 ，其实是只
//
//    有懂得悲观的乐观才是豁达的 ，如果只是乐观那不不过浅薄的乐观⽽而已。——⻢马东

 
    _infoArray = @[@"对⽣生命⽽而⾔言，接纳是最好的温柔，不不论是接纳⼀个⼈人的出现，还是接纳⼀个⼈人的 从此不不⻅见。",@"如果有什什么是⼥女女孩要懂的道理理，那么应该是，爱情是你的社交⽣生活，⽽而不不是⽣生活， 结婚⽣生⼦子是你的⼈人⽣生选择，⽽而不不是你的⼈人⽣生。",@"对于这个世界，你相当的古怪;对于我，你⼀点也不不奇怪;对于这个世界，你是⼀个麻烦;对于我，你就是整个世界。》",@"来到⾃自我意识的边疆，看到⽗父亲坐在云端抽烟，他说孩⼦子去和昨天和解吧，就想 我们从前那样，⽤用⽆无限适⽤用于未来的⽅方法，置换体内星⾠辰辰河流。",@"即便便亿万⼈人沉陷于黯淡的岁⽉月，⼀个单独的⼈人，只要他是真正单独的，也可以像 萤⽕火⾍虫跳舞⼀般顾⾃自⽣生存下去。",@"那天你⽤用⼀块红布，蒙住了了双眼也蒙住了了天。 你问我看⻅见了了什什么，我说我看⻅见了了 幸福》",@"我和这个世界不不熟。这并⾮非是我绝望的原因。我依旧有很多热情，给分开，给死 亡，给昨天，给安寂。我和这个世界不不熟。这并⾮非是我虚假的原因。我依旧有很 多真诚，离不不开，放不不下，活下去，爱得起。",@"一切都是命运，⼀切都是烟云，⼀切都是没有结局的开始，⼀切都是稍纵即逝的 追寻。⼀切欢乐都没有微笑，⼀切苦难都没有泪痕，⼀切语⾔言都是重复，⼀切爱 情都在⼼心⾥里里。",@"我们就是⼀个把事情搞得很⼤大，搞得超级⼤大的乐团，如此⽽而已",@"在这段不不断失去的⽇日⼦子中，如果说我还得到过什什么，应该就是:⼈人⽣生总有那么⼀点来不不及，这么⼀种近似于认命的教训吧。",@"让我崩溃的从来不不是天⼤大的事，碰到天⼤大的事我反倒坚强着呢，让我崩溃的，永 远都是那些细碎⽽而恶⼼心的⼩小事和屁事，它们堆叠在⼀起，让我把世界⼜又恨了了⼀遍",@"任何⼀样东⻄西，你渴望拥有它，它就盛开。⼀旦你拥有它，它就凋谢。",@"有很想⾛走的路路，却是不不能⾛走的路路;有⼀一个说好不不⻅见的⼈人，却是最想⻅见的⼈人;有件 事要我别做，却⾮非常想做，那就是⼈人⽣生，是思念，那就是你。",@"⽼老老⼈人的眼睛是⼲干枯的，只会⼼心上流泪",@"有些笑容背后是紧咬⽛牙关的灵魂。",@"世界上存在这样的关系，你最好的朋友就是你最强⼤大的敌⼈人，这是每个⼈人⾃自我隐瞒的秘密——友谊不不只关于爱，也关于恨",@"想要唱⾸首歌，去唱哭别⼈人，最后却是我，满脸泪痕",@"⼈人⽣生总是这么痛苦吗?还是只有⼩小时候是这样?”“总是如此。",@"时间是世界上⼀一切成就的⼟土壤。时间给空想者痛苦，给创造者幸福。",@"为什什么遇到如此强⼤大的敌⼈人你也不不愿逃跑?那是因为身后，有⾄至爱之⼈人。",@"睡眠，在夜⾥里里是个岛，⼈人得渡到那⼉儿去寻求安全。渡不不过去的，譬如我，就在夜 ⾥里里成了了所有⼈人的异类。",@"你终于知道，当你发脾⽓气的时候，明明不不是为了了什什么重要的事，却有⼀一个⼈人把它 当成⼀一回事，那些⽇日⼦子是多么地甜蜜。",@"一个⼈人越是随遇⽽而安，那他的随需也就要随之越少;需要越少，幸福那就多了了!"];
    
    self.infoLabel.text = @"孤独本身没什么不好，让它不好的，是害怕孤独，今天很重要，今天的你也很重要";
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
