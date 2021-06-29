Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676F63B77DC
	for <lists+linux-api@lfdr.de>; Tue, 29 Jun 2021 20:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbhF2Sbl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 29 Jun 2021 14:31:41 -0400
Received: from mail-bn1nam07on2044.outbound.protection.outlook.com ([40.107.212.44]:43425
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235227AbhF2Sb0 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 29 Jun 2021 14:31:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEA7RD/GNQL8RjKiMXqLenLiHsCpq+ZW8iT//6ae6rC9fenUNAgEkyDpHGPPVxTYhDkU8L1U58r4ZtAg/eny3Dp6NCAmFb3EcxbDhYAsib9i0T14QMmjgoF8XQ3h/Jh8FkCGpdeidh3CkbVquyl19XhHCSr9iM+2ClfafSTs7dlMgyih5gG8brd0HgBpu1Gm2dDIFzOzEPT1X+LLwuysrZe0j7LKFbKc0ieZdnvRjh7tXnOwtQbTb4nIMsjO9A5ckSz1xP6mgCKb7Vb8R3r2ofW9WiUCDAac25ZngC5SFlDn6OCDPWaD2RpjrSg1ww+9Vndeh1gKrIimBn7d3WRwag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpiucJxGmZy9SA9WJhQD/Rx4v9c6We2XYJ7PcDwCrgk=;
 b=IEBDCNO6KTV3gU8dboIKJxVtrvbbcfuSOyYYUW3TcPk6KWSQj90fFOZmmgjCsxPKaG2fovtTXH7dlbdF7UBorS12u9Aheiz7GaDXCxAkCMXib0B5HGPJEaIYpWaIvfeuJnASzzLqdjZskoLm4EsT8dLFx4IOcStl7NDtku+3LqMyqpVJl56FyDInyImBYbMjZXKVSi74lGjOGCDHRdSgK0KDV0uYNTOHHYb17HStfDm3gCHoZe2E9Oo/n4qvIDt63VSpSwQK8ftuRQwt9hTntiUMSKtB+/TvCqFo4m2GccN2KfXYFl4kdhdKh+pyX2tH+yM8uwGf4d+dRyFXosbdAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpiucJxGmZy9SA9WJhQD/Rx4v9c6We2XYJ7PcDwCrgk=;
 b=dSEY2Yw4V/kbH+H4j7Og7rwt9ZtO5WCYD456hqxTYgf2jc+BYr39zCFbKz10ascnED6RjlD0NHurVVKMY5vQWfJXo0ChN51gjYS17bgYe1bOVuF4rIo5P5RcxzE6UxIVS9axKMnWxJnXTSGv/A4Ma97EATpi13YP/dktvGrjBkkGea2Q9hQTluMIBkwkHFhBkHFupIHroIDB2XmhoFdQ1ml2w547wowoFcZ2gisNnaBkYomQxvYFl/uQt7QEYfAltI2Gmhrt1HdXS082+RV4jeqoESUg/44yx73OEdgWhQcAqNIrY3akFaUz16UQa7fzSNhRrSGiVLlgkjelMIiENw==
Received: from BN6PR20CA0053.namprd20.prod.outlook.com (2603:10b6:404:151::15)
 by DM6PR12MB3433.namprd12.prod.outlook.com (2603:10b6:5:38::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Tue, 29 Jun
 2021 18:28:57 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:151:cafe::d1) by BN6PR20CA0053.outlook.office365.com
 (2603:10b6:404:151::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Tue, 29 Jun 2021 18:28:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linux-foundation.org; dkim=none (message not
 signed) header.d=none;linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 18:28:56 +0000
Received: from [10.2.59.206] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 29 Jun
 2021 18:28:55 +0000
Subject: Re: [PATCH v4] mm: introduce reference pages
To:     Matthew Wilcox <willy@infradead.org>
CC:     Peter Collingbourne <pcc@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Jann Horn <jannh@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        <linux-mm@kvack.org>, kernel test robot <lkp@intel.com>,
        Linux API <linux-api@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
References: <20210619092002.1791322-1-pcc@google.com>
 <51c68f8f-dea1-c0c6-7cfb-28d42338ba88@nvidia.com>
 <YNsK8bZ+S3VtsK9g@casper.infradead.org>
 <3c77290d-3a79-9f41-f4ba-7eda399df150@nvidia.com>
 <YNtkncx0BdhX+kse@casper.infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <e0365fc0-e975-9e26-048a-eded27776847@nvidia.com>
Date:   Tue, 29 Jun 2021 11:28:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNtkncx0BdhX+kse@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60c06a72-30cb-455b-774a-08d93b2bc1a6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3433:
X-Microsoft-Antispam-PRVS: <DM6PR12MB343382655F20AAA4EEAEBAC7A8029@DM6PR12MB3433.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gm7dq5Mm7pS8VxiY3HxMr9TICE+efCA0rdaW12dTKT9GbsgMi7lBwHm5RnDdIJrzIUcaR0CUPMyB91VDLyou7PWtCdJ6MlXv5qM/8nMHIVQCTRVS+eLmhaQcRaGFsW46K0cvniBudQUdDo/xqpOC0xGd5iBl+hkRNOL7/lmF/qb4ct+1EduKztnYjVZpd7hFOBUFexfSXxsLkujJCpOCupDeOV7rPLSs0ohIdqtYE0LcNt4B37HLb8Xa6zK4ClAbNIwF0zp4mDILWMlM0kZYeVRUjnPhb4zOcjF3JpOC3PmTVZ228nnTN3gVslSPQwo58WFmuPg/VJlRL30VTq3rtglRsZgHOWQMABvh8IFJL336ndIk2FzbSqbE/2T+uwzwpDSGGmxzPy1FNQdfJQP8qQtuxk2RUyoJAU60JpfNfRqytrBJgWlH04DvW00bUIIJacX/PWomF+m+FFgZKe+sTbmuzzvtND5K6zHc6/+wh6ujSiOD9kB6+lB5UKQ1FR+pqNBZtc/o3ZFibW2b8r/gH8qOW5hu6K/zUIwGePPZduWZWxVn5EgOSV4t6Jw2q/VuLno2X9LoF/G3cKrM8ZDYJyuUkiBnHiuFr71e4Eq13TdS5mJEwbRyZQ9CnjgqfT32jSJ1+EGVBOKhJjlqESNj/kLQqlTY2eXA9qC1whCgt3B0kTdRlLfqM2s6y2mfHm0lqnGuo8Gx6mRMn5D/3DHPzTv4UyyZGJvIFcapNGVjoZQ=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(46966006)(36840700001)(316002)(5660300002)(336012)(36860700001)(356005)(16576012)(478600001)(70586007)(82740400003)(2616005)(4326008)(54906003)(426003)(36756003)(186003)(70206006)(26005)(16526019)(2906002)(82310400003)(47076005)(8936002)(7636003)(8676002)(53546011)(86362001)(7416002)(31686004)(31696002)(6916009)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 18:28:56.6511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c06a72-30cb-455b-774a-08d93b2bc1a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3433
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 6/29/21 11:21 AM, Matthew Wilcox wrote:
> On Tue, Jun 29, 2021 at 10:48:20AM -0700, John Hubbard wrote:
>> On 6/29/21 4:58 AM, Matthew Wilcox wrote:
>>> int refpage_create(const void *__user content, unsigned int size,
>>> 		unsigned long flags);
>>>
>>
>> That does seem better. The key is to have at least one more parameter.
>>
>> Actually I forgot to include pattern data. In both of the approaches above,
>> flags is probably used for that, but if we already know that patterns
>> are being passed, then how about add a "pattern" arg? I think it's
>> good to leave a little room for flexibility and future extensions:
>>
>> int refpage_create(const void *__user content, unsigned int size,
>> 		unsigned long pattern, unsigned long flags);
> 
> I don't get it.  'size' is the length of the pattern, and it's
> pointed to by 'content'.  Why would you pass 'pattern' as well?
> 

argghh, I think it's actually best if I avoid this whole "thinking" thing
until after doing the Coffee thing. sigh. :)

Yes, "content" would hold the pattern. So we're back to your exact
function prototype.


thanks,
-- 
John Hubbard
NVIDIA
