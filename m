Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2FBDECCA
	for <lists+linux-api@lfdr.de>; Tue, 30 Apr 2019 00:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbfD2WcU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Apr 2019 18:32:20 -0400
Received: from mail-eopbgr800098.outbound.protection.outlook.com ([40.107.80.98]:28011
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729481AbfD2WcT (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 29 Apr 2019 18:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPNvlj5Hlvzqi6Ag60lU8wHKADfqtp9Eo/QK7WOu6CQ=;
 b=QdMF9MQLx8827/UQyxPj0U9kXnGFACzKcPl3UBjz+ypQz6wpFut/Ow/i/IWRSb52LgDgm9AsRvPB7W+Ll3MLPTEayZPJa1J2qkZKJ7BfXidyifUF3XB24qQhdYFBvu0GSqZB6AHrH6/fUKZ0S0IZGLsjBfs3jeqXCnLqPUvUck4=
Received: from BN6PR2201MB1266.namprd22.prod.outlook.com (10.174.80.14) by
 BN6PR2201MB1266.namprd22.prod.outlook.com (10.174.80.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Mon, 29 Apr 2019 22:31:37 +0000
Received: from BN6PR2201MB1266.namprd22.prod.outlook.com
 ([fe80::2c9f:ff6c:cc5e:6af1]) by BN6PR2201MB1266.namprd22.prod.outlook.com
 ([fe80::2c9f:ff6c:cc5e:6af1%11]) with mapi id 15.20.1835.018; Mon, 29 Apr
 2019 22:31:37 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>, shuah <shuah@kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: [RFC PATCH for 5.2 10/10] rseq/selftests: mips: use break
 instruction for RSEQ_SIG
Thread-Topic: [RFC PATCH for 5.2 10/10] rseq/selftests: mips: use break
 instruction for RSEQ_SIG
Thread-Index: AQHU+rH+AJnCxtNxUESFNInzrhwEUaZL3nOAgK8p+5b/WLjHAA==
Date:   Mon, 29 Apr 2019 22:31:36 +0000
Message-ID: <20190429223134.unab336v73qdhoz6@pburton-laptop>
References: <20190424152502.14246-1-mathieu.desnoyers@efficios.com>
 <20190424152502.14246-11-mathieu.desnoyers@efficios.com>
 <20190424220609.4kryfcgsv46iu3ds@pburton-laptop>
 <1183307732.352.1556202092390.JavaMail.zimbra@efficios.com>
In-Reply-To: <1183307732.352.1556202092390.JavaMail.zimbra@efficios.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0038.prod.exchangelabs.com (2603:10b6:a03:94::15)
 To BN6PR2201MB1266.namprd22.prod.outlook.com (2603:10b6:405:20::14)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [12.94.197.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 274267f9-149f-432f-fd02-08d6ccf27092
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BN6PR2201MB1266;
x-ms-traffictypediagnostic: BN6PR2201MB1266:
x-microsoft-antispam-prvs: <BN6PR2201MB12662632C8DA14485484077EC1390@BN6PR2201MB1266.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39840400004)(346002)(136003)(396003)(366004)(376002)(189003)(199004)(316002)(76176011)(2906002)(478600001)(6246003)(8676002)(8936002)(42882007)(44832011)(52116002)(25786009)(81166006)(11346002)(446003)(71190400001)(71200400001)(476003)(14454004)(6506007)(102836004)(81156014)(386003)(66476007)(68736007)(66946007)(64756008)(66446008)(73956011)(54906003)(58126008)(66556008)(99286004)(26005)(4326008)(186003)(93886005)(486006)(6916009)(97736004)(256004)(14444005)(6486002)(5660300002)(6436002)(305945005)(7416002)(1076003)(53936002)(7736002)(9686003)(6512007)(6116002)(33716001)(3846002)(229853002)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR2201MB1266;H:BN6PR2201MB1266.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y/81ZrZPl+irbpIP5Lbu648V5PwXudLWuuACRjcKPzv2Ji7Q2ZPNI590+17CsHRPEo+0a2WeQukrFP1DQAnlMOD0CYxHZGPjxpR+VBwrf3t4IBs+KGKU40AsuzTepp0ca5WMymUA4i5ttRPOPL1x1KhQ5CzUe+luyThzUSKvDuxJJOyfl0ZV/JV6Sp54nbAYd8uVhAkzLiNVa70AxsWUX8PiNs9v4TY3zz3uNdW7b6EeuZ2gfQJDccpMIWtSjkPDP8ySijQxPyQ9rlPZjDSu/C69OWYD7JsQKgEMztblNK7s+ZtrXwSn+q4l/bsWTp1eG9/9N6TsndVMhaJzG8lJNq2iy+LKF1y+UITIQm8GLXiUT9wtH9+06s+dGUHDJVaSLpFHt6m023pq7qITNQ9rke+VfStIYRtoKXdcLgbMVws=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D91FD40890C17F459F7E560D4BCC26A6@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 274267f9-149f-432f-fd02-08d6ccf27092
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 22:31:36.9643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1266
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Mathieu,

On Thu, Apr 25, 2019 at 10:21:32AM -0400, Mathieu Desnoyers wrote:
> I've tried to figure out if we could find a way to have RSEQ_SIG left und=
efined
> if it's not on the plain mips environment, but could not find anything th=
at
> would be #defined on plain mips, but #undefined on both micromips and nan=
omips.
>=20
> What I'd like to do is e.g.:
>=20
> #if defined(__nanomips__)
> # ifdef __MIPSEL__
> #  define RSEQ_SIG	0x03500010
> # else
> #  define RSEQ_SIG	0x00100350
> # endif
> #elif defined(__mips_micromips)
> # ifdef __MIPSEL__
> #  define RSEQ_SIG	0xd4070000
> # else
> #  define RSEQ_SIG	0x0000d407
> # endif
> #elif defined(__mips__)
> # define RSEQ_SIG	0x0350000d
> #else
> /* Leave RSEQ_SIG as is. */
> #endif
>=20
> The idea here is to not allow code targeting future MIPS ISA to compile
> with the wrong signature.
>=20
> The delta between compiling without/with -mmicromips on a gcc-8 compiler
> is only:
>=20
> > #define __mips_micromips 1
>=20
> Some interesting delta when compiling for plain little-endian mips with
> gcc-8 compared to the nanomips compiler is:
>=20
> < #define __mips__ 1
> < #define _mips 1
> < #define MIPSEL 1
>=20
> > #define __nanomips__ 1
>=20
> < #define __mips_isa_rev 2
> > #define __mips_isa_rev 6
>=20
> So let's say we have a picomips introduced in the future, can we rely
> on it not defining __mips__ like the nanomips compiler does ? If so,
> my "#elif defined(__mips__)" approach would indeed leave RSEQ_SIG undefin=
ed
> as expected.
>=20
> Thoughts ?

That seems like a reasonable approach to me. I don't think it'll be
guaranteed, but it'll give the best odds of the behavior you want.

If I recall correctly the reason for not defining __mips__ in the
nanoMIPS compiler was to force people to audit MIPS-specific code given
the scale of the changes in nanoMIPS - there are some incompatibilities
at the assembly level but more than that the ABI changes in multiple
ways from register assignment & calling convention to kernel-user struct
layouts & other things. If we were to build existing MIPS-specific code
as-is then some of this could lead to brokenness that the tools wouldn't
have a good way to detect & reject automatically, so making people audit
the code & add in the __nanomips__ check is a sort of safety measure.

So the likelihood of your code above picking up on any future ISA
changes will probably depend upon how incompatible they are, which seems
pretty sensible.

Thanks,
    Paul
