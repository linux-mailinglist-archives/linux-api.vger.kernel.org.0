Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E21961451FE
	for <lists+linux-api@lfdr.de>; Wed, 22 Jan 2020 11:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgAVKCi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 22 Jan 2020 05:02:38 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36623 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgAVKCh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 22 Jan 2020 05:02:37 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so6597601wru.3;
        Wed, 22 Jan 2020 02:02:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H8XhF6Ngu9Vwt38nvy+ftPac/fSxaXbICn0o+rbDDDg=;
        b=nI+RS735fyKg8/2KcWbPJLMNJ3J5BbmsJx4UeILp9BOSZswOb0R2mqhYNyByuhyOxs
         iaenu4Yv1EigRIm+ch4egx2Y7So8RSb0X5HG73hGj81yoUjXmVkiyBrMq0Kk6nCd917B
         hvYUY83MZ3u55kzhnk0L3Ri5t46mnSr4le9z5BkzY0HDs7J71BhwlOQDlDSLO53DNStx
         Tzo8w7cxgH7YKhi7b2NPwsiXY6zY4CaW0rySrVQ1DGofzEpY4K2+rdLxKAarZ+WIE2f7
         U6MWiYzMrA853R3uR7oi70ZMEF3eGE7yeofBLCdarz+SB9XaDypIVEZMD9g5ZvivBjaB
         HOVQ==
X-Gm-Message-State: APjAAAW6seqcZ/bDfu/VoCpIeUnE3o/uvXFcB3zTUvlRci9p6zaI3mae
        2EuHelREFeaYgomn5qLYvAQ=
X-Google-Smtp-Source: APXvYqyT2NvfPYkTXHh62H4Ev4LdAPB2JSAFEoO2hSMYIIxwxdO8P1N2iIb/ahPKYIZS3HNKi6gS0A==
X-Received: by 2002:adf:dd52:: with SMTP id u18mr10148805wrm.131.1579687355474;
        Wed, 22 Jan 2020 02:02:35 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id q3sm3128551wmc.47.2020.01.22.02.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 02:02:34 -0800 (PST)
Date:   Wed, 22 Jan 2020 11:02:33 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Minchan Kim <minchan@kernel.org>, sspatil@google.com,
        kirill@shutemov.name, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, oleksandr@redhat.com, surenb@google.com,
        timmurray@google.com, dancol@google.com, sonnyrao@google.com,
        bgeffon@google.com, hannes@cmpxchg.org, shakeelb@google.com,
        joaodias@google.com, ktkhai@virtuozzo.com,
        christian.brauner@ubuntu.com, sjpark@amazon.de
Subject: Re: Re: [PATCH v2 2/5] mm: introduce external memory hinting API
Message-ID: <20200122100233.GT29276@dhcp22.suse.cz>
References: <20200122082853.GS29276@dhcp22.suse.cz>
 <20200122093624.14799-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122093624.14799-1-sjpark@amazon.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed 22-01-20 10:36:24, SeongJae Park wrote:
> On Wed, 22 Jan 2020 09:28:53 +0100 Michal Hocko <mhocko@kernel.org> wrote:
> 
> > On Tue 21-01-20 10:32:12, Minchan Kim wrote:
> > > On Mon, Jan 20, 2020 at 08:58:25AM +0100, Michal Hocko wrote:
> > [...]
> > > > The interface really has to be robust to future potential usecases.
> > > 
> > > I do understand your concern but for me, it's chicken and egg problem.
> > > We usually do best effort to make something perfect as far as possible
> > > but we also don't do over-engineering without real usecase from the
> > > beginning.
> > > 
> > > I already told you how we could synchronize among processes and potential
> > > way to be extended Daniel suggested(That's why current API has extra field
> > > for the cookie) even though we don't need it right now.
> > 
> > If you can synchronize with the target task then you do not need a
> > remote interface. Just use ptrace and you are done with it.
> > 
> > > If you want to suggest the other way, please explain why your idea is
> > > better and why we need it at this moment.
> > 
> > I believe I have explained my concerns and why they matter. All you are
> > saying is that you do not care because your particular usecase doesn't
> > care. And that is a first signal of a future disaster when we end up
> > with a broken and unfixable interface we have to maintain for ever.
> > 
> > I will not go as far as to nack this but you should seriously think
> > about other potential usecases and how they would work and what we are
> > going to do when a first non-cooperative userspace memory management
> > usecase materializes.
> 
> Beside of the specific environment of Android, I think there are many ways to
> know the address space layout and access patterns of other processes.  The
> idle_page_tracking might be an example that widelay available.
> 
> Of course, the information might not strictly correct due to the timing issue,
> but could be still worth to be used under some extreme situations, such as
> memory pressure or fragmentation.  For the same reason, ptrace() would not be
> sufficient, as we have no perfect control, but only some level of control that
> would be useful under specific situations.

I am not sure I see your point. I am talking about races where a remote
task is operating on a completely different object because the one it
checked for has been unmapped and new one mapped over it. Memory
pressure or a fragmentation will not change the object itself. Sure the
memory might be reclaimed but that should be completely OK unless I am
missing something.

> I assume the users of this systemcall would understand the tradeoff and make
> decisions.

I disagree. My experience tells me that users tend to squeeze the
maximum and beyond and hope they get what they want.

> Also, as the users already have the right to do the tradeoff, I
> think it's fair.  In other words, I think the caller has both the power and the
> responsibility to deal with the time-to-check-time-to-react problem.
> 
> Nonetheless, I also agree this is important concern and the patch would be
> better if it adds more detailed documentation regarding this issue.

If there is _really_ a strong consensus that the racy interface is
reasonable then it absolutely has to be described with a clearly state
that those races might result in hard to predict behavior unless all
tasks sharing the address space are blocked between the check and the
madvise call.
-- 
Michal Hocko
SUSE Labs
