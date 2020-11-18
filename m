Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3392B7E52
	for <lists+linux-api@lfdr.de>; Wed, 18 Nov 2020 14:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbgKRNbh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 Nov 2020 08:31:37 -0500
Received: from mail-am6eur05on2086.outbound.protection.outlook.com ([40.107.22.86]:39009
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725832AbgKRNbg (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 18 Nov 2020 08:31:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTozKppS4Qz08GdI8eJZTdNkiIOPFxz3uRKU/+aLdqI=;
 b=6jwbgNdtogTF3T6ZNCbbjlz7TU8iH9OW3TMjqFOG0OQ0qisLpJ61zfr+cPtd60fX7ARKroDo7RnM5yX5QMe/GUB46BMevi0EAIbvmnXl8ZAHoWNdnHqD1bpDhr0u4SM48uHtCsKN823DwaKygR+fANPAU1AfaFVYOLyFrKn54mo=
Received: from AM6P192CA0060.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:82::37)
 by AM7PR08MB5415.eurprd08.prod.outlook.com (2603:10a6:20b:10d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.24; Wed, 18 Nov
 2020 13:31:31 +0000
Received: from AM5EUR03FT020.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:82:cafe::e1) by AM6P192CA0060.outlook.office365.com
 (2603:10a6:209:82::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend
 Transport; Wed, 18 Nov 2020 13:31:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT020.mail.protection.outlook.com (10.152.16.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Wed, 18 Nov 2020 13:31:31 +0000
Received: ("Tessian outbound 13ed5f5344c0:v71"); Wed, 18 Nov 2020 13:31:31 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 9b4b680dc419c113
X-CR-MTA-TID: 64aa7808
Received: from 5afbe8852c7d.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id BCE70D72-7ECC-4E56-A702-193FEE6B04AB.1;
        Wed, 18 Nov 2020 13:31:25 +0000
Received: from FRA01-MR2-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 5afbe8852c7d.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 18 Nov 2020 13:31:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=as11YVkbv/W+xprvFSZWHtSUuxPc5NieyBSl2SFgRmbpszWyhzrWVA/4nJ6xS8kd7+OuQq9W7roNk9gUqBLXdOE76kOm431om3wXtKKpQNvMgcgttRu/LB55GqwGIZ9GNZaGn/OZSwpVTI7DBHN1SW9r0EL3FykfdYXVu/BGnB9GEnYLrqYYNcyk0EYNPoas0iKPEns3TxFupGTyd79NfM1wRU0Fpkr8cv5GkO3hGARnbaI83F+g4YHhuMyc8mCl16Eb85KelmgDZBqxhrW22kOCVvUfSe0HJ1nT+mQEgMc2vyQufk7i9yB6ioRJYjnl9+80FBro/PNblaYuuX67VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTozKppS4Qz08GdI8eJZTdNkiIOPFxz3uRKU/+aLdqI=;
 b=J4f+E8lP2O4Sx/a1wgmchF7y34pLUhQkPuInyYTrpR1PTf99fRy30J756XwbDHYlyOOutOmCbolfkfedJtDiPqDoSgHCtPKXI4XmunGdeh8Y5ZnY4sCNjrXXWktCsRLTFqa677rgbu9CDj3Js+I4cOxHn3AVmLWKoK8U2CfJMmY7hOtLebffyMgAZGFt/DFQLCJGREIoOr60bfNJ1yBh53bG8q0CVZzeereBgRePyiWpc4LVLt44cSJD9Feb7YYbjWeXH1M8m+zkAT7IDLT4XR0LumIoX2u0xLyfIHSFcKJUuXFPVl4syJCeKTfzsn4Gq3pk/MUwohENHgy3LIu4iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTozKppS4Qz08GdI8eJZTdNkiIOPFxz3uRKU/+aLdqI=;
 b=6jwbgNdtogTF3T6ZNCbbjlz7TU8iH9OW3TMjqFOG0OQ0qisLpJ61zfr+cPtd60fX7ARKroDo7RnM5yX5QMe/GUB46BMevi0EAIbvmnXl8ZAHoWNdnHqD1bpDhr0u4SM48uHtCsKN823DwaKygR+fANPAU1AfaFVYOLyFrKn54mo=
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com (2603:10a6:102:87::18)
 by PR2PR08MB4811.eurprd08.prod.outlook.com (2603:10a6:101:21::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Wed, 18 Nov
 2020 13:31:23 +0000
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::ad91:8ade:4623:e17b]) by PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::ad91:8ade:4623:e17b%6]) with mapi id 15.20.3541.028; Wed, 18 Nov 2020
 13:31:23 +0000
Date:   Wed, 18 Nov 2020 13:31:21 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Florian Weimer <fw@deneb.enyo.de>, libc-alpha@sourceware.org,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] arm64: Introduce prctl(PR_PAC_{SET,GET}_ENABLED_KEYS)
Message-ID: <20201118133121.GA20578@arm.com>
References: <20201014055106.25164-1-pcc@google.com>
 <87blfv6fj3.fsf@mid.deneb.enyo.de>
 <CAMn1gO7a-uyP93P4KapbsXy1+HRSuJR4r_kyy0_-FCY69qO_nA@mail.gmail.com>
 <20201117183911.GI15033@arm.com>
 <X7UUoFcmtuHEhoz9@trantor>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X7UUoFcmtuHEhoz9@trantor>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [217.140.106.54]
X-ClientProxiedBy: LO2P265CA0210.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::30) To PR3PR08MB5564.eurprd08.prod.outlook.com
 (2603:10a6:102:87::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.54) by LO2P265CA0210.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9e::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Wed, 18 Nov 2020 13:31:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 09324f6e-523d-42ba-0c04-08d88bc642ed
X-MS-TrafficTypeDiagnostic: PR2PR08MB4811:|AM7PR08MB5415:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB541580CB98424D8D1C38516DEDE10@AM7PR08MB5415.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 0WQaU+XoOFqBzDwuyb1JW0xUbvvy2mzuVcUCbNL1C6eSc9G6RcxBtax2jpUo0AIlgIY8p2Y1hAULTOUpjU2gNKkhzgg2GTTbkH924j71JJk3e5P8qVya3QutxWzZ4oSYSVc05adF4uRNjZTU47jKc3WeZR3KqLenIcnb8ha6Bgy9Z/CeQK4qtJr27puB4RdyUJpa3sA9gPhDAiEfTi47uGuHYiHH3EzYYVunB5v09OhlKVcOv35fZt3f/zBhsrFrtLOzQ54GCKycyoYZzEfloVmVroCXF1YaRogctuCXgY4l3/zJGrd6pTTI6s4Nh14Gg3L0UnXz2zcoKMdmeoK3VA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5564.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(346002)(136003)(366004)(376002)(8676002)(186003)(44832011)(26005)(5660300002)(37006003)(54906003)(16526019)(316002)(2906002)(8936002)(8886007)(86362001)(52116002)(55016002)(1076003)(7696005)(478600001)(33656002)(4326008)(36756003)(6862004)(2616005)(66556008)(6636002)(66476007)(53546011)(83380400001)(66946007)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +dq9GjHBAXHTC0c7gzty23vFaatWYigRHOeMezmwDK4hGKNB6X5tyCGHip1NM+lcBozyM021ldqtwVuKCKBbmRwt2CD1QxeEFAiC/3exEEapG5S+QKDzJD01xBBa+RUqXwWCwrMhv7ZnuJ28JlzBFIGi1+owFHsjKKMdSzp+DhuFSH+Uy4QnfODLlV8/GAUXcnm8Z67VSaxd5gL7fMWXv9sjKF0FQcFPflhmPTzctaUF1V65ZxKuQfKIAtdt953J9M6QfMjg/HOjePaRyFQ3EoW4uzNil3wHwrNG8q7ZVN2pYTgKQj6FEXr7LzDfJT4Tla+9fLw6hBSzH4PPAKCxhF2o20O3kjRbhDe49WHgrXtsb+/xjFc557K7NKPCPNRjRO0qh9QgwkB0ohf4Qm0JGTzMbaTPgJtidxBGJxEtw5fyL4Kj37TvHJ232mzzkVFDkFbKOOa5UBxkBdg3IhJRI36ceCnwCUGrSVS2nhs+So7s+NtfCacaeK3iDczyXNiAQpsu7m0AZGTCSp3EE1C2sRe/NXiplYm8rxk2o8PcY6XjZhqkcapJ9+G54WZ+kpITNoiOfD/aKEmSOY2m3jYSFJepRHuVAZ7e/A5DaGtKZYoNwh0+h2UXKRiuPrA8sFS/tjuBqOjsFgyPrajcusmMhd/m+YqfgqeDG+yQixIFk72ukrACuzv6sZ1bZeaz0Fo4JAX/pQXq42rUGjJYIN7O0wXL/qv9KujDvnbh44BcXs2Zp2zst6Nnz5Ux9MF60hEgxH4y8Eyyqmzgkj8MO7I2Mw6yo4A7Z/MDUeWY4Oym2Bkqwa9caUu26oUlt1anmqbgJKOyjLZtsitMlx+f/X54B0ZOc0HaKjGlKfEFGRAFLkHdInzz0ikqLZYi1wFCsv1nL6P79CMBppAKY07i+r0mow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4811
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT020.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 47e713dd-fb17-4bf3-bc4c-08d88bc63df0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ueI2H4GtHyUzn3s58oIBowa+N3syVQpD1edvfWAWp2K1Tj/LOON3cUu/136q0tMsEbuObxfalYGNdYkX8ONgxHaUUPqI65pFnpd5jUi4YTaVjCOykdKxszlVsHn6IZ9tfE9mGu2UoK2pp1P9nTERzp9/yXi6A52RqLhpxHsI1qH4sC5xcjHL5JyKode47c7zDtd7aDUjEV2XET/71U5PXjblD1s9pIVQGnKha9lH1LQao4VSzNGz5T/b01l7xoRmuFy1AM69SIZxzAHmYOe4L5Qi1kjzlU+yzyyhBOnp8MtTF67ITpzEgTpdS9UIbRfMODB/P+Km7kp5wYIJtxlD1uYLTZJ0tioMrt1tkVN9CbztHCkOGAg5EYbbHRH4U3bpQPMnjX1DphVPu8bWYGWkmA==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(346002)(376002)(39850400004)(136003)(396003)(46966005)(47076004)(956004)(82740400003)(16526019)(70586007)(478600001)(4326008)(316002)(53546011)(6636002)(8936002)(8676002)(36906005)(2906002)(6862004)(107886003)(54906003)(336012)(44832011)(26005)(7696005)(37006003)(55016002)(1076003)(86362001)(2616005)(8886007)(33656002)(70206006)(186003)(5660300002)(356005)(82310400003)(36756003)(81166007)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2020 13:31:31.4952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09324f6e-523d-42ba-0c04-08d88bc642ed
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT020.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5415
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The 11/18/2020 12:33, Catalin Marinas wrote:
> On Tue, Nov 17, 2020 at 06:39:13PM +0000, Szabolcs Nagy wrote:
> > The 11/17/2020 10:17, Peter Collingbourne via Libc-alpha wrote:
> > > On Tue, Nov 17, 2020 at 9:48 AM Florian Weimer <fw@deneb.enyo.de> wrote:
> > > >
> > > > * Peter Collingbourne:
> > > >
> > > > > This prctl allows the user program to control which PAC keys are enabled
> > > > > in a particular task. The main reason why this is useful is to enable a
> > > > > userspace ABI that uses PAC to sign and authenticate function pointers
> > > > > and other pointers exposed outside of the function, while still allowing
> > > > > binaries conforming to the ABI to interoperate with legacy binaries that
> > > > > do not sign or authenticate pointers.
> > > > >
> > > > > The idea is that a dynamic loader or early startup code would issue
> > > > > this prctl very early after establishing that a process may load legacy
> > > > > binaries, but before executing any PAC instructions.
> > > >
> > > > I thought that the silicon did not support this?
> 
> I think the past discussion we had was around enabling PAC for kernel
> while disabling it for user. The hardware doesn't give us separate bits,
> so Peter's patch toggles them on kernel entry/return, with some overhead
> given by the MSR+ISB (to be added).

ah ok. i probably incorrectly thought that toggling that sys
register bit is too much overhead at kernel entry so assumed
we cannot have PAC off by default or set per process.

(i think with the proposed prctl it's possible to disable PAC
at early ld.so startup and reenable it before calling into the
main exe entry code, if we ever need to disable PAC-RET.)

i assume thread creation/fork inherits the setting but exec
does not (this is another point that may be worth adding to
the documentation).

if we run into issues in userspace with PAC then a prctl that
can be inherited across exec is a possible workaround (so PAC
can be disabled for an entire process tree).

> 
> > > See e.g. the documentation for SCTLR_EL1.EnIA [1] for details. There
> > > are also enable bits for the other three keys.
> > 
> > i think it was insufficiently clear in the architecture
> > spec how that can be context switched. (but it probably
> > changed)
> 
> The bits that we can't toggle easily have the comment "This field is
> permitted to be cached in the TLB" in the ARM ARM. Luckily, it's not the
> case for EnI*.

ok. thanks.
