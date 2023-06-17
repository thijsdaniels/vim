import 'package:flutter/material.dart';
import 'package:vim/widgets/atoms/muscle_map/muscle_map_painter.dart';

class MuscleMapBackPainter extends MuscleMapPainter {
  MuscleMapBackPainter({
    super.muscles,
    super.activeColor,
    super.inactiveColor,
  });

  @override
  void paintSilhouette(Canvas canvas, Size size, Paint paint) {
    canvas.drawPath(silhouette(size), paint);
  }

  @override
  void paintTraps(Canvas canvas, Size size, Paint paint) {
    canvas.drawPath(path1(size), paint);
    canvas.drawPath(path2(size), paint);
  }

  @override
  void paintShoulders(Canvas canvas, Size size, Paint paint) {
    canvas.drawPath(path3(size), paint);
    canvas.drawPath(path4(size), paint);
  }

  @override
  void paintLats(Canvas canvas, Size size, Paint paint) {
    canvas.drawPath(path5(size), paint);
    canvas.drawPath(path6(size), paint);
    canvas.drawPath(path7(size), paint);
    canvas.drawPath(path8(size), paint);
  }

  @override
  void paintTripceps(Canvas canvas, Size size, Paint paint) {
    canvas.drawPath(path9(size), paint);
    canvas.drawPath(path10(size), paint);
    canvas.drawPath(path11(size), paint);
    canvas.drawPath(path12(size), paint);
  }

  @override
  void paintForearms(Canvas canvas, Size size, Paint paint) {
    canvas.drawPath(path13(size), paint);
    canvas.drawPath(path14(size), paint);
    canvas.drawPath(path15(size), paint);
    canvas.drawPath(path16(size), paint);
  }

  @override
  void paintLowerBack(Canvas canvas, Size size, Paint paint) {
    canvas.drawPath(path17(size), paint);
    canvas.drawPath(path18(size), paint);
  }

  @override
  void paintObliques(Canvas canvas, Size size, Paint paint) {
    canvas.drawPath(path19(size), paint);
    canvas.drawPath(path20(size), paint);
  }

  @override
  void paintGlutes(Canvas canvas, Size size, Paint paint) {
    canvas.drawPath(path21(size), paint);
    canvas.drawPath(path22(size), paint);
  }

  @override
  void paintAbductors(Canvas canvas, Size size, Paint paint) {
    canvas.drawPath(path23(size), paint);
    canvas.drawPath(path24(size), paint);
  }

  @override
  void paintHamstrings(Canvas canvas, Size size, Paint paint) {
    canvas.drawPath(path25(size), paint);
    canvas.drawPath(path26(size), paint);
    canvas.drawPath(path27(size), paint);
    canvas.drawPath(path28(size), paint);
    canvas.drawPath(path29(size), paint);
    canvas.drawPath(path30(size), paint);
    canvas.drawPath(path31(size), paint);
    canvas.drawPath(path32(size), paint);
  }

  @override
  void paintCalves(Canvas canvas, Size size, Paint paint) {
    canvas.drawPath(path33(size), paint);
    canvas.drawPath(path34(size), paint);
    canvas.drawPath(path35(size), paint);
    canvas.drawPath(path36(size), paint);
    canvas.drawPath(path37(size), paint);
    canvas.drawPath(path38(size), paint);
  }

  Path silhouette(Size size) {
    return Path()
      ..moveTo(size.width * 0.4803530, size.height * 0.0009787380)
      ..cubicTo(
          size.width * 0.4588646,
          size.height * 0.003314129,
          size.width * 0.4418674,
          size.height * 0.007816187,
          size.width * 0.4257896,
          size.height * 0.01543210)
      ..cubicTo(
          size.width * 0.4175432,
          size.height * 0.01933813,
          size.width * 0.4127594,
          size.height * 0.02230247,
          size.width * 0.4091916,
          size.height * 0.02572016)
      ..cubicTo(
          size.width * 0.4041902,
          size.height * 0.03051029,
          size.width * 0.4041787,
          size.height * 0.03054458,
          size.width * 0.4039683,
          size.height * 0.04068793)
      ..cubicTo(
          size.width * 0.4037695,
          size.height * 0.05029012,
          size.width * 0.4035303,
          size.height * 0.05108916,
          size.width * 0.3996729,
          size.height * 0.05509122)
      ..cubicTo(
          size.width * 0.3961037,
          size.height * 0.05879355,
          size.width * 0.3955879,
          size.height * 0.06014952,
          size.width * 0.3955764,
          size.height * 0.06584362)
      ..cubicTo(
          size.width * 0.3955648,
          size.height * 0.07153567,
          size.width * 0.3960533,
          size.height * 0.07283608,
          size.width * 0.3994452,
          size.height * 0.07613169)
      ..cubicTo(
          size.width * 0.4015807,
          size.height * 0.07820645,
          size.width * 0.4066254,
          size.height * 0.08163786,
          size.width * 0.4106571,
          size.height * 0.08375720)
      ..cubicTo(
          size.width * 0.4181282,
          size.height * 0.08768519,
          size.width * 0.4191729,
          size.height * 0.08874623,
          size.width * 0.4305029,
          size.height * 0.1039095)
      ..cubicTo(
          size.width * 0.4399654,
          size.height * 0.1165741,
          size.width * 0.4383847,
          size.height * 0.1252085,
          size.width * 0.4253948,
          size.height * 0.1318189)
      ..cubicTo(
          size.width * 0.4131383,
          size.height * 0.1380556,
          size.width * 0.3953617,
          size.height * 0.1425514,
          size.width * 0.3285303,
          size.height * 0.1563176)
      ..cubicTo(
          size.width * 0.3035663,
          size.height * 0.1614595,
          size.width * 0.2792507,
          size.height * 0.1668916,
          size.width * 0.2744957,
          size.height * 0.1683882)
      ..cubicTo(
          size.width * 0.2510159,
          size.height * 0.1757785,
          size.width * 0.2341167,
          size.height * 0.1876680,
          size.width * 0.2262219,
          size.height * 0.2023505)
      ..cubicTo(
          size.width * 0.2199856,
          size.height * 0.2139465,
          size.width * 0.2189164,
          size.height * 0.2317174,
          size.width * 0.2234553,
          size.height * 0.2482853)
      ..lineTo(size.width * 0.2252406, size.height * 0.2548011)
      ..lineTo(size.width * 0.2154654, size.height * 0.2618841)
      ..cubicTo(
          size.width * 0.1991801,
          size.height * 0.2736859,
          size.width * 0.1911686,
          size.height * 0.2844712,
          size.width * 0.1864582,
          size.height * 0.3009369)
      ..lineTo(size.width * 0.1839597, size.height * 0.3096708)
      ..lineTo(size.width * 0.1780850, size.height * 0.3120713)
      ..cubicTo(
          size.width * 0.1671499,
          size.height * 0.3165398,
          size.width * 0.1487738,
          size.height * 0.3257064,
          size.width * 0.1413646,
          size.height * 0.3303896)
      ..cubicTo(
          size.width * 0.1274971,
          size.height * 0.3391536,
          size.width * 0.1222565,
          size.height * 0.3450953,
          size.width * 0.1124568,
          size.height * 0.3631687)
      ..cubicTo(
          size.width * 0.09878818,
          size.height * 0.3883724,
          size.width * 0.09252161,
          size.height * 0.3969115,
          size.width * 0.07588617,
          size.height * 0.4129993)
      ..cubicTo(
          size.width * 0.06154899,
          size.height * 0.4268656,
          size.width * 0.06110231,
          size.height * 0.4271968,
          size.width * 0.05475504,
          size.height * 0.4286749)
      ..cubicTo(
          size.width * 0.04576369,
          size.height * 0.4307682,
          size.width * 0.02519452,
          size.height * 0.4371996,
          size.width * 0.01670749,
          size.height * 0.4405713)
      ..cubicTo(
          size.width * 0.002616700,
          size.height * 0.4461680,
          size.width * -0.002249308,
          size.height * 0.4515583,
          size.width * 0.004256455,
          size.height * 0.4543615)
      ..cubicTo(
          size.width * 0.007697378,
          size.height * 0.4558436,
          size.width * 0.01247837,
          size.height * 0.4552167,
          size.width * 0.02231700,
          size.height * 0.4519945)
      ..cubicTo(
          size.width * 0.02589337,
          size.height * 0.4508237,
          size.width * 0.02881844,
          size.height * 0.4501358,
          size.width * 0.02881844,
          size.height * 0.4504664)
      ..cubicTo(
          size.width * 0.02881844,
          size.height * 0.4512867,
          size.width * 0.02280692,
          size.height * 0.4582394,
          size.width * 0.01744524,
          size.height * 0.4636193)
      ..cubicTo(
          size.width * 0.01110660,
          size.height * 0.4699808,
          size.width * 0.008002853,
          size.height * 0.4771111,
          size.width * 0.01002014,
          size.height * 0.4806783)
      ..cubicTo(
          size.width * 0.01439334,
          size.height * 0.4884095,
          size.width * 0.02942651,
          size.height * 0.4917695,
          size.width * 0.05963833,
          size.height * 0.4917695)
      ..cubicTo(
          size.width * 0.07324928,
          size.height * 0.4917695,
          size.width * 0.07516715,
          size.height * 0.4916008,
          size.width * 0.08298271,
          size.height * 0.4897174)
      ..cubicTo(
          size.width * 0.09326225,
          size.height * 0.4872401,
          size.width * 0.09713401,
          size.height * 0.4847805,
          size.width * 0.1043732,
          size.height * 0.4761324)
      ..cubicTo(
          size.width * 0.1124928,
          size.height * 0.4664314,
          size.width * 0.1167781,
          size.height * 0.4575850,
          size.width * 0.1177291,
          size.height * 0.4485597)
      ..cubicTo(
          size.width * 0.1185130,
          size.height * 0.4411228,
          size.width * 0.1188876,
          size.height * 0.4403587,
          size.width * 0.1242824,
          size.height * 0.4351852)
      ..cubicTo(
          size.width * 0.1411729,
          size.height * 0.4189883,
          size.width * 0.1567565,
          size.height * 0.4094801,
          size.width * 0.1995922,
          size.height * 0.3892318)
      ..cubicTo(
          size.width * 0.2233141,
          size.height * 0.3780192,
          size.width * 0.2336037,
          size.height * 0.3726303,
          size.width * 0.2396499,
          size.height * 0.3682558)
      ..cubicTo(
          size.width * 0.2546931,
          size.height * 0.3573697,
          size.width * 0.2615187,
          size.height * 0.3476310,
          size.width * 0.2638847,
          size.height * 0.3336763)
      ..cubicTo(
          size.width * 0.2658919,
          size.height * 0.3218505,
          size.width * 0.2656686,
          size.height * 0.3222284,
          size.width * 0.2730749,
          size.height * 0.3180864)
      ..cubicTo(
          size.width * 0.2907219,
          size.height * 0.3082195,
          size.width * 0.2969092,
          size.height * 0.3042373,
          size.width * 0.3010043,
          size.height * 0.3001118)
      ..cubicTo(
          size.width * 0.3034784,
          size.height * 0.2976187,
          size.width * 0.3064035,
          size.height * 0.2956104,
          size.width * 0.3075576,
          size.height * 0.2956104)
      ..cubicTo(
          size.width * 0.3087305,
          size.height * 0.2956104,
          size.width * 0.3133098,
          size.height * 0.2988354,
          size.width * 0.3180072,
          size.height * 0.3029671)
      ..cubicTo(
          size.width * 0.3226066,
          size.height * 0.3070130,
          size.width * 0.3324899,
          size.height * 0.3146523,
          size.width * 0.3399726,
          size.height * 0.3199424)
      ..lineTo(size.width * 0.3535764, size.height * 0.3295610)
      ..lineTo(size.width * 0.3541700, size.height * 0.3356207)
      ..cubicTo(
          size.width * 0.3548948,
          size.height * 0.3430295,
          size.width * 0.3518790,
          size.height * 0.3515754,
          size.width * 0.3442752,
          size.height * 0.3636653)
      ..cubicTo(
          size.width * 0.3346210,
          size.height * 0.3790137,
          size.width * 0.3337133,
          size.height * 0.3871996,
          size.width * 0.3400706,
          size.height * 0.4015775)
      ..cubicTo(
          size.width * 0.3443588,
          size.height * 0.4112764,
          size.width * 0.3452522,
          size.height * 0.4236200,
          size.width * 0.3424006,
          size.height * 0.4338134)
      ..cubicTo(
          size.width * 0.3395231,
          size.height * 0.4441036,
          size.width * 0.3345821,
          size.height * 0.4537394,
          size.width * 0.3200000,
          size.height * 0.4775034)
      ..cubicTo(
          size.width * 0.3032997,
          size.height * 0.5047195,
          size.width * 0.2979121,
          size.height * 0.5157147,
          size.width * 0.2931801,
          size.height * 0.5322359)
      ..cubicTo(
          size.width * 0.2883415,
          size.height * 0.5491351,
          size.width * 0.2890836,
          size.height * 0.5859863,
          size.width * 0.2946988,
          size.height * 0.6075761)
      ..cubicTo(
          size.width * 0.2975807,
          size.height * 0.6186584,
          size.width * 0.3001585,
          size.height * 0.6248978,
          size.width * 0.3083386,
          size.height * 0.6406036)
      ..cubicTo(
          size.width * 0.3183372,
          size.height * 0.6598018,
          size.width * 0.3191686,
          size.height * 0.6623635,
          size.width * 0.3191326,
          size.height * 0.6738683)
      ..cubicTo(
          size.width * 0.3191009,
          size.height * 0.6838553,
          size.width * 0.3188184,
          size.height * 0.6848086,
          size.width * 0.3094553,
          size.height * 0.7064472)
      ..cubicTo(
          size.width * 0.2930893,
          size.height * 0.7442730,
          size.width * 0.2903228,
          size.height * 0.7563443,
          size.width * 0.2914914,
          size.height * 0.7848560)
      ..cubicTo(
          size.width * 0.2926095,
          size.height * 0.8121399,
          size.width * 0.2952046,
          size.height * 0.8202469,
          size.width * 0.3155677,
          size.height * 0.8600823)
      ..cubicTo(
          size.width * 0.3370288,
          size.height * 0.9020645,
          size.width * 0.3430994,
          size.height * 0.9182647,
          size.width * 0.3433199,
          size.height * 0.9341564)
      ..cubicTo(
          size.width * 0.3435000,
          size.height * 0.9472085,
          size.width * 0.3415202,
          size.height * 0.9501646,
          size.width * 0.3295720,
          size.height * 0.9547051)
      ..cubicTo(
          size.width * 0.3205922,
          size.height * 0.9581139,
          size.width * 0.3143919,
          size.height * 0.9597119,
          size.width * 0.2780893,
          size.height * 0.9679698)
      ..cubicTo(
          size.width * 0.2481801,
          size.height * 0.9747737,
          size.width * 0.2372824,
          size.height * 0.9805693,
          size.width * 0.2463213,
          size.height * 0.9848765)
      ..cubicTo(
          size.width * 0.2538501,
          size.height * 0.9884568,
          size.width * 0.2768386,
          size.height * 0.9912483,
          size.width * 0.3112392,
          size.height * 0.9927641)
      ..cubicTo(
          size.width * 0.3275259,
          size.height * 0.9934774,
          size.width * 0.3411916,
          size.height * 0.9945542,
          size.width * 0.3546268,
          size.height * 0.9961660)
      ..cubicTo(
          size.width * 0.3923775,
          size.height * 1.000713,
          size.width * 0.4097637,
          size.height * 1.000768,
          size.width * 0.4202608,
          size.height * 0.9963786)
      ..cubicTo(
          size.width * 0.4309496,
          size.height * 0.9919136,
          size.width * 0.4335173,
          size.height * 0.9865021,
          size.width * 0.4309150,
          size.height * 0.9739369)
      ..cubicTo(
          size.width * 0.4261628,
          size.height * 0.9509877,
          size.width * 0.4249164,
          size.height * 0.9424554,
          size.width * 0.4238055,
          size.height * 0.9252401)
      ..cubicTo(
          size.width * 0.4231369,
          size.height * 0.9148697,
          size.width * 0.4227939,
          size.height * 0.9032922,
          size.width * 0.4230447,
          size.height * 0.8995199)
      ..cubicTo(
          size.width * 0.4232954,
          size.height * 0.8957476,
          size.width * 0.4238602,
          size.height * 0.8864335,
          size.width * 0.4242983,
          size.height * 0.8788203)
      ..cubicTo(
          size.width * 0.4250937,
          size.height * 0.8649931,
          size.width * 0.4250994,
          size.height * 0.8649794,
          size.width * 0.4314697,
          size.height * 0.8544719)
      ..cubicTo(
          size.width * 0.4473775,
          size.height * 0.8282510,
          size.width * 0.4510216,
          size.height * 0.8186145,
          size.width * 0.4520591,
          size.height * 0.8000137)
      ..cubicTo(
          size.width * 0.4531686,
          size.height * 0.7801372,
          size.width * 0.4508746,
          size.height * 0.7706447,
          size.width * 0.4384914,
          size.height * 0.7439026)
      ..cubicTo(
          size.width * 0.4309409,
          size.height * 0.7275995,
          size.width * 0.4305706,
          size.height * 0.7303704,
          size.width * 0.4422291,
          size.height * 0.7159122)
      ..cubicTo(
          size.width * 0.4584856,
          size.height * 0.6957407,
          size.width * 0.4655807,
          size.height * 0.6725158,
          size.width * 0.4712032,
          size.height * 0.6210562)
      ..cubicTo(
          size.width * 0.4720274,
          size.height * 0.6135117,
          size.width * 0.4749424,
          size.height * 0.5983882,
          size.width * 0.4776801,
          size.height * 0.5874486)
      ..cubicTo(
          size.width * 0.4861412,
          size.height * 0.5536406,
          size.width * 0.4885043,
          size.height * 0.5413464,
          size.width * 0.4894524,
          size.height * 0.5262064)
      ..lineTo(size.width * 0.4903660, size.height * 0.5116043)
      ..lineTo(size.width * 0.5005865, size.height * 0.5118032)
      ..lineTo(size.width * 0.5108069, size.height * 0.5120027)
      ..lineTo(size.width * 0.5106239, size.height * 0.5147462)
      ..cubicTo(
          size.width * 0.5098098,
          size.height * 0.5269595,
          size.width * 0.5149841,
          size.height * 0.5570706,
          size.width * 0.5231729,
          size.height * 0.5877881)
      ..cubicTo(
          size.width * 0.5255375,
          size.height * 0.5966550,
          size.width * 0.5280893,
          size.height * 0.6091564,
          size.width * 0.5288458,
          size.height * 0.6155693)
      ..cubicTo(
          size.width * 0.5361138,
          size.height * 0.6772167,
          size.width * 0.5419971,
          size.height * 0.6966529,
          size.width * 0.5599251,
          size.height * 0.7182373)
      ..cubicTo(
          size.width * 0.5643646,
          size.height * 0.7235802,
          size.width * 0.5677233,
          size.height * 0.7287106,
          size.width * 0.5677233,
          size.height * 0.7301440)
      ..cubicTo(
          size.width * 0.5677233,
          size.height * 0.7315295,
          size.width * 0.5651066,
          size.height * 0.7381070,
          size.width * 0.5619107,
          size.height * 0.7447599)
      ..cubicTo(
          size.width * 0.5542536,
          size.height * 0.7606927,
          size.width * 0.5508098,
          size.height * 0.7709671,
          size.width * 0.5487651,
          size.height * 0.7839781)
      ..cubicTo(
          size.width * 0.5453703,
          size.height * 0.8055898,
          size.width * 0.5515807,
          size.height * 0.8265158,
          size.width * 0.5700216,
          size.height * 0.8556241)
      ..cubicTo(
          size.width * 0.5746671,
          size.height * 0.8629561,
          size.width * 0.5753674,
          size.height * 0.8650892,
          size.width * 0.5764424,
          size.height * 0.8751715)
      ..cubicTo(
          size.width * 0.5793026,
          size.height * 0.9020027,
          size.width * 0.5776715,
          size.height * 0.9341701,
          size.width * 0.5720130,
          size.height * 0.9624691)
      ..cubicTo(
          size.width * 0.5675706,
          size.height * 0.9846914,
          size.width * 0.5681427,
          size.height * 0.9893553,
          size.width * 0.5759222,
          size.height * 0.9943416)
      ..cubicTo(
          size.width * 0.5860576,
          size.height * 1.000844,
          size.width * 0.6029856,
          size.height * 1.001207,
          size.width * 0.6484150,
          size.height * 0.9959191)
      ..cubicTo(
          size.width * 0.6617637,
          size.height * 0.9943690,
          size.width * 0.6765461,
          size.height * 0.9931276,
          size.width * 0.6851585,
          size.height * 0.9928464)
      ..cubicTo(
          size.width * 0.7232190,
          size.height * 0.9915912,
          size.width * 0.7494092,
          size.height * 0.9883333,
          size.width * 0.7556686,
          size.height * 0.9840809)
      ..cubicTo(
          size.width * 0.7594798,
          size.height * 0.9814952,
          size.width * 0.7583285,
          size.height * 0.9799863,
          size.width * 0.7494697,
          size.height * 0.9759739)
      ..cubicTo(
          size.width * 0.7410288,
          size.height * 0.9721536,
          size.width * 0.7346340,
          size.height * 0.9704321,
          size.width * 0.7015418,
          size.height * 0.9630933)
      ..cubicTo(
          size.width * 0.6839841,
          size.height * 0.9591975,
          size.width * 0.6710591,
          size.height * 0.9552263,
          size.width * 0.6646383,
          size.height * 0.9517421)
      ..cubicTo(
          size.width * 0.6581153,
          size.height * 0.9482099,
          size.width * 0.6565014,
          size.height * 0.9435185,
          size.width * 0.6575216,
          size.height * 0.9310700)
      ..cubicTo(
          size.width * 0.6588256,
          size.height * 0.9151578,
          size.width * 0.6647392,
          size.height * 0.9000960,
          size.width * 0.6859366,
          size.height * 0.8587106)
      ..cubicTo(
          size.width * 0.7054467,
          size.height * 0.8206241,
          size.width * 0.7095735,
          size.height * 0.8066735,
          size.width * 0.7095735,
          size.height * 0.7788066)
      ..cubicTo(
          size.width * 0.7095735,
          size.height * 0.7533813,
          size.width * 0.7070447,
          size.height * 0.7432030,
          size.width * 0.6915951,
          size.height * 0.7064472)
      ..cubicTo(
          size.width * 0.6861239,
          size.height * 0.6934362,
          size.width * 0.6812349,
          size.height * 0.6803155,
          size.width * 0.6807277,
          size.height * 0.6772977)
      ..cubicTo(
          size.width * 0.6794798,
          size.height * 0.6698546,
          size.width * 0.6828415,
          size.height * 0.6589630,
          size.width * 0.6915764,
          size.height * 0.6421543)
      ..cubicTo(
          size.width * 0.7048963,
          size.height * 0.6165247,
          size.width * 0.7083775,
          size.height * 0.6045720,
          size.width * 0.7102406,
          size.height * 0.5780947)
      ..cubicTo(
          size.width * 0.7122334,
          size.height * 0.5497627,
          size.width * 0.7088156,
          size.height * 0.5300432,
          size.width * 0.6980692,
          size.height * 0.5078820)
      ..cubicTo(
          size.width * 0.6930605,
          size.height * 0.4975528,
          size.width * 0.6886455,
          size.height * 0.4899664,
          size.width * 0.6739107,
          size.height * 0.4663724)
      ..cubicTo(
          size.width * 0.6695447,
          size.height * 0.4593827,
          size.width * 0.6642608,
          size.height * 0.4497058,
          size.width * 0.6621671,
          size.height * 0.4448683)
      ..cubicTo(
          size.width * 0.6557622,
          size.height * 0.4300713,
          size.width * 0.6551772,
          size.height * 0.4130412,
          size.width * 0.6606801,
          size.height * 0.4015775)
      ..cubicTo(
          size.width * 0.6639885,
          size.height * 0.3946859,
          size.width * 0.6650346,
          size.height * 0.3824492,
          size.width * 0.6628646,
          size.height * 0.3760446)
      ..cubicTo(
          size.width * 0.6618732,
          size.height * 0.3731221,
          size.width * 0.6591455,
          size.height * 0.3677942,
          size.width * 0.6567997,
          size.height * 0.3642058)
      ..cubicTo(
          size.width * 0.6483617,
          size.height * 0.3512922,
          size.width * 0.6443977,
          size.height * 0.3397572,
          size.width * 0.6462248,
          size.height * 0.3334348)
      ..cubicTo(
          size.width * 0.6470331,
          size.height * 0.3306379,
          size.width * 0.6497896,
          size.height * 0.3281241,
          size.width * 0.6607089,
          size.height * 0.3202332)
      ..cubicTo(
          size.width * 0.6681254,
          size.height * 0.3148717,
          size.width * 0.6779582,
          size.height * 0.3071461,
          size.width * 0.6825576,
          size.height * 0.3030645)
      ..cubicTo(
          size.width * 0.6877378,
          size.height * 0.2984684,
          size.width * 0.6917925,
          size.height * 0.2956372,
          size.width * 0.6932089,
          size.height * 0.2956269)
      ..cubicTo(
          size.width * 0.6946441,
          size.height * 0.2956166,
          size.width * 0.6977104,
          size.height * 0.2977140,
          size.width * 0.7014539,
          size.height * 0.3012689)
      ..cubicTo(
          size.width * 0.7054164,
          size.height * 0.3050309,
          size.width * 0.7113127,
          size.height * 0.3089959,
          size.width * 0.7190461,
          size.height * 0.3131001)
      ..cubicTo(
          size.width * 0.7349251,
          size.height * 0.3215261,
          size.width * 0.7357291,
          size.height * 0.3223951,
          size.width * 0.7367954,
          size.height * 0.3323045)
      ..cubicTo(
          size.width * 0.7380605,
          size.height * 0.3440610,
          size.width * 0.7437637,
          size.height * 0.3541927,
          size.width * 0.7539755,
          size.height * 0.3628258)
      ..cubicTo(
          size.width * 0.7629741,
          size.height * 0.3704328,
          size.width * 0.7750461,
          size.height * 0.3771818,
          size.width * 0.8030519,
          size.height * 0.3902606)
      ..cubicTo(
          size.width * 0.8428890,
          size.height * 0.4088649,
          size.width * 0.8562003,
          size.height * 0.4168944,
          size.width * 0.8736369,
          size.height * 0.4328340)
      ..lineTo(size.width * 0.8829597, size.height * 0.4413580)
      ..lineTo(size.width * 0.8830865, size.height * 0.4476488)
      ..cubicTo(
          size.width * 0.8833862,
          size.height * 0.4624403,
          size.width * 0.8985476,
          size.height * 0.4835871,
          size.width * 0.9122392,
          size.height * 0.4883080)
      ..cubicTo(
          size.width * 0.9214352,
          size.height * 0.4914787,
          size.width * 0.9263718,
          size.height * 0.4919650,
          size.width * 0.9457767,
          size.height * 0.4916097)
      ..cubicTo(
          size.width * 0.9699841,
          size.height * 0.4911674,
          size.width * 0.9820086,
          size.height * 0.4888676,
          size.width * 0.9883963,
          size.height * 0.4834575)
      ..cubicTo(
          size.width * 0.9940432,
          size.height * 0.4786742,
          size.width * 0.9920418,
          size.height * 0.4731571,
          size.width * 0.9797781,
          size.height * 0.4597106)
      ..cubicTo(
          size.width * 0.9755663,
          size.height * 0.4550919,
          size.width * 0.9724741,
          size.height * 0.4511454,
          size.width * 0.9729063,
          size.height * 0.4509390)
      ..cubicTo(
          size.width * 0.9733401,
          size.height * 0.4507332,
          size.width * 0.9768573,
          size.height * 0.4514760,
          size.width * 0.9807233,
          size.height * 0.4525905)
      ..cubicTo(
          size.width * 0.9908084,
          size.height * 0.4554973,
          size.width * 0.9935447,
          size.height * 0.4557476,
          size.width * 0.9970447,
          size.height * 0.4540816)
      ..cubicTo(
          size.width * 1.002844,
          size.height * 0.4513210,
          size.width * 1.000203,
          size.height * 0.4480789,
          size.width * 0.9874337,
          size.height * 0.4422819)
      ..cubicTo(
          size.width * 0.9789150,
          size.height * 0.4384150,
          size.width * 0.9592896,
          size.height * 0.4319191,
          size.width * 0.9463055,
          size.height * 0.4286694)
      ..cubicTo(
          size.width * 0.9395908,
          size.height * 0.4269890,
          size.width * 0.9391671,
          size.height * 0.4266811,
          size.width * 0.9250951,
          size.height * 0.4132236)
      ..cubicTo(
          size.width * 0.9085692,
          size.height * 0.3974198,
          size.width * 0.9028473,
          size.height * 0.3896708,
          size.width * 0.8896542,
          size.height * 0.3652263)
      ..cubicTo(
          size.width * 0.8790850,
          size.height * 0.3456454,
          size.width * 0.8737118,
          size.height * 0.3396056,
          size.width * 0.8581196,
          size.height * 0.3297840)
      ..cubicTo(
          size.width * 0.8529236,
          size.height * 0.3265117,
          size.width * 0.8415130,
          size.height * 0.3206104,
          size.width * 0.8327608,
          size.height * 0.3166701)
      ..lineTo(size.width * 0.8168473, size.height * 0.3095055)
      ..lineTo(size.width * 0.8148343, size.height * 0.3027291)
      ..cubicTo(
          size.width * 0.8092320,
          size.height * 0.2838628,
          size.width * 0.8017738,
          size.height * 0.2736996,
          size.width * 0.7839438,
          size.height * 0.2606310)
      ..cubicTo(
          size.width * 0.7767061,
          size.height * 0.2553265,
          size.width * 0.7751888,
          size.height * 0.2537325,
          size.width * 0.7757824,
          size.height * 0.2520576)
      ..cubicTo(
          size.width * 0.7805951,
          size.height * 0.2384890,
          size.width * 0.7803991,
          size.height * 0.2146029,
          size.width * 0.7753905,
          size.height * 0.2042689)
      ..cubicTo(
          size.width * 0.7692622,
          size.height * 0.1916255,
          size.width * 0.7568631,
          size.height * 0.1810466,
          size.width * 0.7391571,
          size.height * 0.1733539)
      ..cubicTo(
          size.width * 0.7281182,
          size.height * 0.1685583,
          size.width * 0.7168573,
          size.height * 0.1654506,
          size.width * 0.6930836,
          size.height * 0.1606365)
      ..cubicTo(
          size.width * 0.5759078,
          size.height * 0.1369108,
          size.width * 0.5642450,
          size.height * 0.1329822,
          size.width * 0.5644092,
          size.height * 0.1172840)
      ..cubicTo(
          size.width * 0.5644654,
          size.height * 0.1118786,
          size.width * 0.5651311,
          size.height * 0.1105892,
          size.width * 0.5735375,
          size.height * 0.09958368)
      ..cubicTo(
          size.width * 0.5817695,
          size.height * 0.08880658,
          size.width * 0.5833127,
          size.height * 0.08733471,
          size.width * 0.5902896,
          size.height * 0.08361248)
      ..cubicTo(
          size.width * 0.6019755,
          size.height * 0.07737860,
          size.width * 0.6041902,
          size.height * 0.07488752,
          size.width * 0.6048977,
          size.height * 0.06717284)
      ..cubicTo(
          size.width * 0.6054625,
          size.height * 0.06103567,
          size.width * 0.6052032,
          size.height * 0.06026475,
          size.width * 0.6008732,
          size.height * 0.05517010)
      ..cubicTo(
          size.width * 0.5965403,
          size.height * 0.05007270,
          size.width * 0.5962983,
          size.height * 0.04935048,
          size.width * 0.5970793,
          size.height * 0.04384636)
      ..cubicTo(
          size.width * 0.5975389,
          size.height * 0.04061248,
          size.width * 0.5973012,
          size.height * 0.03617215,
          size.width * 0.5965519,
          size.height * 0.03397874)
      ..cubicTo(
          size.width * 0.5918314,
          size.height * 0.02017284,
          size.width * 0.5645476,
          size.height * 0.007451989,
          size.width * 0.5280980,
          size.height * 0.002061735)
      ..cubicTo(
          size.width * 0.5151643,
          size.height * 0.0001488422,
          size.width * 0.4926787,
          size.height * -0.0003607668,
          size.width * 0.4803530,
          size.height * 0.0009787380)
      ..close();
  }

  Path path38(Size size) {
    return Path()
      ..moveTo(size.width * 0.3090389, size.height * 0.7406859)
      ..cubicTo(
          size.width * 0.3151282,
          size.height * 0.7158093,
          size.width * 0.3270778,
          size.height * 0.7004047,
          size.width * 0.3484914,
          size.height * 0.6898148)
      ..cubicTo(
          size.width * 0.3521138,
          size.height * 0.6880247,
          size.width * 0.3556052,
          size.height * 0.6865569,
          size.width * 0.3562493,
          size.height * 0.6865569)
      ..cubicTo(
          size.width * 0.3597046,
          size.height * 0.6865569,
          size.width * 0.3622983,
          size.height * 0.6979904,
          size.width * 0.3637954,
          size.height * 0.7198217)
      ..cubicTo(
          size.width * 0.3671599,
          size.height * 0.7688615,
          size.width * 0.3700648,
          size.height * 0.7941015,
          size.width * 0.3739784,
          size.height * 0.8082990)
      ..cubicTo(
          size.width * 0.3766729,
          size.height * 0.8180796,
          size.width * 0.3766225,
          size.height * 0.8245953,
          size.width * 0.3738040,
          size.height * 0.8310905)
      ..cubicTo(
          size.width * 0.3686643,
          size.height * 0.8429355,
          size.width * 0.3568703,
          size.height * 0.8483196,
          size.width * 0.3394597,
          size.height * 0.8467627)
      ..cubicTo(
          size.width * 0.3240692,
          size.height * 0.8453909,
          size.width * 0.3137464,
          size.height * 0.8346914,
          size.width * 0.3083055,
          size.height * 0.8144719)
      ..cubicTo(
          size.width * 0.3037954,
          size.height * 0.7977092,
          size.width * 0.3041628,
          size.height * 0.7605967,
          size.width * 0.3090389,
          size.height * 0.7406859)
      ..close();
  }

  Path path37(Size size) {
    return Path()
      ..moveTo(size.width * 0.6361772, size.height * 0.7229081)
      ..cubicTo(
          size.width * 0.6373256,
          size.height * 0.7067833,
          size.width * 0.6395288,
          size.height * 0.6922702,
          size.width * 0.6413055,
          size.height * 0.6891289)
      ..cubicTo(
          size.width * 0.6421066,
          size.height * 0.6877160,
          size.width * 0.6432464,
          size.height * 0.6865569,
          size.width * 0.6438372,
          size.height * 0.6865569)
      ..cubicTo(
          size.width * 0.6444280,
          size.height * 0.6865569,
          size.width * 0.6482320,
          size.height * 0.6881756,
          size.width * 0.6522911,
          size.height * 0.6901578)
      ..cubicTo(
          size.width * 0.6806859,
          size.height * 0.7040123,
          size.width * 0.6929798,
          size.height * 0.7274760,
          size.width * 0.6955043,
          size.height * 0.7726337)
      ..cubicTo(
          size.width * 0.6975620,
          size.height * 0.8094170,
          size.width * 0.6876254,
          size.height * 0.8374966,
          size.width * 0.6700634,
          size.height * 0.8445336)
      ..cubicTo(
          size.width * 0.6623084,
          size.height * 0.8476406,
          size.width * 0.6496066,
          size.height * 0.8478395,
          size.width * 0.6412017,
          size.height * 0.8449931)
      ..cubicTo(
          size.width * 0.6260908,
          size.height * 0.8398697,
          size.width * 0.6217536,
          size.height * 0.8264678,
          size.width * 0.6272176,
          size.height * 0.8017833)
      ..cubicTo(
          size.width * 0.6308876,
          size.height * 0.7852126,
          size.width * 0.6331686,
          size.height * 0.7651235,
          size.width * 0.6361772,
          size.height * 0.7229081)
      ..close();
  }

  Path path36(Size size) {
    return Path()
      ..moveTo(size.width * 0.3802161, size.height * 0.7630316)
      ..cubicTo(
          size.width * 0.3758242,
          size.height * 0.7278258,
          size.width * 0.3741470,
          size.height * 0.6944239,
          size.width * 0.3765058,
          size.height * 0.6891289)
      ..cubicTo(
          size.width * 0.3771369,
          size.height * 0.6877160,
          size.width * 0.3783718,
          size.height * 0.6865569,
          size.width * 0.3792507,
          size.height * 0.6865569)
      ..cubicTo(
          size.width * 0.3801297,
          size.height * 0.6865569,
          size.width * 0.3833314,
          size.height * 0.6877984,
          size.width * 0.3863660,
          size.height * 0.6893210)
      ..cubicTo(
          size.width * 0.3973991,
          size.height * 0.6948354,
          size.width * 0.4097536,
          size.height * 0.7101166,
          size.width * 0.4213343,
          size.height * 0.7325514)
      ..cubicTo(
          size.width * 0.4287305,
          size.height * 0.7468861,
          size.width * 0.4401787,
          size.height * 0.7758436,
          size.width * 0.4425504,
          size.height * 0.7862209)
      ..cubicTo(
          size.width * 0.4453141,
          size.height * 0.7983128,
          size.width * 0.4402003,
          size.height * 0.8185460,
          size.width * 0.4293473,
          size.height * 0.8384774)
      ..cubicTo(
          size.width * 0.4232839,
          size.height * 0.8496091,
          size.width * 0.4204841,
          size.height * 0.8525377,
          size.width * 0.4158977,
          size.height * 0.8525377)
      ..cubicTo(
          size.width * 0.4099582,
          size.height * 0.8525377,
          size.width * 0.4038242,
          size.height * 0.8493416,
          size.width * 0.3970043,
          size.height * 0.8427023)
      ..cubicTo(
          size.width * 0.3886830,
          size.height * 0.8345953,
          size.width * 0.3865764,
          size.height * 0.8289849,
          size.width * 0.3855101,
          size.height * 0.8120713)
      ..cubicTo(
          size.width * 0.3850461,
          size.height * 0.8047119,
          size.width * 0.3826643,
          size.height * 0.7826475,
          size.width * 0.3802161,
          size.height * 0.7630316)
      ..close();
  }

  Path path35(Size size) {
    return Path()
      ..moveTo(size.width * 0.5631182, size.height * 0.7688683)
      ..cubicTo(
          size.width * 0.5792435,
          size.height * 0.7259122,
          size.width * 0.5972406,
          size.height * 0.6979081,
          size.width * 0.6143963,
          size.height * 0.6890672)
      ..cubicTo(
          size.width * 0.6172089,
          size.height * 0.6876132,
          size.width * 0.6203314,
          size.height * 0.6865569,
          size.width * 0.6213343,
          size.height * 0.6867215)
      ..cubicTo(
          size.width * 0.6223372,
          size.height * 0.6868793,
          size.width * 0.6236988,
          size.height * 0.6883745,
          size.width * 0.6243588,
          size.height * 0.6900412)
      ..cubicTo(
          size.width * 0.6261614,
          size.height * 0.6945885,
          size.width * 0.6244207,
          size.height * 0.7286283,
          size.width * 0.6211354,
          size.height * 0.7530864)
      ..cubicTo(
          size.width * 0.6163991,
          size.height * 0.7883539,
          size.width * 0.6138386,
          size.height * 0.8119136,
          size.width * 0.6138357,
          size.height * 0.8202606)
      ..cubicTo(
          size.width * 0.6138343,
          size.height * 0.8251166,
          size.width * 0.6129539,
          size.height * 0.8298148,
          size.width * 0.6115245,
          size.height * 0.8326063)
      ..cubicTo(
          size.width * 0.6064539,
          size.height * 0.8424966,
          size.width * 0.5923617,
          size.height * 0.8529355,
          size.width * 0.5847680,
          size.height * 0.8524211)
      ..cubicTo(
          size.width * 0.5799524,
          size.height * 0.8520988,
          size.width * 0.5757046,
          size.height * 0.8475720,
          size.width * 0.5699784,
          size.height * 0.8366804)
      ..cubicTo(
          size.width * 0.5606945,
          size.height * 0.8190123,
          size.width * 0.5584841,
          size.height * 0.8111591,
          size.width * 0.5584179,
          size.height * 0.7956104)
      ..cubicTo(
          size.width * 0.5583617,
          size.height * 0.7826475,
          size.width * 0.5587277,
          size.height * 0.7805624,
          size.width * 0.5631182,
          size.height * 0.7688683)
      ..close();
  }

  Path path34(Size size) {
    return Path()
      ..moveTo(size.width * 0.3325692, size.height * 0.8655693)
      ..cubicTo(
          size.width * 0.3285620,
          size.height * 0.8582099,
          size.width * 0.3249452,
          size.height * 0.8514540,
          size.width * 0.3245331,
          size.height * 0.8505418)
      ..cubicTo(
          size.width * 0.3237997,
          size.height * 0.8489232,
          size.width * 0.3238545,
          size.height * 0.8489095,
          size.width * 0.3272378,
          size.height * 0.8500412)
      ..cubicTo(
          size.width * 0.3291369,
          size.height * 0.8506790,
          size.width * 0.3330749,
          size.height * 0.8515089,
          size.width * 0.3359885,
          size.height * 0.8518793)
      ..cubicTo(
          size.width * 0.3406182,
          size.height * 0.8524760,
          size.width * 0.3415620,
          size.height * 0.8529698,
          size.width * 0.3434885,
          size.height * 0.8558093)
      ..cubicTo(
          size.width * 0.3560014,
          size.height * 0.8742318,
          size.width * 0.3660447,
          size.height * 0.9118724,
          size.width * 0.3631311,
          size.height * 0.9294307)
      ..cubicTo(
          size.width * 0.3620893,
          size.height * 0.9357133,
          size.width * 0.3585101,
          size.height * 0.9426475,
          size.width * 0.3559222,
          size.height * 0.9434088)
      ..cubicTo(
          size.width * 0.3552594,
          size.height * 0.9436077,
          size.width * 0.3547248,
          size.height * 0.9381344,
          size.width * 0.3547334,
          size.height * 0.9312483)
      ..cubicTo(
          size.width * 0.3547594,
          size.height * 0.9131276,
          size.width * 0.3486988,
          size.height * 0.8951715,
          size.width * 0.3325692,
          size.height * 0.8655693)
      ..close();
  }

  Path path33(Size size) {
    return Path()
      ..moveTo(size.width * 0.6639380, size.height * 0.8518519)
      ..cubicTo(
          size.width * 0.6653069,
          size.height * 0.8518450,
          size.width * 0.6683718,
          size.height * 0.8512551,
          size.width * 0.6707493,
          size.height * 0.8505281)
      ..cubicTo(
          size.width * 0.6760893,
          size.height * 0.8488957,
          size.width * 0.6777954,
          size.height * 0.8487929,
          size.width * 0.6766945,
          size.height * 0.8501578)
      ..cubicTo(
          size.width * 0.6749625,
          size.height * 0.8523045,
          size.width * 0.6643055,
          size.height * 0.8716941,
          size.width * 0.6601167,
          size.height * 0.8803155)
      ..cubicTo(
          size.width * 0.6495980,
          size.height * 0.9019684,
          size.width * 0.6452104,
          size.height * 0.9166255,
          size.width * 0.6451282,
          size.height * 0.9303841)
      ..cubicTo(
          size.width * 0.6450937,
          size.height * 0.9360425,
          size.width * 0.6455389,
          size.height * 0.9413649,
          size.width * 0.6461167,
          size.height * 0.9422154)
      ..cubicTo(
          size.width * 0.6476225,
          size.height * 0.9444239,
          size.width * 0.6446052,
          size.height * 0.9441632,
          size.width * 0.6421326,
          size.height * 0.9418724)
      ..cubicTo(
          size.width * 0.6315476,
          size.height * 0.9320576,
          size.width * 0.6369841,
          size.height * 0.8918107,
          size.width * 0.6528055,
          size.height * 0.8628669)
      ..cubicTo(
          size.width * 0.6574193,
          size.height * 0.8544239,
          size.width * 0.6600159,
          size.height * 0.8518519,
          size.width * 0.6639380,
          size.height * 0.8518519)
      ..close();
  }

  Path path32(Size size) {
    return Path()
      ..moveTo(size.width * 0.3032450, size.height * 0.5377229)
      ..cubicTo(
          size.width * 0.3079251,
          size.height * 0.5230309,
          size.width * 0.3196686,
          size.height * 0.5113025,
          size.width * 0.3397997,
          size.height * 0.5012154)
      ..cubicTo(
          size.width * 0.3441124,
          size.height * 0.4990549,
          size.width * 0.3481196,
          size.height * 0.4974280,
          size.width * 0.3487061,
          size.height * 0.4976001)
      ..cubicTo(
          size.width * 0.3492925,
          size.height * 0.4977730,
          size.width * 0.3501902,
          size.height * 0.4989095,
          size.width * 0.3507017,
          size.height * 0.5001262)
      ..cubicTo(
          size.width * 0.3512133,
          size.height * 0.5013429,
          size.width * 0.3536412,
          size.height * 0.5044143,
          size.width * 0.3560965,
          size.height * 0.5069506)
      ..lineTo(size.width * 0.3605634, size.height * 0.5115631)
      ..lineTo(size.width * 0.3518963, size.height * 0.5196701)
      ..cubicTo(
          size.width * 0.3301830,
          size.height * 0.5399801,
          size.width * 0.3095159,
          size.height * 0.5679417,
          size.width * 0.3045893,
          size.height * 0.5836763)
      ..lineTo(size.width * 0.3034078, size.height * 0.5874486)
      ..lineTo(size.width * 0.3024481, size.height * 0.5829904)
      ..cubicTo(
          size.width * 0.3005504,
          size.height * 0.5741680,
          size.width * 0.3010720,
          size.height * 0.5445446,
          size.width * 0.3032450,
          size.height * 0.5377229)
      ..close();
  }

  Path path31(Size size) {
    return Path()
      ..moveTo(size.width * 0.6478199, size.height * 0.5017147)
      ..cubicTo(
          size.width * 0.6491499,
          size.height * 0.4998285,
          size.width * 0.6505879,
          size.height * 0.4979986,
          size.width * 0.6510130,
          size.height * 0.4976475)
      ..cubicTo(
          size.width * 0.6520331,
          size.height * 0.4968066,
          size.width * 0.6655605,
          size.height * 0.5037647,
          size.width * 0.6728818,
          size.height * 0.5088957)
      ..cubicTo(
          size.width * 0.6871513,
          size.height * 0.5188985,
          size.width * 0.6946513,
          size.height * 0.5293642,
          size.width * 0.6973862,
          size.height * 0.5430912)
      ..cubicTo(
          size.width * 0.6998040,
          size.height * 0.5552263,
          size.width * 0.6981210,
          size.height * 0.5916591,
          size.width * 0.6954337,
          size.height * 0.5853909)
      ..cubicTo(
          size.width * 0.6849755,
          size.height * 0.5610089,
          size.width * 0.6714741,
          size.height * 0.5424787,
          size.width * 0.6477507,
          size.height * 0.5199444)
      ..lineTo(size.width * 0.6386455, size.height * 0.5112949)
      ..lineTo(size.width * 0.6420231, size.height * 0.5082195)
      ..cubicTo(
          size.width * 0.6438804,
          size.height * 0.5065281,
          size.width * 0.6464885,
          size.height * 0.5036008,
          size.width * 0.6478199,
          size.height * 0.5017147)
      ..close();
  }

  Path path30(Size size) {
    return Path()
      ..moveTo(size.width * 0.3124899, size.height * 0.5915638)
      ..cubicTo(
          size.width * 0.3195922,
          size.height * 0.5720706,
          size.width * 0.3374207,
          size.height * 0.5467949,
          size.width * 0.3595850,
          size.height * 0.5248025)
      ..lineTo(size.width * 0.3688040, size.height * 0.5156550)
      ..lineTo(size.width * 0.3756844, size.height * 0.5182524)
      ..cubicTo(
          size.width * 0.3794683,
          size.height * 0.5196818,
          size.width * 0.3831354,
          size.height * 0.5210761,
          size.width * 0.3838329,
          size.height * 0.5213512)
      ..cubicTo(
          size.width * 0.3845389,
          size.height * 0.5216296,
          size.width * 0.3834236,
          size.height * 0.5246879,
          size.width * 0.3813213,
          size.height * 0.5282442)
      ..cubicTo(
          size.width * 0.3693415,
          size.height * 0.5484986,
          size.width * 0.3641715,
          size.height * 0.5782915,
          size.width * 0.3646816,
          size.height * 0.6241427)
      ..lineTo(size.width * 0.3650202, size.height * 0.6546639)
      ..lineTo(size.width * 0.3612579, size.height * 0.6613697)
      ..cubicTo(
          size.width * 0.3567061,
          size.height * 0.6694815,
          size.width * 0.3472161,
          size.height * 0.6792366,
          size.width * 0.3370980,
          size.height * 0.6862003)
      ..cubicTo(
          size.width * 0.3269380,
          size.height * 0.6931962,
          size.width * 0.3258818,
          size.height * 0.6931139,
          size.width * 0.3285576,
          size.height * 0.6855281)
      ..cubicTo(
          size.width * 0.3293559,
          size.height * 0.6832647,
          size.width * 0.3300173,
          size.height * 0.6770912,
          size.width * 0.3300259,
          size.height * 0.6718093)
      ..cubicTo(
          size.width * 0.3300476,
          size.height * 0.6604774,
          size.width * 0.3273660,
          size.height * 0.6522593,
          size.width * 0.3176052,
          size.height * 0.6337449)
      ..cubicTo(
          size.width * 0.3114640,
          size.height * 0.6220967,
          size.width * 0.3108573,
          size.height * 0.6201845,
          size.width * 0.3102046,
          size.height * 0.6104252)
      ..cubicTo(
          size.width * 0.3096167,
          size.height * 0.6016502,
          size.width * 0.3100159,
          size.height * 0.5983573,
          size.width * 0.3124899,
          size.height * 0.5915638)
      ..close();
  }

  Path path29(Size size) {
    return Path()
      ..moveTo(size.width * 0.6161110, size.height * 0.5209191)
      ..cubicTo(
          size.width * 0.6174323,
          size.height * 0.5205418,
          size.width * 0.6210879,
          size.height * 0.5192298,
          size.width * 0.6242349,
          size.height * 0.5180041)
      ..cubicTo(
          size.width * 0.6273818,
          size.height * 0.5167785,
          size.width * 0.6302435,
          size.height * 0.5157750,
          size.width * 0.6305937,
          size.height * 0.5157750)
      ..cubicTo(
          size.width * 0.6317378,
          size.height * 0.5157750,
          size.width * 0.6467176,
          size.height * 0.5314266,
          size.width * 0.6554308,
          size.height * 0.5417263)
      ..cubicTo(
          size.width * 0.6775879,
          size.height * 0.5679184,
          size.width * 0.6902017,
          size.height * 0.5923224,
          size.width * 0.6902017,
          size.height * 0.6090014)
      ..cubicTo(
          size.width * 0.6902017,
          size.height * 0.6160562,
          size.width * 0.6880692,
          size.height * 0.6218738,
          size.width * 0.6792478,
          size.height * 0.6388861)
      ..cubicTo(
          size.width * 0.6707003,
          size.height * 0.6553711,
          size.width * 0.6680159,
          size.height * 0.6653100,
          size.width * 0.6691484,
          size.height * 0.6762689)
      ..cubicTo(
          size.width * 0.6696354,
          size.height * 0.6809842,
          size.width * 0.6707032,
          size.height * 0.6861934,
          size.width * 0.6715216,
          size.height * 0.6878464)
      ..cubicTo(
          size.width * 0.6723415,
          size.height * 0.6894993,
          size.width * 0.6726009,
          size.height * 0.6910425,
          size.width * 0.6720994,
          size.height * 0.6912757)
      ..cubicTo(
          size.width * 0.6695533,
          size.height * 0.6924623,
          size.width * 0.6529971,
          size.height * 0.6802394,
          size.width * 0.6454366,
          size.height * 0.6715940)
      ..cubicTo(
          size.width * 0.6347968,
          size.height * 0.6594287,
          size.width * 0.6346801,
          size.height * 0.6589554,
          size.width * 0.6351412,
          size.height * 0.6296296)
      ..cubicTo(
          size.width * 0.6356816,
          size.height * 0.5952572,
          size.width * 0.6327997,
          size.height * 0.5674561,
          size.width * 0.6267147,
          size.height * 0.5483539)
      ..cubicTo(
          size.width * 0.6239164,
          size.height * 0.5395706,
          size.width * 0.6194135,
          size.height * 0.5294540,
          size.width * 0.6165447,
          size.height * 0.5255055)
      ..cubicTo(
          size.width * 0.6139179,
          size.height * 0.5218916,
          size.width * 0.6138862,
          size.height * 0.5215542,
          size.width * 0.6161110,
          size.height * 0.5209191)
      ..close();
  }

  Path path28(Size size) {
    return Path()
      ..moveTo(size.width * 0.4476628, size.height * 0.5233265)
      ..cubicTo(
          size.width * 0.4544366,
          size.height * 0.5224753,
          size.width * 0.4646066,
          size.height * 0.5206276,
          size.width * 0.4702637,
          size.height * 0.5192215)
      ..cubicTo(
          size.width * 0.4759193,
          size.height * 0.5178155,
          size.width * 0.4810331,
          size.height * 0.5166193,
          size.width * 0.4816282,
          size.height * 0.5165631)
      ..cubicTo(
          size.width * 0.4864986,
          size.height * 0.5161029,
          size.width * 0.4731628,
          size.height * 0.5772064,
          size.width * 0.4645850,
          size.height * 0.5946495)
      ..cubicTo(
          size.width * 0.4637637,
          size.height * 0.5963196,
          size.width * 0.4636902,
          size.height * 0.5963292,
          size.width * 0.4616686,
          size.height * 0.5950130)
      ..cubicTo(
          size.width * 0.4559971,
          size.height * 0.5913217,
          size.width * 0.4435014,
          size.height * 0.5685617,
          size.width * 0.4388761,
          size.height * 0.5534979)
      ..cubicTo(
          size.width * 0.4356297,
          size.height * 0.5429280,
          size.width * 0.4334885,
          size.height * 0.5301948,
          size.width * 0.4344798,
          size.height * 0.5273553)
      ..cubicTo(
          size.width * 0.4353415,
          size.height * 0.5248896,
          size.width * 0.4354150,
          size.height * 0.5248669,
          size.width * 0.4476628,
          size.height * 0.5233265)
      ..close();
  }

  Path path27(Size size) {
    return Path()
      ..moveTo(size.width * 0.5318905, size.height * 0.5867627)
      ..cubicTo(
          size.width * 0.5241844,
          size.height * 0.5655254,
          size.width * 0.5193112,
          size.height * 0.5449904,
          size.width * 0.5177795,
          size.height * 0.5273093)
      ..cubicTo(
          size.width * 0.5172637,
          size.height * 0.5213429,
          size.width * 0.5173012,
          size.height * 0.5164609,
          size.width * 0.5178631,
          size.height * 0.5164609)
      ..cubicTo(
          size.width * 0.5184251,
          size.height * 0.5164609,
          size.width * 0.5212824,
          size.height * 0.5172414,
          size.width * 0.5242118,
          size.height * 0.5181962)
      ..cubicTo(
          size.width * 0.5271412,
          size.height * 0.5191502,
          size.width * 0.5360231,
          size.height * 0.5208752,
          size.width * 0.5439481,
          size.height * 0.5220295)
      ..cubicTo(
          size.width * 0.5518732,
          size.height * 0.5231838,
          size.width * 0.5599150,
          size.height * 0.5244239,
          size.width * 0.5618184,
          size.height * 0.5247853)
      ..lineTo(size.width * 0.5652781, size.height * 0.5254424)
      ..lineTo(size.width * 0.5643718, size.height * 0.5348409)
      ..cubicTo(
          size.width * 0.5629928,
          size.height * 0.5491461,
          size.width * 0.5564409,
          size.height * 0.5672627,
          size.width * 0.5474222,
          size.height * 0.5817126)
      ..cubicTo(
          size.width * 0.5415231,
          size.height * 0.5911646,
          size.width * 0.5373429,
          size.height * 0.5962442,
          size.width * 0.5360173,
          size.height * 0.5955713)
      ..cubicTo(
          size.width * 0.5353890,
          size.height * 0.5952531,
          size.width * 0.5335331,
          size.height * 0.5912894,
          size.width * 0.5318905,
          size.height * 0.5867627)
      ..close();
  }

  Path path26(Size size) {
    return Path()
      ..moveTo(size.width * 0.3773473, size.height * 0.5785322)
      ..cubicTo(
          size.width * 0.3809524,
          size.height * 0.5516118,
          size.width * 0.3866888,
          size.height * 0.5329774,
          size.width * 0.3934049,
          size.height * 0.5263731)
      ..cubicTo(
          size.width * 0.3957983,
          size.height * 0.5240206,
          size.width * 0.3971844,
          size.height * 0.5233457,
          size.width * 0.3989467,
          size.height * 0.5236763)
      ..cubicTo(
          size.width * 0.4002392,
          size.height * 0.5239191,
          size.width * 0.4066974,
          size.height * 0.5244726,
          size.width * 0.4132983,
          size.height * 0.5249067)
      ..lineTo(size.width * 0.4253012, size.height * 0.5256962)
      ..lineTo(size.width * 0.4246037, size.height * 0.5277654)
      ..cubicTo(
          size.width * 0.4235331,
          size.height * 0.5309431,
          size.width * 0.4262882,
          size.height * 0.5479911,
          size.width * 0.4295014,
          size.height * 0.5580741)
      ..cubicTo(
          size.width * 0.4347522,
          size.height * 0.5745514,
          size.width * 0.4451974,
          size.height * 0.5918683,
          size.width * 0.4562983,
          size.height * 0.6024986)
      ..lineTo(size.width * 0.4613530, size.height * 0.6073388)
      ..lineTo(size.width * 0.4604265, size.height * 0.6159122)
      ..cubicTo(
          size.width * 0.4567190,
          size.height * 0.6502318,
          size.width * 0.4477363,
          size.height * 0.6840706,
          size.width * 0.4373948,
          size.height * 0.7026749)
      ..cubicTo(
          size.width * 0.4330461,
          size.height * 0.7105007,
          size.width * 0.4275317,
          size.height * 0.7175309,
          size.width * 0.4257550,
          size.height * 0.7175240)
      ..cubicTo(
          size.width * 0.4250014,
          size.height * 0.7175171,
          size.width * 0.4225663,
          size.height * 0.7144856,
          size.width * 0.4203444,
          size.height * 0.7107819)
      ..cubicTo(
          size.width * 0.4179323,
          size.height * 0.7067627,
          size.width * 0.4108501,
          size.height * 0.6986626,
          size.width * 0.4027622,
          size.height * 0.6906722)
      ..cubicTo(
          size.width * 0.3843631,
          size.height * 0.6725000,
          size.width * 0.3812277,
          size.height * 0.6677064,
          size.width * 0.3774193,
          size.height * 0.6519204)
      ..cubicTo(
          size.width * 0.3751081,
          size.height * 0.6423416,
          size.width * 0.3750634,
          size.height * 0.5955974,
          size.width * 0.3773473,
          size.height * 0.5785322)
      ..close();
  }

  Path path25(Size size) {
    return Path()
      ..moveTo(size.width * 0.5805548, size.height * 0.5253114)
      ..cubicTo(
          size.width * 0.5834035,
          size.height * 0.5252750,
          size.width * 0.5893012,
          size.height * 0.5248738,
          size.width * 0.5936599,
          size.height * 0.5244204)
      ..cubicTo(
          size.width * 0.5980187,
          size.height * 0.5239671,
          size.width * 0.6021441,
          size.height * 0.5237277,
          size.width * 0.6028285,
          size.height * 0.5238896)
      ..cubicTo(
          size.width * 0.6073487,
          size.height * 0.5249547,
          size.width * 0.6138804,
          size.height * 0.5377106,
          size.width * 0.6172882,
          size.height * 0.5521262)
      ..cubicTo(
          size.width * 0.6220274,
          size.height * 0.5721811,
          size.width * 0.6231210,
          size.height * 0.5843409,
          size.width * 0.6230865,
          size.height * 0.6165981)
      ..cubicTo(
          size.width * 0.6230375,
          size.height * 0.6622956,
          size.width * 0.6218213,
          size.height * 0.6658292,
          size.width * 0.5980706,
          size.height * 0.6893004)
      ..cubicTo(
          size.width * 0.5849193,
          size.height * 0.7022977,
          size.width * 0.5805231,
          size.height * 0.7075514,
          size.width * 0.5763919,
          size.height * 0.7151920)
      ..cubicTo(
          size.width * 0.5755259,
          size.height * 0.7167970,
          size.width * 0.5742406,
          size.height * 0.7181070,
          size.width * 0.5735346,
          size.height * 0.7181070)
      ..cubicTo(
          size.width * 0.5720850,
          size.height * 0.7181070,
          size.width * 0.5680389,
          size.height * 0.7132099,
          size.width * 0.5636196,
          size.height * 0.7061043)
      ..cubicTo(
          size.width * 0.5527911,
          size.height * 0.6886900,
          size.width * 0.5418545,
          size.height * 0.6487071,
          size.width * 0.5394669,
          size.height * 0.6177984)
      ..lineTo(size.width * 0.5386066, size.height * 0.6066529)
      ..lineTo(size.width * 0.5443732, size.height * 0.6007888)
      ..cubicTo(
          size.width * 0.5603905,
          size.height * 0.5845048,
          size.width * 0.5724986,
          size.height * 0.5583669,
          size.width * 0.5744625,
          size.height * 0.5358368)
      ..lineTo(size.width * 0.5753746, size.height * 0.5253772)
      ..lineTo(size.width * 0.5805548, size.height * 0.5253114)
      ..close();
  }

  Path path24(Size size) {
    return Path()
      ..moveTo(size.width * 0.3338545, size.height * 0.4708505)
      ..cubicTo(
          size.width * 0.3366873,
          size.height * 0.4667010,
          size.width * 0.3392867,
          size.height * 0.4630693,
          size.width * 0.3396311,
          size.height * 0.4627805)
      ..cubicTo(
          size.width * 0.3416556,
          size.height * 0.4610809,
          size.width * 0.3426081,
          size.height * 0.4643361,
          size.width * 0.3435144,
          size.height * 0.4760364)
      ..cubicTo(
          size.width * 0.3446715,
          size.height * 0.4909979,
          size.width * 0.3455072,
          size.height * 0.4895761,
          size.width * 0.3311340,
          size.height * 0.4970988)
      ..cubicTo(
          size.width * 0.3262839,
          size.height * 0.4996372,
          size.width * 0.3204712,
          size.height * 0.5029184,
          size.width * 0.3182176,
          size.height * 0.5043896)
      ..cubicTo(
          size.width * 0.3141643,
          size.height * 0.5070364,
          size.width * 0.3141210,
          size.height * 0.5070446,
          size.width * 0.3141210,
          size.height * 0.5051900)
      ..cubicTo(
          size.width * 0.3141210,
          size.height * 0.5019355,
          size.width * 0.3220231,
          size.height * 0.4881866,
          size.width * 0.3338545,
          size.height * 0.4708505)
      ..close();
  }

  Path path23(Size size) {
    return Path()
      ..moveTo(size.width * 0.6561931, size.height * 0.4818841)
      ..cubicTo(
          size.width * 0.6566945,
          size.height * 0.4777016,
          size.width * 0.6574971,
          size.height * 0.4717332,
          size.width * 0.6579741,
          size.height * 0.4686214)
      ..cubicTo(
          size.width * 0.6584510,
          size.height * 0.4655096,
          size.width * 0.6593934,
          size.height * 0.4629630,
          size.width * 0.6600663,
          size.height * 0.4629630)
      ..cubicTo(
          size.width * 0.6614611,
          size.height * 0.4629630,
          size.width * 0.6732406,
          size.height * 0.4802682,
          size.width * 0.6807320,
          size.height * 0.4933237)
      ..cubicTo(
          size.width * 0.6862752,
          size.height * 0.5029835,
          size.width * 0.6880346,
          size.height * 0.5068587,
          size.width * 0.6868761,
          size.height * 0.5068587)
      ..cubicTo(
          size.width * 0.6864568,
          size.height * 0.5068587,
          size.width * 0.6833040,
          size.height * 0.5052051,
          size.width * 0.6798718,
          size.height * 0.5031845)
      ..cubicTo(
          size.width * 0.6764395,
          size.height * 0.5011639,
          size.width * 0.6695014,
          size.height * 0.4972551,
          size.width * 0.6644553,
          size.height * 0.4944993)
      ..lineTo(size.width * 0.6552795, size.height * 0.4894883)
      ..lineTo(size.width * 0.6561931, size.height * 0.4818841)
      ..close();
  }

  Path path22(Size size) {
    return Path()
      ..moveTo(size.width * 0.3556297, size.height * 0.4316941)
      ..cubicTo(
          size.width * 0.3611052,
          size.height * 0.4231139,
          size.width * 0.3727565,
          size.height * 0.4169060,
          size.width * 0.3876081,
          size.height * 0.4146578)
      ..cubicTo(
          size.width * 0.3963573,
          size.height * 0.4133326,
          size.width * 0.4147594,
          size.height * 0.4133381,
          size.width * 0.4255850,
          size.height * 0.4146680)
      ..cubicTo(
          size.width * 0.4519769,
          size.height * 0.4179115,
          size.width * 0.4784885,
          size.height * 0.4282051,
          size.width * 0.4894784,
          size.height * 0.4394760)
      ..lineTo(size.width * 0.4943314, size.height * 0.4444520)
      ..lineTo(size.width * 0.4939236, size.height * 0.4717119)
      ..lineTo(size.width * 0.4935159, size.height * 0.4989712)
      ..lineTo(size.width * 0.4893775, size.height * 0.5029829)
      ..cubicTo(
          size.width * 0.4783343,
          size.height * 0.5136879,
          size.width * 0.4508271,
          size.height * 0.5212730,
          size.width * 0.4231196,
          size.height * 0.5212538)
      ..cubicTo(
          size.width * 0.3948761,
          size.height * 0.5212346,
          size.width * 0.3755490,
          size.height * 0.5153978,
          size.width * 0.3630634,
          size.height * 0.5031187)
      ..cubicTo(
          size.width * 0.3558573,
          size.height * 0.4960322,
          size.width * 0.3547608,
          size.height * 0.4910233,
          size.width * 0.3535072,
          size.height * 0.4594815)
      ..cubicTo(
          size.width * 0.3526297,
          size.height * 0.4373532,
          size.width * 0.3527118,
          size.height * 0.4362661,
          size.width * 0.3556297,
          size.height * 0.4316941)
      ..close();
  }

  Path path21(Size size) {
    return Path()
      ..moveTo(size.width * 0.5091671, size.height * 0.4389575)
      ..cubicTo(
          size.width * 0.5215159,
          size.height * 0.4276598,
          size.width * 0.5464640,
          size.height * 0.4180569,
          size.width * 0.5724524,
          size.height * 0.4145974)
      ..cubicTo(
          size.width * 0.5843660,
          size.height * 0.4130117,
          size.width * 0.6069568,
          size.height * 0.4135350,
          size.width * 0.6158833,
          size.height * 0.4156036)
      ..cubicTo(
          size.width * 0.6289827,
          size.height * 0.4186385,
          size.width * 0.6379121,
          size.height * 0.4242373,
          size.width * 0.6432104,
          size.height * 0.4327380)
      ..cubicTo(
          size.width * 0.6460231,
          size.height * 0.4372490,
          size.width * 0.6463444,
          size.height * 0.4548217,
          size.width * 0.6440029,
          size.height * 0.4761283)
      ..cubicTo(
          size.width * 0.6420375,
          size.height * 0.4940158,
          size.width * 0.6408818,
          size.height * 0.4977791,
          size.width * 0.6357608,
          size.height * 0.5029547)
      ..cubicTo(
          size.width * 0.6269150,
          size.height * 0.5118957,
          size.width * 0.6130749,
          size.height * 0.5176962,
          size.width * 0.5944827,
          size.height * 0.5202551)
      ..cubicTo(
          size.width * 0.5809164,
          size.height * 0.5221221,
          size.width * 0.5600548,
          size.height * 0.5214184,
          size.width * 0.5461095,
          size.height * 0.5186241)
      ..cubicTo(
          size.width * 0.5256340,
          size.height * 0.5145206,
          size.width * 0.5093963,
          size.height * 0.5063903,
          size.width * 0.5057392,
          size.height * 0.4984108)
      ..cubicTo(
          size.width * 0.5046369,
          size.height * 0.4960062,
          size.width * 0.5042608,
          size.height * 0.4864204,
          size.width * 0.5045764,
          size.height * 0.4687929)
      ..lineTo(size.width * 0.5050432, size.height * 0.4427298)
      ..lineTo(size.width * 0.5091671, size.height * 0.4389575)
      ..close();
  }

  Path path20(Size size) {
    return Path()
      ..moveTo(size.width * 0.3558026, size.height * 0.3630700)
      ..cubicTo(
          size.width * 0.3598228,
          size.height * 0.3573573,
          size.width * 0.3631124,
          size.height * 0.3517250,
          size.width * 0.3631124,
          size.height * 0.3505528)
      ..cubicTo(
          size.width * 0.3631124,
          size.height * 0.3474204,
          size.width * 0.3654438,
          size.height * 0.3479582,
          size.width * 0.3680014,
          size.height * 0.3516804)
      ..cubicTo(
          size.width * 0.3773026,
          size.height * 0.3652154,
          size.width * 0.3841801,
          size.height * 0.3907853,
          size.width * 0.3817334,
          size.height * 0.4027359)
      ..cubicTo(
          size.width * 0.3802507,
          size.height * 0.4099739,
          size.width * 0.3796095,
          size.height * 0.4106557,
          size.width * 0.3727334,
          size.height * 0.4122942)
      ..cubicTo(
          size.width * 0.3694236,
          size.height * 0.4130830,
          size.width * 0.3646282,
          size.height * 0.4146715,
          size.width * 0.3620778,
          size.height * 0.4158251)
      ..cubicTo(
          size.width * 0.3564827,
          size.height * 0.4183553,
          size.width * 0.3564467,
          size.height * 0.4183203,
          size.width * 0.3552666,
          size.height * 0.4091221)
      ..cubicTo(
          size.width * 0.3547839,
          size.height * 0.4053498,
          size.width * 0.3526974,
          size.height * 0.3988855,
          size.width * 0.3506326,
          size.height * 0.3947572)
      ..cubicTo(
          size.width * 0.3474092,
          size.height * 0.3883141,
          size.width * 0.3469914,
          size.height * 0.3862730,
          size.width * 0.3476844,
          size.height * 0.3803539)
      ..cubicTo(
          size.width * 0.3483718,
          size.height * 0.3744918,
          size.width * 0.3495893,
          size.height * 0.3718985,
          size.width * 0.3558026,
          size.height * 0.3630700)
      ..close();
  }

  Path path19(Size size) {
    return Path()
      ..moveTo(size.width * 0.6167262, size.height * 0.3957435)
      ..cubicTo(
          size.width * 0.6167017,
          size.height * 0.3842071,
          size.width * 0.6254568,
          size.height * 0.3590357,
          size.width * 0.6326095,
          size.height * 0.3500809)
      ..cubicTo(
          size.width * 0.6343646,
          size.height * 0.3478841,
          size.width * 0.6368876,
          size.height * 0.3485487,
          size.width * 0.6368876,
          size.height * 0.3512071)
      ..cubicTo(
          size.width * 0.6368876,
          size.height * 0.3523176,
          size.width * 0.6401816,
          size.height * 0.3580864,
          size.width * 0.6442089,
          size.height * 0.3640267)
      ..cubicTo(
          size.width * 0.6538444,
          size.height * 0.3782428,
          size.width * 0.6547147,
          size.height * 0.3834108,
          size.width * 0.6492017,
          size.height * 0.3936900)
      ..cubicTo(
          size.width * 0.6466873,
          size.height * 0.3983793,
          size.width * 0.6450836,
          size.height * 0.4035240,
          size.width * 0.6446052,
          size.height * 0.4084362)
      ..cubicTo(
          size.width * 0.6436412,
          size.height * 0.4183436,
          size.width * 0.6435922,
          size.height * 0.4183978,
          size.width * 0.6379222,
          size.height * 0.4157860)
      ..cubicTo(
          size.width * 0.6353718,
          size.height * 0.4146111,
          size.width * 0.6309640,
          size.height * 0.4131893,
          size.width * 0.6281268,
          size.height * 0.4126255)
      ..cubicTo(
          size.width * 0.6252911,
          size.height * 0.4120624,
          size.width * 0.6222478,
          size.height * 0.4111879,
          size.width * 0.6213646,
          size.height * 0.4106811)
      ..cubicTo(
          size.width * 0.6190908,
          size.height * 0.4093772,
          size.width * 0.6167378,
          size.height * 0.4018032,
          size.width * 0.6167262,
          size.height * 0.3957435)
      ..close();
  }

  Path path18(Size size) {
    return Path()
      ..moveTo(size.width * 0.4077219, size.height * 0.3631433)
      ..cubicTo(
          size.width * 0.4359553,
          size.height * 0.3581468,
          size.width * 0.4563530,
          size.height * 0.3519403,
          size.width * 0.4791066,
          size.height * 0.3414225)
      ..cubicTo(
          size.width * 0.4862392,
          size.height * 0.3381255,
          size.width * 0.4925605,
          size.height * 0.3354191,
          size.width * 0.4931556,
          size.height * 0.3354095)
      ..cubicTo(
          size.width * 0.4937507,
          size.height * 0.3353992,
          size.width * 0.4942363,
          size.height * 0.3566872,
          size.width * 0.4942363,
          size.height * 0.3827160)
      ..cubicTo(
          size.width * 0.4942363,
          size.height * 0.4087449,
          size.width * 0.4939510,
          size.height * 0.4300412,
          size.width * 0.4936037,
          size.height * 0.4300412)
      ..cubicTo(
          size.width * 0.4932565,
          size.height * 0.4300412,
          size.width * 0.4869337,
          size.height * 0.4271646,
          size.width * 0.4795548,
          size.height * 0.4236488)
      ..cubicTo(
          size.width * 0.4692061,
          size.height * 0.4187181,
          size.width * 0.4634928,
          size.height * 0.4166111,
          size.width * 0.4545677,
          size.height * 0.4144335)
      ..cubicTo(
          size.width * 0.4409510,
          size.height * 0.4111111,
          size.width * 0.4247939,
          size.height * 0.4090302,
          size.width * 0.4077810,
          size.height * 0.4084081)
      ..lineTo(size.width * 0.3955331, size.height * 0.4079595)
      ..lineTo(size.width * 0.3955072, size.height * 0.3934520)
      ..cubicTo(
          size.width * 0.3954928,
          size.height * 0.3853032,
          size.width * 0.3946671,
          size.height * 0.3762702,
          size.width * 0.3936239,
          size.height * 0.3728436)
      ..cubicTo(
          size.width * 0.3925202,
          size.height * 0.3692167,
          size.width * 0.3922954,
          size.height * 0.3664931,
          size.width * 0.3930692,
          size.height * 0.3661248)
      ..cubicTo(
          size.width * 0.3937839,
          size.height * 0.3657846,
          size.width * 0.4003775,
          size.height * 0.3644424,
          size.width * 0.4077219,
          size.height * 0.3631433)
      ..close();
  }

  Path path17(Size size) {
    return Path()
      ..moveTo(size.width * 0.5068444, size.height * 0.4300144)
      ..cubicTo(
          size.width * 0.5062493,
          size.height * 0.4300288,
          size.width * 0.5057637,
          size.height * 0.4087449,
          size.width * 0.5057637,
          size.height * 0.3827160)
      ..cubicTo(
          size.width * 0.5057637,
          size.height * 0.3566872,
          size.width * 0.5062680,
          size.height * 0.3353909,
          size.width * 0.5068862,
          size.height * 0.3353909)
      ..cubicTo(
          size.width * 0.5075029,
          size.height * 0.3353909,
          size.width * 0.5122046,
          size.height * 0.3374287,
          size.width * 0.5173329,
          size.height * 0.3399191)
      ..cubicTo(
          size.width * 0.5394856,
          size.height * 0.3506776,
          size.width * 0.5627997,
          size.height * 0.3579801,
          size.width * 0.5914986,
          size.height * 0.3631488)
      ..cubicTo(
          size.width * 0.6002161,
          size.height * 0.3647188,
          size.width * 0.6073329,
          size.height * 0.3662915,
          size.width * 0.6073127,
          size.height * 0.3666433)
      ..cubicTo(
          size.width * 0.6072925,
          size.height * 0.3669959,
          size.width * 0.6064121,
          size.height * 0.3713155,
          size.width * 0.6053573,
          size.height * 0.3762428)
      ..cubicTo(
          size.width * 0.6042637,
          size.height * 0.3813477,
          size.width * 0.6036599,
          size.height * 0.3900940,
          size.width * 0.6039524,
          size.height * 0.3965727)
      ..lineTo(size.width * 0.6044669, size.height * 0.4079438)
      ..lineTo(size.width * 0.5914986, size.height * 0.4083978)
      ..cubicTo(
          size.width * 0.5594308,
          size.height * 0.4095199,
          size.width * 0.5282277,
          size.height * 0.4168519,
          size.width * 0.5126657,
          size.height * 0.4269204)
      ..cubicTo(
          size.width * 0.5100576,
          size.height * 0.4286077,
          size.width * 0.5074395,
          size.height * 0.4300000,
          size.width * 0.5068444,
          size.height * 0.4300144)
      ..close();
  }

  Path path16(Size size) {
    return Path()
      ..moveTo(size.width * 0.1312147, size.height * 0.3491571)
      ..cubicTo(
          size.width * 0.1370115,
          size.height * 0.3417394,
          size.width * 0.1483501,
          size.height * 0.3331214,
          size.width * 0.1639928,
          size.height * 0.3242455)
      ..cubicTo(
          size.width * 0.1691455,
          size.height * 0.3213217,
          size.width * 0.1738372,
          size.height * 0.3189300,
          size.width * 0.1744207,
          size.height * 0.3189300)
      ..cubicTo(
          size.width * 0.1775159,
          size.height * 0.3189300,
          size.width * 0.1806513,
          size.height * 0.3330199,
          size.width * 0.1796110,
          size.height * 0.3422497)
      ..cubicTo(
          size.width * 0.1785879,
          size.height * 0.3513278,
          size.width * 0.1756844,
          size.height * 0.3572846,
          size.width * 0.1667061,
          size.height * 0.3687332)
      ..cubicTo(
          size.width * 0.1595432,
          size.height * 0.3778676,
          size.width * 0.1556196,
          size.height * 0.3852977,
          size.width * 0.1556196,
          size.height * 0.3897298)
      ..cubicTo(
          size.width * 0.1556196,
          size.height * 0.3936783,
          size.width * 0.1495576,
          size.height * 0.3995823,
          size.width * 0.1295548,
          size.height * 0.4151125)
      ..cubicTo(
          size.width * 0.1207378,
          size.height * 0.4219582,
          size.width * 0.1124683,
          size.height * 0.4286132,
          size.width * 0.1111787,
          size.height * 0.4299005)
      ..cubicTo(
          size.width * 0.1089294,
          size.height * 0.4321461,
          size.width * 0.1085821,
          size.height * 0.4322250,
          size.width * 0.1026628,
          size.height * 0.4318388)
      ..cubicTo(
          size.width * 0.09235591,
          size.height * 0.4311660,
          size.width * 0.08361960,
          size.height * 0.4285981,
          size.width * 0.07985735,
          size.height * 0.4251358)
      ..cubicTo(
          size.width * 0.07802594,
          size.height * 0.4234492,
          size.width * 0.07836167,
          size.height * 0.4228210,
          size.width * 0.08434294,
          size.height * 0.4167284)
      ..cubicTo(
          size.width * 0.1016960,
          size.height * 0.3990514,
          size.width * 0.1174164,
          size.height * 0.3773532,
          size.width * 0.1245980,
          size.height * 0.3611598)
      ..cubicTo(
          size.width * 0.1265951,
          size.height * 0.3566605,
          size.width * 0.1295720,
          size.height * 0.3512593,
          size.width * 0.1312147,
          size.height * 0.3491571)
      ..close();
  }

  Path path15(Size size) {
    return Path()
      ..moveTo(size.width * 0.8198847, size.height * 0.3387202)
      ..cubicTo(
          size.width * 0.8198847,
          size.height * 0.3315254,
          size.width * 0.8216383,
          size.height * 0.3224856,
          size.width * 0.8235692,
          size.height * 0.3197305)
      ..cubicTo(
          size.width * 0.8239207,
          size.height * 0.3192277,
          size.width * 0.8247983,
          size.height * 0.3189191,
          size.width * 0.8255173,
          size.height * 0.3190446)
      ..cubicTo(
          size.width * 0.8281110,
          size.height * 0.3194973,
          size.width * 0.8450965,
          size.height * 0.3296900,
          size.width * 0.8532911,
          size.height * 0.3357106)
      ..cubicTo(
          size.width * 0.8642450,
          size.height * 0.3437586,
          size.width * 0.8696254,
          size.height * 0.3500686,
          size.width * 0.8747450,
          size.height * 0.3608759)
      ..cubicTo(
          size.width * 0.8799870,
          size.height * 0.3719424,
          size.width * 0.8849193,
          size.height * 0.3801344,
          size.width * 0.8921499,
          size.height * 0.3897826)
      ..cubicTo(
          size.width * 0.8994524,
          size.height * 0.3995267,
          size.width * 0.9113905,
          size.height * 0.4135494,
          size.width * 0.9166268,
          size.height * 0.4185329)
      ..cubicTo(
          size.width * 0.9218415,
          size.height * 0.4234966,
          size.width * 0.9217954,
          size.height * 0.4246365,
          size.width * 0.9162738,
          size.height * 0.4272647)
      ..cubicTo(
          size.width * 0.9104582,
          size.height * 0.4300329,
          size.width * 0.9050101,
          size.height * 0.4313381,
          size.width * 0.8971196,
          size.height * 0.4318525)
      ..cubicTo(
          size.width * 0.8908112,
          size.height * 0.4322641,
          size.width * 0.8906945,
          size.height * 0.4322346,
          size.width * 0.8877738,
          size.height * 0.4295096)
      ..cubicTo(
          size.width * 0.8861470,
          size.height * 0.4279918,
          size.width * 0.8775591,
          size.height * 0.4210864,
          size.width * 0.8686902,
          size.height * 0.4141639)
      ..cubicTo(
          size.width * 0.8475677,
          size.height * 0.3976770,
          size.width * 0.8446383,
          size.height * 0.3946241,
          size.width * 0.8428833,
          size.height * 0.3872743)
      ..cubicTo(
          size.width * 0.8414726,
          size.height * 0.3813676,
          size.width * 0.8393127,
          size.height * 0.3777119,
          size.width * 0.8293127,
          size.height * 0.3643128)
      ..cubicTo(
          size.width * 0.8221960,
          size.height * 0.3547778,
          size.width * 0.8198847,
          size.height * 0.3485041,
          size.width * 0.8198847,
          size.height * 0.3387202)
      ..close();
  }

  Path path14(Size size) {
    return Path()
      ..moveTo(size.width * 0.2092406, size.height * 0.3452140)
      ..cubicTo(
          size.width * 0.2176931,
          size.height * 0.3400837,
          size.width * 0.2348847,
          size.height * 0.3323422,
          size.width * 0.2452695,
          size.height * 0.3289911)
      ..cubicTo(
          size.width * 0.2494553,
          size.height * 0.3276399,
          size.width * 0.2535303,
          size.height * 0.3266303,
          size.width * 0.2543228,
          size.height * 0.3267483)
      ..cubicTo(
          size.width * 0.2564207,
          size.height * 0.3270597,
          size.width * 0.2555216,
          size.height * 0.3353299,
          size.width * 0.2528429,
          size.height * 0.3403505)
      ..cubicTo(
          size.width * 0.2456945,
          size.height * 0.3537455,
          size.width * 0.2181412,
          size.height * 0.3722915,
          size.width * 0.1840202,
          size.height * 0.3866742)
      ..cubicTo(
          size.width * 0.1762089,
          size.height * 0.3899671,
          size.width * 0.1692161,
          size.height * 0.3927641,
          size.width * 0.1684813,
          size.height * 0.3928896)
      ..cubicTo(
          size.width * 0.1665908,
          size.height * 0.3932140,
          size.width * 0.1668213,
          size.height * 0.3910871,
          size.width * 0.1692810,
          size.height * 0.3855213)
      ..cubicTo(
          size.width * 0.1748746,
          size.height * 0.3728649,
          size.width * 0.1917839,
          size.height * 0.3558086,
          size.width * 0.2092406,
          size.height * 0.3452140)
      ..close();
  }

  Path path13(Size size) {
    return Path()
      ..moveTo(size.width * 0.7966758, size.height * 0.3781639)
      ..cubicTo(
          size.width * 0.7626960,
          size.height * 0.3610919,
          size.width * 0.7435159,
          size.height * 0.3436626,
          size.width * 0.7435159,
          size.height * 0.3298594)
      ..cubicTo(
          size.width * 0.7435159,
          size.height * 0.3278128,
          size.width * 0.7441556,
          size.height * 0.3264746,
          size.width * 0.7451340,
          size.height * 0.3264746)
      ..cubicTo(
          size.width * 0.7484078,
          size.height * 0.3264746,
          size.width * 0.7661801,
          size.height * 0.3330802,
          size.width * 0.7775058,
          size.height * 0.3385062)
      ..cubicTo(
          size.width * 0.7964121,
          size.height * 0.3475652,
          size.width * 0.8150000,
          size.height * 0.3625549,
          size.width * 0.8248213,
          size.height * 0.3766632)
      ..cubicTo(
          size.width * 0.8299107,
          size.height * 0.3839733,
          size.width * 0.8332219,
          size.height * 0.3921289,
          size.width * 0.8313256,
          size.height * 0.3926866)
      ..cubicTo(
          size.width * 0.8301225,
          size.height * 0.3930405,
          size.width * 0.8069755,
          size.height * 0.3833395,
          size.width * 0.7966758,
          size.height * 0.3781639)
      ..close();
  }

  Path path12(Size size) {
    return Path()
      ..moveTo(size.width * 0.2614207, size.height * 0.2616694)
      ..cubicTo(
          size.width * 0.2698934,
          size.height * 0.2496187,
          size.width * 0.2848458,
          size.height * 0.2372195,
          size.width * 0.2936513,
          size.height * 0.2349444)
      ..cubicTo(
          size.width * 0.2974654,
          size.height * 0.2339588,
          size.width * 0.3011527,
          size.height * 0.2335844,
          size.width * 0.3011527,
          size.height * 0.2341824)
      ..cubicTo(
          size.width * 0.3011527,
          size.height * 0.2343477,
          size.width * 0.3001124,
          size.height * 0.2365850,
          size.width * 0.2988401,
          size.height * 0.2391550)
      ..cubicTo(
          size.width * 0.2958847,
          size.height * 0.2451221,
          size.width * 0.2968271,
          size.height * 0.2678210,
          size.width * 0.3004510,
          size.height * 0.2780343)
      ..lineTo(size.width * 0.3028545, size.height * 0.2848066)
      ..lineTo(size.width * 0.2977709, size.height * 0.2896941)
      ..cubicTo(
          size.width * 0.2907522,
          size.height * 0.2964403,
          size.width * 0.2715058,
          size.height * 0.3076207,
          size.width * 0.2505562,
          size.height * 0.3171221)
      ..cubicTo(
          size.width * 0.2408790,
          size.height * 0.3215117,
          size.width * 0.2324179,
          size.height * 0.3251029,
          size.width * 0.2317536,
          size.height * 0.3251029)
      ..cubicTo(
          size.width * 0.2287046,
          size.height * 0.3251029,
          size.width * 0.2311239,
          size.height * 0.3207215,
          size.width * 0.2370836,
          size.height * 0.3154513)
      ..cubicTo(
          size.width * 0.2494683,
          size.height * 0.3044973,
          size.width * 0.2493112,
          size.height * 0.3047764,
          size.width * 0.2498977,
          size.height * 0.2925898)
      ..cubicTo(
          size.width * 0.2504856,
          size.height * 0.2803306,
          size.width * 0.2529496,
          size.height * 0.2737202,
          size.width * 0.2614207,
          size.height * 0.2616694)
      ..close();
  }

  Path path11(Size size) {
    return Path()
      ..moveTo(size.width * 0.6981455, size.height * 0.2769781)
      ..cubicTo(
          size.width * 0.7027392,
          size.height * 0.2626866,
          size.width * 0.7026484,
          size.height * 0.2436756,
          size.width * 0.6979496,
          size.height * 0.2354252)
      ..cubicTo(
          size.width * 0.6974366,
          size.height * 0.2345261,
          size.width * 0.6977133,
          size.height * 0.2338820,
          size.width * 0.6986110,
          size.height * 0.2338820)
      ..cubicTo(
          size.width * 0.7089942,
          size.height * 0.2338820,
          size.width * 0.7255663,
          size.height * 0.2458498,
          size.width * 0.7362507,
          size.height * 0.2610645)
      ..cubicTo(
          size.width * 0.7456037,
          size.height * 0.2743820,
          size.width * 0.7480317,
          size.height * 0.2807160,
          size.width * 0.7485533,
          size.height * 0.2931626)
      ..lineTo(size.width * 0.7490115, size.height * 0.3040885)
      ..lineTo(size.width * 0.7585115, size.height * 0.3129362)
      ..cubicTo(
          size.width * 0.7673458,
          size.height * 0.3211646,
          size.width * 0.7699726,
          size.height * 0.3251029,
          size.width * 0.7666268,
          size.height * 0.3251029)
      ..cubicTo(
          size.width * 0.7639020,
          size.height * 0.3251029,
          size.width * 0.7284179,
          size.height * 0.3081749,
          size.width * 0.7174510,
          size.height * 0.3016427)
      ..cubicTo(
          size.width * 0.7113026,
          size.height * 0.2979822,
          size.width * 0.7038833,
          size.height * 0.2926838,
          size.width * 0.7009611,
          size.height * 0.2898690)
      ..lineTo(size.width * 0.6956470, size.height * 0.2847517)
      ..lineTo(size.width * 0.6981455, size.height * 0.2769781)
      ..close();
  }

  Path path10(Size size) {
    return Path()
      ..moveTo(size.width * 0.2293184, size.height * 0.2610281)
      ..cubicTo(
          size.width * 0.2359380,
          size.height * 0.2576626,
          size.width * 0.2451282,
          size.height * 0.2534143,
          size.width * 0.2497406,
          size.height * 0.2515864)
      ..cubicTo(
          size.width * 0.2543545,
          size.height * 0.2497593,
          size.width * 0.2586354,
          size.height * 0.2484136,
          size.width * 0.2592565,
          size.height * 0.2485960)
      ..cubicTo(
          size.width * 0.2598775,
          size.height * 0.2487785,
          size.width * 0.2575490,
          size.height * 0.2523368,
          size.width * 0.2540821,
          size.height * 0.2565021)
      ..cubicTo(
          size.width * 0.2459265,
          size.height * 0.2663032,
          size.width * 0.2392579,
          size.height * 0.2786536,
          size.width * 0.2381513,
          size.height * 0.2860082)
      ..cubicTo(
          size.width * 0.2372882,
          size.height * 0.2917449,
          size.width * 0.2371772,
          size.height * 0.2918827,
          size.width * 0.2312291,
          size.height * 0.2946351)
      ..cubicTo(
          size.width * 0.2250735,
          size.height * 0.2974829,
          size.width * 0.2248026,
          size.height * 0.2977819,
          size.width * 0.2163329,
          size.height * 0.3111015)
      ..cubicTo(
          size.width * 0.2146340,
          size.height * 0.3137743,
          size.width * 0.2112723,
          size.height * 0.3173765,
          size.width * 0.2088646,
          size.height * 0.3191070)
      ..cubicTo(
          size.width * 0.2043559,
          size.height * 0.3223477,
          size.width * 0.1941138,
          size.height * 0.3271605,
          size.width * 0.1917262,
          size.height * 0.3271605)
      ..cubicTo(
          size.width * 0.1875490,
          size.height * 0.3271605,
          size.width * 0.1882248,
          size.height * 0.3155144,
          size.width * 0.1929683,
          size.height * 0.3057373)
      ..cubicTo(
          size.width * 0.1944813,
          size.height * 0.3026193,
          size.width * 0.1961614,
          size.height * 0.2982167,
          size.width * 0.1967017,
          size.height * 0.2959534)
      ..cubicTo(
          size.width * 0.2000548,
          size.height * 0.2819143,
          size.width * 0.2107406,
          size.height * 0.2704712,
          size.width * 0.2293184,
          size.height * 0.2610281)
      ..close();
  }

  Path path9(Size size) {
    return Path()
      ..moveTo(size.width * 0.7413876, size.height * 0.2528450)
      ..cubicTo(
          size.width * 0.7394827,
          size.height * 0.2507949,
          size.width * 0.7382954,
          size.height * 0.2489410,
          size.width * 0.7387478,
          size.height * 0.2487257)
      ..cubicTo(
          size.width * 0.7402450,
          size.height * 0.2480130,
          size.width * 0.7447104,
          size.height * 0.2496125,
          size.width * 0.7578804,
          size.height * 0.2555782)
      ..cubicTo(
          size.width * 0.7740375,
          size.height * 0.2628971,
          size.width * 0.7827248,
          size.height * 0.2682977,
          size.width * 0.7897277,
          size.height * 0.2753772)
      ..cubicTo(
          size.width * 0.7960303,
          size.height * 0.2817497,
          size.width * 0.7987579,
          size.height * 0.2864177,
          size.width * 0.8017839,
          size.height * 0.2960123)
      ..cubicTo(
          size.width * 0.8029841,
          size.height * 0.2998169,
          size.width * 0.8049006,
          size.height * 0.3049095,
          size.width * 0.8060432,
          size.height * 0.3073292)
      ..cubicTo(
          size.width * 0.8102522,
          size.height * 0.3162476,
          size.width * 0.8106254,
          size.height * 0.3271605,
          size.width * 0.8067190,
          size.height * 0.3271605)
      ..cubicTo(
          size.width * 0.8036513,
          size.height * 0.3271605,
          size.width * 0.7911628,
          size.height * 0.3207106,
          size.width * 0.7871138,
          size.height * 0.3170350)
      ..cubicTo(
          size.width * 0.7847291,
          size.height * 0.3148711,
          size.width * 0.7810793,
          size.height * 0.3102346,
          size.width * 0.7790014,
          size.height * 0.3067325)
      ..cubicTo(
          size.width * 0.7743213,
          size.height * 0.2988409,
          size.width * 0.7707738,
          size.height * 0.2954657,
          size.width * 0.7651628,
          size.height * 0.2935638)
      ..cubicTo(
          size.width * 0.7613055,
          size.height * 0.2922565,
          size.width * 0.7608069,
          size.height * 0.2916934,
          size.width * 0.7608069,
          size.height * 0.2886413)
      ..cubicTo(
          size.width * 0.7608069,
          size.height * 0.2815802,
          size.width * 0.7505937,
          size.height * 0.2627531,
          size.width * 0.7413876,
          size.height * 0.2528450)
      ..close();
  }

  Path path8(Size size) {
    return Path()
      ..moveTo(size.width * 0.3626282, size.height * 0.2220761)
      ..cubicTo(
          size.width * 0.3741556,
          size.height * 0.2193683,
          size.width * 0.3919308,
          size.height * 0.2131975,
          size.width * 0.3919308,
          size.height * 0.2119033)
      ..cubicTo(
          size.width * 0.3919308,
          size.height * 0.2115432,
          size.width * 0.3928184,
          size.height * 0.2112483,
          size.width * 0.3939020,
          size.height * 0.2112483)
      ..cubicTo(
          size.width * 0.3965735,
          size.height * 0.2112483,
          size.width * 0.3974784,
          size.height * 0.2146831,
          size.width * 0.3986225,
          size.height * 0.2291804)
      ..lineTo(size.width * 0.3995778, size.height * 0.2412826)
      ..lineTo(size.width * 0.3953660, size.height * 0.2423196)
      ..cubicTo(
          size.width * 0.3930476,
          size.height * 0.2428896,
          size.width * 0.3873184,
          size.height * 0.2436941,
          size.width * 0.3826311,
          size.height * 0.2441063)
      ..cubicTo(
          size.width * 0.3575259,
          size.height * 0.2463155,
          size.width * 0.3339438,
          size.height * 0.2426886,
          size.width * 0.3203862,
          size.height * 0.2345329)
      ..lineTo(size.width * 0.3153530, size.height * 0.2315062)
      ..lineTo(size.width * 0.3183746, size.height * 0.2303416)
      ..cubicTo(
          size.width * 0.3200360,
          size.height * 0.2297010,
          size.width * 0.3280259,
          size.height * 0.2282010,
          size.width * 0.3361297,
          size.height * 0.2270082)
      ..cubicTo(
          size.width * 0.3442334,
          size.height * 0.2258155,
          size.width * 0.3561585,
          size.height * 0.2235960,
          size.width * 0.3626282,
          size.height * 0.2220761)
      ..close();
  }

  Path path7(Size size) {
    return Path()
      ..moveTo(size.width * 0.6013530, size.height * 0.2278608)
      ..cubicTo(
          size.width * 0.6018530,
          size.height * 0.2207984,
          size.width * 0.6026729,
          size.height * 0.2141722,
          size.width * 0.6031729,
          size.height * 0.2131344)
      ..cubicTo(
          size.width * 0.6043012,
          size.height * 0.2107956,
          size.width * 0.6052147,
          size.height * 0.2107819,
          size.width * 0.6096196,
          size.height * 0.2130370)
      ..cubicTo(
          size.width * 0.6141686,
          size.height * 0.2153669,
          size.width * 0.6286599,
          size.height * 0.2202620,
          size.width * 0.6368876,
          size.height * 0.2222490)
      ..cubicTo(
          size.width * 0.6404539,
          size.height * 0.2231104,
          size.width * 0.6521239,
          size.height * 0.2252311,
          size.width * 0.6628213,
          size.height * 0.2269623)
      ..cubicTo(
          size.width * 0.6767579,
          size.height * 0.2292174,
          size.width * 0.6824006,
          size.height * 0.2304444,
          size.width * 0.6827305,
          size.height * 0.2312901)
      ..cubicTo(
          size.width * 0.6834308,
          size.height * 0.2330823,
          size.width * 0.6704265,
          size.height * 0.2392551,
          size.width * 0.6614063,
          size.height * 0.2414115)
      ..cubicTo(
          size.width * 0.6521974,
          size.height * 0.2436139,
          size.width * 0.6412248,
          size.height * 0.2448560,
          size.width * 0.6309769,
          size.height * 0.2448560)
      ..cubicTo(
          size.width * 0.6215432,
          size.height * 0.2448560,
          size.width * 0.6044193,
          size.height * 0.2429815,
          size.width * 0.6021931,
          size.height * 0.2417051)
      ..cubicTo(
          size.width * 0.6008818,
          size.height * 0.2409534,
          size.width * 0.6006715,
          size.height * 0.2374739,
          size.width * 0.6013530,
          size.height * 0.2278608)
      ..close();
  }

  Path path6(Size size) {
    return Path()
      ..moveTo(size.width * 0.3083631, size.height * 0.2458848)
      ..cubicTo(
          size.width * 0.3093285,
          size.height * 0.2424897,
          size.width * 0.3104078,
          size.height * 0.2394808,
          size.width * 0.3107637,
          size.height * 0.2391975)
      ..cubicTo(
          size.width * 0.3116844,
          size.height * 0.2384643,
          size.width * 0.3137939,
          size.height * 0.2385617,
          size.width * 0.3148660,
          size.height * 0.2393875)
      ..cubicTo(
          size.width * 0.3153689,
          size.height * 0.2397750,
          size.width * 0.3203818,
          size.height * 0.2416303,
          size.width * 0.3260058,
          size.height * 0.2435103)
      ..cubicTo(
          size.width * 0.3444164,
          size.height * 0.2496646,
          size.width * 0.3660692,
          size.height * 0.2517469,
          size.width * 0.3855043,
          size.height * 0.2492318)
      ..cubicTo(
          size.width * 0.4013890,
          size.height * 0.2471756,
          size.width * 0.4000288,
          size.height * 0.2469767,
          size.width * 0.4010245,
          size.height * 0.2515082)
      ..cubicTo(
          size.width * 0.4034150,
          size.height * 0.2623971,
          size.width * 0.4175605,
          size.height * 0.2818724,
          size.width * 0.4322363,
          size.height * 0.2944829)
      ..cubicTo(
          size.width * 0.4465677,
          size.height * 0.3067963,
          size.width * 0.4680014,
          size.height * 0.3185288,
          size.width * 0.4864035,
          size.height * 0.3241317)
      ..cubicTo(
          size.width * 0.4949395,
          size.height * 0.3267305,
          size.width * 0.4950576,
          size.height * 0.3271180,
          size.width * 0.4885793,
          size.height * 0.3312270)
      ..cubicTo(
          size.width * 0.4758862,
          size.height * 0.3392771,
          size.width * 0.4234438,
          size.height * 0.3560542,
          size.width * 0.3995288,
          size.height * 0.3597147)
      ..cubicTo(
          size.width * 0.3864035,
          size.height * 0.3617243,
          size.width * 0.3863516,
          size.height * 0.3617010,
          size.width * 0.3803804,
          size.height * 0.3511660)
      ..cubicTo(
          size.width * 0.3705850,
          size.height * 0.3338861,
          size.width * 0.3637061,
          size.height * 0.3255933,
          size.width * 0.3555461,
          size.height * 0.3212263)
      ..cubicTo(
          size.width * 0.3322464,
          size.height * 0.3087565,
          size.width * 0.3154481,
          size.height * 0.2872490,
          size.width * 0.3090202,
          size.height * 0.2616598)
      ..cubicTo(
          size.width * 0.3069784,
          size.height * 0.2535322,
          size.width * 0.3068775,
          size.height * 0.2511097,
          size.width * 0.3083631,
          size.height * 0.2458848)
      ..close();
  }

  Path path5(Size size) {
    return Path()
      ..moveTo(size.width * 0.6144957, size.height * 0.2492318)
      ..cubicTo(
          size.width * 0.6357767,
          size.height * 0.2519856,
          size.width * 0.6591239,
          size.height * 0.2492016,
          size.width * 0.6793948,
          size.height * 0.2414938)
      ..cubicTo(
          size.width * 0.6833573,
          size.height * 0.2399877,
          size.width * 0.6870159,
          size.height * 0.2387387,
          size.width * 0.6875259,
          size.height * 0.2387188)
      ..cubicTo(
          size.width * 0.6893343,
          size.height * 0.2386488,
          size.width * 0.6902622,
          size.height * 0.2410021,
          size.width * 0.6911282,
          size.height * 0.2478580)
      ..cubicTo(
          size.width * 0.6939510,
          size.height * 0.2702010,
          size.width * 0.6745548,
          size.height * 0.3026049,
          size.width * 0.6492017,
          size.height * 0.3179012)
      ..cubicTo(
          size.width * 0.6448242,
          size.height * 0.3205418,
          size.width * 0.6390346,
          size.height * 0.3247140,
          size.width * 0.6363343,
          size.height * 0.3271728)
      ..cubicTo(
          size.width * 0.6314942,
          size.height * 0.3315796,
          size.width * 0.6226888,
          size.height * 0.3440597,
          size.width * 0.6166225,
          size.height * 0.3551097)
      ..cubicTo(
          size.width * 0.6136441,
          size.height * 0.3605377,
          size.width * 0.6133487,
          size.height * 0.3607682,
          size.width * 0.6093847,
          size.height * 0.3607682)
      ..cubicTo(
          size.width * 0.5989928,
          size.height * 0.3607682,
          size.width * 0.5714813,
          size.height * 0.3542003,
          size.width * 0.5460720,
          size.height * 0.3456523)
      ..cubicTo(
          size.width * 0.5299337,
          size.height * 0.3402236,
          size.width * 0.5109020,
          size.height * 0.3319582,
          size.width * 0.5076513,
          size.height * 0.3289657)
      ..cubicTo(
          size.width * 0.5054063,
          size.height * 0.3268999,
          size.width * 0.5054438,
          size.height * 0.3268237,
          size.width * 0.5094020,
          size.height * 0.3254643)
      ..cubicTo(
          size.width * 0.5310749,
          size.height * 0.3180178,
          size.width * 0.5437795,
          size.height * 0.3117846,
          size.width * 0.5580793,
          size.height * 0.3015816)
      ..cubicTo(
          size.width * 0.5750403,
          size.height * 0.2894787,
          size.width * 0.5925562,
          size.height * 0.2685672,
          size.width * 0.5976628,
          size.height * 0.2543203)
      ..cubicTo(
          size.width * 0.6004135,
          size.height * 0.2466488,
          size.width * 0.5986513,
          size.height * 0.2471811,
          size.width * 0.6144957,
          size.height * 0.2492318)
      ..close();
  }

  Path path4(Size size) {
    return Path()
      ..moveTo(size.width * 0.2395749, size.height * 0.2063656)
      ..cubicTo(
          size.width * 0.2499582,
          size.height * 0.1877455,
          size.width * 0.2733357,
          size.height * 0.1737202,
          size.width * 0.2996095,
          size.height * 0.1703477)
      ..cubicTo(
          size.width * 0.3131225,
          size.height * 0.1686139,
          size.width * 0.3252911,
          size.height * 0.1698505,
          size.width * 0.3366268,
          size.height * 0.1741104)
      ..cubicTo(
          size.width * 0.3404957,
          size.height * 0.1755638,
          size.width * 0.3501441,
          size.height * 0.1783333,
          size.width * 0.3580692,
          size.height * 0.1802641)
      ..cubicTo(
          size.width * 0.3659942,
          size.height * 0.1821948,
          size.width * 0.3748516,
          size.height * 0.1847092,
          size.width * 0.3777522,
          size.height * 0.1858505)
      ..cubicTo(
          size.width * 0.3888501,
          size.height * 0.1902195,
          size.width * 0.3936009,
          size.height * 0.1986612,
          size.width * 0.3880778,
          size.height * 0.2042010)
      ..cubicTo(
          size.width * 0.3812277,
          size.height * 0.2110720,
          size.width * 0.3598040,
          size.height * 0.2173752,
          size.width * 0.3278285,
          size.height * 0.2219252)
      ..cubicTo(
          size.width * 0.2997017,
          size.height * 0.2259280,
          size.width * 0.2787795,
          size.height * 0.2318251,
          size.width * 0.2556023,
          size.height * 0.2422840)
      ..cubicTo(
          size.width * 0.2499597,
          size.height * 0.2448299,
          size.width * 0.2449841,
          size.height * 0.2469136,
          size.width * 0.2445447,
          size.height * 0.2469136)
      ..cubicTo(
          size.width * 0.2441066,
          size.height * 0.2469136,
          size.width * 0.2427651,
          size.height * 0.2454472,
          size.width * 0.2415634,
          size.height * 0.2436557)
      ..cubicTo(
          size.width * 0.2343804,
          size.height * 0.2329403,
          size.width * 0.2335403,
          size.height * 0.2171893,
          size.width * 0.2395749,
          size.height * 0.2063656)
      ..close();
  }

  Path path3(Size size) {
    return Path()
      ..moveTo(size.width * 0.6606484, size.height * 0.1745562)
      ..cubicTo(
          size.width * 0.6674352,
          size.height * 0.1719472,
          size.width * 0.6720086,
          size.height * 0.1707449,
          size.width * 0.6779539,
          size.height * 0.1700069)
      ..cubicTo(
          size.width * 0.6857939,
          size.height * 0.1690336,
          size.width * 0.6990043,
          size.height * 0.1699623,
          size.width * 0.7082133,
          size.height * 0.1721344)
      ..cubicTo(
          size.width * 0.7435706,
          size.height * 0.1804726,
          size.width * 0.7669928,
          size.height * 0.2056536,
          size.width * 0.7621398,
          size.height * 0.2301097)
      ..cubicTo(
          size.width * 0.7610259,
          size.height * 0.2357250,
          size.width * 0.7564193,
          size.height * 0.2458018,
          size.width * 0.7545620,
          size.height * 0.2466852)
      ..cubicTo(
          size.width * 0.7541455,
          size.height * 0.2468834,
          size.width * 0.7473098,
          size.height * 0.2442723,
          size.width * 0.7393718,
          size.height * 0.2408834)
      ..cubicTo(
          size.width * 0.7147579,
          size.height * 0.2303765,
          size.width * 0.6966988,
          size.height * 0.2254705,
          size.width * 0.6682219,
          size.height * 0.2215535)
      ..cubicTo(
          size.width * 0.6287666,
          size.height * 0.2161269,
          size.width * 0.6076009,
          size.height * 0.2081269,
          size.width * 0.6076916,
          size.height * 0.1986749)
      ..cubicTo(
          size.width * 0.6077666,
          size.height * 0.1908059,
          size.width * 0.6162911,
          size.height * 0.1860075,
          size.width * 0.6404755,
          size.height * 0.1802215)
      ..cubicTo(
          size.width * 0.6483919,
          size.height * 0.1783272,
          size.width * 0.6574697,
          size.height * 0.1757778,
          size.width * 0.6606484,
          size.height * 0.1745562)
      ..close();
  }

  Path path2(Size size) {
    return Path()
      ..moveTo(size.width * 0.5058314, size.height * 0.1018134)
      ..cubicTo(
          size.width * 0.5045476,
          size.height * 0.1025494,
          size.width * 0.5042248,
          size.height * 0.1083176,
          size.width * 0.5045735,
          size.height * 0.1242757)
      ..cubicTo(
          size.width * 0.5051311,
          size.height * 0.1497359,
          size.width * 0.5049409,
          size.height * 0.1493731,
          size.width * 0.5212896,
          size.height * 0.1562894)
      ..cubicTo(
          size.width * 0.5268919,
          size.height * 0.1586598,
          size.width * 0.5318415,
          size.height * 0.1610514,
          size.width * 0.5322867,
          size.height * 0.1616036)
      ..cubicTo(
          size.width * 0.5327839,
          size.height * 0.1622209,
          size.width * 0.5298934,
          size.height * 0.1642524,
          size.width * 0.5247968,
          size.height * 0.1668669)
      ..cubicTo(
          size.width * 0.5148357,
          size.height * 0.1719774,
          size.width * 0.5112190,
          size.height * 0.1746962,
          size.width * 0.5077291,
          size.height * 0.1796982)
      ..cubicTo(
          size.width * 0.5052651,
          size.height * 0.1832311,
          size.width * 0.5050706,
          size.height * 0.1877949,
          size.width * 0.5046571,
          size.height * 0.2516550)
      ..cubicTo(
          size.width * 0.5044150,
          size.height * 0.2891564,
          size.width * 0.5047305,
          size.height * 0.3200844,
          size.width * 0.5053573,
          size.height * 0.3203827)
      ..cubicTo(
          size.width * 0.5070965,
          size.height * 0.3212106,
          size.width * 0.5259957,
          size.height * 0.3134588,
          size.width * 0.5359813,
          size.height * 0.3078217)
      ..cubicTo(
          size.width * 0.5625965,
          size.height * 0.2927984,
          size.width * 0.5793372,
          size.height * 0.2746776,
          size.width * 0.5871830,
          size.height * 0.2524005)
      ..cubicTo(
          size.width * 0.5885634,
          size.height * 0.2484815,
          size.width * 0.5899741,
          size.height * 0.2382311,
          size.width * 0.5907219,
          size.height * 0.2266804)
      ..cubicTo(
          size.width * 0.5929395,
          size.height * 0.1924513,
          size.width * 0.6000014,
          size.height * 0.1834486,
          size.width * 0.6295432,
          size.height * 0.1771941)
      ..cubicTo(
          size.width * 0.6485879,
          size.height * 0.1731626,
          size.width * 0.6558112,
          size.height * 0.1712085,
          size.width * 0.6630749,
          size.height * 0.1681221)
      ..cubicTo(
          size.width * 0.6669611,
          size.height * 0.1664712,
          size.width * 0.6698429,
          size.height * 0.1649781,
          size.width * 0.6694798,
          size.height * 0.1648052)
      ..cubicTo(
          size.width * 0.6691167,
          size.height * 0.1646317,
          size.width * 0.6575821,
          size.height * 0.1621886,
          size.width * 0.6438473,
          size.height * 0.1593759)
      ..cubicTo(
          size.width * 0.5998026,
          size.height * 0.1503546,
          size.width * 0.5692378,
          size.height * 0.1418402,
          size.width * 0.5538040,
          size.height * 0.1342936)
      ..cubicTo(
          size.width * 0.5392579,
          size.height * 0.1271811,
          size.width * 0.5209207,
          size.height * 0.1129829,
          size.width * 0.5134539,
          size.height * 0.1030521)
      ..cubicTo(
          size.width * 0.5116700,
          size.height * 0.1006797,
          size.width * 0.5086599,
          size.height * 0.1001907,
          size.width * 0.5058314,
          size.height * 0.1018134)
      ..close();
  }

  Path path1(Size size) {
    return Path()
      ..moveTo(size.width * 0.4851052, size.height * 0.1030521)
      ..cubicTo(
          size.width * 0.4812925,
          size.height * 0.1081235,
          size.width * 0.4681153,
          size.height * 0.1200274,
          size.width * 0.4610000,
          size.height * 0.1248285)
      ..cubicTo(
          size.width * 0.4405648,
          size.height * 0.1386187,
          size.width * 0.4135418,
          size.height * 0.1473875,
          size.width * 0.3551873,
          size.height * 0.1591660)
      ..cubicTo(
          size.width * 0.3417147,
          size.height * 0.1618855,
          size.width * 0.3301686,
          size.height * 0.1643326,
          size.width * 0.3295288,
          size.height * 0.1646043)
      ..cubicTo(
          size.width * 0.3273963,
          size.height * 0.1655110,
          size.width * 0.3432118,
          size.height * 0.1714794,
          size.width * 0.3543127,
          size.height * 0.1739568)
      ..cubicTo(
          size.width * 0.3603415,
          size.height * 0.1753025,
          size.width * 0.3687709,
          size.height * 0.1771886,
          size.width * 0.3730461,
          size.height * 0.1781495)
      ..cubicTo(
          size.width * 0.3913069,
          size.height * 0.1822524,
          size.width * 0.4004539,
          size.height * 0.1901591,
          size.width * 0.4048386,
          size.height * 0.2056289)
      ..cubicTo(
          size.width * 0.4056614,
          size.height * 0.2085309,
          size.width * 0.4069683,
          size.height * 0.2189300,
          size.width * 0.4077421,
          size.height * 0.2287380)
      ..cubicTo(
          size.width * 0.4092104,
          size.height * 0.2473443,
          size.width * 0.4110130,
          size.height * 0.2544719,
          size.width * 0.4170533,
          size.height * 0.2655357)
      ..cubicTo(
          size.width * 0.4264107,
          size.height * 0.2826804,
          size.width * 0.4440216,
          size.height * 0.2985741,
          size.width * 0.4662752,
          size.height * 0.3099602)
      ..cubicTo(
          size.width * 0.4773055,
          size.height * 0.3156036,
          size.width * 0.4890850,
          size.height * 0.3203018,
          size.width * 0.4922046,
          size.height * 0.3203018)
      ..cubicTo(
          size.width * 0.4939395,
          size.height * 0.3203018,
          size.width * 0.4942320,
          size.height * 0.3107435,
          size.width * 0.4942075,
          size.height * 0.2549726)
      ..cubicTo(
          size.width * 0.4941902,
          size.height * 0.2148018,
          size.width * 0.4936196,
          size.height * 0.1877942,
          size.width * 0.4927277,
          size.height * 0.1848422)
      ..cubicTo(
          size.width * 0.4907824,
          size.height * 0.1784095,
          size.width * 0.4848818,
          size.height * 0.1726632,
          size.width * 0.4750144,
          size.height * 0.1675898)
      ..cubicTo(
          size.width * 0.4705288,
          size.height * 0.1652840,
          size.width * 0.4668588,
          size.height * 0.1627888,
          size.width * 0.4668588,
          size.height * 0.1620453)
      ..cubicTo(
          size.width * 0.4668588,
          size.height * 0.1612346,
          size.width * 0.4709164,
          size.height * 0.1589767,
          size.width * 0.4769928,
          size.height * 0.1564060)
      ..cubicTo(
          size.width * 0.4939164,
          size.height * 0.1492476,
          size.width * 0.4934395,
          size.height * 0.1501406,
          size.width * 0.4939683,
          size.height * 0.1246091)
      ..cubicTo(
          size.width * 0.4944323,
          size.height * 0.1022524,
          size.width * 0.4941268,
          size.height * 0.1008230,
          size.width * 0.4888919,
          size.height * 0.1008230)
      ..cubicTo(
          size.width * 0.4877305,
          size.height * 0.1008230,
          size.width * 0.4860274,
          size.height * 0.1018258,
          size.width * 0.4851052,
          size.height * 0.1030521)
      ..close();
  }
}
