//
//  BabyPreTableViewCell.m
//  puuman2
//
//  Created by Ra.（祁文龙） on 14-5-5.
//  Copyright (c) 2014年 AFITC. All rights reserved.
//

#import "BabyPreTableViewCell.h"
#import "ColorsAndFonts.h"
#import "UniverseConstant.h"

#define columnB @"http://appui.oss-cn-hangzhou.aliyuncs.com/%E5%AD%95%E6%9C%9F%E5%9B%BE%E7%89%87%EF%BC%88%E4%BA%A7%E6%A3%80%EF%BC%89/"
#define columnA @"http://appui.oss-cn-hangzhou.aliyuncs.com/%E5%AD%95%E6%9C%9F%E5%9B%BE%E7%89%87%EF%BC%88%E6%89%8B%E7%BB%98%EF%BC%89/"
static NSString *clonumAimages[40] = {@"1week%402x.jpg",@"2week%402x.jpg",@"3week%402x.jpg",@"4week%402x.jpg",@"5week%402x.jpg",@"6week%402x.jpg",@"7week%402x.jpg",@"8week%402x.jpg",@"9week%402x.jpg",@"10week%402x.jpg",@"11week%402x.jpg",@"12week%402x.jpg",@"13week%402x.jpg",@"14week%402x.jpg",@"15week%402x.jpg",@"16week%402x.jpg",@"17week%402x.jpg",@"18week%402x.jpg",@"19week%402x.jpg",@"20week%402x.jpg",@"21week%402x.jpg",@"22week%402x.jpg",@"23week%402x.jpg",@"24week%402x.jpg",@"25week%402x.jpg",@"26week%402x.jpg",@"27week%402x.jpg",@"28week%402x.jpg",@"29week%402x.jpg",@"30week%402x.jpg",@"31week%402x.jpg",@"32week%402x.jpg",@"33week%402x.jpg",@"34week%402x.jpg",@"35week%402x.jpg",@"36week%402x.jpg",@"37week%402x.jpg",@"38week%402x.jpg",@"39week%402x.jpg",@"40week%402x.jpg"};
static NSString *clonumBimages[40] = {@"1week-b%402x.PNG",@"2week-b%402x.PNG",@"3week-b%402x.PNG",@"4week-b%402x.PNG",@"5week-b%402x.PNG",@"6week-b%402x.PNG",@"7week-b%402x.PNG",@"8week-b%402x.PNG",@"9week-b%402x.PNG",@"10week-b%402x.PNG",@"11week-b%402x.PNG",@"12week-b%402x.PNG",@"13week-b%402x.PNG",@"14week-b%402x.PNG",@"15week-b%402x.PNG",@"16week-b%402x.PNG",@"17week-b%402x.PNG",@"18week-b%402x.PNG",@"19week-b%402x.PNG",@"20week-b%402x.PNG",@"21week-b%402x.PNG",@"22week-b%402x.PNG",@"23week-b%402x.PNG",@"24week-b%402x.PNG",@"25week-b%402x.PNG",@"26week-b%402x.PNG",@"27week-b%402x.PNG",@"28week-b%402x.PNG",@"29week-b%402x.PNG",@"30week-b%402x.PNG",@"31week-b%402x.PNG",@"32week-b%402x.PNG",@"33week-b%402x.PNG",@"34week-b%402x.PNG",@"35week-b%402x.PNG",@"36week-b%402x.PNG",@"37week-b%402x.PNG",@"38week-b%402x.PNG",@"39week-b%402x.PNG",@"40week-b%402x.PNG"};
#define  BABY_COLUMN_CNT   40
#define kPicWidth 256
#define kPicHeight 296


static NSString *info[40] ={@"·宝宝·\n     因为精子与卵子暂时还没有接触，所以婴儿还没有形成。为了便利，怀孕期通常从最后一次月经周期开始算起，共40周（280天）。但是，真正的排卵和精子的受精在最后月经后的两周才会发生，所以怀孕的最初两周并不是真正的怀孕期间。严格来说，婴儿是精子与卵子受精大约38周后诞生的。                                   \b\n\n·妈妈·\n     距离最后一次月经结束后没几天。在最后一次月经期间，妈妈的身体里会分泌一种叫“滤泡刺激素”的物质，使卵巢里的一个卵子成熟起来。现在，黄体激素分泌并刺激卵巢的话，卵子会排出来（即排卵）留在输卵管，等待精子。                                \b",@"·宝宝·\n     因为精子与卵子暂时还没有接触，所以婴儿还没有形成。为了便利，怀孕期通常从最后一次月经周期开始算起，共40周（280天）。但是，真正的排卵和精子的受精在最后月经后的两周才会发生，所以怀孕的最初两周并不是真正的怀孕期间。严格来说，婴儿是精子与卵子受精大约38周后诞生的                                   \b\n\n·妈妈·\n     在上一周结束了最后一次月经。在那个期间，妈妈身体里分泌的一种叫“滤泡刺激素”的物质会使卵巢里的一个卵子变成熟。现在，黄体激素分泌并刺激卵巢的话，卵子会排出来（即排卵）留在输卵管，等待精子。这时的卵子只有0.1mm大，只凭肉眼很难看见。在这周周末左右妈妈会排卵并和爸爸的精子相遇并受精。                                \b",@"·宝宝·\n     怀孕第三周是精子与卵子真正相见、受精后一起度过的第一周。在数亿个精子中极少数的精子会到达卵子的周围，其中被选中的唯一一个精子会与卵子相见，变成受精体。婴儿的性别在这一瞬间已经确定了。受精体有爸爸的23条染色体和妈妈的23条染色体，共46条染色体，之后经过细胞分裂逐渐成长。受精后的第一个12小时内，受精卵会分裂成两个细胞，之后的每12小时会以自身的二次方的量增加，四天之后会形成13~32个细胞，像一串葡萄一样，我们称之为“桑实胚”。桑实胚会离开输卵管，在这周末安居在子宫内。此时Ta已经变成500多个细胞，在以后的37周里Ta会留在那里成长。细胞的数量虽然多了，但是婴儿的大小还是只有0.1mm大。                                   \b\n\n·妈妈·\n     受精通常发生在排卵前后的5天内。即使受精了，大部分的女性还察觉不了。在受精卵里开始分泌一种叫做“早期怀孕因素”（EPF）的物质，会使子宫内部变成适合怀孕的环境。刚受精的受精体附着在子宫壁的过程中，可能会出现少量的血和黄色的分泌物，这种现象叫做着床出血。受精后12天左右会形成胎盘，并大量分泌雌性激素和黄体酮等怀孕激素。受这些荷尔蒙的影响，子宫将会变得成熟，乳房也为了适合哺乳而在一定程度上变大。                                \b",@"·宝宝·\n     现在我们可以叫他胚胎，而不再是受精体了。Ta像一个小豆子长出了新芽。胚胎在子宫稳定下来的同时，羊水口袋和养分口袋也开始形成。我们叫羊水口袋为羊膜囊，养分口袋为黄囊。胚胎的大小还只有0.2mm，但正在茁壮成长，生成嘴巴、脊髓、心脏、血管等。这周末会长出绒毛膜的绒毛。                                   \b\n\n·妈妈·\n     受精后12天会形成胎盘，并分泌人绒毛膜促性腺激素（hCG），此时可以用早孕试纸自我检测怀孕与否，但最好还是等到人绒毛膜促性腺激素充分分泌，大概需要1~2周的时间，这样会得到更准确的结果。如果体质敏感的话，这种荷尔蒙的变化会引起呕吐等症状。妊娠呕吐在怀孕第3个月时最厉害，此时人绒毛膜促性腺激素分泌达到最高潮；之后会慢慢变好。为了运输更多的氧与营养，血液量也会开始增加。血液量的增幅在怀孕的前三个月程度最大，分娩时会有比没怀孕时多出30%~50%的血液。为了适应增加的血液量，心脏也会跳得更快更有力，脉搏次数会比没怀孕时每分钟多跳15下，因此可能有疲劳、气喘的症状。这段时间乳房的感觉也会和以前不太一样，用手指按乳房时会感到有些硬，甚至麻木或疼痛，乳房和乳头也开始变大，乳晕也会变宽，颜色变深，这是因为血液循环变得活跃起来，使色素沉着。这种变化在出产后也有可能持续。同时子宫的内膜开始变厚，血管也更加发达了。                                \b",@"·宝宝·\n     现在，在婴儿的脊椎处长出了“最初的线条”，此线条成长后会形成三层组织：外胚层、中胚层和内胚层。最上面的外胚层将会形成大脑、脊髓等神经系统和脊椎骨、皮肤、指甲、头发、眼睛、鼻子、嘴巴、耳朵、肛门等器官。中间的中胚叶不但是心脏和血管的基础，还会形成骨骼、肌肉、肾脏和生殖器官。心脏第一次跳动的时间是精子与卵子见面后的第21~22天。最底下的内胚层将会形成肺，肠和膀胱。婴儿的大小像圆珠笔上的小圆珠子那么大（2mm左右），羊水袋（羊膜囊）则是一粒葡萄大小。                                   \b\n\n·妈妈·\n     进入了怀孕第二个月。这是第一次没有月经的一周，人绒毛膜促性腺激素也充分分泌，在早孕试纸测试中阳性反应会很明显。乳房可能会感到很敏感、疼痛，有些女性会感到恶心、想呕吐等。身体会疲劳，觉得肚子酸痛，容易睡不着，小便频繁等，开始经历一些妊娠反应。                                                \b",@"·宝宝·\n     宝宝的成长速度非常的快，这周内就能长大三倍。像眼睛、嘴巴、耳朵等脸部特点开始逐渐具体化，在长出眼睛的位置上会形成眼胚。在这个时候，神精垄沟会关闭，头部的大脑会开始发达。而且小巧的心脏会开始跳动！虽然心脏还很小，但是以整个身体的比例来看，它的大小是成人的9倍。消化器官和呼吸器官也开始长大。在中央线周围会长出40个小组织块，它们将变成支撑宝宝的脊椎骨、肋骨和肌肉。现在手臂还像鱼的鳍一样，将会变成腿的小突起也很快就会出来。到了周末，从头部到臀部的长度会是5mm左右，这与第一次受精后相比，长大了差不多1万倍。                                   \b\n\n·妈妈·\n     在这个阶段暂时体重和腰围不会有明显的变化。妈妈可能会开始呕吐，因为荷尔蒙的变化导致情绪变化多端。在怀孕期间分泌的荷尔蒙中，黄体酮一开始从卵巢分泌，后来从胎盘分泌，因此子宫壁的血管会长得好，给婴儿供给养分也很顺畅。从卵巢、胎盘分泌的另一种荷尔蒙雌激素会使子宫、颈部、阴道、乳房成熟，发展为适合怀孕的状态。到了本周末就将成功结束怀孕的第一个月。                                                \b",@"·宝宝·\n     连接妈妈与孩子最重要的脐带渐渐出现了。脐带由两条动脉和一条静脉组成，新鲜的血液与营养通过静脉供给宝宝，产生的废物通过两条动脉经过胎盘再传回妈妈。这样把血液供给宝宝再回来的过程消耗30秒左右。这周宝宝的大脑发展的特别快。在脑内，会形成脑脊液流动的空间，右脑与左脑的分区也会很明显。如果我们能亲眼观察的话，可以通过透明的头盖骨，隐约看到宝宝的大脑。宝宝的脸部也会明确一点，眼睛会形成晶状体，眼珠的位置也确定了，耳朵形成中耳，嘴巴也会开始有形状。又小又可爱的胳膊还是像鱼的鳍一样，很快腿也会长出来。到周末的时候，从头到臀部大约有9mm，会长的和妈妈的小拇指指甲那么大。体重大概是0.1g。                                   \b\n\n·妈妈·\n     精子与卵子真正相遇后已经五周左右了。如果是第一次怀孕的话，现在体重会慢慢的增长，但周围的人还是不太容易看出来。如果开始出现呕吐症状，反而会比怀孕前轻几公斤。如果这是第二次怀孕的话，子宫和腹部肌肉在一定程度上松弛了很多，所以肚子可能会开始变大。现在妈妈的体内，正在努力产生新的血液，心跳也会比平时更快更强，这都是为了给妈妈自身和宝宝供给充分的营养与氧气。受雌激素，黄体酮等荷尔蒙的影响，乳腺已经形成，为生产母乳而做准备，因此会感到乳房变大变沉。乳头的周围也会因血液循环增加而颜色变身，开始呈现褐色。最近子宫的大小像苹果那么大，但随着快速增长，等到分娩的时候会比怀孕前膨胀1000倍。                                                \b",@"·宝宝·\n     八周的时候，宝宝的头部比身体大，会开始长出耳朵、鼻尖、上嘴唇，手指甲和脚指甲也会冒出来，手腕和脚腕变得很明显，还可以弯曲。眼皮开始长出来了，在还没有完全成型之前，宝宝的眼睛会一直是睁着的样子。宝宝的心脏一分钟跳动150回，比普通成人要快两倍。调节全身肌肉的小脑也已形成。肝也变大了，因此肚子也鼓鼓的。在大脑里开始形成脑下垂体，它分泌出来的荷尔蒙将适度调节婴儿的甲状腺、生殖等很多重要功能。现在鼻孔，喉头，支气管都长出来了，眼睛上长出了视网膜细胞。肾脏开始形成小便。超音波暂时还很难辨别出性别，但是生殖器也发生了第一次变化。现在从头到臀的长度已经有1.6cm了，体重有1g左右。                                   \b\n\n·妈妈·\n     随着宝宝的增长，子宫也在迅速变大。在子宫里，宝宝和胎盘一起在快速增长并牢牢地固定在子宫壁上。在这个过程中，下腹会感到不适，有时会感到疼痛，可能会透出少许的血。子宫的颈部有些发青，会变得越来越柔滑，颜色变浅。大概怀孕7~8周的时候，子宫颈部的黏液盖会形成，它会阻止细菌入侵而起到保护作用。若是曾经经历过怀孕的母亲，会发现肚子比之前的怀孕鼓得更快，这是因为子宫和周围的肌肉、韧带已经经历过怀孕的状态，会像气球一样再一次轻而易举的膨胀，这种现象叫热身效果。近期因为荷尔蒙的变化导致心情有些忧郁，皮肤会变得干燥，要注意保湿。已经跳过了第二个生理周期。                \b",@"·宝宝·\n     这周宝宝的尾巴会消失。到现在为止，像饭勺的手和脚开始有些形状了，仍然比身体大的头部会蜷缩起来，对着胸部，现在已经能够记录脑波了。逐渐眼睛也会成熟起来，鼻梁也长出来了。身体里，软骨和骨骼变得成熟，精子、卵子也会形成，但还需要1~2周的时间才能确定性别。在耳朵内，会长出能够调解身体平衡的耳蜗，胸上会长出乳头，身子和胳膊也变长了，现在更像人的模样了。在体内会长出胆囊，胰脏和肛门。女孩开始长出卵巢，男孩长出精巢，但是还不能分辨是男是女。现在宝宝胳膊的长度和“I”的长度差不多，从头到臀部有2.3cm，体重2g左右。                                   \b\n\n·妈妈·\n     腰围长了一点，但还不能看出是个怀孕的女性。体内的血液量已经增长了50%来帮助子宫的成长，供给孩子更多氧气和营养，因此面色有些红润。妈妈的心脏负担变大，血管也变松弛，会容易出现疲劳、头疼、气喘等症状。同时，由于绒毛性腺激素和黄体酮的增加，皮肤会变得很油腻光滑，一不小心会使青春痘恶化。最近胸的大小变化会很明显，比之前变得柔软一些了，有时会有刺痛或痒的感觉。                                \b",@"·宝宝·\n     怀孕第10周，最主要的脏器大部分都已经完成，现在开始真正运作了。宝宝的尾巴完全消失，大脑正在加速成长，在这周，每分钟有250,000个新的神经细胞诞生，大脑出现了皱纹，会逐渐变得精致起来。手指头和脚趾头都分开了，手指甲和脚趾甲也长了出来，胳膊从柔软的软骨变成坚硬的骨骼，手肘便可以弯曲了。眼睛变得更黑，鼻子变圆，耳朵的样子也快完成了，在长牙齿的位置长出小突起。如果是女孩子，会长出阴蒂，男孩的话会形成阴茎，而且分泌出男性荷尔蒙睾酮，装着睾丸的阴囊会开始膨胀。到周末的时候，从头到臀部的长度是3.1cm，体重是4g左右。如果宝宝按现在的速度继续生长的话，在一个月内他的个子会超过6m。                                   \b\n\n·妈妈·\n     到怀孕10周的时候体液量会增大，眼球的最外面一层巩膜也会涨，比之前变厚3%，这样的变化在分娩后会持续1~2个月，之后自然会恢复到之前的样子。不仅巩膜，眼球内的压力会降低10%左右，视野会变得模糊。乳房的乳晕会冒出20~30个小突起，我们叫它蒙哥马利突起。分娩后进行哺乳时，这些突起会冒出油分，使乳头变得柔滑而不受伤。为了充分吸收妈妈和宝宝充分的营养分的消化器官会比较疲劳，常常感到消化不良，肚胀。现在可以利用多普勒听诊器听到宝宝的心跳声。子宫有一个橘子那么大，脐带有2cm了。                                \b",@"·宝宝·\n     现在宝宝成长到可以正式叫胎儿而不是了胚胎了，从小蝌蚪的样子已经变得有模有样了。从现在开始到20周的时候，宝宝的身高会长高三倍，体重会比现在重30倍。不仅手指甲、脚趾甲和头发已经长出来，在皮肤上也开始形成汗毛的毛囊。耳朵逐渐往上方、两侧移动找到自己的位置。为了保护内部脏器，皮肤渐渐变得不透明、变厚。眼皮已经长好，能够闭上眼睛了，宝宝甚至还会打哈欠了。到了这周末，外部生殖器的位置会冒出小突起。身子，胳膊和腿会变长，从头到臀部的长度是4.1cm，体重是7g左右。                                   \b\n\n·妈妈·\n     现在应该是呕吐等妊娠反应最明显的时候，但一部分产母可能妊娠反应已经缓解而感到食欲旺盛。因为血液量的增长，血液循环会不太好，下肢静脉瘤会严重起来。脸部、胸部和下腹的色素会有些沉淀，但一般分娩后都会消失。最近可能会感到下腹像针扎一样疼，会感到不适，这是因为子宫变大，支撑它的韧带也一起在变大而引起的反应。特别是子宫圆形韧带变大，会产生强烈的疼痛。                                \b",@"·宝宝·\n     宝宝脸上下巴、鼻子等轮廓渐渐明显起来了。上颚的骨骼也变硬了，使鼻子和嘴巴区分开来。现在用多普勒装置可以清晰地听到心脏跳动的声音。在宝宝体内产生的干净的小便会流到羊水里，再变成新鲜的羊水进来。大脑的构造已经开始和出生时差不多成熟了，可以闻味道的嗅觉器官也开始成熟。如果轻轻碰一下宝宝的脸颊，它会把头转向刺激方向并做出张嘴的样子，这叫做觅食反射，是在为出生后吸奶而做准备。调节人新陈代谢的甲状腺已完成，消化器官胆囊和胰脏也能看见。手指甲和脚趾甲更明显了，外部的生殖器也开始形成。从头到臀部的长度是5~6cm，体重是14g，是一周前的两倍。                                   \b\n\n·妈妈·\n     怀孕12周时骨盆已经无法容纳子宫，甚至一部分子宫会超出去。子宫越来越大，压迫膀胱，所以小便比之前频繁了很多，这种症状会越来越明显。暂时还感受不到胎动。目前怀孕荷尔蒙主要由卵巢分泌，但之后从宝宝和胎盘分泌的会更多。雌激素和黄体酮的分泌逐渐增多，因此会出现一些不太愉快的症状，呕吐与乳房痛、头痛与眩晕、小便频繁与失眠等都与荷尔蒙的变化有关。现在已经比怀孕前的体重增了1~3kg左右。现在已经过去怀孕期的三分之一。                                \b",@"·宝宝·\n     现在大部分的脏器、神经和肌肉都形成了，他们之间能紧密协调运作了。被遮在眼皮底下的眼睛经历大约30周左右的发育后将重新睁开。在脐带周围形成的脏器开始在宝宝的肚子里找位置了。在这周内牙龈里的20个幼齿和齿根会长出来。喉头会长出声带，当然在羊水里并不能发出声音。脸部的肌肉发达后，可以笑也可以皱眉头了。虽然还不熟练，但手可以弯曲，也可以用脚踢了。速度快的话，这周内宝宝可能会把手指放到嘴里去，但真正要做吮手指的动作还需要等一阵子。负责消化的胃脏就快发育好了，肝已经开始分泌胆汁，胰脏会分泌胰岛素来调节血糖。现在从头到臀部的长度是7.4cm，体重是23g左右。                   \b\n\n·妈妈·\n     怀孕初期的副作用渐渐消失了，怀孕后期的不适感还没出现，进入了相对轻松的怀孕季度。循环系统的规模在急速膨胀，血压可能会降低，减幅大约是收缩压平均5~10mmHG、舒张压10~15mmHG左右，因人而异，过段时间会渐渐恢复到原来的血压。怀孕第20周时，主要是血浆（血液中间的液体部分）增多，之后赤血球会增多，变成健康的血液。因为血液增多，鼻子里的粘膜肿胀，鼻炎会加重或牙龈会变弱，易出血。这是80%以上的妈妈都会经历的症状。这个月，呼吸时会比平时快，有点喘的感觉；这是为了更有效的排出妈妈和宝宝的排泄物即二氧化碳，脑中枢所诱导的自然现象，三分之二的妈妈会经历的这种现象。                                \b",@"·宝宝·\n     男孩会长出前列腺，女孩的话原本在肚子里的卵巢会移到骨盆。甲状腺在努力工作，同时很努力地制造出荷尔蒙。宝宝反复把羊水喝了再吐出来，模仿呼吸的动作使肺成熟起来。脸颊长了肥嘟嘟的肉，上颚等嘴里的构造物也差不多完成了。胳膊变长了，大拇指也有形状了，但腿还是很短。脾脏完成了，它把旧的红细胞排除掉，使血液更透彻，开始分泌出击败病魔的抗体。这周从头到臀部长度有8.7cm，体重大概有43g左右。                   \b\n\n·妈妈·\n     最近因为雌激素与黄体酮荷尔蒙的影响，乳头与周围的颜色逐渐变深，变宽。以后出产后虽然会变浅，但还是比怀孕前要深一些。胸部比以前重了，按了会有些疼痛。同时，因黄体酮的原因，胃肠管的运动会变慢，特别是食道和胃之间的距离收缩，使防止胃酸逆流的括约筋变弱，会直打酸嗝，反胃。胃肠管速度变慢是使食物在体内的时间更长而吸收更多的营养，但会因此引发逆流性食道炎和便秘等症状的恶化。肠管内的水分会被吸收更多，大便会变硬，而且子宫越来越大，压迫肠管，使便秘更加严重。                                \b",@"·宝宝·\n     身体上开始长汗毛、眉毛、头发等，如果可以看到的话，就能知道宝宝是自然卷还是直发。耳朵和眼睛几乎找到了自己的位置，但暂时还有点偏下。支撑身体的骨骼、骨髓和肌肉会重点发育，手、胳膊、手腕和脚趾头等会动起来。宝宝开始把大拇指放进嘴里吮，也会握拳或踢脚，但暂时妈妈还感受不到。现在从头到臀部的长度是10.1cm，体重是70g左右。                                   \b\n\n·妈妈·\n     子宫越来越大，慢慢向左和前方偏离，会感觉到身体的中心点在移动，姿态也会随之而变。变大的子宫压迫着别的脏器，支撑子宫的肌肉和韧带会拉长，引起各种各样的不适。子宫会压迫从腿到心脏的的血管，使得下肢的血流不流畅，容易腿麻，而且血液量一直在增加，站一会儿脚踝部分就会有些浮肿。最近宝宝会踢腿但是暂时还感觉不到胎动。                                \b",@"·宝宝·\n     像鱼一样长在两边的眼睛渐渐往脸的前方移动。虽然闭着眼睛，但可以动眼球了，嘴巴也可以关闭，耳朵也完全定了位，渐渐能听到外部的声音了。手指甲形成后脚趾甲也跟着形成，外部生殖器也初步成形了。四肢肌肉和神经系统也充分发育，现在脸部肌肉开始长成。如果是女孩，卵巢里已经有数百万个卵子在生成。成长速度快的宝宝已经可以开始打嗝，但因为器官内部不是空气而是水，所以没有打嗝的声音，而且妈妈也无法感受到。到周末的时候，从头到臀部有11.6cm，体重有100g左右。                                   \b\n\n·妈妈·\n     妈妈的体重大约在一周增长500g，一个月增长1.5~2kg，而且增加速度会越来越快。最近受荷尔蒙的影响，会出现从乳头流出透明液体的情况，一般只是水分太多的原因，并不是初乳。而且血液量的增多，粘膜很容易肿，会出现鼻塞、流鼻血等症状。怀孕荷尔蒙会影响阴道内壁的分泌腺，会有分泌物增多的感觉，但不必担心。宝宝和子宫变大后下腹会有拉紧的感觉，还会有点疼痛感，但是随着子宫逐渐移出骨盆，向上移动，压迫膀胱的压力会减少，小便的次数也会随之减少。为了支撑急速增长的子宫重量，脊椎骨会呈往后弯曲的姿势，因此会引发腰痛，而且为了顺利的分娩，骨盆周围的关节会变弱，韧带也会松弛，使腰痛更加恶化了。                                \b",@"·宝宝·\n     现在大部分的脏器都发育完了，现在是长大的和功能成熟的过程。最近宝宝开始积累褐色的脂肪了，是为了出生后维持体温而做准备。现在宝宝是以后出生时体重的一半，和胎盘的大小差不多大。逐渐宝宝会长到比胎盘还大，同时眉毛和头发也开始长出来了，可以做出眨眼、吮手指、吞咽等反射运动。有时宝宝会打嗝，妈妈虽然听不见但能感受得到了。这周末从头到臀部的距离有13cm，体重是140g左右。                   \b\n\n·妈妈·\n     宝宝的快速成长，会需要更多的营养分，使妈妈的食欲会非常旺盛。敏感的话，能微微感受到第一次胎动的感觉，但还不是很明显。因为循环系统的快速扩张，所以血压会一时偏低，而且会有点晕。为了补充扩张的循环系统，血液量也在急剧增加，为了健康的血液，一天需要供给30g以上的铁。因为血液量的增多，妈妈出现鼻渊、流鼻血、刷牙时牙龈出血等副作用，而且会越来越严重。                                                \b",@"·宝宝·\n     宝宝的手指头和脚趾头变得肥嘟嘟了，也开始长指纹了。眼睛已经完全到前面去了，和出生时的面部差不多，耳朵也找到了自己的位置。最近宝宝的骨骼在变硬，我们称之为骨化过程。特别是宝宝的腿和内耳骨会先骨化，因此脑与耳朵之间的神经网络完成，宝宝就可以听到声音了。现在宝宝还可以吞水了，每天都会适量的喝羊水，这样应该是调节羊水量的行为。现在宝宝从头到臀部的长度是14cm，体重是190g左右。                                   \b\n\n·妈妈·\n     最近稍有异味的白色阴道分泌物（白带）增多了，是子宫颈部或阴道周围受到怀孕荷尔蒙影响而引起的，不用太担心。心跳会比平时快50%左右，受黄体酮荷尔蒙的影响肺的容积变宽了，每次吸气吐气时会比平时多40%的空气。同时黄体酮使消化器官的运动变慢，反胃、便秘、消化不良等现象也会因此恶化。妈妈吃饭大约两个小时后营养分通过胎盘传达给宝宝。现在妈妈能感受到宝宝微微的胎动了，就像一滴水泡爆炸而产生咕噜咕噜的感觉。                                                \b",@"·宝宝·\n     最近宝宝的皮肤上长出了又白又滑的油膜——胎脂，它保护在子宫里宝宝的皮肤不受伤害。胎脂下面会长出柔顺的毛，在出生之际会完全消失。宝宝的肾脏也长出来了，现在可以任意小便，在肠里还会形成胎便。宝宝的耳朵已经充分发育，可以听到妈妈的声音了，还能区分几种声音。大脑也成熟了，可以自由的做吮大拇指等有意图的行为。现在从头到臀部的长度是15.3cm，体重是240g左右。                                   \b\n\n·妈妈·\n     以后的2~3个月之间体重会增加很多，最近每周会增500g，以后1个月内会增2kg左右。但是每周的增加量会不一致，可能有时一周会增1Kg左右，但下周几乎不增。现在也是乳房的快速变化的时期，最近比怀孕前的尺寸大两个罩杯。乳头周围的乳晕有色素沉淀产生的斑点，而且这个斑点会变大，可能会占整个胸的一半面积，而且能看到胸部皮肤上正脉血管突出。脸部也有色素沉淀，我们叫它“怀孕面具”。此外肚脐、膝盖内部、肛门与阴道之间、腋下部位也的颜色会变沉变深。                                \b",@"·宝宝·\n     宝宝的脖子、胸与胯等部位形成的褐色脂肪会发热，维持宝宝的体温，之后逐渐消失。依靠胎脂保护的皮肤渐渐变厚、变强韧，会细分为表皮、真皮、皮下组织等多层。眉毛、头发、手指甲等也在精致起来。会做出妈妈能感觉到的胎动。现在从头到臀部的长度是16.4cm，体重是300g左右。                                   \b\n\n·妈妈·\n     我们已经达到怀孕中期了！一直在长大的子宫已经到肚脐的部分了，因为变大的子宫，身体的重心发生变化，平时站着或走路时会产生腰痛或下腹痛等症状。腰痛是几乎一半以上的妈妈经历的最常见的症状。最近如果突然动的话，腹股沟会有刀刺般的感觉，这是支撑子宫的圆形韧带变宽导致的症状，对孩子无害，所以不必担心。另一方面，可以看到肚脐和耻骨之间的白色线条会在怀孕期间颜色变深。现在大部分产母终于可以感受到胎动了。                                                \b",@"·宝宝·\n     腿长的比较长了，已经是和出生时差不多的比例。骨骼与肌肉也发育到了一定程度，胎动也更厉害了，外型上和出生时的差不多，只是较小一些。现在用一般听诊器就可以听到心跳的声音了。最近宝宝在吞羊水，而且可以消化和吸收其中的部分糖分了，虽然这只是宝宝需要的营养中的极少部分（大部分可以通过胎盘获得），但是它已经拥有了自己的消化能力，这很厉害。宝宝骨髓里开始生产血液细胞，出现了和妈妈不一样的睡眠规律，睡觉的时候眼睛也会快速转动，就像在做梦一样。宝宝的全身都覆满了绒毛。现在宝宝的长度是26.7cm，体重是360g左右。                                   \b\n\n·妈妈·\n     怀孕中雌激素与黄体酮荷尔蒙的分泌量比怀孕前多了10倍。怀孕的前五个月，黄体酮比雌激素多，但最近两种荷尔蒙的量基本相当，以后逐渐会逆转，雌激素的分泌量会更多。现在的血压比怀孕前稍微低一些，但是会慢慢恢复到原来的水平。整体的新陈代谢变活跃了，头发和手指甲比平时长得快了。牙龈很敏感，有时会肿、出血。能感受到宝宝踢腿的力量越来越强了。                                \b",@"·宝宝·\n     在宝宝的舌头上形成了能够识别味道的味蕾。神经系统发达了，能感觉到用手触摸的感觉了。女孩的子宫和卵巢已经找到了位置，会开始形成阴道；男孩的睾丸往阴囊方向下去，开始渐渐成熟。令人惊奇的是，女孩的卵巢内已经在产生卵子，为自己未来的孩子做准备。宝宝的身体现在看上去比较瘦弱，但是正在慢慢长肉，全身都覆满了绒毛。眉毛和头发现在还是白色，但会渐渐变深。大脑正在急剧成长，这会一直进行到5岁为止。听觉也会发育得很成熟，以至于外部的声音会把宝宝吓醒。现在从头顶端到脚跟的长度是27.8cm，体重是430g左右。                                   \b\n\n·妈妈·\n     渐渐地，妈妈的心跳会加快，但这是正常现象所以不用担心。同时因为血液量在急剧增长，如果心脏支撑不了的话，血液循环会变差，引发头晕现象。而且如果一天没有摄取30mg以上的铁的话很容易得缺铁性贫血。末梢血管会拉长，静脉会呈蜘蛛网状，扩散到脸、脖子、胸部等地方，分娩后会消失，不必担心。最近胸部越来越大，已经完全做好生产母乳的准备了。速度快的妈妈在乳头上会看到黄色的水滴，我们叫它初乳。                                \b",@"·宝宝·\n     身体的比例已经和出生时的比例差不多了，只是还比较瘦弱而且皱巴巴的。随着脂肪的堆积宝宝会变肥嘟嘟的样子。最近肺开始快速发育，生成肺表面活性剂，使肺里的气囊能够舒缓地扩张。肺周围的血管也在旺盛的成长，肺在慢慢的扩张和收缩，把羊水当做空气做呼吸训练。胎动在活跃地进行中，耳朵也可以听到声音，但暂时还不能区分出细小的声音。宝宝的成长在加速， 4周后体重会是今天体重的两倍左右。如果宝宝现在生下来的话，大脑内的血管还没有完全发育完，可能会导致脑出血，眼睛的视网膜也还没发育好，视力的发育也会出现问题，但是如果能够在新生儿重症患者病房得到有效治疗的话，宝宝也能正常生存下去。现在从头顶端到脚跟的长度是28.9cm，体重是500g左右。                                   \b\n\n·妈妈·\n     宝宝的生长很快，子宫随之变大，会导致下腹疼痛。有一些妈妈的子宫已经为了分娩开始做子宫运动了，我们称之为假性宫缩了；如果还带着疼痛的话，我们叫它假阵痛。假阵痛的间隔和强度不规律，痛感不是从下腹或腰背扩散，而是在特定的部位集中发生，子宫的颈部关闭，所以和真阵痛有所区别。妈妈的身体已经开始为分娩而做准备了。支撑子宫的几个韧带一直在拉长，骨盆关节也松弛了，脊椎也为了平衡体重量而往后仰，所以腰痛会很厉害。                                \b",@"·宝宝·\n     内耳发育了，有了身体的平衡感。现在如果出生的话可以存活的概率是50%。透明的皮肤还有皱纹，脂肪堆积的同时，骨骼与肌肉也精致起来了。宝宝的舌头长出了能充分识别味道的味蕾。现在从头顶端到脚跟的长度是30cm，体重是600g左右。                                   \b\n\n·妈妈·\n     胎动很强烈，但也只有妈妈感觉得到，爸爸想要把手放在妈妈的肚子上感受的话，还需要等一段时间。阴道的组织也变得更厚了，因此分泌物会增多。如果分泌物的颜色浅、没有异味的话不用担心；但如果颜色呈绿色或黄色、有刺鼻的异味，同时感到痒或疼痛的话可能是受到了感染，需要请医生来诊断。最近妈妈的体重以每周500~600g左右的速度增加。                                                \b",@"·宝宝·\n     肺在生长的过程中成熟了。皮肤底下的毛细管开始形成，使透明的皮肤渐渐出现血色。会支撑宝宝的身体一生的脊髓也初具形态。妈妈在吃完饭或睡前，宝宝有规律的动作会变多。宝宝像蕨菜一样的手指头上长的手指甲非常的可爱，已经可以把手指头都弯起来握拳了，但手还没拥有能做正规运动的复杂的神经网，长出神经网还需要一段时间。最近宝宝在认真探索子宫的周围环境。用手摸摸自己别的部位，把脐带的位置也掌握了。现在从头顶端到脚跟的长度是34.6cm，体重是660g左右。                                   \b\n\n·妈妈·\n     怀孕25周前后，出现了妊娠纹，颜色在逐渐变深。妊娠纹指的是过了肚脐垂直方向呈现出的黑色的线。大部分的妈妈都会出现妊娠纹，但也有10~20%的妈妈没有出现，妊娠纹是宝宝和子宫变大的过程中，妈妈腹部的皮肤疲劳，使肌肉拉长，在裂缝部分米拉费色素沉着的现象。这种现象在腹部以外的胸部、腋下、大腿部位也会发生。现在血压会逐渐升高，跟怀孕前差不多了，偶尔心脏会不规矩的嘭嘭跳，应该只是一时的反应，会逐渐消失的。但是出现胸痛和气喘现象的话就需要与医生商量一下了。                                                \b",@"·宝宝·\n     这是宝宝的肺正式发育的时期。肺泡形成了，使得空气和血液能够进行交换；肺表面活性剂也出现，使肺的运动更加舒展。宝宝有了眉毛和眼睫毛，头发也变茂盛，手指和脚趾的指纹也形成了。最近宝宝眼睛上长出了视网膜，大约两周后就可以睁开眼睛。现在身体还是红色的，皱纹也很多，但随着脂肪的积累，等到出生时就会是肥嘟嘟的样子。现在从头顶端到脚跟的长度是35.6cm，体重是760g左右。                                   \b\n\n·妈妈·\n     怀孕时手指甲和脚趾甲会长得很快，是血液循环和新陈代谢活跃的原因，羊水每周也增加50cc。受黄体酮荷尔蒙的影响肺的容积也变大了，因此能够吸入更多的氧气并有效的排出二氧化碳。另一方面，黄体酮会使消化器官的运动迟缓，因此会引起消化不良、反胃、便秘等症状，而且会更加恶化。怀孕的三分之二时间已经过去了。                                                \b",@"·宝宝·\n     宝宝在用成熟的肺做呼吸练习，以羊水代替空气吸进吐出。而且大脑会急速发育。宝宝还很瘦很红，但身体的形态与出生时的样子差的不多。肺、肝、免疫体系统虽然还没有完全成熟，但如果现在出生的话，可以存活的概率是85%以上。宝宝已经能认出妈妈和爸爸的声音，而且能记住了，但因为耳朵被厚重的胎脂覆盖着，而且羊水不能很好的传播声音，所以并不能很清楚的听到外面的声音。现在从头顶端到脚跟的长度是36.6cm，体重是875g左右。                                   \b\n\n·妈妈·\n     如果把怀孕期等分成三个阶段，现在已经进入到最后的三分之一了！胸部更大了，乳头周围会冒出一些小包，它们会分泌油分，使周围的皮肤在喂奶时变得润滑，防止宝宝吮奶时受伤。现在子宫在肚脐和胸部中间的位置。临盆时子宫会占据从骨盆到肋骨下的整个肚子。怀孕中胎动最活跃的时期是27~32周之间，此时宝宝的踢腿和真性宫缩很难分辨。假阵痛和真阵痛也需要区分：假阵痛没有规律、节奏散乱，而真阵痛时肚子、腰下部会出现有规律的收缩现象。                                \b",@"·宝宝·\n     宝宝终于睁开眼睛了！之前宝宝的眼睛一直是闭着的。如果能亲眼看到的话可以观察到宝宝眼睛的颜色，但实际上宝宝出生后6个月间颜色会逐渐变化。最近宝宝的大脑在急速成长。宝宝会进行比较规律的睡眠，一次睡眠时间是大约30分钟左右。到了这周末，从头顶端到脚跟的长度是37.5cm，体重是1kg左右。宝宝已经成熟到即使现在就出生，也可以自己呼吸了。                   \b\n\n·妈妈·\n     最近子宫在变大，周围的韧带拉长了，骨盆、腰、腹股沟和大腿部位会感到不适。如果安静的休息一下可以缓解疼痛，但是稍微动一下又会非常严重。另一方面，妈妈由于体内的小便停滞而容易患上膀胱炎，所以如果在排尿时有疼痛感、小便颜色奇怪或者有异味的话需要和医生商量。阴道的分泌物会增加，但如果颜色浅、没有异味的话是受了怀孕荷尔蒙影响的缘故，不用太担心。如果是炎症，分泌物会呈黄、红或者绿色，有异味，需要及时治疗。最近每周会增500g体重，一个月内会增2kg左右，这些重量大部分不是脂肪，而是宝宝、胎盘和羊水等怀孕时必须增加的重量，所以不用担心。现在妈妈很容易得痱子等皮肤炎，而且手脚容易肿。胎动厉害时，妈妈睡觉时会惊醒。                                                \b",@"·宝宝·\n     宝宝在快速地长大，体重也在增长。同时，皮下脂肪也堆积了很多，肉变得肥嘟嘟而且很柔软。胎动应该会比以前更加旺盛。偶尔宝宝出拳过于强烈，以至于妈妈要暂时屏住呼吸。最近宝宝的大脑已经比较发达，可以自己呼吸和调节体温了，而且会对光、声音、气味、味道、触觉敏感地做出反应。现在从头顶端到脚跟的长度是38.6cm，体重是1150g左右。                                   \b\n\n·妈妈·\n     最近因荷尔蒙的影响，心情会变得很忧郁、易怒等，情绪起伏很大。血压会一时变高，但不用过于担心。随着子宫变大，横膈膜随之抬高（横膈膜是支撑肺的宽大肌肉），到临盆的时候会比平时高3~4cm，因此会有气喘、呼吸困难的感觉。但由于黄体酮的作用，每次呼吸时会更充分地吸入空气，对孩子不会有什么影响。变大了的子宫压迫膀胱，会经常想小便。周围韧带会拉长，骨盆、腰，腹股沟与大腿部分会感到不舒服。因为体重的增长，妈妈会容易得痱子等皮肤炎，而且手与脚很容易肿。                                \b",@"·宝宝·\n     宝宝的成长速度快得让人惊奇，从现在到怀孕37周时，宝宝的体重大约以每周200g以上的速度持续增长。最近宝宝在认真地运动自己的横膈膜来练习呼吸，在这过程中偶尔还会打嗝。覆盖宝宝整个皮肤的绒毛开始逐渐消失。另一方面，宝宝骨骼里的骨髓在自己形成红血球，而且宝宝的大脑会出现复杂皱纹，开始慢慢精致起来。在宝宝神经细胞的脂肪里出现了髓磷脂，帮助神经细胞快速传达。眼皮已经分离，可以自由的眨眼了。现在从头顶端到脚跟的长度是40cm，体重是1320g左右。                                   \b\n\n·妈妈·\n     为了给宝宝提供充分的氧气与营养，血液量增加了，心跳也比平时快20%。因此末梢血管变长，特别是腿或脚踝部分的皮肤上能看到青色血管，五位妈妈中有一位会出现下肢静脉曲张。不仅下肢，在脸、脖子、胸、胳膊等地方也会出现蜘蛛网状的蜘蛛静脉。同样的原理，痔疮也会恶化，因为肛门周围的血液量也在增加，血液返回的路上有庞大的子宫堵着，因此容易造成淤血。这种变化在分娩后几周会自然变好，所以不用太担心。最近宝宝和子宫都变得很大，所以平躺时会有呼吸困难、消化不良的感觉。偶尔会出现白色的分泌物，但是不用担心。                                                \b",@"·宝宝·\n     现在从头顶端到脚跟的长度是41cm，体重是1.5kg左右。从现在到出生，个子会再长高一点，体重会长1kg以上。孩子的生殖器在也在成熟，男孩的话，位于肾脏周围的精子在向腹股沟的位置移动；女孩的话阴蒂会很明显，但阴唇还不是很分明。宝宝的大脑已经充分发育好，即使现在出生，看、听、记忆都没什问题了。肺还没有完全成熟，如果现在分娩的话，需要在新生儿重患者室呆6周以上，而且要借助人工呼吸器的帮助。                                   \b\n\n·妈妈·\n     乳房膨胀了很多，在怀孕时增长的体重里，乳房占据其中的500g~1.5kg左右，而且大部分不是脂肪，而是生产母乳的分泌腺与增加的血液量。受到从怀孕初期就开始分泌的催乳素影响，快的话在这个月内就会开始分泌初乳。最近胎动会在晚上更加强烈。体重会增加，肚子会胀，关节也变松弛了，能感受到整个身体的动作都变得迟钝了。                                \b",@"·宝宝·\n     在过去的几个月里，覆盖着宝宝整个皮肤的绒毛开始慢慢脱落，出生的时候几乎全消失，只残留在肩膀上或背上一部分地方。现在宝宝学会了瞳孔反射，光线暗的时候瞳孔会变大，亮的时候会缩小。宝宝的踢腿感觉和以前有些不一样，因为现在宝宝很大，占满整个子宫，所以踢腿的力度没有以前强，但频率一样。妈妈把身体朝左侧躺着，数一下在2个小时之间有几次胎动，如果是10回以上就是正常的。脚趾甲会越来越精致，现在的体重是1.7kg，从头部到脚后跟的距离是42cm左右。如果现在出生，大部分的宝宝可以生存并正常生活。                                   \b\n\n·妈妈·\n     因为宝宝和子宫在一直变大，压着周围的脏器，所以会很难深呼吸，气喘、反胃、便秘会更加严重，痔疮和下肢静脉曲张也会恶化。因为临近分娩，子宫周围的肌肉会做松紧练习，这时会有些不适，这种现象叫做假阵痛（假性宫缩）。真阵痛是有规律的，而假阵痛不规律、零散。腰和背部会疼，下腹也会变硬。越接近分娩日，假阵痛会来的越频繁，如果子宫的收缩时间超过了5小时，或者太疼的话，那就需要告知医生了。                                \b",@"·宝宝·\n     在不知不觉之间，从头部到脚后跟的距离已经长到44cm，体重是1.9kg。最近宝宝的体重以每周200~300g的速度增长，之后的一个月里生长的速度非常惊人，但到了临盆的前一个月时速度又会慢下来。现在宝宝脑细胞的数量比要出生的时候要多2~3倍，以后会逐渐减少。眼睛的瞳孔已经非常成熟，根据周围的亮度可以自由收缩和松弛而调节光量。肺已经成熟到现在出生也没有一点问题。                                   \b\n\n·妈妈·\n     子宫变大了，制约了横膈膜的运动，使肺的扩张不充分，妈妈会感到无法尽情呼吸。但这个月末子宫会往骨盆向下滑，呼吸会顺畅一点。变大的子宫压迫着膀胱，所以在大笑、打喷嚏或擤鼻子时，会有点尿溢出来。因为子宫和肌肉的松弛，导致体内小便的流动也减弱，此时很容易得膀胱炎。最近羊水的量会达到最高点，之后逐渐降低。越接近临盆，身体会越疲劳，腿和肚子的静脉曲张会变得更严重，体重也会增加，因为现在的血液量很多，所以腿很容易肿胀、疼痛。变大的子宫压着肠，很容易得便秘，再加上胎动，会很难入睡。                                \b",@"·宝宝·\n     以一周1cm左右的速度在茁壮成长。怀孕后期对宝宝的头脑发育是非常重要的，在一周的时间内头部长了1cm。保护宝宝皮肤的白黏黏的胎脂会变厚，宝宝出生后在宝宝的耳朵周围、胳膊等地会找到胎脂的痕迹。而在过去的几个月里一直覆盖着宝宝皮肤的绒毛几乎完全消失了。可爱的手指甲已经完全长到手指头的最末端了。现在从头部到脚后跟的距离是45cm，体重是2150g左右。                                   \b\n\n·妈妈·\n     结束了怀孕的第8个月，即使现在生孩子，妈妈和孩子也不会有太大问题。乳房内部为了产出母乳，已经膨胀到最大，也可以看到乳头的周围冒出可以保湿皮肤的皮脂腺。子宫在渐渐地往骨盆方向下滑，会感到上腹稍微轻松了一点，呼吸顺畅了，如果之前觉得胃酸的话，现在也会感觉好了一些。但下腹越来越沉，小便也很频繁，便秘也会加重。这种变化在第一次经历怀孕的妈妈中更为常见。                                \b",@"·宝宝·\n     现在从头部到脚后跟的距离是46cm，体重超过了2.3kg。最近宝宝的肩膀周围在长肉，一周体重最多会增220g，是怀孕中宝宝体重增幅最大的时期。宝宝变大，子宫内没有什么空间，所以会感觉到胎动减少了，但能经常感觉到宝宝在里面转动，左右摇晃等。男孩的话，现在睾丸一直在往下方移动，与躯干留出一点距离，防止太多体温传递过来，这是为了形成更好的精子。                                   \b\n\n·妈妈·\n     最近在大笑、打喷嚏或擤鼻子的时候可能会溢尿，这是因为变大的子宫压迫膀胱而导致的现象。面临临盆，子宫会渐渐地往骨盆下方移动，所以这种症状会越来越严重。当然在分娩后会逐渐变好。而且，因为变大的子宫往上推着横膈膜，使肋骨分开，所以胸围会长6cm左右。能感觉到为了分娩，身体在逐渐变柔韧，柔软。妈妈需要坚持运动，但如果过分运动的话，变松了的身体各个部位的关节会因为负担过多而损伤，所以一定要注意。变大的子宫压迫坐骨神经，臀部和大腿附近会感到刺痛、酸痛，可能会产生坐骨神经痛。                                                \b",@"·宝宝·\n     如果能往里看，会发现现在宝宝已经长成出生时的模样了。肥嘟嘟的，面部也变圆乎乎的了。为了吮吸母乳，面部肌肉也发育完了。宝宝的体脂肪积累也达到了8%左右，直到出生时会再增15%来维持体温。到这周末，从头部到脚后跟的距离将是47cm，体重超过2.6kg。                                   \b\n\n·妈妈·\n     现在有些妈妈的子宫颈部开始变大，阴道部位会感到尖锐的刺痛，这与阵痛不一样，对宝宝不会有害。子宫颈部变大的开始时期因人而异，有些第一次怀孕的妈妈在真阵痛的数周前就开始，而经历过怀孕的妈妈，会在阵痛前几个小时打开。接近分娩时期，妈妈的体重会减1kg左右，但不用担心。为了做生孩子的准备，血液量在增加，新陈代谢也活跃了，妈妈会出现一会儿有热情，一会儿又突然疲劳的症状。                                \b",@"·宝宝·\n     到这周末的时候就可以叫做临盆了。虽然还不算完全长大，但现在的成长速度会稍微平稳下来，一天会长15g左右的肉。脂肪积累的过程中，宝宝会变得又圆又胖。最近宝宝在练习把身体转到有阳光的位置，这叫做正向反射。现在宝宝从头部到脚后跟的距离是48cm，体重超过了2.9kg左右。                                   \b\n\n·妈妈·\n     最近可以感到血液通过脐带流动时发出的声音，我们叫它脐带杂音。肚子里大约装有680g的胎盘和900g的羊水，子宫比怀孕前重了20倍。子宫位于骨盆周围到胸窝骨底部的空间。大部分妈妈还有些气喘，但一部分妈妈特别是第一次怀孕的妈妈，在生孩子前几周子宫已经往骨盆滑下去，横膈膜会轻松点，呼吸也舒畅，可以做深呼吸了。而已经历过怀孕的妈妈，子宫下滑的时期会晚一点，几乎与分娩的时候一致。                                                \b",@"·宝宝·\n     如果说从开始到现在是宝宝的各个器官长大成型的过程，从现在开始将是这些器官的技能再成熟和发达的过程。大脑和神经构造在日新月异的发展，呼吸和消化功能都变得老练起来。现在宝宝的头围、肩宽和臀宽都差不多了，女孩的话，大阴唇和小阴唇正在形成。现在从头部到脚后跟的距离是50cm，体重超过了3kg。还残留在宝宝肠里的胎便是胆汁等废物，在出生后不久就会排出来。                                   \b\n\n·妈妈·\n     受雌激素与黄体酮等荷尔蒙的影响，胸膨胀到最大程度。即将面临分娩，妈妈的乳头会分泌黄色的初乳。子宫往下滑，再一次压迫膀胱，导致小便频繁，打喷嚏或大笑的时候小便会溢出来。在睡觉前要提前小便，清空膀胱，这样对睡眠有所帮助。最近受到从胎盘分泌的松弛激素影响，三个支撑骨盆骨的韧带会松弛，分娩时骨盆会舒缓打开。但是松弛激素会使骨盆以外的韧带也放松起来，让妈妈感到四肢无力。                                                \b",@"·宝宝·\n     为了出生后维持体温，宝宝每天在积累14~15g的脂肪。使呼吸流畅的肺表面活性剂也更旺盛地分泌，为即将开始的呼吸做准备。最近胎盘会形成很多抗体供给宝宝，这是在出生后的六个月里保护宝宝不被感染的重要物质。宝宝出生后，一部分抗体会通过妈妈的母乳供给。最近宝宝的皮肤变得越来越厚实强韧。到这个周末，覆盖着宝宝皮肤的绒毛几乎完全消失了，但额头，颈部和肩膀上还残留着一点绒毛。也有出生了还留着痕迹的情况。手指甲可能会超过手指末端。现在从头部到脚后跟的距离是平均50.7cm，体重超大约是3.3kg，但越到怀孕后期，不同宝宝的体重差异会更大。                                   \b\n\n·妈妈·\n     预产期即将来临，胎动变得活跃了，子宫颈部也开始扩大。有的妈妈在分娩几周前扩大，而有的妈妈在分娩几小时前才扩大。随着子宫颈部的扩大，在阴道部位会有刀刺的感觉。在怀孕时堵着子宫颈部而防止细菌侵入的黏液盖会脱落。这可能也在分娩两周前，或者是分娩前夕发生。会看到少量带血的黏液分泌物，但不必担心。面临分娩，妈妈精神上会感到压力，晚上可能会失眠。                                                \b",@"·宝宝·\n     这周将碰上预产期，但是只有不到5%的孩子在预产期准时出生，偏差很大。为了出生，宝宝的头盖骨会分成5块，柔软的连接在一起，身体里的软骨也还没完全骨化，仍是柔软的状态。肝也变大了，胸部和腹部会凸出来，体内的脂肪积累到15%了。从头部到臀部的距离是平均36cm左右，但如果把腿伸直的话会超过50cm。体重平均是3.5kg。现在已经做好与妈妈见面的一切准备了，在妈妈进行阵痛的期间宝宝体内会出现几种荷尔蒙，帮助宝宝在出生后维持血压与血糖。                                   \b\n\n·妈妈·\n     体重跟两周前差不多，甚至会有些减少，是因为怀孕后期，宝宝的体重增加速度变慢。但相比怀孕前体重增加了10~15kg左右，其中宝宝的体重是3~4kg，胎盘是600~700g，羊水900g，膨胀的乳房是500g~1.5kg，子宫1kg，脂肪与肌肉的增加量是2.5~3.5kg，血液量1.3~1.8kg，增加了的体液量是900g~1.3kg左右。现在换什么姿势都会很不舒服，很累。胎动与子宫收缩也很厉害。现在已经做好了当妈妈的一切准备。                                                \b"};





@implementation BabyPreTableViewCell
@synthesize  showInfo = _showInfo;
@synthesize maskAlpha = _maskAlpha;
@synthesize contentY = _contentY;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initialization];
    }
    return self;
}

- (void)initialization
{
    _showInfo = NO;
    content = [[UIView alloc] initWithFrame:CGRectMake(8, 32, kPicWidth, kPicHeight)];
    [self.contentView addSubview:content];
    
    imgView = [[AFImageView alloc] initWithFrame:CGRectMake(0, 0, kPicWidth, kPicHeight)];
    [content addSubview:imgView];
    
    questionView = [[UIView alloc] initWithFrame:CGRectMake(180, 16, 64, 64)];
    [questionView setBackgroundColor:[UIColor clearColor]];
    questionView.layer.cornerRadius = 32.0f;
    questionView.layer.masksToBounds = YES;
    [content addSubview:questionView];
    
    UIView *bg_question = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
    [bg_question setBackgroundColor:RGBColor(239, 128, 123)];
    [bg_question setAlpha:0.5];
    [questionView addSubview:bg_question];
    
    UIImageView *question = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
    [question setImage:[UIImage imageNamed:@"btn_preinfo_baby.png"] ];
    [questionView addSubview:question];

    
    infoView = [[UIView alloc] initWithFrame:CGRectMake(0, -kPicHeight, kPicWidth, kPicHeight)];
    [content addSubview:infoView];
    
    content.layer.masksToBounds = YES;
    
    UIView *bgInfo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kPicWidth, kPicHeight)];
    [bgInfo setBackgroundColor:[UIColor blackColor]];
    [bgInfo setAlpha:0.5];
    [infoView addSubview:bgInfo];

    
    weekTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, kPicWidth, 28)];
    [weekTitle setBackgroundColor:[UIColor clearColor]];
    [weekTitle setTextColor:[UIColor whiteColor]];
    [weekTitle setTextAlignment:NSTextAlignmentCenter];
    [weekTitle setFont:PMFont(28)];
    [infoView addSubview:weekTitle];
    
    infoTextView = [[UITextView alloc] initWithFrame:CGRectMake(12,40, kPicWidth - 24, kPicHeight-40-8)];
    [infoTextView setBackgroundColor:[UIColor clearColor]];
    [infoTextView setTextColor:[UIColor whiteColor]];
    [infoTextView setTextAlignment:NSTextAlignmentCenter];
    [infoTextView setFont:PMFont2];
    [infoView addSubview:infoTextView];
    [infoTextView setEditable:NO];
    mask  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kPicWidth, kPicHeight)];
    [mask setBackgroundColor:[UIColor whiteColor]];
    [content addSubview:mask];

}






- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)buildCellWithIndex:(NSInteger)index andSelectedIndex:(NSInteger)selectedIndex andColumnImgBMode:(BOOL)bModel
{
    NSString *imageName = bModel ? [NSString stringWithFormat:@"%@%@", columnB,clonumBimages[index -1]] : [NSString stringWithFormat:@"%@%@",columnA,clonumAimages[index-1]];
    [weekTitle setText:[NSString stringWithFormat:@"%dweek",index]];
    [infoTextView setText:info[index-1]];
    
    [imgView getImage:imageName defaultImage:@"pic_default_baby.png"];

    if (selectedIndex == index) {
        [mask setAlpha:0];
        SetViewLeftUp(content, 8, 0);
    }else{
        [mask setAlpha:0.5];
        SetViewLeftUp(content, 8, 32);
    }

}

- (void)setShowInfo:(BOOL)showInfo
{
    if (_showInfo != showInfo) {
        _showInfo = showInfo;
        if (showInfo) {
            [UIView animateWithDuration:0.5 animations:^{
                SetViewLeftUp(infoView, 0, 0);
                [questionView setAlpha:0];
            } ];
        }else{
            [UIView animateWithDuration:0.5 animations:^{
                SetViewLeftUp(infoView, 0, -kPicHeight);
                [questionView setAlpha:1];
            }];
        }
    }
  
}

- (void)setMaskAlpha:(float)maskAlpha
{
    _maskAlpha = maskAlpha;
    [mask setAlpha:maskAlpha];
}

- (void)setContentY:(float)contentY
{
    _contentY = contentY;
    SetViewLeftUp(content, 8, contentY);
}
@end
