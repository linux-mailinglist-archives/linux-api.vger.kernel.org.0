Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1CD24CBEB
	for <lists+linux-api@lfdr.de>; Thu, 20 Jun 2019 12:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbfFTKcY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Jun 2019 06:32:24 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35934 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfFTKcX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Jun 2019 06:32:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id f21so1369771pgi.3;
        Thu, 20 Jun 2019 03:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vh/TaWAXivsCSm93ZkOvEDBkx2UKyyCx6lOeAnqGOlE=;
        b=ttF/SnGYG3MOm+YgtgBbYEgYcC3Gryeob5F0AgH9pKO3BZ4CD/56pVCkDIFxyQBGnJ
         vNodJ0g4aVQaCP6EaAGUeJY4lkffwXbWCXY68CjsUqSHCBAiAuab7MFHcHqwsatieGZ/
         nYHo33JOSHtedVBSCYVCfNsAMCaDihPzCFYwRPUZDvjFhv1MN0GcPnaiTSpTH1xgHIYn
         tqu9zrsbTkMcFADzh3sHS5xHtVOW2Jfsd6SQL+SxKAix+d8k8hOq9KsmgMZEIPp/xKXy
         oe32UVSZTA6hZKSfi0QIXidVgJrfAoU4o67stK283mjbTtEtY6VrboiGudu85+RMdB8r
         ClnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vh/TaWAXivsCSm93ZkOvEDBkx2UKyyCx6lOeAnqGOlE=;
        b=bcuF+2HcJ7S5abOniVmBUod+hu7RIQIS3jqbvtTgdGnwMoHL0j3Y2Q108X+5O2rkCK
         579RNsBCQtO/2mH7cu/2xWrL6Rds0vnxErk8K+E2yqjGhLjSU69MMo6Efd3Ub4t0IGaY
         SAp5V05FZDcek80iDIIH45KK1psjEIPLCMS+LC9gLhk78ZQkyaCWtUm0MJFM0RemAuWU
         cpAUwe/wtN0YUU/v6mlB0YyWCvmeEEz/HkW1wtPGAlMAk1cy1upnbaSQ+Tmm2ZX8Ckg6
         7uBr6cmZucDldIO9C7ldSEsd1Yri0AfPxoAdDmb/iQcTf7Kf3wYsz0haaF0ZxRJKHlLg
         6q9g==
X-Gm-Message-State: APjAAAVeyh615FWO4St6H54jfv3hAC+Bs9r/jRE1ZIvE7jQgrOWeXig3
        f75+SnPQbOQ1613/ufvRwhM=
X-Google-Smtp-Source: APXvYqzG+Ny73nTkuvycxB2Qtw2No/JfB1pM/xIlj0jTTPw8WMCkRlsju9l456JNXOtmVU5qfE89Vw==
X-Received: by 2002:a63:d008:: with SMTP id z8mr12308782pgf.335.1561026742731;
        Thu, 20 Jun 2019 03:32:22 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id 12sm21098259pfi.60.2019.06.20.03.32.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 03:32:21 -0700 (PDT)
Date:   Thu, 20 Jun 2019 19:32:15 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, jannh@google.com,
        oleg@redhat.com, christian@brauner.io, oleksandr@redhat.com,
        hdanton@sina.com, lizeb@google.com
Subject: Re: [PATCH v2 4/5] mm: introduce MADV_PAGEOUT
Message-ID: <20190620103215.GF105727@google.com>
References: <20190610111252.239156-1-minchan@kernel.org>
 <20190610111252.239156-5-minchan@kernel.org>
 <20190619132450.GQ2968@dhcp22.suse.cz>
 <20190620041620.GB105727@google.com>
 <20190620070444.GB12083@dhcp22.suse.cz>
 <20190620084040.GD105727@google.com>
 <20190620092209.GD12083@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620092209.GD12083@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jun 20, 2019 at 11:22:09AM +0200, Michal Hocko wrote:
> On Thu 20-06-19 17:40:40, Minchan Kim wrote:
> > > > > Pushing out a shared page cache
> > > > > is possible even now but this interface gives a much easier tool to
> > > > > evict shared state and perform all sorts of timing attacks. Unless I am
> > > > > missing something we should be doing something similar to mincore and
> > > > > ignore shared pages without a writeable access or at least document why
> > > > > we do not care.
> > > > 
> > > > I'm not sure IIUC side channel attach. As you mentioned, without this syscall,
> > > > 1. they already can do that simply by memory hogging
> > > 
> > > This is way much more harder for practical attacks because the reclaim
> > > logic is not fully under the attackers control. Having a direct tool to
> > > reclaim memory directly then just opens doors to measure the other
> > > consumers of that memory and all sorts of side channel.
> > 
> > Not sure it's much more harder. It's really easy on my experience.
> > Just creating new memory hogger and consume memory step by step until
> > you newly allocated pages will be reclaimed.
> 
> You can contain an untrusted application into a memcg and it will only
> reclaim its own working set.
> 
> > > > 2. If we need fix MADV_PAGEOUT, that means we need to fix MADV_DONTNEED, too?
> > > 
> > > nope because MADV_DONTNEED doesn't unmap from other processes.
> > 
> > Hmm, I don't understand. MADV_PAGEOUT doesn't unmap from other
> > processes, either.
> 
> Either I am confused or missing something. shrink_page_list does
> try_to_unmap and that unmaps from all processes, right?

You don't miss it. It seems now I undetstand what you pointed out.
What you meant is attacker can see what page was faulting-in from other processes
via measuring access delay from his address space and MADV_PAGEOUT makes it more
easiler. Thus, it's an issue regardless of recent mincore fix. Right?
Then, okay, I will add can_do_mincore similar check for the MADV_PAGEOUT syscall
if others have different ideas.

Thanks.
