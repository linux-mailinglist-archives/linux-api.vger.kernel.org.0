Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1A53B6940
	for <lists+linux-api@lfdr.de>; Mon, 28 Jun 2021 21:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237086AbhF1Tqy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Jun 2021 15:46:54 -0400
Received: from mail-mw2nam08on2050.outbound.protection.outlook.com ([40.107.101.50]:41152
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236432AbhF1Tqx (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 28 Jun 2021 15:46:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TH/n2D+RjiYwDTmE1vtxwnCLv7x4JAGUqlesCaA+BZPNFyKqBFlBEs2Dj36z1Lq+okjoA5vVwpNNs9uXKjdG2kMXVgUy6Z6nKaB9ZED8CgfUOCC1rDpVktchcjPPK3ZtYpQT6587VmWhpUkUNYlb/LXetgTaxoYRRCizQ/XrH4FiSl7dKDv/PiAsZnAx3GF0z3uQP/76QAgjgK0xh/DsjhfnMg5GcSrJ+BZwTK7Li3nTonlmC86A4vQwLM5JRDQA+waqUfkRE1CAitUHwXLSeL3gzLKr7OQt2SQn7c1+BDuwOUZNuugAECLDVKrAyVj8vdvSBucuXnI0IQamPBUExw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vc4idYZ3frxmStIpH1PO2I9z9ScQ+yhNb26EVNJcHyI=;
 b=BhnO3RdLspGLEe/jom2YxxtNhCmYqVs8Nk9RHkDtGJqFgg+4xVfxpt9tmeCtltaZOcm+Jc19gPT/DN6Mqqdt+u2dWz4Mnrp8oH6Lp7E3fqTyJ/DT0mdatL+cXQlO2xthQe377Ny6LUSaDAgQGnHmIw1FHymimY39OUUdLYWkyu/Krqj/2uhK9sJLI2lRQhqDDU7JEE8ooAqR9lIvnOMA/HLZzMMw+qEfsR8sfgBJthX34iAO54lwnP/i/f0nipoAi6ATeJpOsl17WJOzWeQvS6v6+qyWVrDXktYxinA9Zc1fkSMNv3WimZOfIZHo2fsZm7AUAvYDrXykNzoPmtgjqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vc4idYZ3frxmStIpH1PO2I9z9ScQ+yhNb26EVNJcHyI=;
 b=hDkzcbg2xqyHzmrnCDxiwGeiDpkREnGkraaObPGZOdvRax7zYkkDsH8o/qFeXihFQ5HHzrLK1pp5J/K6M7N9eTguwbg5hlhHQ82dgVg50llfXSgZiUIkwBAjcwTLLzAPVe7/EqgDbTYA34WXHZO0WqyCiehGQdQ8qENoMXzk5BEBNdArmF/LFJtoEs4+3fPF4ogiHtRY4uGGi1GsBbrMTThjmut0SKPySAKeZQrEa/WB7omLHhc8xGp5cJ8AdSeg6si6jefM+a3+MEY0ZOTjMCX5Hu6UYhdfptiMlv7xgO6YC3UAH/HnecydxBVsjXcj6tdeBpA6lfNM7f//HwmTGA==
Received: from DS7PR03CA0054.namprd03.prod.outlook.com (2603:10b6:5:3b5::29)
 by MN2PR12MB3247.namprd12.prod.outlook.com (2603:10b6:208:ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Mon, 28 Jun
 2021 19:44:24 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::b6) by DS7PR03CA0054.outlook.office365.com
 (2603:10b6:5:3b5::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Mon, 28 Jun 2021 19:44:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linux-foundation.org; dkim=none (message not
 signed) header.d=none;linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4264.18 via Frontend Transport; Mon, 28 Jun 2021 19:44:24 +0000
Received: from [10.2.59.206] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 28 Jun
 2021 19:44:23 +0000
Subject: Re: [PATCH v4] mm: introduce reference pages
To:     Matthew Wilcox <willy@infradead.org>,
        Peter Collingbourne <pcc@google.com>
CC:     "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Jann Horn <jannh@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        <linux-mm@kvack.org>, kernel test robot <lkp@intel.com>,
        Linux API <linux-api@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
References: <20210619092002.1791322-1-pcc@google.com>
 <YNokDwjyysHGwTy/@casper.infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <6c03ae36-9a4b-6646-66c3-04d4a3de9c1e@nvidia.com>
Date:   Mon, 28 Jun 2021 12:44:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNokDwjyysHGwTy/@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3121aa59-4cc5-444a-78c2-08d93a6d21d7
X-MS-TrafficTypeDiagnostic: MN2PR12MB3247:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3247C602494B9AB3F20AE03AA8039@MN2PR12MB3247.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H4vpzpZtFLDQNzSI6z1EHUeZ+JLZaFGDXFVpajCMh/tzGd/1nZwQrK6MQ6ITefcbhW6FVfpCLeke0D6sPS0Q8hx4qgbWWubMcGmy1n8GSx4JxEmn2EdfPdWJtyUkLjHyPoPen2ASdSeA/yJbHr/TcNPb7e9HV/qchaV0IeS4bT4qt+QXYVnHB752xxgGoVYzjcTOQbSDVPFuT7SnuXc/V2KQgNh+i1OSy7oVDoKxx7yzplKUmm/v/DnDcXALBpXT3i1E3/pzdCo5NbNdZlLOe1QXqEdk5IZLS8M3sgK3qUC+/nNrWJ+DR870eZl4IFTD5aUqes+rzfXvu2kXI6jh4xs0TZzT2R7jQGvm6Zdi8xZcI7XOL5LwbGR0aH69u1q5q1h89ufb9U1dpxqouyhzSiCzUWuIeOrYHc3hq6b7y+J5iycTeGr6vXXVnwhEyQmEBuCzVkfAIn92xU3/uJ3BVnbnIP18JhriN+d2vqdyjBfF3ZXNEeeh2a5x45dq0fWV4fTBoR0pjorFpj9d1vrdyF/Zs+oZTb7/8R7xSCG7uaa3hmXmb+OFcNeTbpglaqWNKhJsdvuBKX9kbz2pfJk2H3awrc5E4bBCG6+WhRRDM8OsZVzN857AgbCKCkcWe74TtO1i7x9HSnV94jKnbgBLa2KTVdHQ+I579Z0lKRQB1bDl9TQzOaGtVLFFa0l6LKwoDVlUMOOfpbI4KieCzccrMBcKw8heJHljDfQkemwsh/g=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(46966006)(36840700001)(316002)(26005)(16576012)(336012)(7416002)(426003)(110136005)(356005)(16526019)(82740400003)(186003)(54906003)(4326008)(7636003)(2906002)(47076005)(478600001)(82310400003)(53546011)(31686004)(5660300002)(2616005)(36860700001)(70586007)(8676002)(31696002)(70206006)(8936002)(36756003)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 19:44:24.2032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3121aa59-4cc5-444a-78c2-08d93a6d21d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3247
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 6/28/21 12:33 PM, Matthew Wilcox wrote:
...
> 
> I wonder if single-byte captures enough of the useful possibilities.
> In the kernel we have memset32() and memset64() [1] so we could support
> a larger pattern than just an 8-bit byte.  It all depends what userspace
> would find useful.
> 
> [1] Along with memset_p(), memset_l() and memset16() that aren't terribly
> relevant to this use case.  Although maybe memset_l() would be the right
> one to use since there probably aren't too many 32-bit apps that want
> a 64-bit pattern and memset64() might not be the fastest on a 32-bit
> kernel).
> 

And in fact, I'm also rather intrigued by doing something like 256 copies
of a 16-byte UUID, per 4KB page. In other words, there are *definitely*
useful patterns that are longer than a single byte, and it seems interesting
to support them here.

Kirill's idea of an API that somehow allows various power of 2 patterns seems
like it would be nice, because then we don't have to pick a value that seems
good in 2021, but less good as time goes by, perhaps.

Another thought is to use an entire 4KB page as the smallest pattern unit.
That would allow the maximum API flexibility, because the caller could
explicitly set every single byte in the page.


thanks,
-- 
John Hubbard
NVIDIA
