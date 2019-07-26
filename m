Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4BA772BC
	for <lists+linux-api@lfdr.de>; Fri, 26 Jul 2019 22:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfGZU0v (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Jul 2019 16:26:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41194 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbfGZU0v (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Jul 2019 16:26:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id m30so25033575pff.8
        for <linux-api@vger.kernel.org>; Fri, 26 Jul 2019 13:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IE5eJowpyCcGnZE2pKcSc9umsrWgUqBG7zCK+NjEKK4=;
        b=OSSRdZkSZXg6M+b9FWF3a1q+TiPSBp244enRgIGdVZjUu/SD8K8PRf3KqpHJ6cYWhk
         n3RevHiDEbDWb3xewyJUfr/5dEQwWqMIwnEbk87NSvS9caP8hIT7G5fh4UfLVUxKM38z
         JNXY9crOfbFD7ctsGRXt2fiHSx0KEPhd66l6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IE5eJowpyCcGnZE2pKcSc9umsrWgUqBG7zCK+NjEKK4=;
        b=A538QEK7xxmjdS6XlI8ye9oqNuyrTP0kXfkCM4iZVev3Np2AamyYvA4iT2lZu2zjzq
         3FXKeQPEYTKSgMc7VETHu+4yt/j3ge6Z91n3Kg17EcRb23I+q8iK9keR6joSGVpEPsqc
         hMMi4wNmxhaC5VLTDOiy8QQtWPHrNYzXGL5Y5vBEcStcFd5G3cRqubGuNYcZSGzs+7WO
         ZRZ95jMr9QQZlTuEK+lo+3JV2ZoB5iaMvHMBn8JZI73koB3osGQ1P4hnzcFcVVnDXCyx
         eDSNGnclfa3FAg9WDrt4V4chgagFRyAFPcLB69BuAh20GDonRW171igYOTR+5uJ2rL82
         o2sQ==
X-Gm-Message-State: APjAAAWYNo+/A0YE4sy6lQyL6RnSN+uFIz30GcSX/2h9PQjEY+46ZMBq
        2TU3aLMAVHxXhGvmhy9pqDs=
X-Google-Smtp-Source: APXvYqwxNJxyl8AMaL5MbjN3DCH0CGh1VKzKZSR7IsnpnOEC6DeGs6F8TvHMF+yBHu4tkJDhVOJeUA==
X-Received: by 2002:a17:90a:4f0e:: with SMTP id p14mr96514100pjh.40.1564172810042;
        Fri, 26 Jul 2019 13:26:50 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id f19sm77269906pfk.180.2019.07.26.13.26.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 13:26:49 -0700 (PDT)
Date:   Fri, 26 Jul 2019 16:26:47 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     sspatil@google.com
Cc:     linux-kernel@vger.kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, bgregg@netflix.com, chansen3@cisco.com,
        dancol@google.com, fmayer@google.com, joaodias@google.com,
        corbet@lwn.net, keescook@chromium.org, kernel-team@android.com,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        rppt@linux.ibm.com, minchan@kernel.org, namhyung@google.com,
        guro@fb.com, sfr@canb.auug.org.au, surenb@google.com,
        tkjos@google.com, vdavydov.dev@gmail.com, vbabka@suse.cz,
        wvw@google.com, sspatil+mutt@google.com
Subject: Re: [PATCH v3 2/2] doc: Update documentation for page_idle virtual
 address indexing
Message-ID: <20190726202647.GA213712@google.com>
References: <20190726152319.134152-1-joel@joelfernandes.org>
 <20190726152319.134152-2-joel@joelfernandes.org>
 <20190726201710.GA144547@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726201710.GA144547@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jul 26, 2019 at 01:17:10PM -0700, sspatil@google.com wrote:
> Thanks Joel, just a couple of nits for the doc inline below. Other than that,
> 
> Reviewed-by: Sandeep Patil <sspatil@google.com>

Thanks!

> I'll plan on making changes to Android to use this instead of the pagemap +
> page_idle. I think it will also be considerably faster.

Cool, glad to know.

> On Fri, Jul 26, 2019 at 11:23:19AM -0400, Joel Fernandes (Google) wrote:
> > This patch updates the documentation with the new page_idle tracking
> > feature which uses virtual address indexing.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  .../admin-guide/mm/idle_page_tracking.rst     | 43 ++++++++++++++++---
> >  1 file changed, 36 insertions(+), 7 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/mm/idle_page_tracking.rst b/Documentation/admin-guide/mm/idle_page_tracking.rst
> > index df9394fb39c2..1eeac78c94a7 100644
> > --- a/Documentation/admin-guide/mm/idle_page_tracking.rst
> > +++ b/Documentation/admin-guide/mm/idle_page_tracking.rst
> > @@ -19,10 +19,14 @@ It is enabled by CONFIG_IDLE_PAGE_TRACKING=y.
> >  
> >  User API
> >  ========
> > +There are 2 ways to access the idle page tracking API. One uses physical
> > +address indexing, another uses a simpler virtual address indexing scheme.
> >  
> > -The idle page tracking API is located at ``/sys/kernel/mm/page_idle``.
> > -Currently, it consists of the only read-write file,
> > -``/sys/kernel/mm/page_idle/bitmap``.
> > +Physical address indexing
> > +-------------------------
> > +The idle page tracking API for physical address indexing using page frame
> > +numbers (PFN) is located at ``/sys/kernel/mm/page_idle``.  Currently, it
> > +consists of the only read-write file, ``/sys/kernel/mm/page_idle/bitmap``.
> >  
> >  The file implements a bitmap where each bit corresponds to a memory page. The
> >  bitmap is represented by an array of 8-byte integers, and the page at PFN #i is
> > @@ -74,6 +78,31 @@ See :ref:`Documentation/admin-guide/mm/pagemap.rst <pagemap>` for more
> >  information about ``/proc/pid/pagemap``, ``/proc/kpageflags``, and
> >  ``/proc/kpagecgroup``.
> >  
> > +Virtual address indexing
> > +------------------------
> > +The idle page tracking API for virtual address indexing using virtual page
> > +frame numbers (VFN) is located at ``/proc/<pid>/page_idle``. It is a bitmap
> > +that follows the same semantics as ``/sys/kernel/mm/page_idle/bitmap``
> > +except that it uses virtual instead of physical frame numbers.
> > +
> > +This idle page tracking API does not need deal with PFN so it does not require
> 
> s/need//
> 
> > +prior lookups of ``pagemap`` in order to find if page is idle or not. This is
> 
> s/in order to find if page is idle or not//

Fixed both, thank you! Will send out update soon.

thanks,

 - Joel

