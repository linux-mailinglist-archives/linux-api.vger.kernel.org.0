Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAC58308C
	for <lists+linux-api@lfdr.de>; Tue,  6 Aug 2019 13:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732890AbfHFLTZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 6 Aug 2019 07:19:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42425 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732881AbfHFLTY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 6 Aug 2019 07:19:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id t132so41424919pgb.9
        for <linux-api@vger.kernel.org>; Tue, 06 Aug 2019 04:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jNBh4Uwy6QLd0fk5I8Y9B9xP/9fw2xkjlyVlCT+yndM=;
        b=hT7m/kPEBbfuocAKw5Xl9iF6rszGIOiOU1pdk9Yl9uQaoSvBKVDI9XOMkrfdb7LwCJ
         TwHeWzeGX8FvyMCo3V+QlzvodG0odf5bOEzj1zCP1QE3OBESAFt9TvXGZ4VZEvsAcJtG
         tqZe0a8M+Hv2lAOkMv1yerWslMxtF2wkEcWqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jNBh4Uwy6QLd0fk5I8Y9B9xP/9fw2xkjlyVlCT+yndM=;
        b=jbnLbim1wQVJFwRegqq4x506AjOKygnaZ4lnos2BOvqSBVA8TJXg5frT+x9F4wmXB5
         CrIBLkKWjnMSo58bJEPycLqWV4M5jdZZs0Wqq3uIK4zVE9DAej+S3JO/XCucu+RZAA6C
         nRhJhy8Ng7/ikPYlUFFY/3UGM5EKqBdiTItyAVdsVhcE1f2zLhKUG+qqYQGvq+2i5yae
         9blPzCAQtbiQaP4i5DDghj3Kmt3EZcXAiu6CDcMN1j4zI2d/Qsno0nivBNM3tSZy/Ch/
         W3Sfe9Vkk2mXApCLNO8jOcv/g5pQwGHMjBLKlIfqwu5AqiuuOQ5o4IbKu3jYAL5QRyBx
         L+/w==
X-Gm-Message-State: APjAAAUQqXYJgrNG05Y/sjBb4vG8yObEdLeCbELYp+z4AGoEPMA7Mm+u
        c8XvKwvQiF9JV5W4LCH7ypP8lg==
X-Google-Smtp-Source: APXvYqywqnwTAaGR6Bs8KS7aVh05Rc6pWzLeu7k4oiw+pFIGujdN2uTYttGBWidHSRA8eyinnS/N7A==
X-Received: by 2002:a17:90a:c20e:: with SMTP id e14mr2839075pjt.0.1565090363666;
        Tue, 06 Aug 2019 04:19:23 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id w16sm109123479pfj.85.2019.08.06.04.19.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 04:19:22 -0700 (PDT)
Date:   Tue, 6 Aug 2019 07:19:21 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brendan Gregg <bgregg@netflix.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Hansen <chansen3@cisco.com>, dancol@google.com,
        fmayer@google.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.ibm.com>, minchan@kernel.org,
        namhyung@google.com, paulmck@linux.ibm.com,
        Robin Murphy <robin.murphy@arm.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, tkjos@google.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 4/5] page_idle: Drain all LRU pagevec before idle
 tracking
Message-ID: <20190806111921.GB117316@google.com>
References: <20190805170451.26009-1-joel@joelfernandes.org>
 <20190805170451.26009-4-joel@joelfernandes.org>
 <20190806084357.GK11812@dhcp22.suse.cz>
 <20190806104554.GB218260@google.com>
 <20190806105149.GT11812@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806105149.GT11812@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Aug 06, 2019 at 12:51:49PM +0200, Michal Hocko wrote:
> On Tue 06-08-19 06:45:54, Joel Fernandes wrote:
> > On Tue, Aug 06, 2019 at 10:43:57AM +0200, Michal Hocko wrote:
> > > On Mon 05-08-19 13:04:50, Joel Fernandes (Google) wrote:
> > > > During idle tracking, we see that sometimes faulted anon pages are in
> > > > pagevec but are not drained to LRU. Idle tracking considers pages only
> > > > on LRU. Drain all CPU's LRU before starting idle tracking.
> > > 
> > > Please expand on why does this matter enough to introduce a potentially
> > > expensinve draining which has to schedule a work on each CPU and wait
> > > for them to finish.
> > 
> > Sure, I can expand. I am able to find multiple issues involving this. One
> > issue looks like idle tracking is completely broken. It shows up in my
> > testing as if a page that is marked as idle is always "accessed" -- because
> > it was never marked as idle (due to not draining of pagevec).
> > 
> > The other issue shows up as a failure in my "swap test", with the following
> > sequence:
> > 1. Allocate some pages
> > 2. Write to them
> > 3. Mark them as idle                                    <--- fails
> > 4. Introduce some memory pressure to induce swapping.
> > 5. Check the swap bit I introduced in this series.      <--- fails to set idle
> >                                                              bit in swap PTE.
> > 
> > Draining the pagevec in advance fixes both of these issues.
> 
> This belongs to the changelog.

Sure, will add.


> > This operation even if expensive is only done once during the access of the
> > page_idle file. Did you have a better fix in mind?
> 
> Can we set the idle bit also for non-lru pages as long as they are
> reachable via pte?

Not at the moment with the current page idle tracking code. PageLRU(page)
flag is checked in page_idle_get_page().

Even if we could set it for non-LRU, the idle bit (page flag) would not be
cleared if page is not on LRU because page-reclaim code (page_referenced() I
believe) would not clear it. This whole mechanism depends on page-reclaim. Or
did I miss your point?


thanks,

 - Joel

