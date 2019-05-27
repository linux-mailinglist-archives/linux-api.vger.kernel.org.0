Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3D52B770
	for <lists+linux-api@lfdr.de>; Mon, 27 May 2019 16:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfE0OV7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 May 2019 10:21:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:41250 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726115AbfE0OV7 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 27 May 2019 10:21:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 25D96AEF3;
        Mon, 27 May 2019 14:21:58 +0000 (UTC)
Date:   Mon, 27 May 2019 16:21:56 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Roman Gushchin <guro@fb.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH RFC] mm/madvise: implement MADV_STOCKPILE (kswapd from
 user space)
Message-ID: <20190527142156.GE1658@dhcp22.suse.cz>
References: <155895155861.2824.318013775811596173.stgit@buzz>
 <20190527141223.GD1658@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527141223.GD1658@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon 27-05-19 16:12:23, Michal Hocko wrote:
> [Cc linux-api. Please always cc this list when proposing a new user
>  visible api. Keeping the rest of the email intact for reference]
> 
> On Mon 27-05-19 13:05:58, Konstantin Khlebnikov wrote:
[...]
> > This implements manual kswapd-style memory reclaim initiated by userspace.
> > It reclaims both physical memory and cgroup pages. It works in context of
> > task who calls syscall madvise thus cpu time is accounted correctly.

I do not follow. Does this mean that the madvise always reclaims from
the memcg the process is member of?
-- 
Michal Hocko
SUSE Labs
