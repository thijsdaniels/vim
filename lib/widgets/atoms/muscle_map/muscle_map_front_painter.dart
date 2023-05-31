import 'package:flutter/material.dart';
import 'package:vim/widgets/atoms/muscle_map/muscle_map_painter.dart';

class MuscleMapFrontPainter extends MuscleMapPainter {
  MuscleMapFrontPainter({
    super.muscles,
  });

  @override
  void paintSilhouette(Canvas canvas, Size size, Paint paint) {
    canvas.drawPath(silhouette(size), paint);
  }

  @override
  void paintCalves(Canvas canvas, Size size, Paint paint) {
    canvas.drawPath(leftTabialisAnterior(size), paint);
    canvas.drawPath(rightTabialisAnterior(size), paint);
    canvas.drawPath(leftGastrocnemius(size), paint);
    canvas.drawPath(rightGastrocnemius(size), paint);
  }

  @override
  void paintQuads(Canvas canvas, Size size, Paint paint) {
    canvas.drawPath(leftRectusFemoralist(size), paint);
    canvas.drawPath(rightRectusFemoralist(size), paint);
    canvas.drawPath(leftVastusLateralis(size), paint);
    canvas.drawPath(rightVastusLateralis(size), paint);
    canvas.drawPath(leftVastusMedialis(size), paint);
    canvas.drawPath(rightVastusMedialis(size), paint);
  }

  @override
  void paintAdductors(Canvas canvas, Size size, Paint paint) {
    canvas.drawPath(leftSartorius(size), paint);
    canvas.drawPath(rightSartorius(size), paint);
  }

  @override
  void paintAbductors(Canvas canvas, Size size, Paint paint) {
    canvas.drawPath(leftGluteusMedius(size), paint);
    canvas.drawPath(rightGluteusMedius(size), paint);
  }

  @override
  void paintLats(Canvas canvas, Size size, Paint paint) {
    canvas.drawPath(path15(size), paint);
    canvas.drawPath(path16(size), paint);
  }

  @override
  void paintObliques(Canvas canvas, Size size, Paint paint) {
    canvas.drawPath(path17(size), paint);
    canvas.drawPath(path18(size), paint);
    canvas.drawPath(path19(size), paint);
    canvas.drawPath(path20(size), paint);
    canvas.drawPath(path21(size), paint);
    canvas.drawPath(path22(size), paint);
  }

  @override
  void paintAbs(Canvas canvas, Size size, Paint paint) {
    canvas.drawPath(path23(size), paint);
    canvas.drawPath(path24(size), paint);
    canvas.drawPath(path25(size), paint);
    canvas.drawPath(path26(size), paint);
    canvas.drawPath(path27(size), paint);
    canvas.drawPath(path28(size), paint);
    canvas.drawPath(path29(size), paint);
    canvas.drawPath(path30(size), paint);
  }

  @override
  void paintForearms(Canvas canvas, Size size, Paint paint) {
    canvas.drawPath(leftBrachioRadialis(size), paint);
    canvas.drawPath(rightBrachioRadialis(size), paint);
    canvas.drawPath(leftExtensorCapriUlnaris(size), paint);
    canvas.drawPath(rightExtensorCapriUlnaris(size), paint);
  }

  @override
  void paintBiceps(Canvas canvas, Size size, Paint paint) {
    canvas.drawPath(leftBiceps(size), paint);
    canvas.drawPath(rightBiceps(size), paint);
  }

  @override
  void paintChest(Canvas canvas, Size size, Paint paint) {
    canvas.drawPath(leftPectoralisMajor(size), paint);
    canvas.drawPath(rightPectoralisMajor(size), paint);
  }

  @override
  void paintShoulders(Canvas canvas, Size size, Paint paint) {
    canvas.drawPath(leftDeltoid(size), paint);
    canvas.drawPath(rightDeltoid(size), paint);
  }

  @override
  void paintTraps(Canvas canvas, Size size, Paint paint) {
    canvas.drawPath(leftTrapezius(size), paint);
    canvas.drawPath(rightTrapezius(size), paint);
  }

  @override
  void paintNeck(Canvas canvas, Size size, Paint paint) {
    canvas.drawPath(sternocleidomastoid(size), paint);
  }

  Path silhouette(Size size) {
    return Path()
      ..moveTo(size.width * 0.4835137, size.height * 0.0007017182)
      ..cubicTo(
          size.width * 0.4579827,
          size.height * 0.003269416,
          size.width * 0.4314661,
          size.height * 0.01071890,
          size.width * 0.4181602,
          size.height * 0.01906186)
      ..cubicTo(
          size.width * 0.4152121,
          size.height * 0.02091134,
          size.width * 0.4106681,
          size.height * 0.02456907,
          size.width * 0.4080635,
          size.height * 0.02719107)
      ..cubicTo(
          size.width * 0.4033709,
          size.height * 0.03191409,
          size.width * 0.4033304,
          size.height * 0.03204399,
          size.width * 0.4036681,
          size.height * 0.04110378)
      ..cubicTo(
          size.width * 0.4039870,
          size.height * 0.04965636,
          size.width * 0.4037605,
          size.height * 0.05052509,
          size.width * 0.4001890,
          size.height * 0.05450584)
      ..cubicTo(
          size.width * 0.3974805,
          size.height * 0.05752509,
          size.width * 0.3961760,
          size.height * 0.06038007,
          size.width * 0.3957071,
          size.height * 0.06432371)
      ..cubicTo(
          size.width * 0.3947605,
          size.height * 0.07227354,
          size.width * 0.3974820,
          size.height * 0.07618625,
          size.width * 0.4081746,
          size.height * 0.08225223)
      ..cubicTo(
          size.width * 0.4186623,
          size.height * 0.08820137,
          size.width * 0.4181126,
          size.height * 0.08770790,
          size.width * 0.4268182,
          size.height * 0.09898900)
      ..cubicTo(
          size.width * 0.4375108,
          size.height * 0.1128433,
          size.width * 0.4389076,
          size.height * 0.1168942,
          size.width * 0.4352857,
          size.height * 0.1235450)
      ..cubicTo(
          size.width * 0.4303954,
          size.height * 0.1325251,
          size.width * 0.4158831,
          size.height * 0.1377869,
          size.width * 0.3665007,
          size.height * 0.1484866)
      ..cubicTo(
          size.width * 0.3557980,
          size.height * 0.1508055,
          size.width * 0.3418470,
          size.height * 0.1537251,
          size.width * 0.3354978,
          size.height * 0.1549753)
      ..cubicTo(
          size.width * 0.2845902,
          size.height * 0.1649959,
          size.width * 0.2731486,
          size.height * 0.1680351,
          size.width * 0.2568052,
          size.height * 0.1758777)
      ..cubicTo(
          size.width * 0.2298167,
          size.height * 0.1888296,
          size.width * 0.2195887,
          size.height * 0.2047588,
          size.width * 0.2211587,
          size.height * 0.2313966)
      ..cubicTo(
          size.width * 0.2215772,
          size.height * 0.2385100,
          size.width * 0.2227345,
          size.height * 0.2466694,
          size.width * 0.2237316,
          size.height * 0.2495292)
      ..lineTo(size.width * 0.2255426, size.height * 0.2547278)
      ..lineTo(size.width * 0.2168730, size.height * 0.2608694)
      ..cubicTo(
          size.width * 0.1988110,
          size.height * 0.2736653,
          size.width * 0.1909957,
          size.height * 0.2841924,
          size.width * 0.1855325,
          size.height * 0.3030900)
      ..cubicTo(
          size.width * 0.1837619,
          size.height * 0.3092151,
          size.width * 0.1829192,
          size.height * 0.3105120,
          size.width * 0.1799509,
          size.height * 0.3116811)
      ..cubicTo(
          size.width * 0.1780289,
          size.height * 0.3124385,
          size.width * 0.1734242,
          size.height * 0.3142405,
          size.width * 0.1697201,
          size.height * 0.3156845)
      ..cubicTo(
          size.width * 0.1610707,
          size.height * 0.3190570,
          size.width * 0.1430736,
          size.height * 0.3288612,
          size.width * 0.1355887,
          size.height * 0.3342770)
      ..cubicTo(
          size.width * 0.1249062,
          size.height * 0.3420069,
          size.width * 0.1213939,
          size.height * 0.3464213,
          size.width * 0.1118023,
          size.height * 0.3641711)
      ..cubicTo(
          size.width * 0.09860462,
          size.height * 0.3885911,
          size.width * 0.09164214,
          size.height * 0.3980639,
          size.width * 0.07530303,
          size.height * 0.4138289)
      ..lineTo(size.width * 0.06132756, size.height * 0.4273141)
      ..lineTo(size.width * 0.05339105, size.height * 0.4291856)
      ..cubicTo(
          size.width * 0.03283838,
          size.height * 0.4340330,
          size.width * 0.006896104,
          size.height * 0.4438014,
          size.width * 0.002284271,
          size.height * 0.4484302)
      ..cubicTo(
          size.width * -0.0004718629,
          size.height * 0.4511973,
          size.width * 0.0004733117,
          size.height * 0.4540000,
          size.width * 0.004512280,
          size.height * 0.4550296)
      ..cubicTo(
          size.width * 0.007464661,
          size.height * 0.4557821,
          size.width * 0.01844300,
          size.height * 0.4538921,
          size.width * 0.02331313,
          size.height * 0.4517931)
      ..cubicTo(
          size.width * 0.02854113,
          size.height * 0.4495395,
          size.width * 0.02865512,
          size.height * 0.4513471,
          size.width * 0.02362193,
          size.height * 0.4567010)
      ..cubicTo(
          size.width * 0.01147619,
          size.height * 0.4696220,
          size.width * 0.009650794,
          size.height * 0.4723038,
          size.width * 0.009512266,
          size.height * 0.4774357)
      ..cubicTo(
          size.width * 0.009405483,
          size.height * 0.4814247,
          size.width * 0.009955267,
          size.height * 0.4827340,
          size.width * 0.01240115,
          size.height * 0.4843086)
      ..cubicTo(
          size.width * 0.02071429,
          size.height * 0.4896605,
          size.width * 0.03535786,
          size.height * 0.4920997,
          size.width * 0.05910534,
          size.height * 0.4920893)
      ..cubicTo(
          size.width * 0.07207937,
          size.height * 0.4920838,
          size.width * 0.07537518,
          size.height * 0.4918440,
          size.width * 0.08152958,
          size.height * 0.4904584)
      ..cubicTo(
          size.width * 0.08549784,
          size.height * 0.4895649,
          size.width * 0.09048918,
          size.height * 0.4879443,
          size.width * 0.09262193,
          size.height * 0.4868564)
      ..cubicTo(
          size.width * 0.1041934,
          size.height * 0.4809553,
          size.width * 0.1190952,
          size.height * 0.4565959,
          size.width * 0.1181775,
          size.height * 0.4450811)
      ..cubicTo(
          size.width * 0.1179408,
          size.height * 0.4421292,
          size.width * 0.1190433,
          size.height * 0.4404502,
          size.width * 0.1252121,
          size.height * 0.4343643)
      ..cubicTo(
          size.width * 0.1405180,
          size.height * 0.4192625,
          size.width * 0.1594199,
          size.height * 0.4078426,
          size.width * 0.1989076,
          size.height * 0.3898412)
      ..cubicTo(
          size.width * 0.2285844,
          size.height * 0.3763120,
          size.width * 0.2399365,
          size.height * 0.3696076,
          size.width * 0.2498571,
          size.height * 0.3597512)
      ..cubicTo(
          size.width * 0.2591154,
          size.height * 0.3505526,
          size.width * 0.2627677,
          size.height * 0.3433959,
          size.width * 0.2639278,
          size.height * 0.3321732)
      ..cubicTo(
          size.width * 0.2649971,
          size.height * 0.3218481,
          size.width * 0.2639509,
          size.height * 0.3229052,
          size.width * 0.2839495,
          size.height * 0.3119416)
      ..cubicTo(
          size.width * 0.2897244,
          size.height * 0.3087759,
          size.width * 0.2969192,
          size.height * 0.3038660,
          size.width * 0.2999380,
          size.height * 0.3010309)
      ..cubicTo(
          size.width * 0.3029567,
          size.height * 0.2981959,
          size.width * 0.3063478,
          size.height * 0.2958763,
          size.width * 0.3074747,
          size.height * 0.2958763)
      ..cubicTo(
          size.width * 0.3086017,
          size.height * 0.2958763,
          size.width * 0.3122395,
          size.height * 0.2981959,
          size.width * 0.3155584,
          size.height * 0.3010309)
      ..cubicTo(
          size.width * 0.3211760,
          size.height * 0.3058309,
          size.width * 0.3390058,
          size.height * 0.3196502,
          size.width * 0.3496364,
          size.height * 0.3274426)
      ..cubicTo(
          size.width * 0.3541659,
          size.height * 0.3307643,
          size.width * 0.3542540,
          size.height * 0.3309808,
          size.width * 0.3540851,
          size.height * 0.3384392)
      ..cubicTo(
          size.width * 0.3538990,
          size.height * 0.3467052,
          size.width * 0.3515180,
          size.height * 0.3525691,
          size.width * 0.3426248,
          size.height * 0.3666667)
      ..cubicTo(
          size.width * 0.3352323,
          size.height * 0.3783869,
          size.width * 0.3344127,
          size.height * 0.3876027,
          size.width * 0.3395700,
          size.height * 0.4010309)
      ..cubicTo(
          size.width * 0.3485354,
          size.height * 0.4243766,
          size.width * 0.3462280,
          size.height * 0.4341732,
          size.width * 0.3224848,
          size.height * 0.4735395)
      ..cubicTo(
          size.width * 0.2925556,
          size.height * 0.5231629,
          size.width * 0.2890895,
          size.height * 0.5337897,
          size.width * 0.2904661,
          size.height * 0.5717155)
      ..cubicTo(
          size.width * 0.2916176,
          size.height * 0.6034818,
          size.width * 0.2944646,
          size.height * 0.6143698,
          size.width * 0.3088687,
          size.height * 0.6421045)
      ..cubicTo(
          size.width * 0.3226999,
          size.height * 0.6687347,
          size.width * 0.3230736,
          size.height * 0.6748680,
          size.width * 0.3123622,
          size.height * 0.6993127)
      ..cubicTo(
          size.width * 0.2938586,
          size.height * 0.7415464,
          size.width * 0.2886176,
          size.height * 0.7629553,
          size.width * 0.2906234,
          size.height * 0.7881443)
      ..cubicTo(
          size.width * 0.2924618,
          size.height * 0.8112234,
          size.width * 0.2976032,
          size.height * 0.8262337,
          size.width * 0.3145815,
          size.height * 0.8580756)
      ..cubicTo(
          size.width * 0.3433131,
          size.height * 0.9119588,
          size.width * 0.3478240,
          size.height * 0.9322268,
          size.width * 0.3340043,
          size.height * 0.9453608)
      ..cubicTo(
          size.width * 0.3240101,
          size.height * 0.9548591,
          size.width * 0.3077691,
          size.height * 0.9624605,
          size.width * 0.2734488,
          size.height * 0.9736838)
      ..cubicTo(
          size.width * 0.2443579,
          size.height * 0.9832027,
          size.width * 0.2326883,
          size.height * 0.9874089,
          size.width * 0.2300144,
          size.height * 0.9893540)
      ..cubicTo(
          size.width * 0.2278427,
          size.height * 0.9909347,
          size.width * 0.2278427,
          size.height * 0.9911959,
          size.width * 0.2300058,
          size.height * 0.9927698)
      ..cubicTo(
          size.width * 0.2344805,
          size.height * 0.9960206,
          size.width * 0.2474242,
          size.height * 0.9980137,
          size.width * 0.2727273,
          size.height * 0.9993402)
      ..cubicTo(
          size.width * 0.3009149,
          size.height * 1.000818,
          size.width * 0.3368110,
          size.height * 0.9988454,
          size.width * 0.3681818,
          size.height * 0.9940893)
      ..cubicTo(
          size.width * 0.3800361,
          size.height * 0.9922887,
          size.width * 0.3885455,
          size.height * 0.9914708,
          size.width * 0.3989899,
          size.height * 0.9911134)
      ..cubicTo(
          size.width * 0.4245310,
          size.height * 0.9902543,
          size.width * 0.4279062,
          size.height * 0.9883918,
          size.width * 0.4277431,
          size.height * 0.9752577)
      ..cubicTo(
          size.width * 0.4276854,
          size.height * 0.9705361,
          size.width * 0.4268456,
          size.height * 0.9629553,
          size.width * 0.4258773,
          size.height * 0.9584192)
      ..cubicTo(
          size.width * 0.4199740,
          size.height * 0.9307560,
          size.width * 0.4151804,
          size.height * 0.8693677,
          size.width * 0.4182006,
          size.height * 0.8601168)
      ..cubicTo(
          size.width * 0.4191457,
          size.height * 0.8572165,
          size.width * 0.4234430,
          size.height * 0.8496976,
          size.width * 0.4277518,
          size.height * 0.8434021)
      ..cubicTo(
          size.width * 0.4442597,
          size.height * 0.8192784,
          size.width * 0.4473377,
          size.height * 0.8116564,
          size.width * 0.4473160,
          size.height * 0.7949485)
      ..cubicTo(
          size.width * 0.4472958,
          size.height * 0.7780619,
          size.width * 0.4439639,
          size.height * 0.7657663,
          size.width * 0.4334141,
          size.height * 0.7436426)
      ..cubicTo(
          size.width * 0.4267359,
          size.height * 0.7296357,
          size.width * 0.4267431,
          size.height * 0.7271134,
          size.width * 0.4334892,
          size.height * 0.7189966)
      ..cubicTo(
          size.width * 0.4506609,
          size.height * 0.6983436,
          size.width * 0.4624242,
          size.height * 0.6614543,
          size.width * 0.4668384,
          size.height * 0.6144330)
      ..cubicTo(
          size.width * 0.4674084,
          size.height * 0.6083691,
          size.width * 0.4707994,
          size.height * 0.5943759,
          size.width * 0.4755022,
          size.height * 0.5786942)
      ..cubicTo(
          size.width * 0.4857128,
          size.height * 0.5446399,
          size.width * 0.4878312,
          size.height * 0.5354426,
          size.width * 0.4889567,
          size.height * 0.5202825)
      ..lineTo(size.width * 0.4898990, size.height * 0.5075753)
      ..lineTo(size.width * 0.5001587, size.height * 0.5075203)
      ..lineTo(size.width * 0.5104185, size.height * 0.5074660)
      ..lineTo(size.width * 0.5114228, size.height * 0.5178227)
      ..cubicTo(
          size.width * 0.5132020,
          size.height * 0.5361890,
          size.width * 0.5167172,
          size.height * 0.5510096,
          size.width * 0.5268384,
          size.height * 0.5828179)
      ..cubicTo(
          size.width * 0.5312698,
          size.height * 0.5967457,
          size.width * 0.5331183,
          size.height * 0.6053162,
          size.width * 0.5346970,
          size.height * 0.6192440)
      ..cubicTo(
          size.width * 0.5388831,
          size.height * 0.6561869,
          size.width * 0.5453319,
          size.height * 0.6813911,
          size.width * 0.5557085,
          size.height * 0.7013746)
      ..cubicTo(
          size.width * 0.5591631,
          size.height * 0.7080275,
          size.width * 0.5681082,
          size.height * 0.7212852,
          size.width * 0.5708716,
          size.height * 0.7238488)
      ..cubicTo(
          size.width * 0.5739986,
          size.height * 0.7267491,
          size.width * 0.5732742,
          size.height * 0.7313265,
          size.width * 0.5678543,
          size.height * 0.7428935)
      ..cubicTo(
          size.width * 0.5583983,
          size.height * 0.7630859,
          size.width * 0.5560851,
          size.height * 0.7701924,
          size.width * 0.5540606,
          size.height * 0.7853127)
      ..cubicTo(
          size.width * 0.5514574,
          size.height * 0.8047491,
          size.width * 0.5552698,
          size.height * 0.8169759,
          size.width * 0.5713131,
          size.height * 0.8406254)
      ..cubicTo(
          size.width * 0.5773304,
          size.height * 0.8494983,
          size.width * 0.5819596,
          size.height * 0.8576632,
          size.width * 0.5828023,
          size.height * 0.8609003)
      ..cubicTo(
          size.width * 0.5853853,
          size.height * 0.8708179,
          size.width * 0.5822179,
          size.height * 0.9149278,
          size.width * 0.5763420,
          size.height * 0.9508591)
      ..cubicTo(
          size.width * 0.5743016,
          size.height * 0.9633333,
          size.width * 0.5728485,
          size.height * 0.9760687,
          size.width * 0.5731126,
          size.height * 0.9791615)
      ..cubicTo(
          size.width * 0.5738932,
          size.height * 0.9882887,
          size.width * 0.5789221,
          size.height * 0.9903436,
          size.width * 0.6024531,
          size.height * 0.9911134)
      ..cubicTo(
          size.width * 0.6125700,
          size.height * 0.9914502,
          size.width * 0.6210736,
          size.height * 0.9922337,
          size.width * 0.6309048,
          size.height * 0.9937595)
      ..cubicTo(
          size.width * 0.6511717,
          size.height * 0.9968935,
          size.width * 0.6676825,
          size.height * 0.9984811,
          size.width * 0.6893189,
          size.height * 0.9993883)
      ..cubicTo(
          size.width * 0.7204026,
          size.height * 1.000680,
          size.width * 0.7533146,
          size.height * 0.9986323,
          size.width * 0.7673160,
          size.height * 0.9945223)
      ..cubicTo(
          size.width * 0.7709004,
          size.height * 0.9934708,
          size.width * 0.7720058,
          size.height * 0.9926667,
          size.width * 0.7720058,
          size.height * 0.9911134)
      ..cubicTo(
          size.width * 0.7720058,
          size.height * 0.9893746,
          size.width * 0.7702554,
          size.height * 0.9884330,
          size.width * 0.7601010,
          size.height * 0.9846873)
      ..cubicTo(
          size.width * 0.7535541,
          size.height * 0.9822680,
          size.width * 0.7394300,
          size.height * 0.9774845,
          size.width * 0.7287157,
          size.height * 0.9740550)
      ..cubicTo(
          size.width * 0.7047908,
          size.height * 0.9663918,
          size.width * 0.6915498,
          size.height * 0.9611478,
          size.width * 0.6811342,
          size.height * 0.9552165)
      ..cubicTo(
          size.width * 0.6625801,
          size.height * 0.9446392,
          size.width * 0.6586465,
          size.height * 0.9387904,
          size.width * 0.6599509,
          size.height * 0.9237113)
      ..cubicTo(
          size.width * 0.6612453,
          size.height * 0.9087285,
          size.width * 0.6674459,
          size.height * 0.8936701,
          size.width * 0.6889076,
          size.height * 0.8533883)
      ..cubicTo(
          size.width * 0.7063377,
          size.height * 0.8206735,
          size.width * 0.7107893,
          size.height * 0.8033883,
          size.width * 0.7095310,
          size.height * 0.7733127)
      ..cubicTo(
          size.width * 0.7085180,
          size.height * 0.7490928,
          size.width * 0.7049856,
          size.height * 0.7359588,
          size.width * 0.6911919,
          size.height * 0.7051546)
      ..cubicTo(
          size.width * 0.6775541,
          size.height * 0.6746983,
          size.width * 0.6775988,
          size.height * 0.6709746,
          size.width * 0.6919336,
          size.height * 0.6426117)
      ..cubicTo(
          size.width * 0.7045224,
          size.height * 0.6177058,
          size.width * 0.7072251,
          size.height * 0.6093560,
          size.width * 0.7100808,
          size.height * 0.5865656)
      ..cubicTo(
          size.width * 0.7121328,
          size.height * 0.5701863,
          size.width * 0.7110173,
          size.height * 0.5439581,
          size.width * 0.7077864,
          size.height * 0.5326460)
      ..cubicTo(
          size.width * 0.7029596,
          size.height * 0.5157416,
          size.width * 0.6960418,
          size.height * 0.5018330,
          size.width * 0.6782193,
          size.height * 0.4731959)
      ..cubicTo(
          size.width * 0.6606811,
          size.height * 0.4450158,
          size.width * 0.6574141,
          size.height * 0.4368625,
          size.width * 0.6574242,
          size.height * 0.4213058)
      ..cubicTo(
          size.width * 0.6574315,
          size.height * 0.4122694,
          size.width * 0.6580909,
          size.height * 0.4084296,
          size.width * 0.6606710,
          size.height * 0.4024055)
      ..cubicTo(
          size.width * 0.6672208,
          size.height * 0.3871148,
          size.width * 0.6663391,
          size.height * 0.3789368,
          size.width * 0.6564589,
          size.height * 0.3633567)
      ..cubicTo(
          size.width * 0.6489812,
          size.height * 0.3515649,
          size.width * 0.6460794,
          size.height * 0.3434419,
          size.width * 0.6466941,
          size.height * 0.3360261)
      ..lineTo(size.width * 0.6471861, size.height * 0.3300880)
      ..lineTo(size.width * 0.6574300, size.height * 0.3229478)
      ..cubicTo(
          size.width * 0.6685267,
          size.height * 0.3152131,
          size.width * 0.6800202,
          size.height * 0.3061175,
          size.width * 0.6869004,
          size.height * 0.2996268)
      ..cubicTo(
          size.width * 0.6893766,
          size.height * 0.2972900,
          size.width * 0.6921948,
          size.height * 0.2955326,
          size.width * 0.6934646,
          size.height * 0.2955326)
      ..cubicTo(
          size.width * 0.6947345,
          size.height * 0.2955326,
          size.width * 0.6969769,
          size.height * 0.2969326,
          size.width * 0.6986912,
          size.height * 0.2987973)
      ..cubicTo(
          size.width * 0.7031025,
          size.height * 0.3035938,
          size.width * 0.7102006,
          size.height * 0.3084584,
          size.width * 0.7216580,
          size.height * 0.3145368)
      ..cubicTo(
          size.width * 0.7272496,
          size.height * 0.3175038,
          size.width * 0.7326724,
          size.height * 0.3207045,
          size.width * 0.7337085,
          size.height * 0.3216495)
      ..cubicTo(
          size.width * 0.7347446,
          size.height * 0.3225945,
          size.width * 0.7362958,
          size.height * 0.3276976,
          size.width * 0.7371558,
          size.height * 0.3329897)
      ..cubicTo(
          size.width * 0.7390202,
          size.height * 0.3444460,
          size.width * 0.7426205,
          size.height * 0.3514392,
          size.width * 0.7509567,
          size.height * 0.3597938)
      ..cubicTo(
          size.width * 0.7593853,
          size.height * 0.3682412,
          size.width * 0.7711746,
          size.height * 0.3755175,
          size.width * 0.7915801,
          size.height * 0.3848660)
      ..cubicTo(
          size.width * 0.8424791,
          size.height * 0.4081835,
          size.width * 0.8578658,
          size.height * 0.4172625,
          size.width * 0.8766133,
          size.height * 0.4350426)
      ..cubicTo(
          size.width * 0.8825671,
          size.height * 0.4406887,
          size.width * 0.8831169,
          size.height * 0.4416385,
          size.width * 0.8831169,
          size.height * 0.4462880)
      ..cubicTo(
          size.width * 0.8831169,
          size.height * 0.4603079,
          size.width * 0.8978932,
          size.height * 0.4822928,
          size.width * 0.9110014,
          size.height * 0.4877739)
      ..cubicTo(
          size.width * 0.9199235,
          size.height * 0.4915052,
          size.width * 0.9268615,
          size.height * 0.4923079,
          size.width * 0.9469177,
          size.height * 0.4919285)
      ..cubicTo(
          size.width * 0.9674012,
          size.height * 0.4915416,
          size.width * 0.9760115,
          size.height * 0.4903120,
          size.width * 0.9842583,
          size.height * 0.4865979)
      ..cubicTo(
          size.width * 0.9919394,
          size.height * 0.4831381,
          size.width * 0.9936522,
          size.height * 0.4795869,
          size.width * 0.9906926,
          size.height * 0.4732515)
      ..cubicTo(
          size.width * 0.9894271,
          size.height * 0.4705423,
          size.width * 0.9864026,
          size.height * 0.4663285,
          size.width * 0.9839726,
          size.height * 0.4638880)
      ..cubicTo(
          size.width * 0.9786724,
          size.height * 0.4585663,
          size.width * 0.9725830,
          size.height * 0.4515326,
          size.width * 0.9725830,
          size.height * 0.4507333)
      ..cubicTo(
          size.width * 0.9725830,
          size.height * 0.4504172,
          size.width * 0.9759913,
          size.height * 0.4512254,
          size.width * 0.9801587,
          size.height * 0.4525306)
      ..cubicTo(
          size.width * 0.9843261,
          size.height * 0.4538357,
          size.width * 0.9894271,
          size.height * 0.4550990,
          size.width * 0.9914949,
          size.height * 0.4553368)
      ..cubicTo(
          size.width * 0.9994921,
          size.height * 0.4562570,
          size.width * 1.002733,
          size.height * 0.4514096,
          size.width * 0.9970505,
          size.height * 0.4470302)
      ..cubicTo(
          size.width * 0.9914892,
          size.height * 0.4427443,
          size.width * 0.9704675,
          size.height * 0.4350660,
          size.width * 0.9493636,
          size.height * 0.4296117)
      ..cubicTo(
          size.width * 0.9391631,
          size.height * 0.4269753,
          size.width * 0.9390014,
          size.height * 0.4268887,
          size.width * 0.9335786,
          size.height * 0.4212062)
      ..cubicTo(
          size.width * 0.9305642,
          size.height * 0.4180481,
          size.width * 0.9254949,
          size.height * 0.4132213,
          size.width * 0.9223102,
          size.height * 0.4104797)
      ..cubicTo(
          size.width * 0.9111039,
          size.height * 0.4008296,
          size.width * 0.9003377,
          size.height * 0.3854186,
          size.width * 0.8867864,
          size.height * 0.3596289)
      ..cubicTo(
          size.width * 0.8801169,
          size.height * 0.3469340,
          size.width * 0.8774416,
          size.height * 0.3436460,
          size.width * 0.8678975,
          size.height * 0.3364048)
      ..cubicTo(
          size.width * 0.8573506,
          size.height * 0.3284041,
          size.width * 0.8434993,
          size.height * 0.3206983,
          size.width * 0.8296768,
          size.height * 0.3151430)
      ..cubicTo(
          size.width * 0.8234358,
          size.height * 0.3126344,
          size.width * 0.8179928,
          size.height * 0.3100564,
          size.width * 0.8175830,
          size.height * 0.3094144)
      ..cubicTo(
          size.width * 0.8171732,
          size.height * 0.3087725,
          size.width * 0.8158023,
          size.height * 0.3048454,
          size.width * 0.8145368,
          size.height * 0.3006873)
      ..cubicTo(
          size.width * 0.8093247,
          size.height * 0.2835698,
          size.width * 0.8012179,
          size.height * 0.2729869,
          size.width * 0.7838586,
          size.height * 0.2606419)
      ..lineTo(size.width * 0.7758701, size.height * 0.2549615)
      ..lineTo(size.width * 0.7779062, size.height * 0.2458653)
      ..cubicTo(
          size.width * 0.7809639,
          size.height * 0.2322062,
          size.width * 0.7803391,
          size.height * 0.2150825,
          size.width * 0.7764603,
          size.height * 0.2062722)
      ..cubicTo(
          size.width * 0.7693232,
          size.height * 0.1900612,
          size.width * 0.7540649,
          size.height * 0.1779258,
          size.width * 0.7310505,
          size.height * 0.1701553)
      ..cubicTo(
          size.width * 0.7196941,
          size.height * 0.1663210,
          size.width * 0.7130375,
          size.height * 0.1647519,
          size.width * 0.6769452,
          size.height * 0.1574021)
      ..cubicTo(
          size.width * 0.5803261,
          size.height * 0.1377258,
          size.width * 0.5663810,
          size.height * 0.1329911,
          size.width * 0.5645267,
          size.height * 0.1192351)
      ..cubicTo(
          size.width * 0.5637590,
          size.height * 0.1135368,
          size.width * 0.5652698,
          size.height * 0.1106027,
          size.width * 0.5760159,
          size.height * 0.09690722)
      ..cubicTo(
          size.width * 0.5822309,
          size.height * 0.08898557,
          size.width * 0.5844387,
          size.height * 0.08700756,
          size.width * 0.5911097,
          size.height * 0.08337801)
      ..cubicTo(
          size.width * 0.6026840,
          size.height * 0.07708247,
          size.width * 0.6052684,
          size.height * 0.07390584,
          size.width * 0.6052684,
          size.height * 0.06597938)
      ..cubicTo(
          size.width * 0.6052684,
          size.height * 0.06046873,
          size.width * 0.6047215,
          size.height * 0.05891409,
          size.width * 0.6017662,
          size.height * 0.05601375)
      ..cubicTo(
          size.width * 0.5986667,
          size.height * 0.05297388,
          size.width * 0.5981717,
          size.height * 0.05134845,
          size.width * 0.5974719,
          size.height * 0.04192440)
      ..cubicTo(
          size.width * 0.5966926,
          size.height * 0.03141993,
          size.width * 0.5966075,
          size.height * 0.03120000,
          size.width * 0.5914401,
          size.height * 0.02611684)
      ..cubicTo(
          size.width * 0.5802049,
          size.height * 0.01506667,
          size.width * 0.5575916,
          size.height * 0.006382137,
          size.width * 0.5288600,
          size.height * 0.002083168)
      ..cubicTo(
          size.width * 0.5174343,
          size.height * 0.0003732048,
          size.width * 0.4939062,
          size.height * -0.0003436405,
          size.width * 0.4835137,
          size.height * 0.0007017182)
      ..close();
  }

  Path leftTabialisAnterior(Size size) {
    return Path()
      ..moveTo(size.width * 0.3117475, size.height * 0.7342543)
      ..cubicTo(
          size.width * 0.3133030,
          size.height * 0.7313608,
          size.width * 0.3145743,
          size.height * 0.7288866,
          size.width * 0.3145743,
          size.height * 0.7287560)
      ..cubicTo(
          size.width * 0.3145743,
          size.height * 0.7286254,
          size.width * 0.3152107,
          size.height * 0.7285223,
          size.width * 0.3159899,
          size.height * 0.7285223)
      ..cubicTo(
          size.width * 0.3167677,
          size.height * 0.7285223,
          size.width * 0.3178023,
          size.height * 0.7293746,
          size.width * 0.3182857,
          size.height * 0.7304124)
      ..cubicTo(
          size.width * 0.3214834,
          size.height * 0.7372715,
          size.width * 0.3282294,
          size.height * 0.7485498,
          size.width * 0.3313766,
          size.height * 0.7522887)
      ..cubicTo(
          size.width * 0.3334242,
          size.height * 0.7547285,
          size.width * 0.3386378,
          size.height * 0.7592371,
          size.width * 0.3429625,
          size.height * 0.7623162)
      ..cubicTo(
          size.width * 0.3526768,
          size.height * 0.7692302,
          size.width * 0.3566436,
          size.height * 0.7748660,
          size.width * 0.3613665,
          size.height * 0.7884742)
      ..cubicTo(
          size.width * 0.3707302,
          size.height * 0.8154570,
          size.width * 0.3774848,
          size.height * 0.8676838,
          size.width * 0.3763867,
          size.height * 0.9046048)
      ..cubicTo(
          size.width * 0.3756739,
          size.height * 0.9285361,
          size.width * 0.3740188,
          size.height * 0.9282474,
          size.width * 0.3579293,
          size.height * 0.9013746)
      ..cubicTo(
          size.width * 0.3460289,
          size.height * 0.8814983,
          size.width * 0.3407417,
          size.height * 0.8738832,
          size.width * 0.3328499,
          size.height * 0.8652302)
      ..cubicTo(
          size.width * 0.3157100,
          size.height * 0.8464467,
          size.width * 0.3062020,
          size.height * 0.8232440,
          size.width * 0.3029899,
          size.height * 0.7923780)
      ..cubicTo(
          size.width * 0.3007518,
          size.height * 0.7708660,
          size.width * 0.3041313,
          size.height * 0.7484399,
          size.width * 0.3117475,
          size.height * 0.7342543)
      ..close();
  }

  Path rightTabialisAnterior(Size size) {
    return Path()
      ..moveTo(size.width * 0.6572771, size.height * 0.7621993)
      ..cubicTo(
          size.width * 0.6668167,
          size.height * 0.7552371,
          size.width * 0.6725945,
          size.height * 0.7483849,
          size.width * 0.6785657,
          size.height * 0.7369691)
      ..cubicTo(
          size.width * 0.6809971,
          size.height * 0.7323230,
          size.width * 0.6834632,
          size.height * 0.7285223,
          size.width * 0.6840476,
          size.height * 0.7285223)
      ..cubicTo(
          size.width * 0.6855801,
          size.height * 0.7285223,
          size.width * 0.6907446,
          size.height * 0.7381031,
          size.width * 0.6932944,
          size.height * 0.7456770)
      ..cubicTo(
          size.width * 0.6972857,
          size.height * 0.7575258,
          size.width * 0.6989755,
          size.height * 0.7783436,
          size.width * 0.6971775,
          size.height * 0.7935052)
      ..cubicTo(
          size.width * 0.6935628,
          size.height * 0.8239725,
          size.width * 0.6848196,
          size.height * 0.8451271,
          size.width * 0.6678629,
          size.height * 0.8644192)
      ..cubicTo(
          size.width * 0.6598283,
          size.height * 0.8735670,
          size.width * 0.6539394,
          size.height * 0.8819656,
          size.width * 0.6419610,
          size.height * 0.9013540)
      ..cubicTo(
          size.width * 0.6246465,
          size.height * 0.9293814,
          size.width * 0.6234185,
          size.height * 0.9290722,
          size.width * 0.6233925,
          size.height * 0.8966942)
      ..cubicTo(
          size.width * 0.6233608,
          size.height * 0.8576701,
          size.width * 0.6300693,
          size.height * 0.8110653,
          size.width * 0.6392569,
          size.height * 0.7864674)
      ..cubicTo(
          size.width * 0.6434978,
          size.height * 0.7751134,
          size.width * 0.6481241,
          size.height * 0.7688797,
          size.width * 0.6572771,
          size.height * 0.7621993)
      ..close();
  }

  Path leftGastrocnemius(Size size) {
    return Path()
      ..moveTo(size.width * 0.4111241, size.height * 0.7828179)
      ..cubicTo(
          size.width * 0.4126970,
          size.height * 0.7645017,
          size.width * 0.4156696,
          size.height * 0.7468041,
          size.width * 0.4178759,
          size.height * 0.7426117)
      ..cubicTo(
          size.width * 0.4193203,
          size.height * 0.7398763,
          size.width * 0.4207273,
          size.height * 0.7412027,
          size.width * 0.4247778,
          size.height * 0.7491409)
      ..cubicTo(
          size.width * 0.4373102,
          size.height * 0.7736907,
          size.width * 0.4383665,
          size.height * 0.7998488,
          size.width * 0.4277561,
          size.height * 0.8229141)
      ..cubicTo(
          size.width * 0.4241746,
          size.height * 0.8306942,
          size.width * 0.4169278,
          size.height * 0.8407766,
          size.width * 0.4154286,
          size.height * 0.8400619)
      ..cubicTo(
          size.width * 0.4107792,
          size.height * 0.8378488,
          size.width * 0.4087345,
          size.height * 0.8106529,
          size.width * 0.4111241,
          size.height * 0.7828179)
      ..close();
  }

  Path rightGastrocnemius(Size size) {
    return Path()
      ..moveTo(size.width * 0.5676970, size.height * 0.7690722)
      ..cubicTo(
          size.width * 0.5700563,
          size.height * 0.7605911,
          size.width * 0.5761111,
          size.height * 0.7464742,
          size.width * 0.5788701,
          size.height * 0.7430172)
      ..cubicTo(
          size.width * 0.5809524,
          size.height * 0.7404055,
          size.width * 0.5825209,
          size.height * 0.7421924,
          size.width * 0.5843001,
          size.height * 0.7491890)
      ..cubicTo(
          size.width * 0.5907691,
          size.height * 0.7746392,
          size.width * 0.5910216,
          size.height * 0.8342131,
          size.width * 0.5846840,
          size.height * 0.8396082)
      ..cubicTo(
          size.width * 0.5820014,
          size.height * 0.8418900,
          size.width * 0.5717143,
          size.height * 0.8246942,
          size.width * 0.5676768,
          size.height * 0.8111821)
      ..cubicTo(
          size.width * 0.5644834,
          size.height * 0.8004880,
          size.width * 0.5644935,
          size.height * 0.7805911,
          size.width * 0.5676970,
          size.height * 0.7690722)
      ..close();
  }

  Path leftRectusFemoralist(Size size) {
    return Path()
      ..moveTo(size.width * 0.3405988, size.height * 0.5377890)
      ..cubicTo(
          size.width * 0.3466970,
          size.height * 0.4929354,
          size.width * 0.3667172,
          size.height * 0.4553265,
          size.width * 0.3915411,
          size.height * 0.4420962)
      ..cubicTo(
          size.width * 0.3931371,
          size.height * 0.4412460,
          size.width * 0.3949697,
          size.height * 0.4405498,
          size.width * 0.3956133,
          size.height * 0.4405498)
      ..cubicTo(
          size.width * 0.3978975,
          size.height * 0.4405498,
          size.width * 0.4056335,
          size.height * 0.4489430,
          size.width * 0.4090996,
          size.height * 0.4551814)
      ..cubicTo(
          size.width * 0.4258110,
          size.height * 0.4852612,
          size.width * 0.4271457,
          size.height * 0.5466096,
          size.width * 0.4119423,
          size.height * 0.5859107)
      ..cubicTo(
          size.width * 0.4037879,
          size.height * 0.6069904,
          size.width * 0.3927749,
          size.height * 0.6187141,
          size.width * 0.3776219,
          size.height * 0.6224460)
      ..cubicTo(
          size.width * 0.3734906,
          size.height * 0.6234639,
          size.width * 0.3732641,
          size.height * 0.6234275,
          size.width * 0.3676941,
          size.height * 0.6208502)
      ..cubicTo(
          size.width * 0.3459466,
          size.height * 0.6107918,
          size.width * 0.3351674,
          size.height * 0.5777436,
          size.width * 0.3405988,
          size.height * 0.5377890)
      ..close();
  }

  Path rightRectusFemoralist(Size size) {
    return Path()
      ..moveTo(size.width * 0.5812352, size.height * 0.4865979)
      ..cubicTo(
          size.width * 0.5856522,
          size.height * 0.4663155,
          size.width * 0.5918947,
          size.height * 0.4525931,
          size.width * 0.6003232,
          size.height * 0.4446412)
      ..cubicTo(
          size.width * 0.6027071,
          size.height * 0.4423911,
          size.width * 0.6052525,
          size.height * 0.4405498,
          size.width * 0.6059769,
          size.height * 0.4405498)
      ..cubicTo(
          size.width * 0.6106349,
          size.height * 0.4405498,
          size.width * 0.6257951,
          size.height * 0.4532316,
          size.width * 0.6332886,
          size.height * 0.4633973)
      ..cubicTo(
          size.width * 0.6526421,
          size.height * 0.4896515,
          size.width * 0.6649437,
          size.height * 0.5371787,
          size.width * 0.6609812,
          size.height * 0.5703821)
      ..cubicTo(
          size.width * 0.6578571,
          size.height * 0.5965443,
          size.width * 0.6493535,
          size.height * 0.6122694,
          size.width * 0.6338211,
          size.height * 0.6206062)
      ..lineTo(size.width * 0.6283882, size.height * 0.6235223)
      ..lineTo(size.width * 0.6232929, size.height * 0.6225079)
      ..cubicTo(
          size.width * 0.6204906,
          size.height * 0.6219505,
          size.width * 0.6154877,
          size.height * 0.6200282,
          size.width * 0.6121760,
          size.height * 0.6182357)
      ..cubicTo(
          size.width * 0.5984661,
          size.height * 0.6108172,
          size.width * 0.5878413,
          size.height * 0.5911010,
          size.width * 0.5812381,
          size.height * 0.5608247)
      ..cubicTo(
          size.width * 0.5786970,
          size.height * 0.5491677,
          size.width * 0.5786941,
          size.height * 0.4982687,
          size.width * 0.5812352,
          size.height * 0.4865979)
      ..close();
  }

  Path leftVastusLateralis(Size size) {
    return Path()
      ..moveTo(size.width * 0.3030577, size.height * 0.5476674)
      ..cubicTo(
          size.width * 0.3064690,
          size.height * 0.5311457,
          size.width * 0.3141457,
          size.height * 0.5178309,
          size.width * 0.3233059,
          size.height * 0.5125430)
      ..cubicTo(
          size.width * 0.3314848,
          size.height * 0.5078220,
          size.width * 0.3316017,
          size.height * 0.5081629,
          size.width * 0.3280361,
          size.height * 0.5262543)
      ..cubicTo(
          size.width * 0.3249654,
          size.height * 0.5418282,
          size.width * 0.3245382,
          size.height * 0.5767849,
          size.width * 0.3273030,
          size.height * 0.5862543)
      ..cubicTo(
          size.width * 0.3302107,
          size.height * 0.5962220,
          size.width * 0.3339711,
          size.height * 0.6031354,
          size.width * 0.3417504,
          size.height * 0.6128247)
      ..cubicTo(
          size.width * 0.3531631,
          size.height * 0.6270412,
          size.width * 0.3556999,
          size.height * 0.6325189,
          size.width * 0.3556999,
          size.height * 0.6429553)
      ..cubicTo(
          size.width * 0.3556999,
          size.height * 0.6502172,
          size.width * 0.3552193,
          size.height * 0.6523086,
          size.width * 0.3531371,
          size.height * 0.6541237)
      ..cubicTo(
          size.width * 0.3494877,
          size.height * 0.6573052,
          size.width * 0.3451977,
          size.height * 0.6570790,
          size.width * 0.3379278,
          size.height * 0.6533223)
      ..cubicTo(
          size.width * 0.3207330,
          size.height * 0.6444371,
          size.width * 0.3085469,
          size.height * 0.6230289,
          size.width * 0.3030750,
          size.height * 0.5920962)
      ..cubicTo(
          size.width * 0.3011876,
          size.height * 0.5814186,
          size.width * 0.3011775,
          size.height * 0.5567711,
          size.width * 0.3030577,
          size.height * 0.5476674)
      ..close();
  }

  Path rightVastusLateralis(Size size) {
    return Path()
      ..moveTo(size.width * 0.6731645, size.height * 0.5268041)
      ..cubicTo(
          size.width * 0.6720043,
          size.height * 0.5203780,
          size.width * 0.6710418,
          size.height * 0.5139608,
          size.width * 0.6710260,
          size.height * 0.5125430)
      ..cubicTo(
          size.width * 0.6710087,
          size.height * 0.5111258,
          size.width * 0.6715873,
          size.height * 0.5099656,
          size.width * 0.6723102,
          size.height * 0.5099656)
      ..cubicTo(
          size.width * 0.6745296,
          size.height * 0.5099656,
          size.width * 0.6806667,
          size.height * 0.5138667,
          size.width * 0.6844675,
          size.height * 0.5176948)
      ..cubicTo(
          size.width * 0.7076638,
          size.height * 0.5410481,
          size.width * 0.7039221,
          size.height * 0.6108351,
          size.width * 0.6778442,
          size.height * 0.6412371)
      ..cubicTo(
          size.width * 0.6702670,
          size.height * 0.6500701,
          size.width * 0.6601039,
          size.height * 0.6563574,
          size.width * 0.6534040,
          size.height * 0.6563574)
      ..cubicTo(
          size.width * 0.6484242,
          size.height * 0.6563574,
          size.width * 0.6448903,
          size.height * 0.6511306,
          size.width * 0.6448903,
          size.height * 0.6437670)
      ..cubicTo(
          size.width * 0.6448903,
          size.height * 0.6339216,
          size.width * 0.6474632,
          size.height * 0.6289471,
          size.width * 0.6637446,
          size.height * 0.6073162)
      ..cubicTo(
          size.width * 0.6766710,
          size.height * 0.5901436,
          size.width * 0.6797893,
          size.height * 0.5634921,
          size.width * 0.6731645,
          size.height * 0.5268041)
      ..close();
  }

  Path leftVastusMedialis(Size size) {
    return Path()
      ..moveTo(size.width * 0.3947576, size.height * 0.6292289)
      ..cubicTo(
          size.width * 0.4174257,
          size.height * 0.6126660,
          size.width * 0.4304040,
          size.height * 0.5901931,
          size.width * 0.4337835,
          size.height * 0.5616515)
      ..cubicTo(
          size.width * 0.4343333,
          size.height * 0.5570027,
          size.width * 0.4352872,
          size.height * 0.5534460,
          size.width * 0.4359019,
          size.height * 0.5537478)
      ..cubicTo(
          size.width * 0.4383939,
          size.height * 0.5549698,
          size.width * 0.4465065,
          size.height * 0.5728811,
          size.width * 0.4517157,
          size.height * 0.5886598)
      ..cubicTo(
          size.width * 0.4572179,
          size.height * 0.6053271,
          size.width * 0.4568730,
          size.height * 0.6283560,
          size.width * 0.4508297,
          size.height * 0.6479388)
      ..cubicTo(
          size.width * 0.4460231,
          size.height * 0.6635120,
          size.width * 0.4374315,
          size.height * 0.6741540,
          size.width * 0.4270144,
          size.height * 0.6774371)
      ..cubicTo(
          size.width * 0.4220938,
          size.height * 0.6789883,
          size.width * 0.4203377,
          size.height * 0.6791718,
          size.width * 0.4139076,
          size.height * 0.6788089)
      ..cubicTo(
          size.width * 0.4049076,
          size.height * 0.6783017,
          size.width * 0.3925123,
          size.height * 0.6749265,
          size.width * 0.3865512,
          size.height * 0.6713608)
      ..cubicTo(
          size.width * 0.3792900,
          size.height * 0.6670165,
          size.width * 0.3761544,
          size.height * 0.6627622,
          size.width * 0.3754921,
          size.height * 0.6563574)
      ..cubicTo(
          size.width * 0.3745079,
          size.height * 0.6468550,
          size.width * 0.3786869,
          size.height * 0.6409718,
          size.width * 0.3947576,
          size.height * 0.6292289)
      ..close();
  }

  Path rightVastusMedialis(Size size) {
    return Path()
      ..moveTo(size.width * 0.5521558, size.height * 0.5814433)
      ..cubicTo(
          size.width * 0.5558557,
          size.height * 0.5710935,
          size.width * 0.5634127,
          size.height * 0.5551100,
          size.width * 0.5652626,
          size.height * 0.5537196)
      ..cubicTo(
          size.width * 0.5658470,
          size.height * 0.5532804,
          size.width * 0.5671082,
          size.height * 0.5581505,
          size.width * 0.5680635,
          size.height * 0.5645430)
      ..cubicTo(
          size.width * 0.5724271,
          size.height * 0.5937065,
          size.width * 0.5853463,
          size.height * 0.6146027,
          size.width * 0.6094329,
          size.height * 0.6314502)
      ..cubicTo(
          size.width * 0.6220058,
          size.height * 0.6402454,
          size.width * 0.6271645,
          size.height * 0.6482735,
          size.width * 0.6258615,
          size.height * 0.6570186)
      ..cubicTo(
          size.width * 0.6249192,
          size.height * 0.6633368,
          size.width * 0.6212020,
          size.height * 0.6676460,
          size.width * 0.6130678,
          size.height * 0.6718488)
      ..cubicTo(
          size.width * 0.6036248,
          size.height * 0.6767285,
          size.width * 0.5956133,
          size.height * 0.6786708,
          size.width * 0.5848773,
          size.height * 0.6786832)
      ..cubicTo(
          size.width * 0.5766566,
          size.height * 0.6786935,
          size.width * 0.5755152,
          size.height * 0.6785052,
          size.width * 0.5709149,
          size.height * 0.6763828)
      ..cubicTo(
          size.width * 0.5563146,
          size.height * 0.6696474,
          size.width * 0.5476494,
          size.height * 0.6500818,
          size.width * 0.5458932,
          size.height * 0.6198852)
      ..cubicTo(
          size.width * 0.5449755,
          size.height * 0.6040880,
          size.width * 0.5457417,
          size.height * 0.5993787,
          size.width * 0.5521558,
          size.height * 0.5814433)
      ..close();
  }

  Path leftSartorius(Size size) {
    return Path()
      ..moveTo(size.width * 0.4309625, size.height * 0.4771450)
      ..cubicTo(
          size.width * 0.4299192,
          size.height * 0.4740247,
          size.width * 0.4293867,
          size.height * 0.4713189,
          size.width * 0.4297792,
          size.height * 0.4711313)
      ..cubicTo(
          size.width * 0.4301732,
          size.height * 0.4709436,
          size.width * 0.4306378,
          size.height * 0.4707904,
          size.width * 0.4308110,
          size.height * 0.4707904)
      ..cubicTo(
          size.width * 0.4309856,
          size.height * 0.4707904,
          size.width * 0.4373463,
          size.height * 0.4755326,
          size.width * 0.4449466,
          size.height * 0.4813285)
      ..cubicTo(
          size.width * 0.4525469,
          size.height * 0.4871251,
          size.width * 0.4626306,
          size.height * 0.4944426,
          size.width * 0.4673550,
          size.height * 0.4975897)
      ..cubicTo(
          size.width * 0.4751544,
          size.height * 0.5027863,
          size.width * 0.4760317,
          size.height * 0.5037292,
          size.width * 0.4768947,
          size.height * 0.5078419)
      ..cubicTo(
          size.width * 0.4780938,
          size.height * 0.5135601,
          size.width * 0.4754055,
          size.height * 0.5370344,
          size.width * 0.4718456,
          size.height * 0.5519148)
      ..cubicTo(
          size.width * 0.4678615,
          size.height * 0.5685739,
          size.width * 0.4636825,
          size.height * 0.5773656,
          size.width * 0.4596421,
          size.height * 0.5775869)
      ..cubicTo(
          size.width * 0.4588745,
          size.height * 0.5776289,
          size.width * 0.4567619,
          size.height * 0.5733333,
          size.width * 0.4549481,
          size.height * 0.5680412)
      ..cubicTo(
          size.width * 0.4512367,
          size.height * 0.5572110,
          size.width * 0.4474444,
          size.height * 0.5509313,
          size.width * 0.4418745,
          size.height * 0.5463918)
      ..lineTo(size.width * 0.4380794, size.height * 0.5432990)
      ..lineTo(size.width * 0.4379091, size.height * 0.5226804)
      ..cubicTo(
          size.width * 0.4377403,
          size.height * 0.5024206,
          size.width * 0.4363333,
          size.height * 0.4931986,
          size.width * 0.4309625,
          size.height * 0.4771450)
      ..close();
  }

  Path rightSartorius(Size size) {
    return Path()
      ..moveTo(size.width * 0.5274863, size.height * 0.5013746)
      ..cubicTo(
          size.width * 0.5372511,
          size.height * 0.4946619,
          size.width * 0.5542179,
          size.height * 0.4823148,
          size.width * 0.5612900,
          size.height * 0.4767766)
      ..cubicTo(
          size.width * 0.5655325,
          size.height * 0.4734536,
          size.width * 0.5694820,
          size.height * 0.4709794,
          size.width * 0.5700664,
          size.height * 0.4712784)
      ..cubicTo(
          size.width * 0.5706508,
          size.height * 0.4715766,
          size.width * 0.5702900,
          size.height * 0.4742955,
          size.width * 0.5692670,
          size.height * 0.4773196)
      ..cubicTo(
          size.width * 0.5638153,
          size.height * 0.4934179,
          size.width * 0.5622958,
          size.height * 0.5031072,
          size.width * 0.5621025,
          size.height * 0.5230241)
      ..lineTo(size.width * 0.5619048, size.height * 0.5432990)
      ..lineTo(size.width * 0.5573232, size.height * 0.5475402)
      ..cubicTo(
          size.width * 0.5514776,
          size.height * 0.5529533,
          size.width * 0.5479755,
          size.height * 0.5590247,
          size.width * 0.5446046,
          size.height * 0.5695876)
      ..cubicTo(
          size.width * 0.5428961,
          size.height * 0.5749423,
          size.width * 0.5412915,
          size.height * 0.5780069,
          size.width * 0.5401948,
          size.height * 0.5780069)
      ..cubicTo(
          size.width * 0.5335036,
          size.height * 0.5780069,
          size.width * 0.5255570,
          size.height * 0.5498653,
          size.width * 0.5242799,
          size.height * 0.5216495)
      ..lineTo(size.width * 0.5234877, size.height * 0.5041237)
      ..lineTo(size.width * 0.5274863, size.height * 0.5013746)
      ..close();
  }

  Path leftGluteusMedius(Size size) {
    return Path()
      ..moveTo(size.width * 0.3271039, size.height * 0.4828282)
      ..cubicTo(
          size.width * 0.3450779,
          size.height * 0.4562859,
          size.width * 0.3515931,
          size.height * 0.4429759,
          size.width * 0.3530981,
          size.height * 0.4297251)
      ..cubicTo(
          size.width * 0.3535815,
          size.height * 0.4254729,
          size.width * 0.3544488,
          size.height * 0.4219931,
          size.width * 0.3550260,
          size.height * 0.4219931)
      ..cubicTo(
          size.width * 0.3556032,
          size.height * 0.4219931,
          size.width * 0.3587763,
          size.height * 0.4236976,
          size.width * 0.3620794,
          size.height * 0.4257808)
      ..cubicTo(
          size.width * 0.3653810,
          size.height * 0.4278639,
          size.width * 0.3713030,
          size.height * 0.4307134,
          size.width * 0.3752395,
          size.height * 0.4321127)
      ..cubicTo(
          size.width * 0.3791746,
          size.height * 0.4335127,
          size.width * 0.3823911,
          size.height * 0.4349780,
          size.width * 0.3823853,
          size.height * 0.4353698)
      ..cubicTo(
          size.width * 0.3823810,
          size.height * 0.4357622,
          size.width * 0.3810462,
          size.height * 0.4370103,
          size.width * 0.3794214,
          size.height * 0.4381443)
      ..cubicTo(
          size.width * 0.3693434,
          size.height * 0.4451780,
          size.width * 0.3556522,
          size.height * 0.4606667,
          size.width * 0.3441890,
          size.height * 0.4780069)
      ..cubicTo(
          size.width * 0.3329206,
          size.height * 0.4950509,
          size.width * 0.3213492,
          size.height * 0.5080522,
          size.width * 0.3160649,
          size.height * 0.5096076)
      ..cubicTo(
          size.width * 0.3104690,
          size.height * 0.5112557,
          size.width * 0.3145354,
          size.height * 0.5013869,
          size.width * 0.3271039,
          size.height * 0.4828282)
      ..close();
  }

  Path rightGluteusMedius(Size size) {
    return Path()
      ..moveTo(size.width * 0.6254834, size.height * 0.4323959)
      ..cubicTo(
          size.width * 0.6290231,
          size.height * 0.4311856,
          size.width * 0.6349625,
          size.height * 0.4283491,
          size.width * 0.6386825,
          size.height * 0.4260942)
      ..cubicTo(
          size.width * 0.6424040,
          size.height * 0.4238385,
          size.width * 0.6460014,
          size.height * 0.4219931,
          size.width * 0.6466782,
          size.height * 0.4219931)
      ..cubicTo(
          size.width * 0.6473535,
          size.height * 0.4219931,
          size.width * 0.6479206,
          size.height * 0.4240804,
          size.width * 0.6479365,
          size.height * 0.4266323)
      ..cubicTo(
          size.width * 0.6480101,
          size.height * 0.4389203,
          size.width * 0.6549856,
          size.height * 0.4542948,
          size.width * 0.6717720,
          size.height * 0.4791698)
      ..cubicTo(
          size.width * 0.6824848,
          size.height * 0.4950460,
          size.width * 0.6892352,
          size.height * 0.5080110,
          size.width * 0.6874892,
          size.height * 0.5093567)
      ..cubicTo(
          size.width * 0.6858427,
          size.height * 0.5106247,
          size.width * 0.6807835,
          size.height * 0.5076942,
          size.width * 0.6757763,
          size.height * 0.5025732)
      ..cubicTo(
          size.width * 0.6730938,
          size.height * 0.4998302,
          size.width * 0.6643968,
          size.height * 0.4883869,
          size.width * 0.6564488,
          size.height * 0.4771436)
      ..cubicTo(
          size.width * 0.6426075,
          size.height * 0.4575636,
          size.width * 0.6324488,
          size.height * 0.4459127,
          size.width * 0.6232944,
          size.height * 0.4391148)
      ..cubicTo(
          size.width * 0.6209582,
          size.height * 0.4373808,
          size.width * 0.6190476,
          size.height * 0.4356550,
          size.width * 0.6190476,
          size.height * 0.4352797)
      ..cubicTo(
          size.width * 0.6190476,
          size.height * 0.4349045,
          size.width * 0.6219437,
          size.height * 0.4336069,
          size.width * 0.6254834,
          size.height * 0.4323959)
      ..close();
  }

  Path path15(Size size) {
    return Path()
      ..moveTo(size.width * 0.3116782, size.height * 0.2652790)
      ..cubicTo(
          size.width * 0.3132814,
          size.height * 0.2624509,
          size.width * 0.3159928,
          size.height * 0.2575863,
          size.width * 0.3177042,
          size.height * 0.2544674)
      ..cubicTo(
          size.width * 0.3194156,
          size.height * 0.2513485,
          size.width * 0.3209784,
          size.height * 0.2487973,
          size.width * 0.3211775,
          size.height * 0.2487973)
      ..cubicTo(
          size.width * 0.3213752,
          size.height * 0.2487973,
          size.width * 0.3266811,
          size.height * 0.2511938,
          size.width * 0.3329654,
          size.height * 0.2541237)
      ..cubicTo(
          size.width * 0.3392496,
          size.height * 0.2570536,
          size.width * 0.3476941,
          size.height * 0.2602234,
          size.width * 0.3517302,
          size.height * 0.2611684)
      ..lineTo(size.width * 0.3590678, size.height * 0.2628866)
      ..lineTo(size.width * 0.3600649, size.height * 0.2671258)
      ..cubicTo(
          size.width * 0.3606133,
          size.height * 0.2694577,
          size.width * 0.3608283,
          size.height * 0.2750667,
          size.width * 0.3605455,
          size.height * 0.2795904)
      ..lineTo(size.width * 0.3600289, size.height * 0.2878151)
      ..lineTo(size.width * 0.3528817, size.height * 0.2944055)
      ..lineTo(size.width * 0.3457330, size.height * 0.3009952)
      ..lineTo(size.width * 0.3496349, size.height * 0.3084014)
      ..cubicTo(
          size.width * 0.3541530,
          size.height * 0.3169801,
          size.width * 0.3541198,
          size.height * 0.3168385,
          size.width * 0.3516494,
          size.height * 0.3168385)
      ..cubicTo(
          size.width * 0.3488802,
          size.height * 0.3168385,
          size.width * 0.3370707,
          size.height * 0.3088729,
          size.width * 0.3289971,
          size.height * 0.3015601)
      ..cubicTo(
          size.width * 0.3204589,
          size.height * 0.2938268,
          size.width * 0.3139957,
          size.height * 0.2848605,
          size.width * 0.3110000,
          size.height * 0.2765924)
      ..cubicTo(
          size.width * 0.3088672,
          size.height * 0.2707058,
          size.width * 0.3088990,
          size.height * 0.2701821,
          size.width * 0.3116782,
          size.height * 0.2652790)
      ..close();
  }

  Path path16(Size size) {
    return Path()
      ..moveTo(size.width * 0.6497489, size.height * 0.2611684)
      ..cubicTo(
          size.width * 0.6539553,
          size.height * 0.2601828,
          size.width * 0.6617403,
          size.height * 0.2572048,
          size.width * 0.6680072,
          size.height * 0.2541828)
      ..cubicTo(
          size.width * 0.6740159,
          size.height * 0.2512859,
          size.width * 0.6793131,
          size.height * 0.2488887,
          size.width * 0.6797792,
          size.height * 0.2488564)
      ..cubicTo(
          size.width * 0.6802468,
          size.height * 0.2488241,
          size.width * 0.6820072,
          size.height * 0.2513485,
          size.width * 0.6836926,
          size.height * 0.2544674)
      ..cubicTo(
          size.width * 0.6853781,
          size.height * 0.2575863,
          size.width * 0.6880765,
          size.height * 0.2624289,
          size.width * 0.6896898,
          size.height * 0.2652296)
      ..cubicTo(
          size.width * 0.6921486,
          size.height * 0.2694983,
          size.width * 0.6923954,
          size.height * 0.2709979,
          size.width * 0.6912150,
          size.height * 0.2745079)
      ..cubicTo(
          size.width * 0.6871299,
          size.height * 0.2866598,
          size.width * 0.6772150,
          size.height * 0.2988749,
          size.width * 0.6635960,
          size.height * 0.3085361)
      ..cubicTo(
          size.width * 0.6531530,
          size.height * 0.3159443,
          size.width * 0.6516219,
          size.height * 0.3168385,
          size.width * 0.6493911,
          size.height * 0.3168385)
      ..cubicTo(
          size.width * 0.6472338,
          size.height * 0.3168385,
          size.width * 0.6481587,
          size.height * 0.3138447,
          size.width * 0.6523304,
          size.height * 0.3073162)
      ..cubicTo(
          size.width * 0.6560794,
          size.height * 0.3014515,
          size.width * 0.6559177,
          size.height * 0.3006337,
          size.width * 0.6501053,
          size.height * 0.2960433)
      ..cubicTo(
          size.width * 0.6473506,
          size.height * 0.2938667,
          size.width * 0.6440317,
          size.height * 0.2903423,
          size.width * 0.6427316,
          size.height * 0.2882110)
      ..cubicTo(
          size.width * 0.6401890,
          size.height * 0.2840460,
          size.width * 0.6395426,
          size.height * 0.2740735,
          size.width * 0.6413550,
          size.height * 0.2670103)
      ..lineTo(size.width * 0.6424141, size.height * 0.2628866)
      ..lineTo(size.width * 0.6497489, size.height * 0.2611684)
      ..close();
  }

  Path path17(Size size) {
    return Path()
      ..moveTo(size.width * 0.3643420, size.height * 0.3102110)
      ..cubicTo(
          size.width * 0.3623665,
          size.height * 0.3065024,
          size.width * 0.3607504,
          size.height * 0.3032227,
          size.width * 0.3607504,
          size.height * 0.3029237)
      ..cubicTo(
          size.width * 0.3607504,
          size.height * 0.3020282,
          size.width * 0.3681400,
          size.height * 0.3031320,
          size.width * 0.3770750,
          size.height * 0.3053608)
      ..cubicTo(
          size.width * 0.3992670,
          size.height * 0.3108990,
          size.width * 0.4119928,
          size.height * 0.3237691,
          size.width * 0.4137374,
          size.height * 0.3424399)
      ..cubicTo(
          size.width * 0.4141876,
          size.height * 0.3472598,
          size.width * 0.4140115,
          size.height * 0.3512027,
          size.width * 0.4133449,
          size.height * 0.3512027)
      ..cubicTo(
          size.width * 0.4126797,
          size.height * 0.3512027,
          size.width * 0.4104762,
          size.height * 0.3504481,
          size.width * 0.4084488,
          size.height * 0.3495251)
      ..cubicTo(
          size.width * 0.4064214,
          size.height * 0.3486027,
          size.width * 0.3976883,
          size.height * 0.3455876,
          size.width * 0.3890418,
          size.height * 0.3428241)
      ..cubicTo(
          size.width * 0.3803954,
          size.height * 0.3400612,
          size.width * 0.3728268,
          size.height * 0.3373368,
          size.width * 0.3722208,
          size.height * 0.3367698)
      ..cubicTo(
          size.width * 0.3716147,
          size.height * 0.3362027,
          size.width * 0.3704026,
          size.height * 0.3315120,
          size.width * 0.3695267,
          size.height * 0.3263464)
      ..cubicTo(
          size.width * 0.3686421,
          size.height * 0.3211368,
          size.width * 0.3663333,
          size.height * 0.3139512,
          size.width * 0.3643420,
          size.height * 0.3102110)
      ..close();
  }

  Path path18(Size size) {
    return Path()
      ..moveTo(size.width * 0.5901400, size.height * 0.3307010)
      ..cubicTo(
          size.width * 0.5961905,
          size.height * 0.3165959,
          size.width * 0.6111198,
          size.height * 0.3071292,
          size.width * 0.6332525,
          size.height * 0.3033636)
      ..cubicTo(
          size.width * 0.6361544,
          size.height * 0.3028694,
          size.width * 0.6390144,
          size.height * 0.3024522,
          size.width * 0.6396104,
          size.height * 0.3024357)
      ..cubicTo(
          size.width * 0.6412338,
          size.height * 0.3023904,
          size.width * 0.6409221,
          size.height * 0.3039849,
          size.width * 0.6387229,
          size.height * 0.3069581)
      ..cubicTo(
          size.width * 0.6357460,
          size.height * 0.3109849,
          size.width * 0.6320548,
          size.height * 0.3218076,
          size.width * 0.6309004,
          size.height * 0.3298969)
      ..lineTo(size.width * 0.6298701, size.height * 0.3371134)
      ..lineTo(size.width * 0.6136840, size.height * 0.3422893)
      ..cubicTo(
          size.width * 0.6047821,
          size.height * 0.3451361,
          size.width * 0.5955354,
          size.height * 0.3483608,
          size.width * 0.5931371,
          size.height * 0.3494557)
      ..cubicTo(
          size.width * 0.5907374,
          size.height * 0.3505505,
          size.width * 0.5882814,
          size.height * 0.3512103,
          size.width * 0.5876768,
          size.height * 0.3509223)
      ..cubicTo(
          size.width * 0.5857417,
          size.height * 0.3499986,
          size.width * 0.5872799,
          size.height * 0.3373711,
          size.width * 0.5901400,
          size.height * 0.3307010)
      ..close();
  }

  Path path19(Size size) {
    return Path()
      ..moveTo(size.width * 0.3600159, size.height * 0.3531986)
      ..cubicTo(
          size.width * 0.3612713,
          size.height * 0.3504000,
          size.width * 0.3626811,
          size.height * 0.3472598,
          size.width * 0.3631486,
          size.height * 0.3462199)
      ..cubicTo(
          size.width * 0.3636147,
          size.height * 0.3451801,
          size.width * 0.3649192,
          size.height * 0.3443299,
          size.width * 0.3660462,
          size.height * 0.3443299)
      ..cubicTo(
          size.width * 0.3684949,
          size.height * 0.3443299,
          size.width * 0.3875426,
          size.height * 0.3503244,
          size.width * 0.3972208,
          size.height * 0.3541402)
      ..cubicTo(
          size.width * 0.4010101,
          size.height * 0.3556344,
          size.width * 0.4058139,
          size.height * 0.3582412,
          size.width * 0.4078961,
          size.height * 0.3599333)
      ..cubicTo(
          size.width * 0.4116566,
          size.height * 0.3629890,
          size.width * 0.4116753,
          size.height * 0.3630797,
          size.width * 0.4108629,
          size.height * 0.3736832)
      ..cubicTo(
          size.width * 0.4104127,
          size.height * 0.3795533,
          size.width * 0.4094545,
          size.height * 0.3846378,
          size.width * 0.4087345,
          size.height * 0.3849808)
      ..cubicTo(
          size.width * 0.4067085,
          size.height * 0.3859457,
          size.width * 0.3598499,
          size.height * 0.3628804,
          size.width * 0.3586797,
          size.height * 0.3603416)
      ..cubicTo(
          size.width * 0.3581587,
          size.height * 0.3592117,
          size.width * 0.3587605,
          size.height * 0.3559979,
          size.width * 0.3600159,
          size.height * 0.3531986)
      ..close();
  }

  Path path20(Size size) {
    return Path()
      ..moveTo(size.width * 0.5923781, size.height * 0.3605519)
      ..cubicTo(
          size.width * 0.5953420,
          size.height * 0.3575773,
          size.width * 0.6051400,
          size.height * 0.3533704,
          size.width * 0.6213449,
          size.height * 0.3481141)
      ..cubicTo(
          size.width * 0.6276205,
          size.height * 0.3460784,
          size.width * 0.6337734,
          size.height * 0.3443938,
          size.width * 0.6350173,
          size.height * 0.3443711)
      ..cubicTo(
          size.width * 0.6378167,
          size.height * 0.3443203,
          size.width * 0.6421818,
          size.height * 0.3525588,
          size.width * 0.6421544,
          size.height * 0.3578419)
      ..cubicTo(
          size.width * 0.6421313,
          size.height * 0.3622309,
          size.width * 0.6390361,
          size.height * 0.3641959,
          size.width * 0.6121631,
          size.height * 0.3768790)
      ..cubicTo(
          size.width * 0.5989567,
          size.height * 0.3831127,
          size.width * 0.5931010,
          size.height * 0.3854570,
          size.width * 0.5922915,
          size.height * 0.3848337)
      ..cubicTo(
          size.width * 0.5916609,
          size.height * 0.3843478,
          size.width * 0.5908470,
          size.height * 0.3792639,
          size.width * 0.5904805,
          size.height * 0.3735368)
      ..cubicTo(
          size.width * 0.5899076,
          size.height * 0.3645533,
          size.width * 0.5901688,
          size.height * 0.3627704,
          size.width * 0.5923781,
          size.height * 0.3605519)
      ..close();
  }

  Path path21(Size size) {
    return Path()
      ..moveTo(size.width * 0.3468860, size.height * 0.3923278)
      ..cubicTo(
          size.width * 0.3444906,
          size.height * 0.3868790,
          size.width * 0.3455657,
          size.height * 0.3804062,
          size.width * 0.3500635,
          size.height * 0.3731924)
      ..cubicTo(
          size.width * 0.3513001,
          size.height * 0.3712096,
          size.width * 0.3530505,
          size.height * 0.3697595,
          size.width * 0.3542092,
          size.height * 0.3697595)
      ..cubicTo(
          size.width * 0.3568355,
          size.height * 0.3697595,
          size.width * 0.3833117,
          size.height * 0.3832784,
          size.width * 0.3941443,
          size.height * 0.3901505)
      ..cubicTo(
          size.width * 0.3988095,
          size.height * 0.3931107,
          size.width * 0.4039033,
          size.height * 0.3971478,
          size.width * 0.4054632,
          size.height * 0.3991210)
      ..cubicTo(
          size.width * 0.4130909,
          size.height * 0.4087766,
          size.width * 0.4188485,
          size.height * 0.4331237,
          size.width * 0.4137244,
          size.height * 0.4340598)
      ..cubicTo(
          size.width * 0.4076190,
          size.height * 0.4351759,
          size.width * 0.3834127,
          size.height * 0.4254289,
          size.width * 0.3709278,
          size.height * 0.4168268)
      ..cubicTo(
          size.width * 0.3607302,
          size.height * 0.4098000,
          size.width * 0.3495671,
          size.height * 0.3984254,
          size.width * 0.3468860,
          size.height * 0.3923278)
      ..close();
  }

  Path path22(Size size) {
    return Path()
      ..moveTo(size.width * 0.5970938, size.height * 0.3977842)
      ..cubicTo(
          size.width * 0.6009899,
          size.height * 0.3936117,
          size.width * 0.6150101,
          size.height * 0.3850124,
          size.width * 0.6312973,
          size.height * 0.3768041)
      ..cubicTo(
          size.width * 0.6389856,
          size.height * 0.3729292,
          size.width * 0.6461746,
          size.height * 0.3697595,
          size.width * 0.6472727,
          size.height * 0.3697595)
      ..cubicTo(
          size.width * 0.6496566,
          size.height * 0.3697595,
          size.width * 0.6528759,
          size.height * 0.3748612,
          size.width * 0.6550909,
          size.height * 0.3821464)
      ..cubicTo(
          size.width * 0.6571400,
          size.height * 0.3888811,
          size.width * 0.6545974,
          size.height * 0.3948667,
          size.width * 0.6459437,
          size.height * 0.4036880)
      ..cubicTo(
          size.width * 0.6334603,
          size.height * 0.4164103,
          size.width * 0.6182468,
          size.height * 0.4255856,
          size.width * 0.6001097,
          size.height * 0.4313278)
      ..cubicTo(
          size.width * 0.5856580,
          size.height * 0.4359038,
          size.width * 0.5852612,
          size.height * 0.4357093,
          size.width * 0.5862886,
          size.height * 0.4245546)
      ..cubicTo(
          size.width * 0.5871674,
          size.height * 0.4150192,
          size.width * 0.5918629,
          size.height * 0.4033835,
          size.width * 0.5970938,
          size.height * 0.3977842)
      ..close();
  }

  Path path23(Size size) {
    return Path()
      ..moveTo(size.width * 0.4020606, size.height * 0.2615395)
      ..cubicTo(
          size.width * 0.4182352,
          size.height * 0.2599759,
          size.width * 0.4444747,
          size.height * 0.2581045,
          size.width * 0.4588745,
          size.height * 0.2574873)
      ..cubicTo(
          size.width * 0.4716032,
          size.height * 0.2569423,
          size.width * 0.4903016,
          size.height * 0.2574371,
          size.width * 0.4926955,
          size.height * 0.2583835)
      ..cubicTo(
          size.width * 0.4946768,
          size.height * 0.2591670,
          size.width * 0.4949668,
          size.height * 0.2607581,
          size.width * 0.4946277,
          size.height * 0.2690000)
      ..lineTo(size.width * 0.4942280, size.height * 0.2786942)
      ..lineTo(size.width * 0.4855267, size.height * 0.2791512)
      ..cubicTo(
          size.width * 0.4684646,
          size.height * 0.2800481,
          size.width * 0.4534343,
          size.height * 0.2831409,
          size.width * 0.4230462,
          size.height * 0.2920076)
      ..cubicTo(
          size.width * 0.4129899,
          size.height * 0.2949423,
          size.width * 0.4035887,
          size.height * 0.2975512,
          size.width * 0.4021558,
          size.height * 0.2978055)
      ..cubicTo(
          size.width * 0.3917287,
          size.height * 0.2996570,
          size.width * 0.3758543,
          size.height * 0.2895443,
          size.width * 0.3723016,
          size.height * 0.2787869)
      ..cubicTo(
          size.width * 0.3710245,
          size.height * 0.2749223,
          size.width * 0.3711486,
          size.height * 0.2734041,
          size.width * 0.3729856,
          size.height * 0.2703938)
      ..cubicTo(
          size.width * 0.3762756,
          size.height * 0.2650034,
          size.width * 0.3809524,
          size.height * 0.2635794,
          size.width * 0.4020606,
          size.height * 0.2615395)
      ..close();
  }

  Path path24(Size size) {
    return Path()
      ..moveTo(size.width * 0.5050505, size.height * 0.2680694)
      ..cubicTo(
          size.width * 0.5050505,
          size.height * 0.2589491,
          size.width * 0.5054444,
          size.height * 0.2583086,
          size.width * 0.5115440,
          size.height * 0.2574948)
      ..cubicTo(
          size.width * 0.5245137,
          size.height * 0.2557636,
          size.width * 0.6083521,
          size.height * 0.2610852,
          size.width * 0.6186277,
          size.height * 0.2642921)
      ..cubicTo(
          size.width * 0.6273247,
          size.height * 0.2670062,
          size.width * 0.6304185,
          size.height * 0.2727890,
          size.width * 0.6271587,
          size.height * 0.2802351)
      ..cubicTo(
          size.width * 0.6236133,
          size.height * 0.2883320,
          size.width * 0.6136681,
          size.height * 0.2959890,
          size.width * 0.6047763,
          size.height * 0.2974653)
      ..cubicTo(
          size.width * 0.5996118,
          size.height * 0.2983223,
          size.width * 0.5949986,
          size.height * 0.2973732,
          size.width * 0.5735931,
          size.height * 0.2910502)
      ..cubicTo(
          size.width * 0.5473535,
          size.height * 0.2832990,
          size.width * 0.5254531,
          size.height * 0.2790378,
          size.width * 0.5118514,
          size.height * 0.2790378)
      ..cubicTo(
          size.width * 0.5085786,
          size.height * 0.2790378,
          size.width * 0.5064935,
          size.height * 0.2786557,
          size.width * 0.5059264,
          size.height * 0.2779505)
      ..cubicTo(
          size.width * 0.5054444,
          size.height * 0.2773526,
          size.width * 0.5050505,
          size.height * 0.2729058,
          size.width * 0.5050505,
          size.height * 0.2680694)
      ..close();
  }

  Path path25(Size size) {
    return Path()
      ..moveTo(size.width * 0.4186089, size.height * 0.3007759)
      ..cubicTo(
          size.width * 0.4335455,
          size.height * 0.2942144,
          size.width * 0.4634387,
          size.height * 0.2869485,
          size.width * 0.4838355,
          size.height * 0.2849216)
      ..cubicTo(
          size.width * 0.4887576,
          size.height * 0.2844323,
          size.width * 0.4932713,
          size.height * 0.2841643,
          size.width * 0.4938672,
          size.height * 0.2843251)
      ..cubicTo(
          size.width * 0.4944632,
          size.height * 0.2844859,
          size.width * 0.4949495,
          size.height * 0.2921759,
          size.width * 0.4949495,
          size.height * 0.3014151)
      ..lineTo(size.width * 0.4949495, size.height * 0.3182131)
      ..lineTo(size.width * 0.4808802, size.height * 0.3182371)
      ..cubicTo(
          size.width * 0.4647359,
          size.height * 0.3182646,
          size.width * 0.4484286,
          size.height * 0.3195086,
          size.width * 0.4378211,
          size.height * 0.3215230)
      ..cubicTo(
          size.width * 0.4317475,
          size.height * 0.3226763,
          size.width * 0.4298759,
          size.height * 0.3227753,
          size.width * 0.4269986,
          size.height * 0.3220955)
      ..cubicTo(
          size.width * 0.4226277,
          size.height * 0.3210625,
          size.width * 0.4146551,
          size.height * 0.3135402,
          size.width * 0.4123247,
          size.height * 0.3082481)
      ..lineTo(size.width * 0.4105859, size.height * 0.3043003)
      ..lineTo(size.width * 0.4186089, size.height * 0.3007759)
      ..close();
  }

  Path path26(Size size) {
    return Path()
      ..moveTo(size.width * 0.5053838, size.height * 0.3017326)
      ..cubicTo(
          size.width * 0.5051703,
          size.height * 0.2928570,
          size.width * 0.5052843,
          size.height * 0.2852378,
          size.width * 0.5056349,
          size.height * 0.2848014)
      ..cubicTo(
          size.width * 0.5063795,
          size.height * 0.2838777,
          size.width * 0.5158730,
          size.height * 0.2845595,
          size.width * 0.5274170,
          size.height * 0.2863656)
      ..cubicTo(
          size.width * 0.5470765,
          size.height * 0.2894405,
          size.width * 0.5730909,
          size.height * 0.2965278,
          size.width * 0.5836306,
          size.height * 0.3016804)
      ..lineTo(size.width * 0.5893391, size.height * 0.3044715)
      ..lineTo(size.width * 0.5876378, size.height * 0.3083340)
      ..cubicTo(
          size.width * 0.5853391,
          size.height * 0.3135519,
          size.width * 0.5773434,
          size.height * 0.3210694,
          size.width * 0.5730014,
          size.height * 0.3220955)
      ..cubicTo(
          size.width * 0.5701385,
          size.height * 0.3227718,
          size.width * 0.5682713,
          size.height * 0.3226825,
          size.width * 0.5624517,
          size.height * 0.3215897)
      ..cubicTo(
          size.width * 0.5512035,
          size.height * 0.3194777,
          size.width * 0.5430823,
          size.height * 0.3187897,
          size.width * 0.5238095,
          size.height * 0.3183141)
      ..lineTo(size.width * 0.5057720, size.height * 0.3178694)
      ..lineTo(size.width * 0.5053838, size.height * 0.3017326)
      ..close();
  }

  Path path27(Size size) {
    return Path()
      ..moveTo(size.width * 0.4374401, size.height * 0.3295436)
      ..cubicTo(
          size.width * 0.4432496,
          size.height * 0.3263931,
          size.width * 0.4482222,
          size.height * 0.3251904,
          size.width * 0.4601183,
          size.height * 0.3240619)
      ..cubicTo(
          size.width * 0.4709293,
          size.height * 0.3230364,
          size.width * 0.4904055,
          size.height * 0.3227622,
          size.width * 0.4931659,
          size.height * 0.3235966)
      ..cubicTo(
          size.width * 0.4945873,
          size.height * 0.3240268,
          size.width * 0.4949062,
          size.height * 0.3290632,
          size.width * 0.4946089,
          size.height * 0.3464385)
      ..lineTo(size.width * 0.4942280, size.height * 0.3687285)
      ..lineTo(size.width * 0.4754690, size.height * 0.3689388)
      ..cubicTo(
          size.width * 0.4650620,
          size.height * 0.3690557,
          size.width * 0.4543810,
          size.height * 0.3688254,
          size.width * 0.4514791,
          size.height * 0.3684220)
      ..cubicTo(
          size.width * 0.4444228,
          size.height * 0.3674399,
          size.width * 0.4355137,
          size.height * 0.3626838,
          size.width * 0.4313521,
          size.height * 0.3576763)
      ..cubicTo(
          size.width * 0.4284632,
          size.height * 0.3542014,
          size.width * 0.4279726,
          size.height * 0.3524062,
          size.width * 0.4279841,
          size.height * 0.3453608)
      ..cubicTo(
          size.width * 0.4280014,
          size.height * 0.3362316,
          size.width * 0.4293882,
          size.height * 0.3339120,
          size.width * 0.4374401,
          size.height * 0.3295436)
      ..close();
  }

  Path path28(Size size) {
    return Path()
      ..moveTo(size.width * 0.5053911, size.height * 0.3468179)
      ..cubicTo(
          size.width * 0.5051198,
          size.height * 0.3312220,
          size.width * 0.5054820,
          size.height * 0.3246351,
          size.width * 0.5066494,
          size.height * 0.3239656)
      ..cubicTo(
          size.width * 0.5086522,
          size.height * 0.3228158,
          size.width * 0.5232872,
          size.height * 0.3227155,
          size.width * 0.5367879,
          size.height * 0.3237588)
      ..cubicTo(
          size.width * 0.5541097,
          size.height * 0.3250969,
          size.width * 0.5624026,
          size.height * 0.3277491,
          size.width * 0.5688615,
          size.height * 0.3340172)
      ..cubicTo(
          size.width * 0.5715541,
          size.height * 0.3366296,
          size.width * 0.5720606,
          size.height * 0.3382948,
          size.width * 0.5721010,
          size.height * 0.3446735)
      ..cubicTo(
          size.width * 0.5721616,
          size.height * 0.3539986,
          size.width * 0.5685815,
          size.height * 0.3597354,
          size.width * 0.5597071,
          size.height * 0.3645381)
      ..cubicTo(
          size.width * 0.5521486,
          size.height * 0.3686275,
          size.width * 0.5475887,
          size.height * 0.3691979,
          size.width * 0.5245310,
          size.height * 0.3689388)
      ..lineTo(size.width * 0.5057720, size.height * 0.3687285)
      ..lineTo(size.width * 0.5053911, size.height * 0.3468179)
      ..close();
  }

  Path path29(Size size) {
    return Path()
      ..moveTo(size.width * 0.4392583, size.height * 0.3836419)
      ..cubicTo(
          size.width * 0.4422742,
          size.height * 0.3763024,
          size.width * 0.4438701,
          size.height * 0.3754550,
          size.width * 0.4563333,
          size.height * 0.3745711)
      ..cubicTo(
          size.width * 0.4605094,
          size.height * 0.3742749,
          size.width * 0.4707431,
          size.height * 0.3740763,
          size.width * 0.4790765,
          size.height * 0.3741299)
      ..lineTo(size.width * 0.4942280, size.height * 0.3742268)
      ..lineTo(size.width * 0.4945974, size.height * 0.4269759)
      ..cubicTo(
          size.width * 0.4949524,
          size.height * 0.4775540,
          size.width * 0.4948600,
          size.height * 0.4797251,
          size.width * 0.4923463,
          size.height * 0.4797251)
      ..cubicTo(
          size.width * 0.4909048,
          size.height * 0.4797251,
          size.width * 0.4875873,
          size.height * 0.4787292,
          size.width * 0.4849740,
          size.height * 0.4775127)
      ..cubicTo(
          size.width * 0.4665830,
          size.height * 0.4689491,
          size.width * 0.4478672,
          size.height * 0.4460962,
          size.width * 0.4392208,
          size.height * 0.4216495)
      ..cubicTo(
          size.width * 0.4357403,
          size.height * 0.4118082,
          size.width * 0.4357590,
          size.height * 0.3921581,
          size.width * 0.4392583,
          size.height * 0.3836419)
      ..close();
  }

  Path path30(Size size) {
    return Path()
      ..moveTo(size.width * 0.5050505, size.height * 0.4272048)
      ..cubicTo(
          size.width * 0.5050505,
          size.height * 0.3858591,
          size.width * 0.5054343,
          size.height * 0.3746007,
          size.width * 0.5068543,
          size.height * 0.3742880)
      ..cubicTo(
          size.width * 0.5078470,
          size.height * 0.3740694,
          size.width * 0.5172597,
          size.height * 0.3740179,
          size.width * 0.5277734,
          size.height * 0.3741732)
      ..cubicTo(
          size.width * 0.5524257,
          size.height * 0.3745368,
          size.width * 0.5568947,
          size.height * 0.3754144,
          size.width * 0.5595368,
          size.height * 0.3804124)
      ..cubicTo(
          size.width * 0.5605354,
          size.height * 0.3823024,
          size.width * 0.5621212,
          size.height * 0.3876591,
          size.width * 0.5630620,
          size.height * 0.3923162)
      ..cubicTo(
          size.width * 0.5671111,
          size.height * 0.4123704,
          size.width * 0.5561111,
          size.height * 0.4406399,
          size.width * 0.5361977,
          size.height * 0.4613608)
      ..cubicTo(
          size.width * 0.5268124,
          size.height * 0.4711251,
          size.width * 0.5134416,
          size.height * 0.4797251,
          size.width * 0.5076436,
          size.height * 0.4797251)
      ..cubicTo(
          size.width * 0.5051703,
          size.height * 0.4797251,
          size.width * 0.5050505,
          size.height * 0.4772900,
          size.width * 0.5050505,
          size.height * 0.4272048)
      ..close();
  }

  Path leftBrachioRadialis(Size size) {
    return Path()
      ..moveTo(size.width * 0.1332944, size.height * 0.3468667)
      ..cubicTo(
          size.width * 0.1401674,
          size.height * 0.3394653,
          size.width * 0.1559812,
          size.height * 0.3294454,
          size.width * 0.1678326,
          size.height * 0.3249835)
      ..cubicTo(
          size.width * 0.1716984,
          size.height * 0.3235278,
          size.width * 0.1752915,
          size.height * 0.3223381,
          size.width * 0.1758153,
          size.height * 0.3223395)
      ..cubicTo(
          size.width * 0.1784921,
          size.height * 0.3223464,
          size.width * 0.1865368,
          size.height * 0.3253457,
          size.width * 0.1891544,
          size.height * 0.3273134)
      ..cubicTo(
          size.width * 0.1918326,
          size.height * 0.3293258,
          size.width * 0.1920577,
          size.height * 0.3302866,
          size.width * 0.1913651,
          size.height * 0.3367698)
      ..cubicTo(
          size.width * 0.1903983,
          size.height * 0.3458021,
          size.width * 0.1858240,
          size.height * 0.3572172,
          size.width * 0.1802049,
          size.height * 0.3646124)
      ..cubicTo(
          size.width * 0.1698889,
          size.height * 0.3781924,
          size.width * 0.1442915,
          size.height * 0.3950804,
          size.width * 0.1163074,
          size.height * 0.4067711)
      ..cubicTo(
          size.width * 0.1051443,
          size.height * 0.4114344,
          size.width * 0.09177489,
          size.height * 0.4158076,
          size.width * 0.08868254,
          size.height * 0.4158076)
      ..cubicTo(
          size.width * 0.08661760,
          size.height * 0.4158076,
          size.width * 0.08672006,
          size.height * 0.4155065,
          size.width * 0.08943434,
          size.height * 0.4135739)
      ..cubicTo(
          size.width * 0.09554257,
          size.height * 0.4092261,
          size.width * 0.1081241,
          size.height * 0.3961120,
          size.width * 0.1139206,
          size.height * 0.3880495)
      ..cubicTo(
          size.width * 0.1206652,
          size.height * 0.3786708,
          size.width * 0.1255310,
          size.height * 0.3681058,
          size.width * 0.1255628,
          size.height * 0.3627787)
      ..cubicTo(
          size.width * 0.1255887,
          size.height * 0.3581952,
          size.width * 0.1286782,
          size.height * 0.3518385,
          size.width * 0.1332944,
          size.height * 0.3468667)
      ..close();
  }

  Path rightBrachioRadialis(Size size) {
    return Path()
      ..moveTo(size.width * 0.8116508, size.height * 0.3460481)
      ..cubicTo(
          size.width * 0.8070967,
          size.height * 0.3327326,
          size.width * 0.8093045,
          size.height * 0.3268055,
          size.width * 0.8199726,
          size.height * 0.3237079)
      ..cubicTo(
          size.width * 0.8225584,
          size.height * 0.3229567,
          size.width * 0.8250000,
          size.height * 0.3223485,
          size.width * 0.8253968,
          size.height * 0.3223567)
      ..cubicTo(
          size.width * 0.8257937,
          size.height * 0.3223643,
          size.width * 0.8292107,
          size.height * 0.3234515,
          size.width * 0.8329899,
          size.height * 0.3247718)
      ..cubicTo(
          size.width * 0.8466797,
          size.height * 0.3295553,
          size.width * 0.8659250,
          size.height * 0.3430756,
          size.width * 0.8720808,
          size.height * 0.3522337)
      ..cubicTo(
          size.width * 0.8733521,
          size.height * 0.3541237,
          size.width * 0.8750678,
          size.height * 0.3591519,
          size.width * 0.8758961,
          size.height * 0.3634076)
      ..cubicTo(
          size.width * 0.8788860,
          size.height * 0.3787808,
          size.width * 0.8947965,
          size.height * 0.4013691,
          size.width * 0.9103838,
          size.height * 0.4123711)
      ..cubicTo(
          size.width * 0.9139769,
          size.height * 0.4149072,
          size.width * 0.9143550,
          size.height * 0.4155065,
          size.width * 0.9124805,
          size.height * 0.4157017)
      ..cubicTo(
          size.width * 0.9056147,
          size.height * 0.4164158,
          size.width * 0.8683146,
          size.height * 0.4005017,
          size.width * 0.8506566,
          size.height * 0.3893244)
      ..cubicTo(
          size.width * 0.8278745,
          size.height * 0.3749052,
          size.width * 0.8176364,
          size.height * 0.3635450,
          size.width * 0.8116508,
          size.height * 0.3460481)
      ..close();
  }

  Path leftExtensorCapriUlnaris(Size size) {
    return Path()
      ..moveTo(size.width * 0.2215007, size.height * 0.3357031)
      ..cubicTo(
          size.width * 0.2324242,
          size.height * 0.3356646,
          size.width * 0.2400000,
          size.height * 0.3342742,
          size.width * 0.2467532,
          size.height * 0.3310674)
      ..cubicTo(
          size.width * 0.2521789,
          size.height * 0.3284914,
          size.width * 0.2539726,
          size.height * 0.3287567,
          size.width * 0.2539394,
          size.height * 0.3321306)
      ..cubicTo(
          size.width * 0.2538514,
          size.height * 0.3411732,
          size.width * 0.2475786,
          size.height * 0.3519141,
          size.width * 0.2374372,
          size.height * 0.3603904)
      ..cubicTo(
          size.width * 0.2280000,
          size.height * 0.3682777,
          size.width * 0.2175815,
          size.height * 0.3740550,
          size.width * 0.1846003,
          size.height * 0.3896907)
      ..cubicTo(
          size.width * 0.1532193,
          size.height * 0.4045677,
          size.width * 0.1385584,
          size.height * 0.4131107,
          size.width * 0.1232165,
          size.height * 0.4254598)
      ..cubicTo(
          size.width * 0.1161429,
          size.height * 0.4311533,
          size.width * 0.1138990,
          size.height * 0.4324289,
          size.width * 0.1098297,
          size.height * 0.4330729)
      ..cubicTo(
          size.width * 0.1031313,
          size.height * 0.4341326,
          size.width * 0.09149784,
          size.height * 0.4333574,
          size.width * 0.08567244,
          size.height * 0.4314639)
      ..cubicTo(
          size.width * 0.07705628,
          size.height * 0.4286625,
          size.width * 0.07692929,
          size.height * 0.4287656,
          size.width * 0.09956710,
          size.height * 0.4200962)
      ..cubicTo(
          size.width * 0.1530000,
          size.height * 0.3996344,
          size.width * 0.1858701,
          size.height * 0.3791203,
          size.width * 0.1962771,
          size.height * 0.3597388)
      ..cubicTo(
          size.width * 0.1991861,
          size.height * 0.3543230,
          size.width * 0.2034632,
          size.height * 0.3405856,
          size.width * 0.2034632,
          size.height * 0.3366598)
      ..cubicTo(
          size.width * 0.2034632,
          size.height * 0.3346832,
          size.width * 0.2036970,
          size.height * 0.3345938,
          size.width * 0.2074315,
          size.height * 0.3351491)
      ..cubicTo(
          size.width * 0.2096133,
          size.height * 0.3354735,
          size.width * 0.2159452,
          size.height * 0.3357230,
          size.width * 0.2215007,
          size.height * 0.3357031)
      ..close();
  }

  Path rightExtensorCapriUlnaris(Size size) {
    return Path()
      ..moveTo(size.width * 0.7611270, size.height * 0.3579203)
      ..cubicTo(
          size.width * 0.7534329,
          size.height * 0.3508619,
          size.width * 0.7493882,
          size.height * 0.3438955,
          size.width * 0.7480375,
          size.height * 0.3353759)
      ..cubicTo(
          size.width * 0.7469553,
          size.height * 0.3285423,
          size.width * 0.7476465,
          size.height * 0.3280577,
          size.width * 0.7542540,
          size.height * 0.3310247)
      ..cubicTo(
          size.width * 0.7564776,
          size.height * 0.3320227,
          size.width * 0.7617605,
          size.height * 0.3336034,
          size.width * 0.7659928,
          size.height * 0.3345375)
      ..cubicTo(
          size.width * 0.7724098,
          size.height * 0.3359533,
          size.width * 0.7751659,
          size.height * 0.3361766,
          size.width * 0.7825873,
          size.height * 0.3358832)
      ..cubicTo(
          size.width * 0.7874820,
          size.height * 0.3356893,
          size.width * 0.7928355,
          size.height * 0.3353237,
          size.width * 0.7944848,
          size.height * 0.3350701)
      ..cubicTo(
          size.width * 0.7973550,
          size.height * 0.3346296,
          size.width * 0.7975584,
          size.height * 0.3349773,
          size.width * 0.7992165,
          size.height * 0.3431196)
      ..cubicTo(
          size.width * 0.8042294,
          size.height * 0.3677464,
          size.width * 0.8206349,
          size.height * 0.3832935,
          size.width * 0.8628918,
          size.height * 0.4034674)
      ..cubicTo(
          size.width * 0.8728254,
          size.height * 0.4082089,
          size.width * 0.8867965,
          size.height * 0.4143814,
          size.width * 0.8939394,
          size.height * 0.4171828)
      ..cubicTo(
          size.width * 0.9010823,
          size.height * 0.4199842,
          size.width * 0.9103752,
          size.height * 0.4236447,
          size.width * 0.9145916,
          size.height * 0.4253168)
      ..lineTo(size.width * 0.9222569, size.height * 0.4283581)
      ..lineTo(size.width * 0.9182814, size.height * 0.4303347)
      ..cubicTo(
          size.width * 0.9121717,
          size.height * 0.4333718,
          size.width * 0.9001890,
          size.height * 0.4345230,
          size.width * 0.8908398,
          size.height * 0.4329711)
      ..cubicTo(
          size.width * 0.8876205,
          size.height * 0.4324364,
          size.width * 0.8846797,
          size.height * 0.4307265,
          size.width * 0.8787273,
          size.height * 0.4259265)
      ..cubicTo(
          size.width * 0.8630332,
          size.height * 0.4132735,
          size.width * 0.8468211,
          size.height * 0.4038557,
          size.width * 0.8139784,
          size.height * 0.3883162)
      ..cubicTo(
          size.width * 0.7801789,
          size.height * 0.3723237,
          size.width * 0.7711934,
          size.height * 0.3671553,
          size.width * 0.7611270,
          size.height * 0.3579203)
      ..close();
  }

  Path leftBiceps(Size size) {
    return Path()
      ..moveTo(size.width * 0.2582973, size.height * 0.2484522)
      ..cubicTo(
          size.width * 0.2726248,
          size.height * 0.2429292,
          size.width * 0.2778268,
          size.height * 0.2412234,
          size.width * 0.2825267,
          size.height * 0.2405079)
      ..cubicTo(
          size.width * 0.2874791,
          size.height * 0.2397540,
          size.width * 0.2957100,
          size.height * 0.2401223,
          size.width * 0.3010563,
          size.height * 0.2413381)
      ..cubicTo(
          size.width * 0.3074012,
          size.height * 0.2427808,
          size.width * 0.3073276,
          size.height * 0.2467711,
          size.width * 0.3007475,
          size.height * 0.2579478)
      ..cubicTo(
          size.width * 0.2966061,
          size.height * 0.2649821,
          size.width * 0.2951631,
          size.height * 0.2689333,
          size.width * 0.2943016,
          size.height * 0.2756014)
      ..cubicTo(
          size.width * 0.2930043,
          size.height * 0.2856543,
          size.width * 0.2898499,
          size.height * 0.2911230,
          size.width * 0.2803939,
          size.height * 0.2997210)
      ..cubicTo(
          size.width * 0.2689134,
          size.height * 0.3101574,
          size.width * 0.2496017,
          size.height * 0.3208914,
          size.width * 0.2324488,
          size.height * 0.3263711)
      ..cubicTo(
          size.width * 0.2186898,
          size.height * 0.3307656,
          size.width * 0.2062814,
          size.height * 0.3295265,
          size.width * 0.2000808,
          size.height * 0.3231381)
      ..cubicTo(
          size.width * 0.1973059,
          size.height * 0.3202777,
          size.width * 0.1969856,
          size.height * 0.3188186,
          size.width * 0.1971154,
          size.height * 0.3096220)
      ..cubicTo(
          size.width * 0.1972439,
          size.height * 0.3004509,
          size.width * 0.1977460,
          size.height * 0.2984399,
          size.width * 0.2016566,
          size.height * 0.2914089)
      ..cubicTo(
          size.width * 0.2121847,
          size.height * 0.2724818,
          size.width * 0.2253564,
          size.height * 0.2603918,
          size.width * 0.2417027,
          size.height * 0.2546509)
      ..cubicTo(
          size.width * 0.2448773,
          size.height * 0.2535361,
          size.width * 0.2523449,
          size.height * 0.2507464,
          size.width * 0.2582973,
          size.height * 0.2484522)
      ..close();
  }

  Path rightBiceps(Size size) {
    return Path()
      ..moveTo(size.width * 0.7005094, size.height * 0.2600825)
      ..cubicTo(
          size.width * 0.6919639,
          size.height * 0.2452605,
          size.width * 0.6920188,
          size.height * 0.2427876,
          size.width * 0.7009250,
          size.height * 0.2409677)
      ..cubicTo(
          size.width * 0.7075498,
          size.height * 0.2396144,
          size.width * 0.7171501,
          size.height * 0.2400021,
          size.width * 0.7238889,
          size.height * 0.2418962)
      ..cubicTo(
          size.width * 0.7265108,
          size.height * 0.2426330,
          size.width * 0.7337013,
          size.height * 0.2452069,
          size.width * 0.7398687,
          size.height * 0.2476165)
      ..cubicTo(
          size.width * 0.7460361,
          size.height * 0.2500261,
          size.width * 0.7541717,
          size.height * 0.2529945,
          size.width * 0.7579481,
          size.height * 0.2542144)
      ..cubicTo(
          size.width * 0.7785671,
          size.height * 0.2608715,
          size.width * 0.7990404,
          size.height * 0.2837869,
          size.width * 0.8035859,
          size.height * 0.3052948)
      ..cubicTo(
          size.width * 0.8058773,
          size.height * 0.3161354,
          size.width * 0.8017778,
          size.height * 0.3247931,
          size.width * 0.7930635,
          size.height * 0.3275127)
      ..cubicTo(
          size.width * 0.7832828,
          size.height * 0.3305649,
          size.width * 0.7727662,
          size.height * 0.3291162,
          size.width * 0.7574329,
          size.height * 0.3226021)
      ..cubicTo(
          size.width * 0.7250779,
          size.height * 0.3088564,
          size.width * 0.7056277,
          size.height * 0.2906199,
          size.width * 0.7056277,
          size.height * 0.2740296)
      ..cubicTo(
          size.width * 0.7056277,
          size.height * 0.2703533,
          size.width * 0.7042237,
          size.height * 0.2665258,
          size.width * 0.7005094,
          size.height * 0.2600825)
      ..close();
  }

  Path leftPectoralisMajor(Size size) {
    return Path()
      ..moveTo(size.width * 0.3506494, size.height * 0.1868735)
      ..cubicTo(
          size.width * 0.3630058,
          size.height * 0.1808763,
          size.width * 0.3739149,
          size.height * 0.1773278,
          size.width * 0.3861602,
          size.height * 0.1753216)
      ..cubicTo(
          size.width * 0.3908355,
          size.height * 0.1745560,
          size.width * 0.3973506,
          size.height * 0.1739189,
          size.width * 0.4006378,
          size.height * 0.1739058)
      ..cubicTo(
          size.width * 0.4099740,
          size.height * 0.1738701,
          size.width * 0.4569019,
          size.height * 0.1800969,
          size.width * 0.4749336,
          size.height * 0.1837636)
      ..cubicTo(
          size.width * 0.4826436,
          size.height * 0.1853313,
          size.width * 0.4892367,
          size.height * 0.1882337,
          size.width * 0.4922367,
          size.height * 0.1913808)
      ..cubicTo(
          size.width * 0.4946710,
          size.height * 0.1939326,
          size.width * 0.4948889,
          size.height * 0.1965072,
          size.width * 0.4949177,
          size.height * 0.2230997)
      ..lineTo(size.width * 0.4949495, size.height * 0.2520405)
      ..lineTo(size.width * 0.4743867, size.height * 0.2525100)
      ..cubicTo(
          size.width * 0.4516248,
          size.height * 0.2530289,
          size.width * 0.4251804,
          size.height * 0.2544192,
          size.width * 0.4078817,
          size.height * 0.2560069)
      ..cubicTo(
          size.width * 0.3749784,
          size.height * 0.2590261,
          size.width * 0.3518701,
          size.height * 0.2551464,
          size.width * 0.3339278,
          size.height * 0.2435911)
      ..cubicTo(
          size.width * 0.3296869,
          size.height * 0.2408598,
          size.width * 0.3245180,
          size.height * 0.2379883,
          size.width * 0.3224401,
          size.height * 0.2372096)
      ..cubicTo(
          size.width * 0.3174113,
          size.height * 0.2353258,
          size.width * 0.3055180,
          size.height * 0.2332667,
          size.width * 0.2961760,
          size.height * 0.2326632)
      ..cubicTo(
          size.width * 0.2920101,
          size.height * 0.2323938,
          size.width * 0.2886003,
          size.height * 0.2319038,
          size.width * 0.2886003,
          size.height * 0.2315746)
      ..cubicTo(
          size.width * 0.2886003,
          size.height * 0.2312447,
          size.width * 0.2928312,
          size.height * 0.2278997,
          size.width * 0.2980029,
          size.height * 0.2241409)
      ..cubicTo(
          size.width * 0.3031732,
          size.height * 0.2203814,
          size.width * 0.3117922,
          size.height * 0.2135670,
          size.width * 0.3171558,
          size.height * 0.2089973)
      ..cubicTo(
          size.width * 0.3295397,
          size.height * 0.1984460,
          size.width * 0.3371140,
          size.height * 0.1934433,
          size.width * 0.3506494,
          size.height * 0.1868735)
      ..close();
  }

  Path rightPectoralisMajor(Size size) {
    return Path()
      ..moveTo(size.width * 0.5265094, size.height * 0.1837636)
      ..cubicTo(
          size.width * 0.5347287,
          size.height * 0.1820921,
          size.width * 0.5605123,
          size.height * 0.1781533,
          size.width * 0.5779221,
          size.height * 0.1759107)
      ..cubicTo(
          size.width * 0.5994560,
          size.height * 0.1731354,
          size.width * 0.6077662,
          size.height * 0.1733863,
          size.width * 0.6243939,
          size.height * 0.1773100)
      ..cubicTo(
          size.width * 0.6338600,
          size.height * 0.1795443,
          size.width * 0.6392900,
          size.height * 0.1814598,
          size.width * 0.6484675,
          size.height * 0.1858021)
      ..cubicTo(
          size.width * 0.6627475,
          size.height * 0.1925588,
          size.width * 0.6698672,
          size.height * 0.1972440,
          size.width * 0.6857374,
          size.height * 0.2103237)
      ..cubicTo(
          size.width * 0.6923766,
          size.height * 0.2157973,
          size.width * 0.7011919,
          size.height * 0.2226577,
          size.width * 0.7053261,
          size.height * 0.2255704)
      ..cubicTo(
          size.width * 0.7094603,
          size.height * 0.2284832,
          size.width * 0.7128427,
          size.height * 0.2311436,
          size.width * 0.7128427,
          size.height * 0.2314832)
      ..cubicTo(
          size.width * 0.7128427,
          size.height * 0.2318234,
          size.width * 0.7082655,
          size.height * 0.2324612,
          size.width * 0.7026724,
          size.height * 0.2329010)
      ..cubicTo(
          size.width * 0.6923131,
          size.height * 0.2337155,
          size.width * 0.6826883,
          size.height * 0.2355306,
          size.width * 0.6774762,
          size.height * 0.2376515)
      ..cubicTo(
          size.width * 0.6758817,
          size.height * 0.2383003,
          size.width * 0.6715123,
          size.height * 0.2408880,
          size.width * 0.6677662,
          size.height * 0.2434014)
      ..cubicTo(
          size.width * 0.6507446,
          size.height * 0.2548247,
          size.width * 0.6266825,
          size.height * 0.2589746,
          size.width * 0.5942684,
          size.height * 0.2560770)
      ..cubicTo(
          size.width * 0.5754242,
          size.height * 0.2543924,
          size.width * 0.5500043,
          size.height * 0.2530460,
          size.width * 0.5270563,
          size.height * 0.2525155)
      ..lineTo(size.width * 0.5064935, size.height * 0.2520405)
      ..lineTo(size.width * 0.5064935, size.height * 0.2229003)
      ..cubicTo(
          size.width * 0.5064935,
          size.height * 0.1953340,
          size.width * 0.5066465,
          size.height * 0.1936172,
          size.width * 0.5093160,
          size.height * 0.1911244)
      ..cubicTo(
          size.width * 0.5126061,
          size.height * 0.1880522,
          size.width * 0.5191082,
          size.height * 0.1852687,
          size.width * 0.5265094,
          size.height * 0.1837636)
      ..close();
  }

  Path leftDeltoid(Size size) {
    return Path()
      ..moveTo(size.width * 0.2315931, size.height * 0.2110158)
      ..cubicTo(
          size.width * 0.2402395,
          size.height * 0.1876137,
          size.width * 0.2694040,
          size.height * 0.1706460,
          size.width * 0.3078167,
          size.height * 0.1666687)
      ..cubicTo(
          size.width * 0.3200159,
          size.height * 0.1654055,
          size.width * 0.3341919,
          size.height * 0.1654254,
          size.width * 0.3474632,
          size.height * 0.1667237)
      ..cubicTo(
          size.width * 0.3597937,
          size.height * 0.1679299,
          size.width * 0.3740144,
          size.height * 0.1704151,
          size.width * 0.3746652,
          size.height * 0.1714777)
      ..cubicTo(
          size.width * 0.3748975,
          size.height * 0.1718557,
          size.width * 0.3711183,
          size.height * 0.1732474,
          size.width * 0.3662670,
          size.height * 0.1745704)
      ..cubicTo(
          size.width * 0.3438312,
          size.height * 0.1806893,
          size.width * 0.3196320,
          size.height * 0.1946646,
          size.width * 0.2972857,
          size.height * 0.2144089)
      ..cubicTo(
          size.width * 0.2859971,
          size.height * 0.2243828,
          size.width * 0.2776205,
          size.height * 0.2299141,
          size.width * 0.2633680,
          size.height * 0.2368034)
      ..cubicTo(
          size.width * 0.2509062,
          size.height * 0.2428268,
          size.width * 0.2357157,
          size.height * 0.2485808,
          size.width * 0.2341919,
          size.height * 0.2478543)
      ..cubicTo(
          size.width * 0.2297417,
          size.height * 0.2457347,
          size.width * 0.2279812,
          size.height * 0.2207883,
          size.width * 0.2315931,
          size.height * 0.2110158)
      ..close();
  }

  Path rightDeltoid(Size size) {
    return Path()
      ..moveTo(size.width * 0.6254488, size.height * 0.1717498)
      ..cubicTo(
          size.width * 0.6240808,
          size.height * 0.1706955,
          size.width * 0.6412843,
          size.height * 0.1677615,
          size.width * 0.6587302,
          size.height * 0.1660742)
      ..cubicTo(
          size.width * 0.6654560,
          size.height * 0.1654241,
          size.width * 0.6825455,
          size.height * 0.1657326,
          size.width * 0.6919192,
          size.height * 0.1666742)
      ..cubicTo(
          size.width * 0.7313362,
          size.height * 0.1706330,
          size.width * 0.7613506,
          size.height * 0.1885237,
          size.width * 0.7691602,
          size.height * 0.2127148)
      ..cubicTo(
          size.width * 0.7724473,
          size.height * 0.2228948,
          size.width * 0.7705238,
          size.height * 0.2455904,
          size.width * 0.7661962,
          size.height * 0.2477003)
      ..cubicTo(
          size.width * 0.7648110,
          size.height * 0.2483766,
          size.width * 0.7544820,
          size.height * 0.2448887,
          size.width * 0.7420447,
          size.height * 0.2395450)
      ..cubicTo(
          size.width * 0.7307244,
          size.height * 0.2346818,
          size.width * 0.7165743,
          size.height * 0.2259533,
          size.width * 0.7074646,
          size.height * 0.2182131)
      ..cubicTo(
          size.width * 0.7030144,
          size.height * 0.2144330,
          size.width * 0.6961530,
          size.height * 0.2087574,
          size.width * 0.6922165,
          size.height * 0.2056014)
      ..cubicTo(
          size.width * 0.6752554,
          size.height * 0.1920041,
          size.width * 0.6510880,
          size.height * 0.1790502,
          size.width * 0.6342208,
          size.height * 0.1745162)
      ..cubicTo(
          size.width * 0.6298442,
          size.height * 0.1733402,
          size.width * 0.6258961,
          size.height * 0.1720948,
          size.width * 0.6254488,
          size.height * 0.1717498)
      ..close();
  }

  Path leftTrapezius(Size size) {
    return Path()
      ..moveTo(size.width * 0.3748730, size.height * 0.1524564)
      ..cubicTo(
          size.width * 0.3921053,
          size.height * 0.1484206,
          size.width * 0.4130231,
          size.height * 0.1429464,
          size.width * 0.4213564,
          size.height * 0.1402921)
      ..cubicTo(
          size.width * 0.4296898,
          size.height * 0.1376371,
          size.width * 0.4369654,
          size.height * 0.1354495,
          size.width * 0.4375253,
          size.height * 0.1354302)
      ..cubicTo(
          size.width * 0.4380837,
          size.height * 0.1354110,
          size.width * 0.4389610,
          size.height * 0.1365553,
          size.width * 0.4394733,
          size.height * 0.1379725)
      ..cubicTo(
          size.width * 0.4423983,
          size.height * 0.1460564,
          size.width * 0.4450851,
          size.height * 0.1512172,
          size.width * 0.4496595,
          size.height * 0.1575326)
      ..cubicTo(
          size.width * 0.4588240,
          size.height * 0.1701897,
          size.width * 0.4583405,
          size.height * 0.1689450,
          size.width * 0.4547547,
          size.height * 0.1706474)
      ..cubicTo(
          size.width * 0.4519264,
          size.height * 0.1719897,
          size.width * 0.4501890,
          size.height * 0.1721512,
          size.width * 0.4397027,
          size.height * 0.1720467)
      ..cubicTo(
          size.width * 0.4276046,
          size.height * 0.1719258,
          size.width * 0.4256176,
          size.height * 0.1717010,
          size.width * 0.3751804,
          size.height * 0.1647567)
      ..cubicTo(
          size.width * 0.3628788,
          size.height * 0.1630625,
          size.width * 0.3507042,
          size.height * 0.1614605,
          size.width * 0.3481241,
          size.height * 0.1611966)
      ..cubicTo(
          size.width * 0.3455440,
          size.height * 0.1609320,
          size.width * 0.3434589,
          size.height * 0.1605079,
          size.width * 0.3434877,
          size.height * 0.1602550)
      ..cubicTo(
          size.width * 0.3435166,
          size.height * 0.1600014,
          size.width * 0.3576392,
          size.height * 0.1564921,
          size.width * 0.3748730,
          size.height * 0.1524564)
      ..close();
  }

  Path rightTrapezius(Size size) {
    return Path()
      ..moveTo(size.width * 0.5502208, size.height * 0.1592880)
      ..cubicTo(
          size.width * 0.5564820,
          size.height * 0.1502735,
          size.width * 0.5595440,
          size.height * 0.1447189,
          size.width * 0.5619740,
          size.height * 0.1379725)
      ..cubicTo(
          size.width * 0.5624834,
          size.height * 0.1365553,
          size.width * 0.5634286,
          size.height * 0.1353952,
          size.width * 0.5640722,
          size.height * 0.1353952)
      ..cubicTo(
          size.width * 0.5647143,
          size.height * 0.1353952,
          size.width * 0.5683925,
          size.height * 0.1365416,
          size.width * 0.5722453,
          size.height * 0.1379423)
      ..cubicTo(
          size.width * 0.5820476,
          size.height * 0.1415072,
          size.width * 0.6086883,
          size.height * 0.1485601,
          size.width * 0.6353160,
          size.height * 0.1546392)
      ..cubicTo(
          size.width * 0.6477330,
          size.height * 0.1574742,
          size.width * 0.6579177,
          size.height * 0.1600014,
          size.width * 0.6579509,
          size.height * 0.1602550)
      ..cubicTo(
          size.width * 0.6579827,
          size.height * 0.1605079,
          size.width * 0.6558990,
          size.height * 0.1609320,
          size.width * 0.6533189,
          size.height * 0.1611966)
      ..cubicTo(
          size.width * 0.6507388,
          size.height * 0.1614605,
          size.width * 0.6385642,
          size.height * 0.1630515,
          size.width * 0.6262626,
          size.height * 0.1647306)
      ..cubicTo(
          size.width * 0.5758312,
          size.height * 0.1716165,
          size.width * 0.5723434,
          size.height * 0.1720096,
          size.width * 0.5610144,
          size.height * 0.1720880)
      ..cubicTo(
          size.width * 0.5512915,
          size.height * 0.1721553,
          size.width * 0.5494690,
          size.height * 0.1719704,
          size.width * 0.5466450,
          size.height * 0.1706282)
      ..lineTo(size.width * 0.5434113, size.height * 0.1690914)
      ..lineTo(size.width * 0.5502208, size.height * 0.1592880)
      ..close();
  }

  Path sternocleidomastoid(Size size) {
    return Path()
      ..moveTo(size.width * 0.4458874, size.height * 0.1289512)
      ..cubicTo(
          size.width * 0.4458874,
          size.height * 0.1321354,
          size.width * 0.4537244,
          size.height * 0.1477890,
          size.width * 0.4589278,
          size.height * 0.1549973)
      ..cubicTo(
          size.width * 0.4672641,
          size.height * 0.1665464,
          size.width * 0.4764329,
          size.height * 0.1746117,
          size.width * 0.4872035,
          size.height * 0.1798715)
      ..cubicTo(
          size.width * 0.4989163,
          size.height * 0.1855918,
          size.width * 0.5010722,
          size.height * 0.1855904,
          size.width * 0.5128903,
          size.height * 0.1798495)
      ..cubicTo(
          size.width * 0.5238817,
          size.height * 0.1745107,
          size.width * 0.5345368,
          size.height * 0.1650034,
          size.width * 0.5425180,
          size.height * 0.1534144)
      ..cubicTo(
          size.width * 0.5487792,
          size.height * 0.1443216,
          size.width * 0.5545657,
          size.height * 0.1322371,
          size.width * 0.5538600,
          size.height * 0.1297216)
      ..cubicTo(
          size.width * 0.5534343,
          size.height * 0.1282007,
          size.width * 0.5524257,
          size.height * 0.1285375,
          size.width * 0.5429019,
          size.height * 0.1333801)
      ..cubicTo(
          size.width * 0.5312742,
          size.height * 0.1392942,
          size.width * 0.5316854,
          size.height * 0.1387828,
          size.width * 0.5253290,
          size.height * 0.1552344)
      ..cubicTo(
          size.width * 0.5236681,
          size.height * 0.1595306,
          size.width * 0.5203752,
          size.height * 0.1652522,
          size.width * 0.5180101,
          size.height * 0.1679491)
      ..cubicTo(
          size.width * 0.5132742,
          size.height * 0.1733491,
          size.width * 0.5041053,
          size.height * 0.1795945,
          size.width * 0.5004185,
          size.height * 0.1799326)
      ..cubicTo(
          size.width * 0.4969221,
          size.height * 0.1802529,
          size.width * 0.4867258,
          size.height * 0.1734199,
          size.width * 0.4819408,
          size.height * 0.1675505)
      ..cubicTo(
          size.width * 0.4796955,
          size.height * 0.1647966,
          size.width * 0.4765022,
          size.height * 0.1589863,
          size.width * 0.4748456,
          size.height * 0.1546392)
      ..cubicTo(
          size.width * 0.4687778,
          size.height * 0.1387251,
          size.width * 0.4696811,
          size.height * 0.1398674,
          size.width * 0.4587345,
          size.height * 0.1342447)
      ..cubicTo(
          size.width * 0.4532554,
          size.height * 0.1314302,
          size.width * 0.4487734,
          size.height * 0.1288371,
          size.width * 0.4487734,
          size.height * 0.1284818)
      ..cubicTo(
          size.width * 0.4487734,
          size.height * 0.1281258,
          size.width * 0.4481241,
          size.height * 0.1278351,
          size.width * 0.4473304,
          size.height * 0.1278351)
      ..cubicTo(
          size.width * 0.4465368,
          size.height * 0.1278351,
          size.width * 0.4458874,
          size.height * 0.1283375,
          size.width * 0.4458874,
          size.height * 0.1289512)
      ..close();
  }
}
