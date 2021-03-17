Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11CA033F965
	for <lists+linux-api@lfdr.de>; Wed, 17 Mar 2021 20:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbhCQTew (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 17 Mar 2021 15:34:52 -0400
Received: from mail-eopbgr1400103.outbound.protection.outlook.com ([40.107.140.103]:35635
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233258AbhCQTes (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 17 Mar 2021 15:34:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajTrF7RZpSjv0X4cNb1iR8+0HF98vXMCaRa6XNUIf1mXB/u4sb2n3APOWtOI+dz6CB5mZWWPbVMumMvI5zoWbjloVa3Xtd+2G9eEOkd+MJXc1gVtrren6DZlz62uBYaOrAmcNVi4ND3mSKO+TnENupa0ggc9jXCD4jYUaNHf1Fns7Wzhm5mJ/n+ux4JysftvPfP9cFqRMY5zyIVgPBxSoED0fFR9YmolHkZjfm0uQeedXncVzKw3x/pyqgk5AqyBtMqO82ZM9S70TAeJIZYbZHejBevsfyiRqxlvWVe+nKQIDir2sRXM3USR3KFrJ8kaEcGM8PnmRQ1D2O4q/HzLGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gbq3zBZZsQ3wGprkjteiNdtnRmOILlDhMlVC8zUdXQg=;
 b=bfW5cKafIvF8iDX/NE65ya0IZxFrO1dlxhIMQiqn5TggS7Ywq4Aa7UlaMGocKdhDELaSS68nbBjwbtfa/oVbKIS77Y83JcgWQqom3ufwz3hBVKl2Ksn7x+yWdCgRL9/DSwPl6cnSpKo/W+ENmqzmt62d1vik5HkV9umC7a4USJ5I8fP18wajqc+iwTVdd02fZFTTb8nhBYBrvA8+0/uqLP7YKBmPy0uMmVW0dPnK3j+Vm1xvjhrMTSIRQsZnWcPzEeuhoeXHQTK/balzb8tT6O4zSlet+ecfNPVOTDp+bxlqs8v9bK9Xs8v2yqmA2AXFCrlyXBwRAPP6/UNCd24B4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gbq3zBZZsQ3wGprkjteiNdtnRmOILlDhMlVC8zUdXQg=;
 b=dDXZ9bDE8l5MS6T4S+BZ5xp0JWwBKyYUYFYgR8khDbWv6s6Rj/VWefsw8Jt+8J/Jcnzqr25w+oiLsoDokgUeuHiJjT5Kkp1+vAxlZxAXfNIuLOXuthoQjhEETEkctVqtTj+qmp7nymIogOmWJr4xRsisBnxaYGEHWxNH08dx3kM=
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com (2603:1096:604:7a::23)
 by OSBPR01MB2933.jpnprd01.prod.outlook.com (2603:1096:604:16::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 19:34:45 +0000
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433]) by OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433%7]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 19:34:44 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: RE: [PATCH net-next v1] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Thread-Topic: [PATCH net-next v1] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Thread-Index: AQHXG2GRAbvHLXA2TkeXL57CD6n/lKqIjkEAgAABJgA=
Date:   Wed, 17 Mar 2021 19:34:44 +0000
Message-ID: <OSBPR01MB4773D4FAD63E114761654006BA6A9@OSBPR01MB4773.jpnprd01.prod.outlook.com>
References: <1616007596-2402-1-git-send-email-min.li.xe@renesas.com>
 <YFJWWrX+UgXyD9NS@kroah.com>
In-Reply-To: <YFJWWrX+UgXyD9NS@kroah.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=renesas.com;
x-originating-ip: [72.140.114.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e6f02177-f26b-48db-b3a8-08d8e97bb7cd
x-ms-traffictypediagnostic: OSBPR01MB2933:
x-microsoft-antispam-prvs: <OSBPR01MB29331A24B1BD88E1A3A8974CBA6A9@OSBPR01MB2933.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lt+ZCP672OgSXTxEBoqa+kknvUkPrfU70P6fCq2YxAXqxTjkuMWQv4FdltkkpFXSiJfvlMIL+GF4wVs1e6ugQpHMFVQR9l771j/Et2pTKH+l11LG3wxQxSiVj2HUEF8e09yi5td1wzNW6ysQwTcfpQHhmS4twXiltKaYj0GQnXg/fPeGVx3IF5frxVKRE5yfmqDCHl3D/3sWGzFhQnKAWC8XHEhV7DdnfO3RiNPqUa8RP+VILrhxPzAJ4tU1Ylg0QSh4FE/jqAykwfrDm8XA574Bv9G3WFp9AtQKwuChMD6Zi+Pjl7KXU0HURw+ttavpw/q8CzZukgfJrtsNbJF4aGbZcH9IHuI236GZsbpyW4s4S5/HbPVOdNuld3zMle9xTMrf78yPe6p0XxRMBz0Zwqkq2d2YMcMO5WFDuG4KDeEKSppq3VKyMouInfdj+FUVkG26rXWcCtmft3t1/ontqkA0bUV8QpsZkJCcyh4FRONuTJedaKKv9sThzggOFB09SZEL4xaukmu4k8JLbuoWWlJTdniqBUwEExp7ski4M023AoC+PE+4VYIwAcs/MCN6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4773.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(54906003)(66556008)(4326008)(8676002)(66446008)(64756008)(5660300002)(316002)(26005)(53546011)(66476007)(76116006)(71200400001)(478600001)(66946007)(6916009)(6506007)(33656002)(8936002)(52536014)(55016002)(86362001)(2906002)(7696005)(83380400001)(186003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?xAwqN3f5wanUHXQaOiicdV2XJsOQpqHVgL3bbXaociUKZxyFt4pA5p8aZrC9?=
 =?us-ascii?Q?VQcxYLoJB3xuUVDTgcuXY+SwgJC3Y4KHuk7kTGPgfxe2XK/8y2LyU9kru7fA?=
 =?us-ascii?Q?iZKI+4n3U2OtvvaGX2Egliq/hZHsQ+/HpL/PrVgaB1NXDoLL4KdOkVOi6UYF?=
 =?us-ascii?Q?StlEK5ZfREtrQhex/4w77XXUFYOc+WThWihJ8bRjfxI2edq2MptwcFZ7l+gJ?=
 =?us-ascii?Q?PRAVPNLMD8mNDacDTTr8DL0VETl1/Ob46M1/NK7z1sLYubegFww/W5MHbFz6?=
 =?us-ascii?Q?EulztFZDdMR4x5adly+MwJ3A6myWfYTC4rjihQYDPQorOQeviVq8SwAfnvBQ?=
 =?us-ascii?Q?ZEPZnpUPDf7HM/rWK/BT5uQQfXvj2U1N9z4PpCIIDS/sCzc4BdncpAtytp3v?=
 =?us-ascii?Q?Bxpz64KcVo0XnSGypCB4LDV2CAX3gzV8B2saw8eLGEAdIYgoR8P++w5+MLEW?=
 =?us-ascii?Q?3ga6QHkNyxfn60DqyvhAGePd7a/rcEBp1WkiUHN6um9hoC6f+gAsfLrNu0XE?=
 =?us-ascii?Q?o+QTk8gKQSmYaz9kD/TALXbBnuZrbZQLokxVz3kJhYUbNn2l5wRm3Z/eohiI?=
 =?us-ascii?Q?qU93tfY1E45zcYGGZwyAaIVFFvq9HxdLK3xZa4nsKFx47Df2gHEBYWeHP1kf?=
 =?us-ascii?Q?jLvir5kLym0GnXfostKrylvNrf+I+ZTzd/EIXZCWnLVx+rVevnq+lvoxOiGf?=
 =?us-ascii?Q?KYSBmhGxxSqyWAzxryGjkMi1TMcDhh2fXXsqg0dR0dBAicWm2Lm1mE18dvyM?=
 =?us-ascii?Q?2ZsDUNJDggwC9L60rS5Ie5CxrzYMee1kxz1BTjdo01ddwJUJbZ+6ZPdrNuGs?=
 =?us-ascii?Q?RM5KlQlR8oxyP62ufE1PGNN2WPUZZzn4YB7Wb0DUntaTl/BSnEERp0vVrfo7?=
 =?us-ascii?Q?whnj/+Eqk4l94D15U5z4RSTdnMUEGqrEhm+gOxp5DyTH6I8UR1BZJKGg/z5Q?=
 =?us-ascii?Q?hHupfiGIqYNQ0gl9r7iB21H6AljPcE8Xxskw+9XBvRchaSXhnekazIdwlBjS?=
 =?us-ascii?Q?jd5BcykPRAaQJY+KDEQZSLo3lueLvu5msVe2VU4Wam9HoyFAMu7zWyS6beYa?=
 =?us-ascii?Q?H4NI70s6YQlppdPkTYXMp1nDpxPhesQOGZu/ED2mPokQTBez0v08ATroUrNf?=
 =?us-ascii?Q?nyspc7eq6ryZUJPk7mHU/D5Y5fRZJmw6ZgwCJ/Qyy3bCkCF0tucdAVEqgVFB?=
 =?us-ascii?Q?MrC/n3C4wb43D1BhYToOYtb8sNnMkF2A7w4WnCPtSdb6JtJpvfpvVVcNVXcE?=
 =?us-ascii?Q?AqGA9l2LBezfJE609Eo0Km2aSLev9FltTLZ0//ANedTDmo7qVLqkVvs0xFI2?=
 =?us-ascii?Q?aayK0IKZOmAOcH2+9VqNLCfb?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4773.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f02177-f26b-48db-b3a8-08d8e97bb7cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2021 19:34:44.5286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r912oL/YY77GiuyYp5ln8Ma9T+hi1UdtUc2QmfcY1uXtdqdr08qhRFmQcU+gaqRm5Kz7nL3Fol3vXb9L5bXAoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2933
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Greg

You are right, this is not for the network tree.

Can you point me to the right tree to base this change for?

Thanks

Min

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: March 17, 2021 3:20 PM
> To: Min Li <min.li.xe@renesas.com>
> Cc: derek.kiernan@xilinx.com; dragan.cvetic@xilinx.com; arnd@arndb.de;
> linux-kernel@vger.kernel.org; linux-api@vger.kernel.org
> Subject: Re: [PATCH net-next v1] misc: Add Renesas Synchronization
> Management Unit (SMU) support
>=20
> On Wed, Mar 17, 2021 at 02:59:56PM -0400, min.li.xe@renesas.com wrote:
> > From: Min Li <min.li.xe@renesas.com>
> >
> > This driver is developed for the IDT ClockMatrix(TM) and 82P33xxx
> > families of timing and synchronization devices.It will be used by
> > Renesas PTP Clock Manager for Linux (pcm4l) software to provide
> > support to GNSS assisted partial timing support (APTS) and other
> networking timing functions.
> >
> > Current version provides kernel API's to support the following
> > functions -set combomode to enable SYNCE clock support -read dpll's
> > state to determine if the dpll is locked to the GNSS channel -read
> > dpll's ffo (fractional frequency offset)
> >
> > Signed-off-by: Min Li <min.li.xe@renesas.com>
>=20
> Why the "net-next" in the subject line?
>=20
> This is not for the network tree (given that you didn't even cc:
> netdev...) or am I confused?
>=20
> thanks,
>=20
> gre gk-h
