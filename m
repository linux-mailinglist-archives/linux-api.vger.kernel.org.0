Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 466BA64F88
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2019 02:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfGKAZa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 10 Jul 2019 20:25:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45870 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfGKAZa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 10 Jul 2019 20:25:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id o13so2000706pgp.12;
        Wed, 10 Jul 2019 17:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PSrRRdlZuwCbhrC4BGiP6VbqlB+slyYAJraAbbeTAVc=;
        b=dqi0EsXhqHhP5K98X2PHRzhIJqAh7Uf6mdAJ2kB12s1CPYVMytMsw0oLnDkGpCSZAK
         XXR8EVrqMiIQG3kKg9YQBlWsotzErD0+O4eIRniG+KLOt+3eRrE0KLAErkWvo6QE2zRZ
         mREN/Mah+yTttDd29Fn7vi06Hm3IytJrK9MMBukNqZEEqfw9FzaLjWpo3r3OrPopS7YT
         sM02a86i/AryiKGUXK1wxsZoBHIsuBqBqzFDeoQNFovViyWduLDOZ9zN9IVfyuXVBrxN
         gUORW28ayC6zatUrswHpC1e1EeESLDyc3yBdmuE3K+GJ87O7nypgGE7gOBI0Dx7yBOzS
         E2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PSrRRdlZuwCbhrC4BGiP6VbqlB+slyYAJraAbbeTAVc=;
        b=iqU266zu0nQ5SH0nC2rr1ngxIsW94+qd0p2j1Ng6pJMt1pWjYIxoR7X5td4AR0pc2S
         qAwOQs5wgV/VnsCIEULiQlc3h1G0Dc0xN/ZcF5U6Vl4lFm1/kyxhGZCkCJc7vHWpQEbO
         CXXUGdUXVfxOl5KMlVC8Buyxm6EdM0sa+2ooUkeiYEFG0vQuLI5fDrZH9+NRGV2mecJV
         RQsgRKdbkKoLUij4JyT1ZstBRhZxLlMkr9iCpQ+TPAOgsrEJp9RxC+3g2WtoXQFYe1rO
         +gl9e1saSC9z8m4LdLoNwFGOPxhJVvVvyfIgVGSms4IwrGCqgx+iTdXm06fRIzbGnN/h
         WqBw==
X-Gm-Message-State: APjAAAWHOhDQf0yRJMzIOVFvyTFGhdtrtoSJfRPhuyVWSx4zWAz+lrJB
        w1SMtOv3Hkfw48c7h8zag3g=
X-Google-Smtp-Source: APXvYqyh0rIS43MPSspgemppfQv0nfmEjAFry/GPnBi51JgdU/Rn2St6WkcieBqjyJtXAPkz9zxifw==
X-Received: by 2002:a65:60cc:: with SMTP id r12mr1166350pgv.333.1562804729591;
        Wed, 10 Jul 2019 17:25:29 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id v138sm3886270pfc.15.2019.07.10.17.25.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 17:25:28 -0700 (PDT)
Date:   Thu, 11 Jul 2019 09:25:21 +0900
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
        Sonny Rao <sonnyrao@google.com>, oleksandr@redhat.com,
        hdanton@sina.com, lizeb@google.com,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v3 4/5] mm: introduce MADV_PAGEOUT
Message-ID: <20190711002521.GA71901@google.com>
References: <20190627115405.255259-1-minchan@kernel.org>
 <20190627115405.255259-5-minchan@kernel.org>
 <20190709095518.GF26380@dhcp22.suse.cz>
 <20190710104809.GA186559@google.com>
 <20190710111622.GI29695@dhcp22.suse.cz>
 <20190710115356.GC186559@google.com>
 <20190710194719.GS29695@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710194719.GS29695@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jul 10, 2019 at 09:47:19PM +0200, Michal Hocko wrote:
> On Wed 10-07-19 20:53:56, Minchan Kim wrote:
> > On Wed, Jul 10, 2019 at 01:16:22PM +0200, Michal Hocko wrote:
> > > On Wed 10-07-19 19:48:09, Minchan Kim wrote:
> > > > On Tue, Jul 09, 2019 at 11:55:19AM +0200, Michal Hocko wrote:
> > > [...]
> > > > > I am still not convinced about the SWAP_CLUSTER_MAX batching and the
> > > > > udnerlying OOM argument. Is one pmd worth of pages really an OOM risk?
> > > > > Sure you can have many invocations in parallel and that would add on
> > > > > but the same might happen with SWAP_CLUSTER_MAX. So I would just remove
> > > > > the batching for now and think of it only if we really see this being a
> > > > > problem for real. Unless you feel really strong about this, of course.
> > > > 
> > > > I don't have the number to support SWAP_CLUSTER_MAX batching for hinting
> > > > operations. However, I wanted to be consistent with other LRU batching
> > > > logic so that it could affect altogether if someone try to increase
> > > > SWAP_CLUSTER_MAX which is more efficienty for batching operation, later.
> > > > (AFAIK, someone tried it a few years ago but rollback soon, I couldn't
> > > > rebemeber what was the reason at that time, anyway).
> > > 
> > > Then please drop this part. It makes the code more complex while any
> > > benefit is not demonstrated.
> > 
> > The history says the benefit.
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/patch/?id=d37dd5dcb955dd8c2cdd4eaef1f15d1b7ecbc379
> 
> Limiting the number of isolated pages is fine. All I am saying is that
> SWAP_CLUSTER_MAX is an arbitrary number same as 512 pages for one PMD as
> a unit of work. Both can lead to the same effect if there are too many
> parallel tasks doing the same thing.
> 
> I do not want you to change that in the reclaim path. All I am asking
> for is to add a bathing without any actual data to back that because
> that makes the code more complex without any gains.

I understand what you meant and I'm really one to make code simple.
However, my concern was that we have isolated by SWAP_CLUSTER_MAX(32 pages)
for other path(reclaim/compaction) so I want to be consistent with others.
If you think that the consistency(IOW, others are 32 limit but here 256
limit) is no helpful this case, I don't have any strong opinion.
Let's drop the part. I will add it into description, then.

Thanks.

> -- 
> Michal Hocko
> SUSE Labs
