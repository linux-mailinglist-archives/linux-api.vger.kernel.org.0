Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB5911E845
	for <lists+linux-api@lfdr.de>; Wed, 15 May 2019 08:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfEOG0n (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 May 2019 02:26:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34696 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfEOG0m (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 May 2019 02:26:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id f8so1248932wrt.1
        for <linux-api@vger.kernel.org>; Tue, 14 May 2019 23:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=r4oR53z2LH/girWhdadET5NwW+9qTEXME3Zh2uwLVAY=;
        b=miy2NmpCp8lgA+KPkHngu2XM/6lGKDrytI+kAXtNTQcr7Ej+udZfqYi9mU9adL1Qnl
         mYFaVIcpMjJjiTDNtRnwpNkSIShjgz86vpAUNxCVfsvoJewE9FufPv27H8Y94FP/pPrm
         fuuCFKMkhHnI2kdjav4VA5Kzm+FujzW1wXGUTmYvSYltBBsPCFx888ORrAGNy0eJbChM
         NsoBuX2jskOWWyNHz6ArRmzOx3YDHDH36XHhuhsgUI+H6na3ciYRRwp6VdA/BysCSpKT
         kpATZFlcOONHHXGXBISdazT961DNuvegKmU2LiPunPxDQhXwq3XRitc7BUYrkK9URxjs
         OSZA==
X-Gm-Message-State: APjAAAWw/J+3DACfAMFxoD0HtqLh8AAqXuamjXuWRr+blFyqNp0HDO7A
        Cd9pGzekquDqP/jgE7LKpJeR1g==
X-Google-Smtp-Source: APXvYqwzRUd6h96LZgyFbTY+qpvrY3nI1N7OivjjSgq9A995vDhb95FwUCzP1jKfNcPST/ps3r/5IA==
X-Received: by 2002:a5d:6750:: with SMTP id l16mr17082656wrw.274.1557901600948;
        Tue, 14 May 2019 23:26:40 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t7sm981391wrq.76.2019.05.14.23.26.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 23:26:40 -0700 (PDT)
Date:   Wed, 15 May 2019 08:26:39 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Timofey Titovets <nefelim4ag@gmail.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, linux-mm@kvack.org,
        linux-api@vger.kernel.org, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH RFC v2 4/4] mm/ksm: add force merging/unmerging
 documentation
Message-ID: <20190515062639.qpqdkbrmujhnxfg7@butterfly.localdomain>
References: <20190514131654.25463-1-oleksandr@redhat.com>
 <20190514131654.25463-5-oleksandr@redhat.com>
 <CAGqmi77gESF0h8ZduHm8TTPKRqQLGFdCP15TAW5skDwZnL85YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGqmi77gESF0h8ZduHm8TTPKRqQLGFdCP15TAW5skDwZnL85YA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi.

On Wed, May 15, 2019 at 03:53:55AM +0300, Timofey Titovets wrote:
> LGTM for whole series
> 
> Reviewed-by: Timofey Titovets <nefelim4ag@gmail.com>
> 
> вт, 14 мая 2019 г. в 16:17, Oleksandr Natalenko <oleksandr@redhat.com>:
> >
> > Document respective sysfs knob.
> >
> > Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
> > ---
> >  Documentation/admin-guide/mm/ksm.rst | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
> > index 9303786632d1..4302b92910ec 100644
> > --- a/Documentation/admin-guide/mm/ksm.rst
> > +++ b/Documentation/admin-guide/mm/ksm.rst
> > @@ -78,6 +78,17 @@ KSM daemon sysfs interface
> >  The KSM daemon is controlled by sysfs files in ``/sys/kernel/mm/ksm/``,
> >  readable by all but writable only by root:
> >
> > +force_madvise
> > +        write-only control to force merging/unmerging for specific
> > +        task.
> > +
> > +        To mark the VMAs as mergeable, use:
> > +        ``echo PID > /sys/kernel/mm/ksm/force_madvise``
> > +
> > +        To unmerge all the VMAs, use:
> > +        ``echo -PID > /sys/kernel/mm/ksm/force_madvise``
> > +        (note the prepending "minus")
> > +
> In patch 3/4 you have special case with PID 0,
> may be that also must be documented here?

Thanks for the review. Yes, this is a valid point, I'll document it too.

> 
> >  pages_to_scan
> >          how many pages to scan before ksmd goes to sleep
> >          e.g. ``echo 100 > /sys/kernel/mm/ksm/pages_to_scan``.
> > --
> > 2.21.0
> >
> 
> 
> --
> Have a nice day,
> Timofey.

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer
