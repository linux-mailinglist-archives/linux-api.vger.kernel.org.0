Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED7C3281EF
	for <lists+linux-api@lfdr.de>; Mon,  1 Mar 2021 16:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236991AbhCAPMk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 1 Mar 2021 10:12:40 -0500
Received: from mail-eopbgr1410137.outbound.protection.outlook.com ([40.107.141.137]:64040
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236982AbhCAPMg (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 1 Mar 2021 10:12:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BynSICFO6qBZ6H8A/fjrbxv6A96O9ye+gQCoqFQZYZI6hJvWPMaHrwR2T79TgTqavrCNlRvIvNaJVtqD0m4WF0s6qJVrUJr3Uwl5xsMEgAGzRtl16+2jZ/4Rj947t+1dMfzTScC8phLnLfR6zETHpvqMtsFIPw6L7v4Pv8CacfP22amYmDOE2zCar3b8VnVqRXF8mY/O2WfrcrUkQfrmOy/i8cPHzDfuKcnuT8ESAFsoqWrT9mGc0Hr8mE0m+O0QfCy7MMOrl98LzjSXC1+bOWouospBpfeQjyCzxdUxirTKaBqwlouaPNXoa5tX9yFh5fFhcFdiLShb39XnC/TYcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rijtsB6ljTnf7dCCZMk1+gTejEdBJsCZYc6o9dJr+ic=;
 b=FPnbvWUeVoHhvHqQ4kGqFfxzZT7aOV/ll0TPltuPBp+YyZ8gJ+qv3djcXBEJ0rCkdqcgasc56Duklt/NKVbXazhr7Bzp4qqr8mvPPlncgHr1aPNd4cylzmLHXHPL9TT6MVbwWNWV/R3w+F0yaZFeUVakWl32mRNpsOwgyeZHeROg2joVTLhapAjHffEVfYaFw+3y2VSnxHFeZx9cqBumKOLYzpuRV8CRr/hB5KFYDVWPBYQaeYai9tc7be77YsYPoJ4oI4F2Uw7jikRVt8TqFI14jA+UeW29HwcakzJjxMZJOe1rYl2qVdl8/BIzpEJu55BvG9AjyL/bnn1c/CpxVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rijtsB6ljTnf7dCCZMk1+gTejEdBJsCZYc6o9dJr+ic=;
 b=Wmc+RaHcQ5i98NG5suq5RuTjSjOwKw7ru0SCi4hIlLWBjfqlZ9AHxEj+UCBbgoPi8+g+M9YHBlXQl15aA2j3BtgHELrjqxMaalayfRsMVUY5Ot8FbZjXJ66akEwefX0+ItuytXuAWordy6LEU7vEbovH1DGt6TP686khyWVOVhc=
Received: from OSAPR01MB2737.jpnprd01.prod.outlook.com (2603:1096:603:38::21)
 by OSBPR01MB5270.jpnprd01.prod.outlook.com (2603:1096:604:4c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Mon, 1 Mar
 2021 15:11:42 +0000
Received: from OSAPR01MB2737.jpnprd01.prod.outlook.com
 ([fe80::4d2d:3155:768e:50e0]) by OSAPR01MB2737.jpnprd01.prod.outlook.com
 ([fe80::4d2d:3155:768e:50e0%7]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 15:11:42 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        "REE dirk.behme@de.bosch.com" <dirk.behme@de.bosch.com>,
        Peter Erben <Peter.Erben@de.bosch.com>
Subject: RE: [PATCH 3/7] dt-bindings: misc: Add binding for R-Car DAB
Thread-Topic: [PATCH 3/7] dt-bindings: misc: Add binding for R-Car DAB
Thread-Index: AQHXC8j9uaI63SAiyE2WHTRNCWQ/bapqJcUAgAUc04A=
Date:   Mon, 1 Mar 2021 15:11:42 +0000
Message-ID: <OSAPR01MB27379DB2150F87B1EFB34BEEC29A9@OSAPR01MB2737.jpnprd01.prod.outlook.com>
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
 <20210225225147.29920-4-fabrizio.castro.jz@renesas.com>
 <c907737b-dffd-e5f3-6e4f-2e8a7781bc95@gmail.com>
In-Reply-To: <c907737b-dffd-e5f3-6e4f-2e8a7781bc95@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [2.28.163.123]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 48325aca-0a15-414c-3332-08d8dcc45229
x-ms-traffictypediagnostic: OSBPR01MB5270:
x-ms-exchange-minimumurldomainage: outlook.com#9692
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB527035E64335D53D34BEA8AAC29A9@OSBPR01MB5270.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZYslu6+3CM8WJJ9urrHRLJe/Hi4SvieBDzlfOW0mFq6hIMrveI+2emSN0UUqHc/ooaLizLRol9bYsQzcbOId3D2aQ3gXM1pyJanBhKyCeEm3Ke5R35xa/18eDGoGCNSMdibIZHHC9Q3Nab2hiwQJWxrlwlaovJmEwCz9cNC+WZ2fpGMNiDLvK8CsXpbDtWqE/YAbBfRP5nSF747oMGKBuqGpr6a7K07eLJq5tH+1huKufhAds+TqZFUUkmAlXDisQ8F6BB5IgYmwJOZ4G1jywZc1ytX9PtUANuMQEBnYVnIjQSEvVwTQvQgcrVMY35EVs/n+mMZy25ekm67FTONhK1q2x8WiA3QDaV/ujI/0cMYlVajHkQpC2w1UStc5IoP2EVQ3ZjguFjKCI+t4iwZ8zfm0rDkQxkI7GTu7eOJf5kUh0YnlosxzOwR8RtVWi8xCYrm9Kl7TaOt6ucGh0zwRY+Eu/q4L4KYpyoahbKwpvmdYCrorP+TR2zpavvSVB8MqMtRX1mjiywh+qhlnn/WqPjosZ0Eh2/R/TCGKRiFl9CLv/Qi8pIQpoN8TLnih9dj04swhmnn84iicA3iN7ccJJrAlgWePb9jUpLYsEqgw+C4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB2737.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(45080400002)(86362001)(5660300002)(8676002)(478600001)(8936002)(71200400001)(966005)(33656002)(53546011)(6506007)(2906002)(26005)(66556008)(7696005)(186003)(52536014)(316002)(76116006)(66476007)(64756008)(7416002)(55016002)(66946007)(54906003)(4326008)(9686003)(107886003)(66446008)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?AJ2EPzSKPtkneJjM51U7A8ezmpuV3rPxC7p52GnwtkCGWbuFxJbWbdMXgGnL?=
 =?us-ascii?Q?wisPdi4R12u2+eOWtdj0/tCScSvU9/1E2lkheuvaukVhzYa2jFC+nTd9QI7h?=
 =?us-ascii?Q?/X3mRqEt0iL82j/FUZYUl+DR59RvWybbFPbYsiBw5JM0jJ7cWQ6aKo1CHcJo?=
 =?us-ascii?Q?67gtpCJBWLi4uJLmr2bm82LZDHoXxx55kN79rCJ8QJAFuBYmh42t84nK4u+4?=
 =?us-ascii?Q?7atu8z49wkr+7mNtgett+O5imKwnjuU5F2lDzeGUwPTxP4h2YZlnppwO2b15?=
 =?us-ascii?Q?fwFRbTx32FI9zDAsURntMVlfy/MjvXjKFtFk5w79xyAv0k2gGa/RQ07QzQNe?=
 =?us-ascii?Q?Y1quTQZVt1h4cjkrrp9879MpUDEJhExVwDRydXCnK5fSD2pH0dcbZDRZzNbx?=
 =?us-ascii?Q?jAl/CDm8QpGoJgqibVzvj/hJqIuVEUQ79X5wiKKYHXDB0i+jVtXRIq4JrHBP?=
 =?us-ascii?Q?Th8WAzHcBZNTlGdHXQmtlfXp+JeqqCXY4ez+b++3JNduESVSpfDz+7+8uR02?=
 =?us-ascii?Q?8m5WwUiNXQNi2pa2uFuFowD2/yoUqZ/jWX1zKMYtX+8kISJalmWXd0Y9xvUq?=
 =?us-ascii?Q?xmB0uZeLKdakqCEaOGtKPl0YVuTtXw0UJm4+1k89fxiAw/z6aB9rH3wHkawk?=
 =?us-ascii?Q?kImp1OwNyG6D0hX7hIlB6IwXksMbAdnvY8LDMk8KEYJoKGsa90TLr16l1hGH?=
 =?us-ascii?Q?s6SWpUDFlzs2FVPnt66C8onW+IcoF4cImPmoicmI3kcC7gXNXjXGzHTRS0aI?=
 =?us-ascii?Q?3FKtFltO13fFFocJauLvyOHNo1fLEsaxB1iXcRusVJMfSv8sQGXwfmB+q6JH?=
 =?us-ascii?Q?GCp78NaNmPQAdcN7uayOFjhkcfCn9vpyULJEB6KN5Yu7a2bkXLJTaKr7TLov?=
 =?us-ascii?Q?oLbXYi6Dy6EuFkgDW5N5PtO8M1rs4cCqmC567csXTb4OZzINZmlY/kf11rMc?=
 =?us-ascii?Q?io5c/3heIXjoB7NKouWCaLb7DlmCvvWT+wVKRqkI61/rX0930ek/SjBAiVjj?=
 =?us-ascii?Q?Qu0Nfzb3+p7ty052beR1Y4JaM37ULX84i2WyHEIWgxTQsLiowBGmV6/gruzH?=
 =?us-ascii?Q?zDniSG2AD3evYJkzT80Bwlp+0YFVqoT+M0ahQOw3QpnxU+h57yI7VQCx/A9l?=
 =?us-ascii?Q?yJqN/pMVeV5cFvdBZYF1EzkjMYz551Xyjrwm/xtKCDlPeSRKLLNA223KAdZv?=
 =?us-ascii?Q?IWfdCnW2N+dRtaM56mm0J/xEUiKdI2HmExBJnt79igU4qGwF6WcoeafPsWom?=
 =?us-ascii?Q?11wAul5rnT7Zg5k44gUewzt2MZU6Xos9cuWFPYPzL6B07Fh2l6jApD7u9jCL?=
 =?us-ascii?Q?/k26dp+4vxjVie+OoW3qGzW0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2737.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48325aca-0a15-414c-3332-08d8dcc45229
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 15:11:42.1598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9VtOUBU1BN4lL4ZYTtrR9gxh08ZcfC1rZ5uIaqAvoExUUuxgxvR8ryd4ExvunvatHzCyEEkTlUfn+/qAxMN8UL8cmu8qN6vCVjxyBotLzu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB5270
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Sergei,

Thanks for your feedback!

> From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
> Sent: 26 February 2021 09:07
> Subject: Re: [PATCH 3/7] dt-bindings: misc: Add binding for R-Car DAB
>=20
> Hello!
>=20
> On 26.02.2021 1:51, Fabrizio Castro wrote:
>=20
> > Document bindings for R-Car DAB hardware accelerator, currently
> > found on the r8a77990 SoC (a.k.a. R-Car E3) and on the r8a77965
> > SoC (a.k.a. R-Car M3-N).
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > ---
> >   .../devicetree/bindings/misc/renesas,dab.yaml | 75 ++++++++++++++++++=
+
> >   1 file changed, 75 insertions(+)
> >   create mode 100644
> Documentation/devicetree/bindings/misc/renesas,dab.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/misc/renesas,dab.yaml
> b/Documentation/devicetree/bindings/misc/renesas,dab.yaml
> > new file mode 100644
> > index 000000000000..e9494add13d7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/misc/renesas,dab.yaml
> > @@ -0,0 +1,75 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright (C) 2021 Renesas Electronics Corporation
> > +%YAML 1.2
> > +---
> > +$id:
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevice=
tre
> e.org%2Fschemas%2Fmisc%2Frenesas%2Cdab.yaml%23&amp;data=3D04%7C01%7Cfabri=
zio
> .castro.jz%40renesas.com%7C4ea11a8f46fc4f4642ad08d8da35d682%7C53d82571da1=
9
> 47e49cb4625a166a4a2a%7C0%7C0%7C637499272091083125%7CUnknown%7CTWFpbGZsb3d=
8
> eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&
> amp;sdata=3Dp5MNncCLOIMaYLyBtmOl%2Br%2BIKe9ByUqxv1k05FbYj94%3D&amp;reserv=
ed=3D
> 0
> > +$schema:
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevice=
tre
> e.org%2Fmeta-
> schemas%2Fcore.yaml%23&amp;data=3D04%7C01%7Cfabrizio.castro.jz%40renesas.=
com
> %7C4ea11a8f46fc4f4642ad08d8da35d682%7C53d82571da1947e49cb4625a166a4a2a%7C=
0
> %7C0%7C637499272091083125%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ=
Q
> IjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DdBI8WMPjxAE=
vhY
> 3cj7WKJW4FjCrfN5JpAoqC9XSPNaY%3D&amp;reserved=3D0
> > +
> > +title: Renesas R-Car DAB Hardware Accelerator
> > +
> > +maintainers:
> > +  - Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > +
> > +description:
> > +  The DAB hardware accelerator found on some R-Car devices is a
> hardware
> > +  accelerator for software DAB demodulators.
> > +  It consists of one FFT (Fast Fourier Transform) module and one
> decoder module,
> > +  compatible with DAB specification (ETSI EN 300 401 and ETSI TS 102
> 563).
> > +  The decoder module can perform FIC decoding and MSC decoding
> processing from
> > +  de-puncture to final decoded result.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - renesas,dab-r8a77965     # R-Car M3-N
> > +          - renesas,dab-r8a77990     # R-Car E3
>=20
>     Why not renesas,<soc>-dab?

Will change.


Thanks,
Fab

>=20
> > +      - const: renesas,rcar-gen3-dab # Generic fallback for R-Car Gen3
> devices
> [...]
>=20
> MBR, Sergei
