Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C420FDFCE
	for <lists+linux-api@lfdr.de>; Fri, 15 Nov 2019 15:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfKOOM6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 15 Nov 2019 09:12:58 -0500
Received: from mail-eopbgr720087.outbound.protection.outlook.com ([40.107.72.87]:33952
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727443AbfKOOM6 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 15 Nov 2019 09:12:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMbdtrKMCyAalIceeeW/dkXCaIr/Wutc0/FG9XvxNOUYf/ZQ80fzR3UTOeFRrRuMkbrgbW63ft3uzfmnHvzJI3Jw5hPoOITpoKfhk1RNN6bmCf7n5ZkUiba0W8lEl+d/uB/Zt3Tlz2uOO2Dm+2A9c9Wz6hLRdzNAdSS5G/f3UhR8jODvMdzaOyv41VTY1+bEVbMXaeSLCnR+qEpSOsMbdLH+L/P8thU5FTUyhfQUXQdqBK+H3BtzD45nvZBo20X/YXXhKoZw/nOWzNsumZMf7P4hVd7URtLKPG6uTtK73oa5ZSYi71Za2GhlLRZXvsFzNq4qZdkRX5qfP7oOjQ6Yqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRCzcWTDN1b92Debzhlgk1CHemLK5eyz87Bbx4Y/uLM=;
 b=K3qEXfz34d2/NCoQN2i9S8wg7puErJ2opZ7dvQy1uLqqJ7BcDh7iP5n18KYuzwA5RHQp7j06/QaFfHI9RT0416i5rIOxs69LXTHaPPgCKK3wdlFgUqkuEeq9zNM3iO5lIGOQz2NPNR/Yd2J/oIR0wYiemI/RH++zk6/n8AORURlkN+ef9qjmra2W3OuwcfOxjZCokcwUu/uXUDPHC8Lz/GQLIlY30nAzU+o0zxGQRpJopBl/NsbnLFH+vOTwr2pr/1S99al8imqiwM2+LNYcAPqzCSJp/poMoc5ZkbKkURu4zhrYsaQqY9dpmXLk21afsiQbH6WwreRoXo5m/UOIQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRCzcWTDN1b92Debzhlgk1CHemLK5eyz87Bbx4Y/uLM=;
 b=ffNF7aHKPKXTyv6spE2Ed21uOrC/wqlIpiR0yHCR7u1W4SQi5DgKlwI2p4QBiadSBAqxiduvZGn0NeOfLkgmoeBq+rx0NSkDLXeoy7SCYaOWHUsqxgeYhnlLfEMNUb8HG5Gi8dCarbcelJ/aOYQWLL+j8H9nthB3V028Vapdb+Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.71.154) by
 DM6PR12MB4249.namprd12.prod.outlook.com (10.141.8.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 15 Nov 2019 14:12:55 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::dd0c:8e53:4913:8ef4]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::dd0c:8e53:4913:8ef4%5]) with mapi id 15.20.2451.024; Fri, 15 Nov 2019
 14:12:55 +0000
From:   Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: AMD TLB errata, (Was: [PATCH RFC] mm: add MAP_EXCLUSIVE to create
 exclusive user mappings)
To:     Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
 <1572171452-7958-2-git-send-email-rppt@kernel.org>
 <20191028123124.ogkk5ogjlamvwc2s@box> <20191028130018.GA7192@rapoport-lnx>
 <20191028131623.zwuwguhm4v4s5imh@box>
 <CAA9_cmd7f2y2AAT6646S=tco3yfyLgCAC4Qp=1iTQaJqrQcOwQ@mail.gmail.com>
 <20191029064318.s4n4gidlfjun3d47@box>
 <20191029085602.GI4114@hirez.programming.kicks-ass.net>
 <20191029110024.yjytp22lhd2vekrv@box>
 <20191029123949.GL4114@hirez.programming.kicks-ass.net>
Openpgp: preference=signencrypt
Message-ID: <1da1b025-cabc-6f04-bde5-e50830d1ecf0@amd.com>
Date:   Fri, 15 Nov 2019 08:12:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20191029123949.GL4114@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0201CA0051.namprd02.prod.outlook.com
 (2603:10b6:803:20::13) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:15e::26)
MIME-Version: 1.0
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 29aa85a6-c9bc-4384-1ec6-08d769d5e8c4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4249:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4249378CBFC6244DA054B7C4EC700@DM6PR12MB4249.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 02229A4115
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(199004)(189003)(110136005)(54906003)(36756003)(86362001)(6666004)(66556008)(66946007)(8676002)(6512007)(66476007)(6246003)(8936002)(2906002)(31696002)(81156014)(81166006)(50466002)(5660300002)(58126008)(25786009)(6116002)(2486003)(76176011)(23676004)(52116002)(6486002)(47776003)(3846002)(305945005)(316002)(229853002)(14454004)(7736002)(230700001)(65806001)(2616005)(99286004)(4326008)(476003)(65956001)(66066001)(53546011)(6506007)(386003)(478600001)(186003)(26005)(486006)(31686004)(446003)(14444005)(11346002)(7416002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB4249;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tb9q45e5EO+q6tc8iEfIYcZg/lxU4Nildc7BdS9/Pu5/4yxDQsDXe2wbE/T5T4gzHMngYSCIZNk+Z9h76EXcbXxeJO/PPDOzhxXVlgHCvtFPnwUB77FugvdTvkCBd+/Uts61jtmseF1YA2DH1HS9NMabd0Bxy7lBGdwG6Va9Ti/AhzXA7lHE82etjbbLhKKaLCwXmNTTTSC+WAInn7pEP5YoITuMMfickMnhnz4bINpjZPuiwYOTrqw5+ey5cWSu0T04COWqhBzLxTWcgXppn7h2iKXFoUT/9tKXLp35GyxckDPTCWLBR/ILuAuriSArWGe76XXIQQ5Gst6YjFL03FyD7k9F51JucTrv4a7TBMa+yrMijqAFSSrIVkvYbI8nEo5nn7ewUDJZoqEPdChb4weFN5VfYLO3BGcn1NpaO05/VtgZd57wtNFEuWxrONB5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29aa85a6-c9bc-4384-1ec6-08d769d5e8c4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 14:12:55.3570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTqq3rO6DX3jiRmRDnIGST64sWmiOnqps9AAp6cWLOIKw0KXxgkQ2GCRopED8H5lZB77vcerJr0vMGxY9BaBlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4249
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 10/29/19 7:39 AM, Peter Zijlstra wrote:
> On Tue, Oct 29, 2019 at 02:00:24PM +0300, Kirill A. Shutemov wrote:
>> On Tue, Oct 29, 2019 at 09:56:02AM +0100, Peter Zijlstra wrote:
>>> On Tue, Oct 29, 2019 at 09:43:18AM +0300, Kirill A. Shutemov wrote:
>>>> But some CPUs don't like to have two TLB entries for the same memory with
>>>> different sizes at the same time. See for instance AMD erratum 383.
>>>>
>>>> Getting it right would require making the range not present, flush TLB and
>>>> only then install huge page. That's what we do for userspace.
>>>>
>>>> It will not fly for the direct mapping. There is no reasonable way to
>>>> exclude other CPU from accessing the range while it's not present (call
>>>> stop_machine()? :P). Moreover, the range may contain the code that doing
>>>> the collapse or data required for it...
>>>>
>>>> BTW, looks like current __split_large_page() in pageattr.c is susceptible
>>>> to the errata. Maybe we can get away with the easy way...
>>>
>>> As you write above, there is just no way we can have a (temporary) hole
>>> in the direct map.
>>>
>>> We are careful about that other errata, and make sure both translations
>>> are identical wrt everything else.
>>
>> It's not clear if it is enough to avoid the issue. "under a highly specific
>> and detailed set of conditions" is not very specific set of conditions :P
> 
> Yeah, I know ... :/ Tom is there any chance you could shed a little more
> light on that errata?

I talked with some of the hardware folks and if you maintain the same bits
in the large and small pages (aside from the large page bit) until the
flush, then the errata should not occur.

The errata really applies to mappings that end up with different attribute
bits being set. Even then, it doesn't fail every time. There are other
conditions required to make it fail.

Thanks,
Tom

> 
