Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89A521BB35
	for <lists+linux-api@lfdr.de>; Fri, 10 Jul 2020 18:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgGJQkt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 10 Jul 2020 12:40:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42058 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728299AbgGJQkr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 Jul 2020 12:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594399245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=16iHsWi68rugM50PMlWHTfZ82HbbVxq1zQ7HFx1abr0=;
        b=PUfVp2sZV+BuLe+xvyJMy87O/gO8RvjpplRAgVItlRIXZbuJ6Ng/VrPgjAJssS/0g+u2e0
        g/N87oNhdX3efpshaMEHQ6QW160ZSJlkUE2sdAHxw6LJ3+9/BF3q0iUdgLO1jDGOaN2wO0
        Wa/XZa7VMtSHejIZCnvx68PhQ8LGeqQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-ZEPGKszDNvimJnurQS_0wg-1; Fri, 10 Jul 2020 12:40:41 -0400
X-MC-Unique: ZEPGKszDNvimJnurQS_0wg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F7DD800685;
        Fri, 10 Jul 2020 16:40:38 +0000 (UTC)
Received: from mail (ovpn-112-112.rdu2.redhat.com [10.10.112.112])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B6B6D7EF89;
        Fri, 10 Jul 2020 16:40:37 +0000 (UTC)
Date:   Fri, 10 Jul 2020 12:40:37 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Idan Yaniv <idan.yaniv@ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [RFC PATCH v2 1/5] mm: make HPAGE_PxD_{SHIFT,MASK,SIZE} always
 available
Message-ID: <20200710164037.GA11749@redhat.com>
References: <20200706172051.19465-1-rppt@kernel.org>
 <20200706172051.19465-2-rppt@kernel.org>
 <alpine.LSU.2.11.2007062153000.2793@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2007062153000.2793@eggly.anvils>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Hugh and Mike,

On Mon, Jul 06, 2020 at 10:07:34PM -0700, Hugh Dickins wrote:
> Adding Andrea to Cc, he's the one who structured it that way,
> and should be consulted.
>
> I'm ambivalent myself.  Many's the time I've been irritated by the
> BUILD_BUG() in HPAGE_etc, and it's responsible for very many #ifdef
> CONFIG_TRANSPARENT_HUGEPAGEs or IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)s
> that you find uglily scattered around the source.
> 
> But that's the point of it: it's warning when you write code peculiar
> to THP, that is going to bloat the build of kernels without any THP.
> 
> So although I've often been tempted to do as you suggest, I've always
> ended up respecting Andrea's intention, and worked around it instead
> (sometimes with #ifdef or IS_ENABLED(), sometimes with
> PMD_{SHIFT,MASK_SIZE}, sometimes with a local definition).

The only other reasons that comes to mind in addition of optimizing
the bloat away at build time is to make it easier to identify the THP
code and to make it explicit that hugetlbfs shouldn't us it or it
could be wrong on some arches.

However for this case the BUILD_BUG() looks right and this doesn't
look like a false positive.

This patchset has nothing to do THP, so it'd be more correct to use
MAX_ORDER whenever the fragmentation is about the buddy (doesn't look
the case here) or PUD_SIZE/ORDER/PMD_SIZE/ORDER if the objective is
not to unnecessarily split extra and unrelated hugepud/hugepmds in the
direct mapping (as in this case).

The real issue exposed by the BUILD_BUG is the lack of PMD_ORDER
definition and fs/dax.c already run into and it solved it locally in the
dax.c file:

/* The order of a PMD entry */
#define PMD_ORDER	(PMD_SHIFT - PAGE_SHIFT)

The fact it's not just this patch but also dax.c that run into the
same issue, makes me think PMD_ORDER should be defined and then you
can use PMD_* and PUD_* for this non-THP purpose.

Then the question if to remove the BUILD_BUG becomes orthogonal to
this patchset, but I don't see much value in retaining HPAGE_PMD/PUD_*
unless the BUILD_BUG is retained too, because this patchset already
hints that without the BUILD_BUG() the HPAGE_PMD_* definitions would
likely spill into non THP paths and they would lose also the only
value left (the ability to localize the THP code paths). So I wouldn't
be against removing the BUILD_BUG if it's causing maintenance
overhead, but then I would drop HPAGE_PMD_* too along with it or it
may just cause confusion.

Thanks,
Andrea

