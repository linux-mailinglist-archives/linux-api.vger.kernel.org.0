Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6919B3B7762
	for <lists+linux-api@lfdr.de>; Tue, 29 Jun 2021 19:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbhF2Ruv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 29 Jun 2021 13:50:51 -0400
Received: from mail-dm6nam10on2057.outbound.protection.outlook.com ([40.107.93.57]:57761
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232066AbhF2Ruu (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 29 Jun 2021 13:50:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGfCcIhYBMKpPRKa+z2yfuPycWyKywgZywZG8Sv0PLlDllh47b9Vh7PcEpIpcXxcqwMrm5/KVXBUK7vYrl15a6U6b0f1dR2FlMmJQ7prPDZ//UlWIopLCm2uHtacjz8bHOFWXDtep68qcf5x6L64Aa0ecqfcH4t3NdSGl8m5rkOQ8MnNCAZijCcoQnbPAxTWIppP8+eEIGN/lQxfLSZU/7Imyv4IB7dDpDZ/+1jYUfM2rDH2pLrj83XGW2HeNJcI9PYXW0djn4+kVhQdihDJxYpLOGZbSIjNHVPLoT1xgssa2z3mmwNd5cvmqsNV5+e/1UVcyBqCKO86MdqvxTeazQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMGxidUH8SMjBvtPbO3bNWf6sZDTW5guXBPGzMrs3Kc=;
 b=HSWrcsI7rsgi84W7DtLlo2w4i+3YqwtebiN5sAMuXo9HeY9EyRLHqaZ2MFrAYg4wcQHrkz5JZenHktllT9tO2oyQ//IeuXObSyx5d7bqod1MiAe+kCuJ0sYwR7nVOy3TFeaZvyetW8ylU4V00NwI1pisaZyVArfNZc/oSyIYqIFumg6hXS9lLQcGsHtXMNhD3YZn/Iy5VO9xDoUpahPstn8sec+fax405yj4ynDZiXj0h6hx+d1NYDKoIpX9kwG+HzWYxozn4J4oxWBjr8ZwoZyqpuDF6ckj+xeH2mSSWF+wI3dpozOr/nG5IkVLbkvHis3AIeinXYc/cqPg159CQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMGxidUH8SMjBvtPbO3bNWf6sZDTW5guXBPGzMrs3Kc=;
 b=kOr+IuiTwyKHFLbALLOC7mC2UyRtDATekHrOp9DVlCBOWKzRWpaymNsSVsIoUElz/bVB6ngRlLANHd0DPCIDgfu+SDiM0wOJ7G3jTf6wo0nc0mTNA/zVoGxei1nNjyYgLEHCnGUHLWKLPDlrS9NRDUZghdvQsXR3DJi2YNGigt3/JAdDgLcPpIkhOWj7m/5dSnk3Wj8B1lcsBpiMbAyrij2UXMTjpcSeYPe3fFl1ahfQtXkN8ADfEtAk2jBFndRjnF/iRWsy482JnWFY+B4sAD71LlF4iFm+KDj1FL+RsAhSQ9SsvMgT9NmsQxlwwPUuPiLO4JH5ba2Xi6DPjfc0Ew==
Received: from DS7PR03CA0231.namprd03.prod.outlook.com (2603:10b6:5:3ba::26)
 by DM6PR12MB3161.namprd12.prod.outlook.com (2603:10b6:5:182::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Tue, 29 Jun
 2021 17:48:22 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::69) by DS7PR03CA0231.outlook.office365.com
 (2603:10b6:5:3ba::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21 via Frontend
 Transport; Tue, 29 Jun 2021 17:48:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linux-foundation.org; dkim=none (message not
 signed) header.d=none;linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 17:48:21 +0000
Received: from [10.2.59.206] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 29 Jun
 2021 17:48:20 +0000
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
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <3c77290d-3a79-9f41-f4ba-7eda399df150@nvidia.com>
Date:   Tue, 29 Jun 2021 10:48:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNsK8bZ+S3VtsK9g@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7884061-a1fe-459f-67a3-08d93b261630
X-MS-TrafficTypeDiagnostic: DM6PR12MB3161:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3161912BDFF0573BE392FEF3A8029@DM6PR12MB3161.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SRytymIk9uSMGCJ/1pIGDqbz7Y27Vn2A63seIYQe4r60x7jWf6PVajDKLYD8JLigEY0zlruQKBU/FxIawbCY9SY2VVZkYMECcZS3H7uG7DKaU9WM3iB+QCLNDO8pXcEfd4Lqfqwi0LAHfai/MrePU+kzfExu3+ubVbYFydwhtGjsPk3V8QiI13ykFovXZTA6rDQa6W+2VIFavL+yH04l/1oXUQSIIGOipvjMeT9uGJy7RfuQBZQ6FF0lxSly2zsaLRvhVsK1SQOA43kEk+sl9sC4cJiNFLf9wLVZVhib2gML0NFgqVIK/UGdnlLRztIgDe3Guv85hAhg6Az4Ubb4A5x68ySTiBEm7jdRIJqrLaWKfEISHEJgFvKnCj1iNCWhic/hDj5YRX941/mysYR5dHR05zVFCPsW+MM8dlTBiZfvE1l3RD7GN45YKo+5BNyhZYfuGIWj1WViXUxd7zHr4UaBXlNwLrb18rdKVYiJ2VEBL7BRGGvlepubpY2t7XWM7H4XmhPsFqyuHA2v7rNG6A/tZB+xQfmIGH+oiyJnwu1TWxiKNNE4hRWcszIEsDoczaK+QsRJwBqI0hYvGVhbcDR9HdwxcmWSGXsAJcq2Bf8otr+8ZReFkgAO4HODeXO64Jufd4E/Oswrj2TchNr5WlIQuC3sdjijMkWH+L8NHEx4pWdNOsC5Q4732BaUgMs89iLlF70KrmWrryHrzUfZVnLJVFb6uuT4UVFGaW4zIpM=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(46966006)(36840700001)(336012)(16576012)(316002)(7416002)(26005)(356005)(426003)(16526019)(82740400003)(186003)(4326008)(83380400001)(54906003)(7636003)(47076005)(478600001)(53546011)(82310400003)(31686004)(5660300002)(2906002)(2616005)(70586007)(86362001)(8936002)(36756003)(36860700001)(31696002)(70206006)(6916009)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 17:48:21.5233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7884061-a1fe-459f-67a3-08d93b261630
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3161
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 6/29/21 4:58 AM, Matthew Wilcox wrote:
> On Tue, Jun 29, 2021 at 12:19:22AM -0700, John Hubbard wrote:
>>> +SYSCALL_DEFINE2(refpage_create, const void *__user, content, unsigned long,
>>> +		flags)
>>
>>  From the API discussion (and using a simpler syntax to illustrate this), it
>> seems like the following would be close:
>>
>> enum content_type {
>> 	BYTE_PATTERN,
>> 	FOUR_BYTE_PATTERN,
>> 	...
>> 	FULL_4KB_PAGE
>> };
>>
>> int refpage_create(const void *__user content, enum content_type, unsigned long flags);
>>
>> ...and if content_type == BYTE_PATTERN, then content is a pointer to just one byte of
>> data, and so forth for the other enum values.
> 
> That seems a little more complicated and non-extensible.

This is true. I wasn't sure I liked it all that much, either, when I wrote
it. haha.

> 
> int refpage_create(const void *__user content, unsigned int size,
> 		unsigned long flags);
> 

That does seem better. The key is to have at least one more parameter.

Actually I forgot to include pattern data. In both of the approaches above,
flags is probably used for that, but if we already know that patterns
are being passed, then how about add a "pattern" arg? I think it's
good to leave a little room for flexibility and future extensions:

int refpage_create(const void *__user content, unsigned int size,
		unsigned long pattern, unsigned long flags);


thanks,
-- 
John Hubbard
NVIDIA
