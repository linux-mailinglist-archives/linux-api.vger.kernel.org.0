Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB84D1462AF
	for <lists+linux-api@lfdr.de>; Thu, 23 Jan 2020 08:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgAWH3N (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 23 Jan 2020 02:29:13 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42326 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725777AbgAWH3N (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 23 Jan 2020 02:29:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579764551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Swf1miaJ2KibF1rWEltK6FB4Al/NU26D9Z8MNRvgV1o=;
        b=BKVRbpzL1QgKuQYQn5Y91fPzk0ZShh9q6OAe1YHPWDzlgFnelR2KSmsU+tHHTKUzr8s2j9
        LJDi6QNs9jorpKxGLrw3tJ51HJgL4N+/+ACO/CgaIPPaQ15aaMX6cFbPMNcT/++i+i2qga
        j7REJ23A4JLUU+5H5UYGgdqz3eqIgGE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-WQn6wjm5MJ2wH2Ao0c9SSg-1; Thu, 23 Jan 2020 02:29:07 -0500
X-MC-Unique: WQn6wjm5MJ2wH2Ao0c9SSg-1
Received: by mail-wm1-f70.google.com with SMTP id t16so623629wmt.4
        for <linux-api@vger.kernel.org>; Wed, 22 Jan 2020 23:29:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Swf1miaJ2KibF1rWEltK6FB4Al/NU26D9Z8MNRvgV1o=;
        b=OITTs0KYQzIzps8OVWrynv+c5gpPYCxktcdxZ33CSdAQMxZPW+ItonTwa7PNJUDPz6
         +1IOaePOmf2mdjZk6ucOqFOVxMFidM/NFPcync4eUuafWWFGVrzzVAj7E9Ip+R7QOtMm
         CZgp2j5oLtPJTXFciSKsNRrHmiA1DWhkCNiQzBB4bO6qOT7SxTBaA4VDHiDd0hRy3stj
         mEX8ASO1ZmAX9ZuujsHHpQElLUAJU2vsURPUjcxaRje93Ke21kkXyvxRr45q55PMFh7N
         3qlTq2kpiIveEfFk+ruevUMxW0vg+qFYUOfFGeSTMrSs87inL4QPK2MYZVLITokEJQvh
         JdfQ==
X-Gm-Message-State: APjAAAXu2ke6zdfVcTjMLxw2wWZ3wYUpYrizmdycAhjA2AJp14y2X6F1
        pEC8TcI8fEArOpQRy/Mr1zDolm2Te5jjTbHSaZgOVdXUSFcKBziLLDmnPpTv7dfOpZM+3LbHtK3
        +/jqdIebRyYtzXzAqfCOx
X-Received: by 2002:adf:fe0e:: with SMTP id n14mr16615726wrr.116.1579764546541;
        Wed, 22 Jan 2020 23:29:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqynoI3k83YYvEjN9Vq70/cg2K/88hFd6YtoeaGnpbIqaxUURJKASpUHj31Q/0KxCIPHp2utJg==
X-Received: by 2002:adf:fe0e:: with SMTP id n14mr16615675wrr.116.1579764546241;
        Wed, 22 Jan 2020 23:29:06 -0800 (PST)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a9sm1509848wmm.15.2020.01.22.23.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 23:29:04 -0800 (PST)
Date:   Thu, 23 Jan 2020 08:29:04 +0100
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>, ktkhai@virtuozzo.com,
        christian.brauner@ubuntu.com, sjpark@amazon.de
Subject: Re: [PATCH v2 2/5] mm: introduce external memory hinting API
Message-ID: <20200123072904.ludphxkxseyg2qli@butterfly.localdomain>
References: <20200116235953.163318-1-minchan@kernel.org>
 <20200116235953.163318-3-minchan@kernel.org>
 <20200117115225.GV19428@dhcp22.suse.cz>
 <20200117155837.bowyjpndfiym6cgs@box>
 <20200117173239.GB140922@google.com>
 <20200117212653.7uftw3lk35oykkmb@box>
 <20200121181113.GE140922@google.com>
 <20200122104424.7gvrfivymjvdous4@butterfly.localdomain>
 <20200123014316.GB249784@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123014316.GB249784@google.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jan 22, 2020 at 05:43:16PM -0800, Minchan Kim wrote:
> > It seems I've overlooked an important piece of this submission: one
> > cannot apply the hint to all the anonymous mapping regardless of address
> > range. For KSM I'd rather either have a possibility to hint all the
> > anonymous mappings, or, as it was suggested previously, be able to iterate
> > over existing mappings using some (fd-based?) API.
> 
> Thing is how you could identify a certan range is better for KSM than
> others from external process?

I think the info like this is kinda available via /proc/pid/smaps. It
lists the ranges and the vmflags. But using it raises 2 concerns: one is
the absence of guarantee the mappings won't change after smaps is read
and the second one is that there's no separate vmflag for marking a vma
as non-meregable (and IIRC from previous attempts on addressing this,
we've already exhausted all the flags on 32-bit arches, so it is not
something that can be trivially addressed).

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer

