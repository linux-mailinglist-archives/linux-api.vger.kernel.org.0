Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFF43CF255
	for <lists+linux-api@lfdr.de>; Tue, 20 Jul 2021 05:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244250AbhGTCWW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 19 Jul 2021 22:22:22 -0400
Received: from mail-dm6nam12on2068.outbound.protection.outlook.com ([40.107.243.68]:11712
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243997AbhGSVuz (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 19 Jul 2021 17:50:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnIGC4jb8rpFsVEQJETK5GlWErzgAVDTSWlkV7p7/2SIU6mVS9nbfxCZ3BtICfNfI+YTOHkxIo216/1imU8IjemxP3+RrEaolWOTTZhfX+aatR1kMYSRnUmpMtL/UCpr2tJE6QPBFLOmhArBCZGergs9G8MGBpMjlXB0G1lZkPkx+7QbBub7ZnlJ1CbzAabotp6oQM/gmQ8ihHYIe0wMrpWTS3vTP8+jaaBxprhUry+aVb7QRe9iwtdhakqrpuYb7xMmSe4P/ophRhczR4I7ZdhFgNDY5PJ7JzoOFA2W4VMvpudYtQestCkVpExt4INx+g+M5fKs/Uhc7ZmVIMGqzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EK3lkH3Styyzi74ukxtOsX/Eq7LWwvEwClUNqqEeIiE=;
 b=F+fO1uyTgffmV0WlrZ7br6Ly/Ch08zLnqb+WHXPifghq61ydAyWT9jy6JMCb9xlrrrH1FxIseBrRBA1V3qBUTCNbDbOwsXglrxV6pec5JR9TZW02+J8OJ+P03ny21y7obqv12+OYsJ+auwz7/m6Xp8kp7V7z0bf9nVBCk0Ybpw2pd/LlVTPv4L0IJy6X+6GZhAjo2bPW/poNbhWle6iIXXYreMEHPi8nfz2DKd77z6mHooQ/w1lMD4ag714X+Y2TBpcSiHVpKcBjpJD5O14JaljSeTyM+UIeMPY0tkMiV1ttp5APWMg0cJKg2NNFN1T99vjx8aPGn2hj3ggNmTPkNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EK3lkH3Styyzi74ukxtOsX/Eq7LWwvEwClUNqqEeIiE=;
 b=rXEZto9PGxLEq+br/xOATT+oj0uaeTAgMKgK4IH9dbMBipf3+MIbd7DK+yrg9xx9Rvaqemq5uvOjo5N/71u/kCNyE7ZUDLovaK4xqLEOGmh8iMFP1LsBRbEK2LnYMIqMl/DnWhr5NPaFGnbWhpGzn4LhEivgJIX5jZirCdRFDI5g4ALuFSQ89ocSBc46i6gGGd9qZtlasH7lYPyUxzVuA3YGXcsTtgdFHCIrl+HCeQfCWs0Mvjr0WU/bngog4Y88t3IpCjzGuSDrEflGSVYn1yQDukg7BudYPlSzrecO59I/n4I8HOu95zsLfc+SHYgnHrdktpXyoFISHmOX6n6TIA==
Received: from MW4PR04CA0234.namprd04.prod.outlook.com (2603:10b6:303:87::29)
 by BY5PR12MB5509.namprd12.prod.outlook.com (2603:10b6:a03:1d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Mon, 19 Jul
 2021 22:31:33 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::fc) by MW4PR04CA0234.outlook.office365.com
 (2603:10b6:303:87::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Mon, 19 Jul 2021 22:31:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linux-foundation.org; dkim=none (message not
 signed) header.d=none;linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 22:31:33 +0000
Received: from [10.2.84.248] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 19 Jul
 2021 22:30:47 +0000
Subject: Re: [PATCH v4] mm: introduce reference pages
To:     Peter Collingbourne <pcc@google.com>,
        David Hildenbrand <david@redhat.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Michal Hocko <mhocko@kernel.org>, Jann Horn <jannh@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel test robot <lkp@intel.com>,
        Linux API <linux-api@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
References: <20210619092002.1791322-1-pcc@google.com>
 <30e92457-d540-159c-4c4e-0b8f0d2a1838@redhat.com>
 <CAMn1gO529Ua1LJBM=vdwT8Cz+CXSvJcuGhuqotSuiUyjTBDfAQ@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <5359583b-6acf-4db4-b036-ff1a538dced5@nvidia.com>
Date:   Mon, 19 Jul 2021 15:30:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAMn1gO529Ua1LJBM=vdwT8Cz+CXSvJcuGhuqotSuiUyjTBDfAQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a988364f-a59c-4a05-bffa-08d94b04f647
X-MS-TrafficTypeDiagnostic: BY5PR12MB5509:
X-Microsoft-Antispam-PRVS: <BY5PR12MB55098A1E6F337DAEA41BFFF1A8E19@BY5PR12MB5509.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nSb5FCGZhkV0bxxEOqV9sQTZp3d0eh8mrJaijNuO7QgvCNlOdXI1JwDRDFw+i1gaf0eGb1N8ie/tGCiA1z8uErwn6QmiEZadonILPHQdmUl350df7cipF9kF9yH2kWWGl2J2nJJFilF7FtpL8J9ezgNFORB+ZaIf3Bi5gW+abJhpXCm5X/4UkwBTxnLFUymxezjeeHvf16xW5siqjOflK6BLdOa987QvAR1cmcwFxRXed7vpljBNfOFh9u2mei0J3RlH16lZQR+Zsc5CHQEWNhCI5256QrS6a/BictESsFPucFe+xY1GTPmPAZUPxM7wybfBesuc3K4wP0UxngMfhUQZVXCngqrehPWGbPgLOYqspXqPWo0sT9JqvVDOv3K0nxXeieUB0pfsRvfMmnrwWJigS5PJjENuoJaQyoFQBIn5AT3fv877h9nLRaMu2uab8jxkGFqUPfo8bivqG8UFvBc8j3sssYvL05BDN2UIgmyHK9rYoCmEmOE5Anc+KJWL9jHFuFGBKJdw2RlZc1mAuV6hHuR8WR5woOrsZZfbGb9NLgbDRwNz2ZqwZYhOKpMASpDQfndEcMPYhSyFxqR0FawZm+c8Ok+OKOwJHGd58dszXTDTWjaDMRMHH9Iorn5zktktOk6ROGMM8WjBhYhy/vzVReSI16MovBYQVjnhu2W12lYS+OsMJGtXHa2tm0w1iGZzubWxhPnthJQ2rR6hP+NaFc+RUHB8OPfjs9PrX/A=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(46966006)(36840700001)(186003)(478600001)(16526019)(53546011)(2906002)(8676002)(26005)(86362001)(336012)(31696002)(426003)(4326008)(5660300002)(2616005)(8936002)(7416002)(7636003)(31686004)(110136005)(70206006)(70586007)(54906003)(36756003)(82310400003)(16576012)(36906005)(316002)(82740400003)(47076005)(356005)(36860700001)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 22:31:33.1686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a988364f-a59c-4a05-bffa-08d94b04f647
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5509
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 7/19/21 3:26 PM, Peter Collingbourne wrote:
...
>>> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
>>> index 55b2ec1f965a..ae3c763eb9e9 100644
>>> --- a/include/linux/gfp.h
>>> +++ b/include/linux/gfp.h
>>> @@ -55,8 +55,9 @@ struct vm_area_struct;
>>>    #define ___GFP_ACCOUNT              0x400000u
>>>    #define ___GFP_ZEROTAGS             0x800000u
>>>    #define ___GFP_SKIP_KASAN_POISON    0x1000000u
>>> +#define ___GFP_NOZERO                0x2000000u
>>
>> Oh god, please no. We've discussed this a couple of times already:
>> whatever leaves the page allcoator shall be zeroed. No exceptions, not
>> even for other allocators (like hugetlb).
>>
>> Introducing something like that to the whole system, including random
>> drivers, destroys the whole purpose of the security feature. Please
>> don't burry something so controversial in your patch.
> 
> Got it -- I was unaware that this was controversial.
> 
> Avoiding the double initialization does help a bit in benchmarks, at
> least for the fully faulted case. The alternative approach that I was
> thinking of was to somehow plumb the required pattern into the page
> allocator (which would maintain the invariant that the pages are
> initialized, but not necessarily with zeroes), but this would require
> touching several layers of the allocator.  I suppose that this doesn't

That sounds right.

> need to be done immediately though -- we can deal with the double
> initialization for now and avoid it somehow in a followup.
> 

Actually, I'd encourage going straight to the final result, in this
case. It's good to see what we are going to end up with, and figure
out if it's worth the trade-offs.


thanks,
-- 
John Hubbard
NVIDIA
