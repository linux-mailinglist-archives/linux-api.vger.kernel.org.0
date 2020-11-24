Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304842C2E22
	for <lists+linux-api@lfdr.de>; Tue, 24 Nov 2020 18:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390255AbgKXRMa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Nov 2020 12:12:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:60464 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389971AbgKXRMa (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 24 Nov 2020 12:12:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CA717AC90;
        Tue, 24 Nov 2020 17:12:29 +0000 (UTC)
Subject: Re: [PATCH] mm: introduce sysctl file to flush per-cpu vmstat
 statistics
To:     Christopher Lameter <cl@linux.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>
References: <20201117162805.GA274911@fuller.cnet>
 <20201117180356.GT29991@casper.infradead.org>
 <alpine.DEB.2.22.394.2011171855500.215602@www.lameter.com>
 <20201117202317.GA282679@fuller.cnet>
 <alpine.DEB.2.22.394.2011201817320.248402@www.lameter.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <72f598ea-9fdf-537d-0b3a-aac2251d347c@suse.cz>
Date:   Tue, 24 Nov 2020 18:12:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2011201817320.248402@www.lameter.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 11/20/20 7:20 PM, Christopher Lameter wrote:
> On Tue, 17 Nov 2020, Marcelo Tosatti wrote:
> 
>> > So what we would need would be something like a sysctl that puts the
>> > system into a quiet state by completing all workqueue items. Idle all
>> > subsystems that need it and put the cpu into NOHZ mode.
>>
>> Are you suggesting that instead of a specific file to control vmstat
>> workqueue only, a more generic sysctl could be used?
> 
> Yes. Introduce a sysctl to quiet down the system. Clean caches that will
> trigger kernel threads and whatever else is pending on that processor.

Please CC linux-api on future postings that introduce stuff like this.

>> About NOHZ mode: the CPU should enter NOHZ automatically as soon as
>> there is a single thread running, so unclear why that would be needed.
> 
> There are typically pending actions that still trigger interruptions.
> 
> If you would immediately quiet down the system if there is only one thread
> runnable then you would compromise system performance through frequent
> counter folding and cache cleaning etc.

If someone goes through the trouble of setting up NOHZ, these 
disruptions should be only temporary and happen during the setup, no?
