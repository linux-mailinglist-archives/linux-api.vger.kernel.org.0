Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 845D54AB01
	for <lists+linux-api@lfdr.de>; Tue, 18 Jun 2019 21:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbfFRT12 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 18 Jun 2019 15:27:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49344 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727553AbfFRT11 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 18 Jun 2019 15:27:27 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6938458E42;
        Tue, 18 Jun 2019 19:27:27 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D4CA19C5B;
        Tue, 18 Jun 2019 19:27:25 +0000 (UTC)
Subject: Re: [PATCH] mm, memcg: Report number of memcg caches in slabinfo
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-api@vger.kernel.org
References: <20190617142149.5245-1-longman@redhat.com>
 <20190617143842.GC1492@dhcp22.suse.cz>
 <9e165eae-e354-04c4-6362-0f80fe819469@redhat.com>
 <20190618123750.GG3318@dhcp22.suse.cz>
 <dee4dee2-1f4f-a7c9-0014-dca54b991377@redhat.com>
 <20190618183208.GK3318@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <681ed4dc-e8a5-afcf-98b6-c17544c6094d@redhat.com>
Date:   Tue, 18 Jun 2019 15:27:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190618183208.GK3318@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 18 Jun 2019 19:27:27 +0000 (UTC)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 6/18/19 2:32 PM, Michal Hocko wrote:
> On Tue 18-06-19 12:59:24, Waiman Long wrote:
>> On 6/18/19 8:37 AM, Michal Hocko wrote:
> [...]
>>> Is this useful enough to put into slabinfo? Doesn't this sound more like
>>> a debugfs kinda a thing?
>> I guess it is probably more on the debug side of things. I add it to
>> slabinfo as the data is readily available. It will be much more work if
>> we need to export the data via debugfs.
>>
>> We are seeing the kmem_cache slab growing continuously overtime when
>> running a container-based workloads. Roman's kmem_cache reparenting
>> patch will hopefully solve a major part of the problem, but we still
>> need a way to confirm that by looking at how many memcg kmem_caches are
>> associated with each root kmem_cache.
> I am not disputing usefulness. Dead memcgs are showing up as a problem
> for a longer time and having a more debugging information is definitely
> useful. I am just not really sure that /proc/slabinfo is the proper
> vehicle for that information. It might be just easier to stick it there
> but that is not the best justification for adding something we will have
> to maintain for ever. Not to mention that the number of dead memcgs
> might not be enough to debug further when we can easily end up needing
> to provide more in something less "carved in stone" kinda interface like
> debugfs.
>
Fair enough.

I will rework the patch and expose the information via debugfs then.

Cheers,
Longman

