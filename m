Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24DC7183083
	for <lists+linux-api@lfdr.de>; Thu, 12 Mar 2020 13:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgCLMkb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 12 Mar 2020 08:40:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:38502 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgCLMkb (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 12 Mar 2020 08:40:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A46F4B1DE;
        Thu, 12 Mar 2020 12:40:28 +0000 (UTC)
Subject: Re: [PATCH v7 2/7] mm: introduce external memory hinting API
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com, sj38.park@gmail.com
References: <20200302193630.68771-1-minchan@kernel.org>
 <20200302193630.68771-3-minchan@kernel.org>
 <bc3f6bd5-f032-bcf5-a09f-556ab785c587@suse.cz>
 <20200310222008.GB72963@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <07109fb3-dcf3-0252-4515-7e476fadc259@suse.cz>
Date:   Thu, 12 Mar 2020 13:40:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310222008.GB72963@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3/10/20 11:20 PM, Minchan Kim wrote:
> On Thu, Mar 05, 2020 at 07:15:10PM +0100, Vlastimil Babka wrote:
>> On 3/2/20 8:36 PM, Minchan Kim wrote:
>> > There is usecase that System Management Software(SMS) want to give
>> > a memory hint like MADV_[COLD|PAGEEOUT] to other processes and
>> > in the case of Android, it is the ActivityManagerService.
>> > 
>> > It's similar in spirit to madvise(MADV_WONTNEED), but the information
>> 
>> You mean MADV_DONTNEED?
> 
> Mean to DONT_NEED's future version.

What's that exactly?

>> 
>> > required to make the reclaim decision is not known to the app.
>> 
>> This seems to be mixing up the differences between MADV_DONTNEED and
>> COLD/PAGEOUT and self-imposed vs external memory hints?
> 
> Sorry, I don't understand what you want here.

You say that process_madvise(MADV_[COLD|PAGEEOUT]) is similar to
madvise(MADV_WONTNEED) but the difference is that the information
required to make the reclaim decision is not known to the app.

I see two differences. One is madvise vs process_madvise, which is explained by
"reclaim decision is not known to the app."
The other is MADV_WONTNEED vs MADV_[COLD|PAGEEOUT], which is... I'm not sure
until you say what's "DONT_NEED's future version" :D

Anyway I assume this part is from the versions where the new COLD and PAGEOUT
flags were introduced together with external memory hinting API?
