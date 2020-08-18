Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0929248DED
	for <lists+linux-api@lfdr.de>; Tue, 18 Aug 2020 20:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgHRSZs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 18 Aug 2020 14:25:48 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:9235 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbgHRSZr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 18 Aug 2020 14:25:47 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f3c1cba0001>; Tue, 18 Aug 2020 11:23:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Aug 2020 11:25:47 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Aug 2020 11:25:47 -0700
Received: from [10.2.49.218] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Aug
 2020 18:25:41 +0000
Subject: Re: [PATCH v3] mm: introduce reference pages
To:     Matthew Wilcox <willy@infradead.org>
CC:     Peter Collingbourne <pcc@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        <linux-mm@kvack.org>, kernel test robot <lkp@intel.com>,
        Linux API <linux-api@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
References: <20200814213310.42170-1-pcc@google.com>
 <c2f7efa7-0b52-b92f-79bc-a0cc26b0d92c@nvidia.com>
 <20200818030021.GM17456@casper.infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <2ce2125f-5424-63d5-16a2-a4e1da76053e@nvidia.com>
Date:   Tue, 18 Aug 2020 11:25:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200818030021.GM17456@casper.infradead.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1597775035; bh=jd+8W6y4hx20CWRRPjc9DIa9OXmFSc2Rf98XZmP8xww=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=XPxZFquO6BA6KLKmkHcIXEzKU+w0/Z7CJ2gDt4x9bphHOp0pwo5wp/7UhFNawwH/M
         2CSyfcoU5dXekP7VsUXq2QJZKo4ZanGXOHJZbnK+227dIbVQ/ovTWGLq6deB1aQTSy
         qpkYeH/D5GaYNbMKh78UtGu8oIz04jXfPNhG9aU0gKZbjyruzLN1/t0YilbMEpGvnb
         i687cd/itAIwFaJJ9sSJIiOX8AnynXiVcBDokebWBQe4xykp/ntpZ/ahrhwIdsNh9E
         GgZMamtCgCQ0bR/nhzOhAEtckrAkBSIDv4ptpsAEsCCCURchgRx/RoyA88KJbvwdoU
         1N7jTgGcb9QNQ==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 8/17/20 8:00 PM, Matthew Wilcox wrote:
> On Mon, Aug 17, 2020 at 07:31:39PM -0700, John Hubbard wrote:
>>>             Real time (s)    Max RSS (KiB)
>>> anon        2.237081         107088
>>> memset      2.252241         112180
>>> refpage     2.243786         107128
>>>
>>> We can see that RSS for refpage is almost the same as anon, and real
>>> time overhead is 44% that of memset.
>>>
>>
>> Are some of the numbers stale, maybe? Try as I might, I cannot combine
>> anything above to come up with 44%. :)
> 
> You're not trying hard enough ;-)
> 
> (2.252241 - 2.237081) / 2.237081 = .00677668801442594166
> (2.243786 - 2.237081) / 2.237081 = .00299720930981041812
> .00299720930981041812 / .00677668801442594166 = .44228232189973614648
> 
> tadaa!

haha, OK then! :) Next time I may try harder, but on the other hand my
interpretation of the results is still "this is a small effect", even
if there is a way to make it sound large by comparing the 3rd significant
digits of the results...

> 
> As I said last time this was posted, I'm just not excited by this.  We go
> from having a 0.68% time overhead down to an 0.30% overhead, which just
> doesn't move the needle for me.  Maybe there's a better benchmark than
> this to show benefits from this patchset.
> 

Yes, I wonder if there is an artificial workload that just uses refpages
really extensively, maybe we can get some good solid improvements shown
with that? Otherwise, it seems like we've just learned that memset is
actually pretty good in this case. :)

thanks,
-- 
John Hubbard
NVIDIA
