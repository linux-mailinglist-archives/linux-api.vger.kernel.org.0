Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929372B6CB0
	for <lists+linux-api@lfdr.de>; Tue, 17 Nov 2020 19:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbgKQSOw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 17 Nov 2020 13:14:52 -0500
Received: from mail-db8eur05on2083.outbound.protection.outlook.com ([40.107.20.83]:27934
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726731AbgKQSOw (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 17 Nov 2020 13:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AgvffoqRRxY/Vo9gPmrhYW4Cel4seUMp57aHOpdn7o=;
 b=hFeoSY0jeHE2OTYBbl7x5yoC8BykMEdtpoJCLJvv8KJqkk+VTGnxbyAh/X+yvQgbskyCMJ5PVFyrsqtmSKYjhCbtGII7+9ig1Jl3yMeDrvNWJzwBM2G0pkqC8OO1kRKeOgfT8ZJPiGDQjvE57yQPJ9ugYQLyimp02V0QnyZDC/M=
Received: from MRXP264CA0019.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:15::31)
 by VI1PR08MB3950.eurprd08.prod.outlook.com (2603:10a6:803:dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Tue, 17 Nov
 2020 18:14:45 +0000
Received: from VE1EUR03FT053.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:500:15:cafe::64) by MRXP264CA0019.outlook.office365.com
 (2603:10a6:500:15::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend
 Transport; Tue, 17 Nov 2020 18:14:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT053.mail.protection.outlook.com (10.152.19.198) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.22 via Frontend Transport; Tue, 17 Nov 2020 18:14:42 +0000
Received: ("Tessian outbound 082214a64d39:v71"); Tue, 17 Nov 2020 18:14:40 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: af61711e4d057ba1
X-CR-MTA-TID: 64aa7808
Received: from 9ef09af9e44b.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9276476A-FB70-4114-9C90-96A297419CCE.1;
        Tue, 17 Nov 2020 18:14:34 +0000
Received: from FRA01-PR2-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 9ef09af9e44b.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 17 Nov 2020 18:14:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAG+dvRIiRZEGEe4XhhNGgoRvHF4C2PCr9EFjw4LGLlfqdAX1pAEEIwPXohTBV+L0BF4YlBaMjxr3sWWBP1LBxp8vu7mAl/of9KttPfZi9Iiy+iIyQG3poyJ8yvHjvL0GCte5qkduhXhtH9k6rvkso5kNzHh/Ovbw3DvFgYilxtc6DLZRtILOcSWzTXiA75s9vv0l4XJ4FergYN4e0qpglcu3v5EA754Rk4NCqZRXmzhT9Fq62WekErSuP+hVAncEzWTWO6ZDJYikyaHxUsh67pdZZIF3B10PIDEstOL+Tu6Xiyd1pVyS9KdosxkotUqyAK3k41eFrb6+wo/xMgBOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AgvffoqRRxY/Vo9gPmrhYW4Cel4seUMp57aHOpdn7o=;
 b=hNxOvWCNrhr9pfcK89kes9taaqg1hilgueeebmphPPOHg0BHYFogkJPtoyNyzoU2NWQVDPzG/mv1JzO+PMZ3ZzwvjqoY0ZN1VjE2Ct5kTWi2v5k/+3UAWo7r+eJSMOnTnUi9ckg1cL5OLM15RwAzTrRVymKVARUZKtnAEnpPfX7x0DUmZU1svaCAtcMode40doz0WxE8nCx/OrnBWJsk581ISZkmPO//LrMYjq4Jxmt5uk1AfxIREw8sihGO1xaHjZKu6VJw7Zl+pq4/e0sB6zbBD3jGbODpozgaq1EaztUuQ+7PgyXiPTambqgagVqfSy1o+7apPeRRJti7QbWfMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AgvffoqRRxY/Vo9gPmrhYW4Cel4seUMp57aHOpdn7o=;
 b=hFeoSY0jeHE2OTYBbl7x5yoC8BykMEdtpoJCLJvv8KJqkk+VTGnxbyAh/X+yvQgbskyCMJ5PVFyrsqtmSKYjhCbtGII7+9ig1Jl3yMeDrvNWJzwBM2G0pkqC8OO1kRKeOgfT8ZJPiGDQjvE57yQPJ9ugYQLyimp02V0QnyZDC/M=
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com (2603:10a6:102:87::18)
 by PR2PR08MB4875.eurprd08.prod.outlook.com (2603:10a6:101:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Tue, 17 Nov
 2020 18:14:33 +0000
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::ad91:8ade:4623:e17b]) by PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::ad91:8ade:4623:e17b%6]) with mapi id 15.20.3541.028; Tue, 17 Nov 2020
 18:14:33 +0000
Date:   Tue, 17 Nov 2020 18:14:31 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will@kernel.org>, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org
Subject: Re: [PATCH v2] arm64: Introduce prctl(PR_PAC_{SET,GET}_ENABLED_KEYS)
Message-ID: <20201117181431.GH15033@arm.com>
References: <20201014055106.25164-1-pcc@google.com>
 <X7QIeRIKwd3ShByU@trantor>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X7QIeRIKwd3ShByU@trantor>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [217.140.106.54]
X-ClientProxiedBy: LO2P265CA0407.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::35) To PR3PR08MB5564.eurprd08.prod.outlook.com
 (2603:10a6:102:87::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.54) by LO2P265CA0407.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:f::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28 via Frontend Transport; Tue, 17 Nov 2020 18:14:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: da3280a3-bfc8-46c5-21e6-08d88b24a8c5
X-MS-TrafficTypeDiagnostic: PR2PR08MB4875:|VI1PR08MB3950:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB3950DB5290962640EC7AD4F3EDE20@VI1PR08MB3950.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 9xAHm8UquJXms9pJO6id5NX06m16elUSadm8ajduPyiY/POjGKpNsLUdLa+yor0+zklbgnXO/WFIUCfco0YxLLwggKOEZBDVEPZMEj8znEW3FEhyMPrieyTSDHCnW3XbDkJkD7aQ/TdLAVDOFpRIxoNII/ipZNjNC+oSM1ZOKe/2xgcQ3kkqktVZkaNXYnYuj6OcX6uZSwaOOgK8vHLe5lJasq50BSInsVIgUbRRSSWzW5IDqwsCgj5SEsEzLay/Z3A4kU4EJtZVVdzlVCj1nO0Zq4SbghZkq0LDVQ2MbNDUTvznGFJlAFgdqw4jYBkJRhDFlEsRQh7oyiphg0BbkvbS4VkqrzzgSplJSlPz+6n+QP85roKfIaZRa366jEZLe/PdXDOgt2QEwMjEPXCwng==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5564.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(2906002)(86362001)(55016002)(8886007)(478600001)(6636002)(36756003)(44832011)(54906003)(966005)(37006003)(4326008)(6862004)(316002)(186003)(16526019)(1076003)(956004)(33656002)(2616005)(8936002)(5660300002)(7696005)(26005)(52116002)(66476007)(66556008)(8676002)(83380400001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: nmy9gkIV/nLbXYcyf8A95WfgjAx4Y9Z6bV6Bwc8qb8+lr5JyJ3M9uNjHXRGy8LiRCj7nnyaf9fhA548vNiVEWtmxw5aias08mSnK7djODwV+aqW5DoDv50H8DnQ/OkuS986yR1VB4W4JWdbgGuoYeyqsV4GfIS1i0/05tl65EmKyQsSP11vTV9cehbjuYZFGKoRGIVjc1Ib8VeLnFeyxbtjh/zNODq4vZb6sdkbz+eWvWqm8TWy0Os//8kYCCUwwsWcdO0S5ZzdHpnTB87TWcw/Xof0ULTHctAGjVaBjQ19Z+Qrf+MY67BsjdaRXf9hl7rrvxBAqpzgSz+/yo5fqzMNyd97Gq4ab3IcaBntzk2NWOTTtVA0pBIgtw7Y2urJek6Ba79lIaAjgauHgY0hyVvUWCmBq5UlDyWkjJEZS2hZXHIw/FIIGGHUYbapuls657CpHI52Bfo1XbOJCAKKQvKmkOoYcFQGW5iBUJGIH4E6Utj1Pdk4JnRI+5by7e908ujWorC3m0TpMj+iP9Ejq/nU3tGKSa6EIeIASEGHRqz77wk9BU8l3of67zks+0GNKkfxwIRWkq5ieONgj07n68QmCZKKpC4PUSRQ+39YmzAl5cKFDXuO3Qr6aCT9h0GfXrhkuLNwIAUG7jfpzjdZ3BMHNG9BJtjQ1CjvuDVR6jRkU345Y6/F2+MIsgnu9/iyZ5BF65CxUYqiGHBZjj1djoIQ8BIai99EhYjstIeqgX9aJJC5gqAliVGWiKWwdf4WHfBmUEPBoP+wAFC6l89xAWix0hI0Se73aVrOL3KGhnXkTlkFRJM6R5zyNcZ1cWEXhkPJUGvTB6Ku38Vd+1wNp6dMCGcw0/nwN2U9Q0iIjttg5c16dI0VD1DtzDGquG8XiIZqDG95Fdbux0GDxg8ckOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4875
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT053.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4caeca1f-5678-4952-5775-08d88b24a24c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mdPwpJmTL9V2mamBrjHGT2KQQaFTw9MGQICRHAn3gPFHTMUQVSFcMzHtq+YNyLMunhMqZWvbKuxkDfF4wNDFDIAHXrgOaTPLo5CS2/nNS+lafShnrwPayRqb+UlS8tM7VFlhsdFuZeQyKiYHABk3Z9hg0osC56sSTNyka4U4DCiPNTzIhCHOjsR3ncOdon9HQUFXHhDn50o/yslo91W7NqAoL3Z1+f8MkRs8yoDNoWaBMDevhS4yFpa0d8WQf5nBkCp9nAxE2VM0upl9MobN6F8dEyVBXj99X7DhO22ERihQZf1jc5KG/mcBK0i6UWHMEsFePJiMewV7+QcoitF6Pbv1v7hB4YjoxJvTv5Hw3dQSBGcXi/qpU6ttzYx8cmit9fT/43YBJdPoDc3Hj82R1vAVwDRsJpIOvmSCoxs6slupdJs9HozwQyGJQ7EPJEyrYtkZSu0nHeppa3GZtuDwyED7AU0AlJwbmc8fSeri0ys=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(39850400004)(396003)(136003)(376002)(346002)(46966005)(966005)(54906003)(478600001)(356005)(82310400003)(44832011)(6636002)(33656002)(47076004)(37006003)(6862004)(82740400003)(81166007)(316002)(2616005)(107886003)(956004)(8886007)(7696005)(26005)(2906002)(4326008)(1076003)(8936002)(16526019)(70586007)(36906005)(55016002)(70206006)(86362001)(336012)(8676002)(186003)(36756003)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2020 18:14:42.5795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da3280a3-bfc8-46c5-21e6-08d88b24a8c5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT053.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3950
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The 11/17/2020 17:29, Catalin Marinas wrote:
> Adding Szabolcs and libc-alpha. The original patch below and also here:
> 
> https://lore.kernel.org/r/20201014055106.25164-1-pcc@google.com
> 
> The patch looks fine to me but I'd like the glibc community to confirm
> that they are happy with this ABI addition. I'd also like Dave Martin to
> ack the patch since he was involved in the discussion for v1.
> 
> Thanks.
> 
> Catalin
> 
> On Tue, Oct 13, 2020 at 10:51:06PM -0700, Peter Collingbourne wrote:
> > This prctl allows the user program to control which PAC keys are enabled
> > in a particular task. The main reason why this is useful is to enable a
> > userspace ABI that uses PAC to sign and authenticate function pointers
> > and other pointers exposed outside of the function, while still allowing
> > binaries conforming to the ABI to interoperate with legacy binaries that
> > do not sign or authenticate pointers.
> > 
> > The idea is that a dynamic loader or early startup code would issue
> > this prctl very early after establishing that a process may load legacy
> > binaries, but before executing any PAC instructions.
> > 
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > Link: https://linux-review.googlesource.com/id/Ibc41a5e6a76b275efbaa126b31119dc197b927a5
> > ---
> > This patch must be applied on top of Catalin's MTE series:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux for-next/mte
> > 
> > Alternatively the series with this patch on top may be
> > downloaded from Gerrit by following the link above.
...
> > +Enabling and disabling keys
> > +---------------------------
> > +
> > +The prctl PR_PAC_SET_ENABLED_KEYS allows the user program to control which
> > +PAC keys are enabled in a particular task. It takes two arguments, the
> > +first being a bitmask of PR_PAC_APIAKEY, PR_PAC_APIBKEY, PR_PAC_APDAKEY
> > +and PR_PAC_APDBKEY specifying which keys shall be affected by this prctl,
> > +and the second being a bitmask of the same bits specifying whether the key
> > +should be enabled or disabled. For example::
> > +
> > +  prctl(PR_PAC_SET_ENABLED_KEYS,
> > +        PR_PAC_APIAKEY | PR_PAC_APIBKEY | PR_PAC_APDAKEY | PR_PAC_APDBKEY,
> > +        PR_PAC_APIBKEY, 0, 0);
> > +
> > +disables all keys except the IB key.
> > +
> > +The main reason why this is useful is to enable a userspace ABI that uses PAC
> > +instructions to sign and authenticate function pointers and other pointers
> > +exposed outside of the function, while still allowing binaries conforming to
> > +the ABI to interoperate with legacy binaries that do not sign or authenticate
> > +pointers.
> > +
> > +The idea is that a dynamic loader or early startup code would issue this
> > +prctl very early after establishing that a process may load legacy binaries,
> > +but before executing any PAC instructions.

which keys are enabled by default when HWCAP_PACA is
set in AT_HWCAPS ? i think that would be useful to
point out here.

per process enable/disable was deemed costly to do when
pac support was added, did this change? (i'm happy if it
did, because even without a new PAC specific pointer ABI,
plain PAC-RET can cause problems if a process tries to do
its own DWARF unwinding but does not understand the new
opcode that toggles PAC status of the return address,
possibly in a third party library, so a way to opt-out of
PAC is useful. currently it's a kernel config option and
system wide on or off.)

