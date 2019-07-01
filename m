Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4D95B8E9
	for <lists+linux-api@lfdr.de>; Mon,  1 Jul 2019 12:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfGAKW7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 1 Jul 2019 06:22:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:36526 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726076AbfGAKW7 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 1 Jul 2019 06:22:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7BEA0AEE6;
        Mon,  1 Jul 2019 10:22:57 +0000 (UTC)
Date:   Mon, 1 Jul 2019 12:22:56 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>, oleksandr@redhat.com,
        hdanton@sina.com, lizeb@google.com,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v3 0/5] Introduce MADV_COLD and MADV_PAGEOUT
Message-ID: <20190701102256.GN6376@dhcp22.suse.cz>
References: <20190627115405.255259-1-minchan@kernel.org>
 <20190701073848.GB136163@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701073848.GB136163@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon 01-07-19 16:38:48, Minchan Kim wrote:
> 
> Hi Folks,
> 
> Do you guys have comments? I think it would be long enough to be
> pending. If there is no further comments, I want to ask to merge.

This is definitely on my todo list for this week. But please be patient.
It's been _one_ work day since you posted this last version so I do not
think this is stalling for too long. Sure the current version is
probably not too much different from the previous but I didn't get to
review it in the depth yet. All the code duplication doesn't make it
much easier but I understand your reasoning that sharing more code is
not really straightforward.
-- 
Michal Hocko
SUSE Labs
