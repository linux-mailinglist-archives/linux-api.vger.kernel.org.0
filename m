Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 170AD8D375
	for <lists+linux-api@lfdr.de>; Wed, 14 Aug 2019 14:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfHNMtU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 14 Aug 2019 08:49:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:60860 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726263AbfHNMtU (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 14 Aug 2019 08:49:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EAC0FAEE9;
        Wed, 14 Aug 2019 12:49:18 +0000 (UTC)
Subject: Re: [RESEND PATCH 1/2 -mm] mm: account lazy free pages separately
To:     Yang Shi <yang.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     kirill.shutemov@linux.intel.com, hannes@cmpxchg.org,
        rientjes@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Linux API <linux-api@vger.kernel.org>
References: <1565308665-24747-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190809083216.GM18351@dhcp22.suse.cz>
 <1a3c4185-c7ab-8d6f-8191-77dce02025a7@linux.alibaba.com>
 <20190809180238.GS18351@dhcp22.suse.cz>
 <79c90f6b-fcac-02e1-015a-0eaa4eafdf7d@linux.alibaba.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <564a0860-94f1-6301-5527-5c2272931d8b@suse.cz>
Date:   Wed, 14 Aug 2019 14:49:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <79c90f6b-fcac-02e1-015a-0eaa4eafdf7d@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 8/9/19 8:26 PM, Yang Shi wrote:
> Here the new counter is introduced for patch 2/2 to account deferred 
> split THPs into available memory since NR_ANON_THPS may contain 
> non-deferred split THPs.
> 
> I could use an internal counter for deferred split THPs, but if it is 
> accounted by mod_node_page_state, why not just show it in /proc/meminfo? 

The answer to "Why not" is that it becomes part of userspace API (btw this
patchset should have CC'd linux-api@ - please do for further iterations) and
even if the implementation detail of deferred splitting might change in the
future, we'll basically have to keep the counter (even with 0 value) in
/proc/meminfo forever.

Also, quite recently we have added the following counter:

KReclaimable: Kernel allocations that the kernel will attempt to reclaim
              under memory pressure. Includes SReclaimable (below), and other
              direct allocations with a shrinker.

Although THP allocations are not exactly "kernel allocations", once they are
unmapped, they are in fact kernel-only, so IMHO it wouldn't be a big stretch to
add the lazy THP pages there?

> Or we fix NR_ANON_THPS and show deferred split THPs in /proc/meminfo?
> 
>>
> 

