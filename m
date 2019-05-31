Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A91C3086F
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2019 08:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfEaGWI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 31 May 2019 02:22:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:58348 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725955AbfEaGWI (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 31 May 2019 02:22:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 93B68AF60;
        Fri, 31 May 2019 06:22:07 +0000 (UTC)
Date:   Fri, 31 May 2019 08:22:06 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     semenzato@chromium.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        sonnyrao@chromium.org, Yu Zhao <yuzhao@chromium.org>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v2 1/1] mm: smaps: split PSS into components
Message-ID: <20190531062206.GD6896@dhcp22.suse.cz>
References: <20190531002633.128370-1-semenzato@chromium.org>
 <20190531060401.GA7386@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531060401.GA7386@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri 31-05-19 08:04:01, Michal Hocko wrote:
> [Please always Cc linux-api mailing list (now added) when adding a new
> user visible API. Keeping the rest of the email intact for reference]
> 
> On Thu 30-05-19 17:26:33, semenzato@chromium.org wrote:
> > From: Luigi Semenzato <semenzato@chromium.org>
> > 
> > Report separate components (anon, file, and shmem)
> > for PSS in smaps_rollup.
> > 
> > This helps understand and tune the memory manager behavior
> > in consumer devices, particularly mobile devices.  Many of
> > them (e.g. chromebooks and Android-based devices) use zram
> > for anon memory, and perform disk reads for discarded file
> > pages.  The difference in latency is large (e.g. reading
> > a single page from SSD is 30 times slower than decompressing
> > a zram page on one popular device), thus it is useful to know
> > how much of the PSS is anon vs. file.

Could you describe how exactly are those new counters going to be used?

I do not expect this to add a visible penalty to users who are not going
to use the counter but have you tried to measure that?

-- 
Michal Hocko
SUSE Labs
