Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220CF2C4241
	for <lists+linux-api@lfdr.de>; Wed, 25 Nov 2020 15:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgKYOiP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 Nov 2020 09:38:15 -0500
Received: from mail-eopbgr70089.outbound.protection.outlook.com ([40.107.7.89]:10818
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727611AbgKYOiO (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 25 Nov 2020 09:38:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrKkcCyZ3NT3eX5cRm+jpTomxuPLMcCvUvcXCCeCCRc=;
 b=ZVFGMKWgumBOCk5wdyJG0HZtb3J2jG7Kk07nz7/wHNQwXChV1OgDayaz5WWgi59CujdNZUcTPSzW7ToDKZm0Q5wY3E7elD9vVN6A0DPY14vhzuHYcvv3P576jpH6QXpw6wyYlJc3LDvTqHDGh0R5qJBsErwRRyBJsu1HDZeoD1Y=
Received: from AM5PR0301CA0019.eurprd03.prod.outlook.com
 (2603:10a6:206:14::32) by DB6PR0801MB2085.eurprd08.prod.outlook.com
 (2603:10a6:4:79::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Wed, 25 Nov
 2020 14:38:08 +0000
Received: from VE1EUR03FT015.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:206:14:cafe::fe) by AM5PR0301CA0019.outlook.office365.com
 (2603:10a6:206:14::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Wed, 25 Nov 2020 14:38:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT015.mail.protection.outlook.com (10.152.18.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Wed, 25 Nov 2020 14:38:07 +0000
Received: ("Tessian outbound fcd5bc555ddc:v71"); Wed, 25 Nov 2020 14:38:07 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 33931dd6d35c8835
X-CR-MTA-TID: 64aa7808
Received: from 84a9dd5f86ae.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B95AA5ED-A476-41B8-91AB-7A6399F6F553.1;
        Wed, 25 Nov 2020 14:38:00 +0000
Received: from FRA01-MR2-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 84a9dd5f86ae.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 25 Nov 2020 14:38:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQUHDSPrwESwUBUW+Ik6A1lx/B3bW2ucUMZmMWttPUqoepaaeuljMuiLAKotWKr5YnyEro/RoXQTIzjDfMd8pLXA2dJypZkykJmwEkY+rqfvIoBbhe5PMg5aTg/qS+olu/2iWVLz1o8tkMx8XEBcaTZ3S6zMv58J4Jr2KRD+aFzV6nijAb3zxKUG6r1dQTohIFVP+KChz/QPdNZlAg7qPUfpqL63f6UfOZ5NUmGuaHCtyiTITGf/JP/K0YgfF96Sojy3zknw9fIAgUk8Kp1/g1wYIWbvP9RppLnh7r2yCD66xw52k7tQyDWRT+rEh3BiuZXKrvObef4abHEFX71B/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrKkcCyZ3NT3eX5cRm+jpTomxuPLMcCvUvcXCCeCCRc=;
 b=gLLugsCQZWl6sKMntp9hIdKAu4q5S+q6Yv9+OtGj/VuOsS28JHcbmCxLAgPnj7vUMPvd0/abH6iOr8tVGB/A8mYV9hsWDf19Oao9kcjyOQScEbZC5YKW8mRs0B5v3y+TqbpTyPuNEqVcrMDMd976wdiYa9s92b/WiwjD7HrpIOuWb2LbQH3DwwULIWpWufzMuh70VRonBuUj4yWwfAVN5hKWoz6iu4nukGI/BAQr8727mSJNPtLFPu6PoUbKeU9gIOeICO4pOgg6FbkRmU4hltC/V6betmuuRWqJlrCzlt8gupxkHopUR+1MJzA44VdLyL35btPmR7B9ZlJKWtChBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrKkcCyZ3NT3eX5cRm+jpTomxuPLMcCvUvcXCCeCCRc=;
 b=ZVFGMKWgumBOCk5wdyJG0HZtb3J2jG7Kk07nz7/wHNQwXChV1OgDayaz5WWgi59CujdNZUcTPSzW7ToDKZm0Q5wY3E7elD9vVN6A0DPY14vhzuHYcvv3P576jpH6QXpw6wyYlJc3LDvTqHDGh0R5qJBsErwRRyBJsu1HDZeoD1Y=
Authentication-Results-Original: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=arm.com;
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com (2603:10a6:102:87::18)
 by PR2PR08MB4874.eurprd08.prod.outlook.com (2603:10a6:101:1d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.29; Wed, 25 Nov
 2020 14:37:58 +0000
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::ac13:db5:ef4:2dd2]) by PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::ac13:db5:ef4:2dd2%4]) with mapi id 15.20.3589.030; Wed, 25 Nov 2020
 14:37:58 +0000
Date:   Wed, 25 Nov 2020 14:37:55 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Linux API <linux-api@vger.kernel.org>, nd@arm.com
Subject: Re: [PATCH 2/2] arm64: allow TCR_EL1.TBID0 to be configured
Message-ID: <20201125143753.GO20578@arm.com>
References: <20f64e26fc8a1309caa446fffcb1b4e2fe9e229f.1605952129.git.pcc@google.com>
 <64c0fa360333fd5275582d25019614156a8302bc.1605952129.git.pcc@google.com>
 <20201124184742.GC42276@C02TF0J2HF1T.local>
 <CAMn1gO7G=s7pHFf3jNLj6tZyRuRDvpC2_o=oNWEi4h902hnj6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMn1gO7G=s7pHFf3jNLj6tZyRuRDvpC2_o=oNWEi4h902hnj6g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [217.140.106.54]
X-ClientProxiedBy: LNXP265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::13) To PR3PR08MB5564.eurprd08.prod.outlook.com
 (2603:10a6:102:87::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.54) by LNXP265CA0025.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5c::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Wed, 25 Nov 2020 14:37:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: be9816de-b09b-4ad8-e983-08d8914fb9d8
X-MS-TrafficTypeDiagnostic: PR2PR08MB4874:|DB6PR0801MB2085:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0801MB2085479D7D5CD320727E8089EDFA0@DB6PR0801MB2085.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 3/w4cF5lUqhnrclVmlYKn75Bux/X/4ayWUGXcUx88vEFC+5/+JNgssyYOuddbQz6eUXub9ygWBCcMMliQ07KwnOhQJyr/wx1X0mySW8+cAQ9rXFCToUxm2A9mW2mF2D5sU3HGhB0ApnrXf2v7jm4UVXlbYSIiSv3OmFo3j5NvVgs35oeaVZZtxUELLdC246NGHE5BbpDnGDIzighrqtCxtKmfmNO0cGI5kJxj4+CKGJt46mfgaKI98GOAQY3z3H0IDHNGyZLMyKq3Q/LUcjmGyR673hpIfwKDlGDfF0JE5t0lwTc5dKgla/4Vpdol+mwZwSFbLU4btHQ/pBcYU+vwqpCVojsH+KsFu33k+tDGHYsPz4Cbp66OhoQYM7+6cmbii1xEgvVrd/7FWYjvhskhQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5564.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(26005)(66946007)(2616005)(316002)(2906002)(44832011)(6916009)(66476007)(66556008)(8936002)(8676002)(55016002)(956004)(83380400001)(4326008)(16526019)(186003)(53546011)(966005)(1076003)(36756003)(5660300002)(478600001)(52116002)(8886007)(33656002)(54906003)(7696005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NDQwSFJ1d1pndkdjSnpOUnUxS3cveDJoM1A1Nm5waXlwWnRjTTJrbVdwK3E5?=
 =?utf-8?B?ZHNnekdZZzhsMXc4ekxwVHN6UGUxY1YxOElPb0VMamN5L3MzN2tnaHFsUVM5?=
 =?utf-8?B?VVZzd2lNMFl1aktBZlE0NXZlNEllWmpyMDNKb2EwYVFxb1JLZnZlWW41TjZt?=
 =?utf-8?B?Vm5KTDViWWZLalRqL0RQS2pySS9FZ1pXZW56aHh0aWVHWk1Yc0JHcFhWZ0Vt?=
 =?utf-8?B?YnMrS3IyWlFWOFdlS3BPa214a1dZb2QxYlJpYndDVStic1QrZlkzSDZXRmlR?=
 =?utf-8?B?SlQrUUc5UXZLN3piRUV0MzRCcGNYcU4zT2NHakRrMHM5THF2V2JCc292MXlk?=
 =?utf-8?B?UmhlQWd0cnFVT1pscExxTk9UOFljWnpGTGNwaGZOTWVPUmdRaHlhb3pZbkpU?=
 =?utf-8?B?dmZiSitRMURmZHlCcE5QME5yZTJ4OUZPMkJKemJ3cWFSWnFzanJXNlIrRDNF?=
 =?utf-8?B?Q1E3dWNqOHNPYnRjM3NJMU9HK3lFYUpwVVFGTVdTVDBlNCtRRVVnZFFHc2Ey?=
 =?utf-8?B?Zm0zMGtBVENVUnVRdnR6R1MycFNkU3FJRDU1WXZhWmk1aXBZZ0srbUpZeGs4?=
 =?utf-8?B?amRuYllLNzFQNUUvWldJZzhUdXFrMXI3c3NSVkpzRGJOaUVvMGFKTEpIMnFU?=
 =?utf-8?B?OVN1RmxEcWZoUnpxZ3dMSjg2cGozZVZvSzA2UFE5ZEZNZEt5STVVZUtaQkEy?=
 =?utf-8?B?cUVDSWhpNXdKTE9rVGRPZWZ5QkRaUW9HQmpDTFkrQ0xGVjhnQjdvWk5ESy9u?=
 =?utf-8?B?SHU4TVZiWmpCQWlRendxb3Vmd0xtUVBFWmQ1VEtJdmRaUWEyaUozblZIcFRK?=
 =?utf-8?B?TUVvVXZvOS9WbFgwZllwQUdDYjlKeTlSRGtJRWZuWkVGY1h0QkM3bkhJd3pX?=
 =?utf-8?B?dTB2aElia0tzVHJTQlhSdHVFZE55SmpGZGY1alk2b09nRG1wVGp0b2piTTZS?=
 =?utf-8?B?R3lBajNSQi9ITDllakcrVEVHN2w0ZzAzT09aWVpsVnp1YjROMklwTnRqQ2F0?=
 =?utf-8?B?bGpuZGpGMkI0K2ZKWTNLQ0hpcGR0bk9hZW5rTzkxQXUzMDBKeWliTWNwT3h1?=
 =?utf-8?B?dU1PajM1QjViZllkbWdYbnJneHlVWHpYKzJmdGFHNG9tcDZJWktLSTBQY05l?=
 =?utf-8?B?bFB2anI3YmpORFJaYnI4R2NqZFpyL2F4bW8rOXVRNGZkMEgyU3FJS0xPT3Fn?=
 =?utf-8?B?QVNmSC9rSnRKRTBBc21yTDgxMC9WNFlqNUpKMTA1QVJVWjZZQzQvU09uK1VU?=
 =?utf-8?B?T3l0ZEI3RHVIRzBaOFEwMWJ5ejNPNjY3ak45ZDFHM1BDL2tyclNDdjJjQnd3?=
 =?utf-8?Q?fUArBgAi97ZucK267ih9bnPQfpci72P776?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4874
Original-Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT015.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: f4229882-fb1d-4984-7dfc-08d8914fb3c1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bxjn76fP9SwD5XcHjFB572UsdP0s62CP3g7jMRtcgLMZW83P6/V6CH1j2gpeZ8acPfkjFr6tfkP0bE7G3RR1KKRfpmBwbz1VKQoe1v26fMO3STrDOo9R8kLXTkvS/JJeP45Qhe1IiLNScW9KdVuXO8rk+kKElvq8oMy9hNcUazl30PUclN5sRdVIlnApRsYIGbqcQDQJvoF2Rl1rH+KJseSiNZSxhJG8VBdcNXY2f+Dojx1Qs7TG0LDEXfCDhMQVqkBJLDAapOOhsPumZq4O5HUXqbfsWQV++0aOZE3aR077GUvmsqLcLVItZnkReI0jZvrOzb9iA/aTmtqH7uB5TkzGq6J1zBL2Z2L0E7/sHHi9pkJMmZeN1kvtaSqloBO1WH7e+++5gsb8rXBdr2WhrdClvgZU0tkv97X/zUa9OTjvtCQZCr9p8kcbtoqTL8ITtXL1A4QcqqIGkxiRRRVBV8xr4I9Uomaz/Zx3UzcP1qQ=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(46966005)(1076003)(956004)(4326008)(53546011)(2616005)(86362001)(16526019)(478600001)(83380400001)(82740400003)(54906003)(2906002)(82310400003)(33656002)(186003)(356005)(6862004)(36756003)(336012)(81166007)(26005)(55016002)(8936002)(5660300002)(7696005)(316002)(8676002)(70586007)(966005)(44832011)(47076004)(70206006)(8886007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2020 14:38:07.8106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be9816de-b09b-4ad8-e983-08d8914fb9d8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT015.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2085
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The 11/24/2020 11:18, Peter Collingbourne wrote:
> On Tue, Nov 24, 2020 at 10:47 AM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Sat, Nov 21, 2020 at 01:59:03AM -0800, Peter Collingbourne wrote:
> > > Introduce a Kconfig option that controls whether TCR_EL1.TBID0 is
> > > set at boot time.
> > >
> > > Setting TCR_EL1.TBID0 increases the number of signature bits used by
> > > the pointer authentication instructions for instruction addresses by 8,
> > > which improves the security of pointer authentication, but it also has
> > > the consequence of changing the operation of the branch instructions
> > > so that they no longer ignore the top byte of the target address but
> > > instead fault if they are non-zero. Since this is a change to the
> > > userspace ABI the option defaults to off.
> > >
> > > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > > Link: https://linux-review.googlesource.com/id/Ife724ad708142bc475f42e8c1d9609124994bbbd
> > > ---
> > > This is more of an RFC. An open question is how to expose this.
> > > Having it be a build-time flag is probably the simplest option
> > > but I guess it could also be a boot flag. Since it involves an
> > > ABI change we may also want a prctl() so that userspace can
> > > figure out which mode it is in.
> > >
> > > I think we should try to avoid it being a per-task property
> > > so that we don't need to swap yet another system register on
> > > task switch.
> >
> > Having it changed per task at run-time is problematic as this bit may be
> > cached in the TLB, so it would require a synchronisation across all CPUs
> > followed by TLBI. It's not even clear to me from the ARM ARM whether
> > this bit is tagged by ASID, which, if not, would make a per-process
> > setting impossible.
> >
> > So this leaves us with a cmdline option. If we are confident that no
> > software makes use of tagged instruction pointers, we could have it
> > default on.
> 
> I would be concerned about turning it on by default because tagged
> instruction pointers may end up being used unintentionally as a result
> of emergent behavior. For example, when booting Android under FVP with
> this enabled I discovered that SwiftShader would crash when entering
> JITed code because the code was being stored at a tagged address
> (tagged because it had been allocated using Scudo's MTE allocator).
> Arguably software shouldn't be storing executable code in memory owned
> by the allocator as this would require changing the permissions of
> memory that it doesn't own, but from the kernel's perspective it is
> valid.

it might be still possible to change this abi on linux by
default, but i don't know what's the right way to manage the
abi transition. i will have to think about it.

i dont think PROT_MTE|PROT_EXEC is architecturally well
supported (e.g. to have different colored functions or
similar, pc relative addressing doesn't work right).

(tbi for instruction pointers is unlikely to be useful, but
extra 8 bits for pac is useful. i think we should be able to
move to an abi that is compatible with either setting.)

(i think supporting mmap/munmap/madvise/mprotect on malloced
memory is problematic in general not just with heap tagging
so it would be nice to fix whatever jit that marks malloced
memory as executable.)
