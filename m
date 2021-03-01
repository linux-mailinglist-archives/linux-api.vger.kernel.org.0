Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91E1328207
	for <lists+linux-api@lfdr.de>; Mon,  1 Mar 2021 16:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237049AbhCAPP3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 1 Mar 2021 10:15:29 -0500
Received: from mail-eopbgr1410115.outbound.protection.outlook.com ([40.107.141.115]:18631
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237060AbhCAPOQ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 1 Mar 2021 10:14:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSb5n8IfSyJElE0HPp9CUa61DWyh5WK2q5z8K/UQul5mAE8pCVcdS3UzjaKsKfc3DKUQh1rwUEWplkuclsALR4XHHG+yU5PKvtEpGNfo0qu+j4gVKE45dqKyKbiDuK2SDOvP1wCNjdUyMXE3vEvY8H6/3yp3D5yhPx8E24IEtoUcyAZzPoR6lOxcu5f9xtv9jIkISi+zT0GKIcHkyBLVbH+ALKufynrUSKLDj2zGXaRO4Gux0tGH8iGa+evYDv9qCARZRJ9AEdI3XrMzNqst5bS+ruO2ipyVM8KBKoNVxSUheai3XgFPUtNkaV9MAhFshvI52nu0qnMSQSg6Hrp3FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeozguZ120X5++8wNBwjfhcjpdTmefOh8iRWg3QAdMk=;
 b=AEYafr0HP9X4SPu/haY1Fom4COQgVwCk2dtBbRjglQ0ozKibrJWNw6VXKIrz+HWU9yti35Iez2B5oHEPqZDd85hLXZqZBIRzFIuTEP5BGbz9oxDEs8t0kEsUb0N0H2S25eo0Q9QmwHM56CdhO9GqLehRDFYA7VaGNVgk0ddEgqnHUV6oMgWAnUrLQhGV40bonWSr1hF9CQZzGmVwAU9QsiHuZpRoXKRzyKpzjJhC10ooDDRvQoQCV8zrWQl6pwpuc8nNCKbARikVCsXDCNK8xJ7gwk2eyGG161N5KV9nUOva/m1ehpN0z4HiXsZ8egPcbDUNM8+5x6Uv8//mAuugSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeozguZ120X5++8wNBwjfhcjpdTmefOh8iRWg3QAdMk=;
 b=rL0/vSBMwzUfiyl8iXSSQBpXpQjf2Tcx9JU+HxxMUMau4jYl+0YUL5n642rZuRpm63axOKBhoQg0vlhpPD4kMhJzWIozHf3XNnu+tia9qHWCCpqfEvslEYAwpwiOa/l1lS6p7Gm0hq1iESheOyHjWxyjGexvLZAXgY6jIOddiBk=
Received: from OSAPR01MB2737.jpnprd01.prod.outlook.com (2603:1096:603:38::21)
 by OSBPR01MB5270.jpnprd01.prod.outlook.com (2603:1096:604:4c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Mon, 1 Mar
 2021 15:13:24 +0000
Received: from OSAPR01MB2737.jpnprd01.prod.outlook.com
 ([fe80::4d2d:3155:768e:50e0]) by OSAPR01MB2737.jpnprd01.prod.outlook.com
 ([fe80::4d2d:3155:768e:50e0%7]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 15:13:24 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Thread-Index: AQHXC8j9uaI63SAiyE2WHTRNCWQ/bapqZ4gAgATbWMA=
Date:   Mon, 1 Mar 2021 15:13:24 +0000
Message-ID: <OSAPR01MB2737C9B5A781E7F7134D7038C29A9@OSAPR01MB2737.jpnprd01.prod.outlook.com>
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
 <20210225225147.29920-4-fabrizio.castro.jz@renesas.com>
 <YDjxQOx9bDXLjk6E@pendragon.ideasonboard.com>
In-Reply-To: <YDjxQOx9bDXLjk6E@pendragon.ideasonboard.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=none action=none
 header.from=renesas.com;
x-originating-ip: [2.28.163.123]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d0a09c45-4a21-4638-8f62-08d8dcc48ee7
x-ms-traffictypediagnostic: OSBPR01MB5270:
x-ms-exchange-minimumurldomainage: outlook.com#9692
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB527022F3AE5FE19AD53F0CC0C29A9@OSBPR01MB5270.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H6Y9+qcWXY/OzKT1WZls1al2HvODEMwITSFRT7h4mcIP1ha1a6Geua5M/EzwjGYSN4WWx/AHso4pezF2+4oi0Va7wzOFiKkqMdAoQt/Q14yYcbtqummb4NuMkKmY56SDt1n0N2jj9YoFH4t+u1ehUyU11TETWGBpz8nEFPL7//cBPmOwWjt3xw8a9ewUYCNzTGW6YcfX51iia+p6V5Hv7U6wSWmXlIbbhk2DGkbycryc44lCvsfqjzrRcFv9sr9/p1wpCk/Wr7nPkvIarbAYlXATYnFkovAdCiqKYR2u9y6DTZrm25LoYsvdqSstt37y6Dj8WdCEKV4b1HnDOXZkSbIe6JUs2P8tctYQNLwYZdmypHU4H1qGA+pgdi7TW/a5jq7MW6CKW1CcZ/5B7HloQmmMJgclcCzsnXjctKPESjSuav6KcsObIrxxDmg5yuO+P8ESMqYMRLMvEYZUAjVTe0PlFhb5WRZVuk2hMfL/vt9m3eunhiaOHYGchhGsHvLBlIN38syojZa6/AWXX7y56knW4VL7WIwsLjPMqlcChgCmtvK4K2FkDmH5t/4Y06RAiaG81Shm6hYJJ9t24Fmx+JMqdFBQw1g88Asm8tpCyTs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB2737.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(83380400001)(45080400002)(86362001)(5660300002)(8676002)(478600001)(8936002)(71200400001)(966005)(33656002)(53546011)(6506007)(2906002)(26005)(66556008)(6916009)(7696005)(186003)(52536014)(316002)(76116006)(66476007)(64756008)(7416002)(55016002)(66946007)(54906003)(4326008)(9686003)(107886003)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?KotngcddluDuIHxnWOZ973ojSNNYznVlTnyQAgKv/Zzfre8bTlnZuFTWpSWy?=
 =?us-ascii?Q?IfFf4LL9pPDAO3A+u+g6j9tWUj8/iQCZl0Gp4Ul4E5tLAx6Fuo3YS1CuOGa6?=
 =?us-ascii?Q?d/F/hQoaz5T6mRea0poTNhsaG/+b/EVSRF4G4DHQ38Quf9yVlLZMuqjJYfZw?=
 =?us-ascii?Q?DcmDpcJXSwMY0kW0+cWmOp/r3rydF1yIUofjUemys0ivYWVo7ssOiIY5ynIp?=
 =?us-ascii?Q?bVjvbw8r+tyNYy3gwyrTlEqoTZHeRHydSyNPNPgJLjOCtUpWIaCKVg90XOzY?=
 =?us-ascii?Q?aWiVc5l3OGkgqN/wljwCPDA8Xehz0GlhAT53EFxDuQ8swTdFYHdb1VjLHEC8?=
 =?us-ascii?Q?csxNdfVl8++L4wPfj2uwetEy2I6jVEMbaYXPkcX+CO4cMngXjzAZ5DIw4jLz?=
 =?us-ascii?Q?+6e9sAz+e7G5z20vJ6m40T0wAJcCktAjmEyJnhSIoHvX2qZc/MMtwecYnVb3?=
 =?us-ascii?Q?dy4fUMBHF9k7brkcPA/r47sq9rDZ87PeIHogFNO1tLyKoD6IS+7d3WbdhkDf?=
 =?us-ascii?Q?KQWnkVqF9Ickfwol32UrEfTFIvB6D+F/URLM7K0l+NXxb0K4aSZA4FmiAYSS?=
 =?us-ascii?Q?NkTGfXIdpeWGil8t9ewf1EBGPo2wU17gnaR/nUZR80gWu3Y1Aamr8yamGqbj?=
 =?us-ascii?Q?DkFBlubOc2IRW7yYO/RBArmvpsCWuqG9beaNZW8yekgnNPiQzTo05jZITBi1?=
 =?us-ascii?Q?4guCbeYmNQz2aImDCOgxQlVVNTdsNt57Oi95KcXLtkWsNbvMv73Bk4UcTUTq?=
 =?us-ascii?Q?Y6ENpHJNeV79DyqZSQcynqGF/bhP8dgrK0DrNtuVp5mDw1AvM1Uy28SLlUWr?=
 =?us-ascii?Q?0fj0Uul4nm9x6o/zd5XIqB1XuhYVOY3gMf/vAXX/P5TKPSguCqUP2EuxNf4u?=
 =?us-ascii?Q?AuxYDe2WzUx7+0l4i51r7sYaGKUAgTCUSPgl1ik9Dhu7foT9pcfN3tZx24VP?=
 =?us-ascii?Q?WwGa1I7jTHcU+z+z3D16HTpKchm/Sm8kUnYWXHfj1rU/nJDHPVc10KuYJwXV?=
 =?us-ascii?Q?YVnIOjb83DLAJQKfEhYiIU1MZDW63DvvVIkl6lyuKkFwLJdZHTxqp93w8HM8?=
 =?us-ascii?Q?kpXYuMQUpsq1ogY3XUrST27CwQbGZlpvN+at3OZksCCDYNux3YbPwobueWaA?=
 =?us-ascii?Q?kfPi/+M4XA1ZulbThKRTqvNTpet0zyNQFYXAdQVkQKCLA3tkJPeScwmtBWUl?=
 =?us-ascii?Q?n2LiaNNw7grw2TqJo2sb9kPUe5sw9SomMdl0CJBvrhYvxiDscewPmZomm0cT?=
 =?us-ascii?Q?jcR99d8mHoKciiOD5zXSnB7xXMqeXKb3M7bthjBSnMVWlvwEm7otKqg0uFTa?=
 =?us-ascii?Q?QDlxrQQrL6M9LNod+B2Nef8o?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2737.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a09c45-4a21-4638-8f62-08d8dcc48ee7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 15:13:24.0417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3zn/Q55NNKAINInZ+2lRPQodb8XG+i/WpYwA7XQ5NycTg4KfRFyVGlOM0fYy67HjmJWFKsSkdfSTvOuvPiEdbn0u8GEMRNrAe99qpG+5bk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB5270
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Laurent,

Thanks for your feedback!

> From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Sent: 26 February 2021 13:02
> Subject: Re: [PATCH 3/7] dt-bindings: misc: Add binding for R-Car DAB
>=20
> Hi Fabrizio,
>=20
> Thank you for the patch.
>=20
> On Thu, Feb 25, 2021 at 10:51:43PM +0000, Fabrizio Castro wrote:
> > Document bindings for R-Car DAB hardware accelerator, currently
> > found on the r8a77990 SoC (a.k.a. R-Car E3) and on the r8a77965
> > SoC (a.k.a. R-Car M3-N).
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > ---
> >  .../devicetree/bindings/misc/renesas,dab.yaml | 75 +++++++++++++++++++
> >  1 file changed, 75 insertions(+)
> >  create mode 100644
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
> .castro.jz%40renesas.com%7Cb383aa9cfef34b6653e008d8da56c204%7C53d82571da1=
9
> 47e49cb4625a166a4a2a%7C0%7C0%7C637499413468300421%7CUnknown%7CTWFpbGZsb3d=
8
> eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&
> amp;sdata=3Dr95fhwTCpf0gkNoRtCLrUbZtaCbI3da9sbFLv0UXipE%3D&amp;reserved=
=3D0
> > +$schema:
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevice=
tre
> e.org%2Fmeta-
> schemas%2Fcore.yaml%23&amp;data=3D04%7C01%7Cfabrizio.castro.jz%40renesas.=
com
> %7Cb383aa9cfef34b6653e008d8da56c204%7C53d82571da1947e49cb4625a166a4a2a%7C=
0
> %7C0%7C637499413468300421%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ=
Q
> IjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DajJ%2BmBs4z=
OzK
> cJghYY89B6PMgrxRFgoVVuflZCFmHYc%3D&amp;reserved=3D0
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
> > +      - const: renesas,rcar-gen3-dab # Generic fallback for R-Car Gen3
> devices
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
>=20
> I usually try to describe clocks:
>=20
>   clocks:
>     items:
>       - description: The module functional clock
>=20
> but as there's a single clock, it may not be worth it. Up to you.

Will change as per your suggestion.

Thanks,
Fab

>=20
> > +
> > +  clock-names:
> > +    const: dab
>=20
> With Geert's and Sergei's comments addressed,
>=20
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>=20
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +  - power-domains
> > +  - resets
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  # R8A77990 (R-Car E3)
> > +  - |
> > +    #include <dt-bindings/clock/r8a77990-cpg-mssr.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/power/r8a77990-sysc.h>
> > +
> > +    dab: dab@e6730000 {
> > +        compatible =3D "renesas,dab-r8a77990",
> > +                     "renesas,rcar-gen3-dab";
> > +        reg =3D <0xe6730000 0x120>;
> > +        interrupts =3D <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>;
> > +        clocks =3D <&cpg CPG_MOD 1016>;
> > +        clock-names =3D "dab";
> > +        power-domains =3D <&sysc R8A77990_PD_ALWAYS_ON>;
> > +        resets =3D <&cpg 1016>;
> > +        status =3D "disabled";
> > +    };
>=20
> --
> Regards,
>=20
> Laurent Pinchart
