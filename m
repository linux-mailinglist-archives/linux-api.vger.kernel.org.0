Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E9B2D4021
	for <lists+linux-api@lfdr.de>; Wed,  9 Dec 2020 11:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbgLIKjJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 9 Dec 2020 05:39:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:58508 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729861AbgLIKjF (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 9 Dec 2020 05:39:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 77035ACC3;
        Wed,  9 Dec 2020 10:38:23 +0000 (UTC)
Date:   Wed, 9 Dec 2020 11:38:21 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     akpm@linux-foundation.org, n-horiguchi@ah.jp.nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] mm,hwpoison: Return -EBUSY when migration fails
Message-ID: <20201209103821.GE30892@linux>
References: <20201209092818.30417-1-osalvador@suse.de>
 <ae1f9209-f4f7-fae5-1d8f-5e7e5d2d55aa@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae1f9209-f4f7-fae5-1d8f-5e7e5d2d55aa@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Dec 09, 2020 at 11:25:31AM +0100, Vlastimil Babka wrote:
> On 12/9/20 10:28 AM, Oscar Salvador wrote:
> > Currently, we return -EIO when we fail to migrate the page.
> > 
> > Migrations' failures are rather transient as they can happen due to
> > several reasons, e.g: high page refcount bump, mapping->migrate_page
> > failing etc.
> > All meaning that at that time the page could not be migrated, but
> > that has nothing to do with an EIO error.
> > 
> > Let us return -EBUSY instead, as we do in case we failed to isolate
> > the page.
> > 
> > While are it, let us remove the "ret" print as its value does not change.
> > 
> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Technically this affects madvise(2) so let's cc linux-api. The manpage doesn't
> document error codes of MADV_HWPOISON and MADV_SOFT_OFFLINE (besides EPERM)
> though so nothing to adjust there. It's meant only for the hwpoison testing
> suite anyway.

Well, not only for hwpoison testing suite.

RAS/CEC and GHES also use soft_offline_page by means of memory_failure_queue
in case a page cec count goes beyond a certain thereshold, but they do not
really check the return code.

Only madvise does.


-- 
Oscar Salvador
SUSE L3
