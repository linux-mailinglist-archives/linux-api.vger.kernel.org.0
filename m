Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39097142C01
	for <lists+linux-api@lfdr.de>; Mon, 20 Jan 2020 14:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgATNYJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 Jan 2020 08:24:09 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44599 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgATNYJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 20 Jan 2020 08:24:09 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so29550697wrm.11;
        Mon, 20 Jan 2020 05:24:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xHYwI1c4dvmZ1Pb+9NFFerZpg3qzCoeSJtlv6Fl2OEo=;
        b=O2ca8CtOzmKaw5SrNmEFoRwuyCNxT4YCbywXq8pVAHQmzn4Suh2TxcRf5w+qMsV9+4
         AtSR/BbRkBMfHSTpngIp4fI58cQYapM5iyP+2wtA60o+HKlf/Wt5dj/0l1XprI9DvFzJ
         9qOcnx9oUQ/2hOiXoq9Nt+vlifj4vSdj9KbC+URv4apzoShKyXnqK3FoK4mYmkKe/0uQ
         b1PE8+sBE4yR/qKAhPgjA0/J+6JTzAJs3t9ftgEJutBsJwCzI0fNfo0GZgkq8AwHnWSD
         2LZbgWN/imipbqbDyny9iiZYHo0azjHTrjryVWIvqFW329zNg8QDsQpYdvgteGGzCrDY
         VpLg==
X-Gm-Message-State: APjAAAXjI6NA86h18pVnF0FQO237EeQyrea81n1QJFMZnaLysY6SWCme
        +7LIt5/xuQYnTjKXT9953Mc/M6QW
X-Google-Smtp-Source: APXvYqwz363seedT/u6ORqRmln0OxS4y1h1TOUeH8L2/nLGIXUtTnmYs+avUnskCxcR26g24PYSV5g==
X-Received: by 2002:adf:ef4e:: with SMTP id c14mr18209651wrp.142.1579526647518;
        Mon, 20 Jan 2020 05:24:07 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id n67sm23630987wmf.46.2020.01.20.05.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 05:24:06 -0800 (PST)
Date:   Mon, 20 Jan 2020 14:24:05 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>, christian.brauner@ubuntu.com,
        sjpark@amazon.de
Subject: Re: [PATCH v2 2/5] mm: introduce external memory hinting API
Message-ID: <20200120132405.GF18451@dhcp22.suse.cz>
References: <20200116235953.163318-1-minchan@kernel.org>
 <20200116235953.163318-3-minchan@kernel.org>
 <20200117115225.GV19428@dhcp22.suse.cz>
 <f57fb198-4070-d3b4-b6bd-43b29ff40a2c@virtuozzo.com>
 <20200120112722.GY18451@dhcp22.suse.cz>
 <20200120123935.onlls7enjtzenbvt@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120123935.onlls7enjtzenbvt@box>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon 20-01-20 15:39:35, Kirill A. Shutemov wrote:
> On Mon, Jan 20, 2020 at 12:27:22PM +0100, Michal Hocko wrote:
> > On Mon 20-01-20 13:24:35, Kirill Tkhai wrote:
[...]
> > > Even two threads on common memory need a synchronization
> > > to manage mappings in a sane way. Managing memory from two processes
> > > is the same in principle, and the only difference is that another level
> > > of synchronization is required.
> > 
> > Well, not really. The operation might simply attempt to perform an
> > operation on a specific memory area and get a failure if it doesn't
> > reference the same object anymore. What I think we need is some form of
> > a handle to operate on. In the past we have discussed several
> > directions. I was proposing /proc/self/map_anon/ (analogous to
> > map_files) where you could inspect anonymous memory and get a file
> > handle for it. madvise would then operate on the fd and then there
> > shouldn't be a real problem to revalidate that the object is still
> > valid. But there was no general enthusiasm about that approach. There
> > are likely some land mines on the way.
> 
> Converting anon memory to file-backed is bad idea and going to backfire.

I didn't mean to convert. I meant to expose that information via proc
the same way we do for file backed mappings. That shouldn't really
require to re-design the way how anonymous vma work IMO. But I haven't
tried that so there might be many gotchas there.

There are obvious things to think about though. Such fd cannot be sent
to other processes (SCM stuff), mmap of the file would have to be
disallowed and many others I am not aware of. I am not even pushing this
direction because I am not convinced about how viable it is myself. But
it would sound like a nice extension of the existing mechanism we have
and a file based madvise sounds attractive to me as well because we
already have that.
-- 
Michal Hocko
SUSE Labs
