Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9142431F263
	for <lists+linux-api@lfdr.de>; Thu, 18 Feb 2021 23:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhBRWfk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Feb 2021 17:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhBRWfj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Feb 2021 17:35:39 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09245C061786
        for <linux-api@vger.kernel.org>; Thu, 18 Feb 2021 14:34:59 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id z21so2150187pgj.4
        for <linux-api@vger.kernel.org>; Thu, 18 Feb 2021 14:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=PjuW2uBQD89P7RlCcE9r4w/f8p7EZ47g6UObZWyrNJs=;
        b=wGEj5oeVZcX/yASMYkFItFWu8teDIDt3qsz2z2Eckh+c4GcTBYNGPik/MmeX6X7Itt
         l/HAkR4xInyJw9VzdpjWP5bkmqfhvWM9QUt2hhSq8i1GA2zVG8JkwvShcpYji4fUSsm2
         AVBjGBgIgTh11DHkfdtNQAla1bOsbzplVL9eKlGpiOeR3GDLdUQQnTSl5xlDCFeERAa+
         yi/c25EfYLilLBfBPzxhlUm/1JHR0aK0l+LOjtygmjYkbYjhw8Q4XQQ5stGvORfxruCu
         fTT6dZbRvWiB/6wb9bCaKBbny6kY4S8i+5gnVRTNAPrydDAuogw4+PEqfeiTA4j7pElM
         PLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=PjuW2uBQD89P7RlCcE9r4w/f8p7EZ47g6UObZWyrNJs=;
        b=CyC/fYPS82yVf9pYlcJxIgUdp/reot1mDmX4QFWaneMAINEEMNClsh2U2v+uwsdhcJ
         X4p1/xHu3oB7VhHt8PXvF/nWaJI/fOmEYDdpHK7sEVjdDnZ3sj/T/SdhQnkvog/P10M6
         3NI7uEHQEU/UpILo6bRnFb3eEBuaJyWgEQ4f4KMj4HYpHza+t+v2588dkNb1ryTLDQVj
         hJS0J/4lUPftQX/9IiRkPXWVfJVB/ngfzRn5Pi4lJbFO4MDPyWJdByH+dQebbdrBqnRF
         Lmf1OeGHqRlmhvtuhWB8WIKujH+mkcMsOt3QggfilzfUl7kpw9zasQj9vAZPTuTz2qQp
         BICQ==
X-Gm-Message-State: AOAM5323wBEoCmBmWbYycPXmBJb5vgEmoF4g7SCgJiNHykshYlJeZq+Q
        I7mjG9GeP7GIMvubdpKkvdBS0A==
X-Google-Smtp-Source: ABdhPJxVlpmz7MpPiyDQTWu8x7EZzrlS+vaPUHimF82ElG73KtaZFLiH+u+1SUdU/WohO7JpUecsgQ==
X-Received: by 2002:a05:6a00:1693:b029:1ec:b0af:d1d with SMTP id k19-20020a056a001693b02901ecb0af0d1dmr6476442pfc.42.1613687698363;
        Thu, 18 Feb 2021 14:34:58 -0800 (PST)
Received: from [2620:15c:17:3:b498:93bf:c9f9:831d] ([2620:15c:17:3:b498:93bf:c9f9:831d])
        by smtp.gmail.com with ESMTPSA id w187sm7100987pgb.52.2021.02.18.14.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 14:34:57 -0800 (PST)
Date:   Thu, 18 Feb 2021 14:34:56 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     David Hildenbrand <david@redhat.com>
cc:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Chris Kennelly <ckennelly@google.com>, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [RFC] Hugepage collapse in process context
In-Reply-To: <600ee57f-d839-d402-fb0f-e9f350114dce@redhat.com>
Message-ID: <5127b9c-a147-8ef5-c942-ae8c755413d0@google.com>
References: <d098c392-273a-36a4-1a29-59731cdf5d3d@google.com> <YCzSDPbBsksCX5zP@dhcp22.suse.cz> <0b51a213-650e-7801-b6ed-9545466c15db@suse.cz> <600ee57f-d839-d402-fb0f-e9f350114dce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, 18 Feb 2021, David Hildenbrand wrote:

> > > > Hi everybody,
> > > > 
> > > > Khugepaged is slow by default, it scans at most 4096 pages every 10s.
> > > > That's normally fine as a system-wide setting, but some applications
> > > > would
> > > > benefit from a more aggressive approach (as long as they are willing to
> > > > pay for it).
> > > > 
> > > > Instead of adding priorities for eligible ranges of memory to
> > > > khugepaged,
> > > > temporarily speeding khugepaged up for the whole system, or sharding its
> > > > work for memory belonging to a certain process, one approach would be to
> > > > allow userspace to induce hugepage collapse.
> > > > 
> > > > The benefit to this approach would be that this is done in process
> > > > context
> > > > so its cpu is charged to the process that is inducing the collapse.
> > > > Khugepaged is not involved.
> > > 
> > > Yes, this makes a lot of sense to me.
> > > 
> > > > Idea was to allow userspace to induce hugepage collapse through the new
> > > > process_madvise() call.  This allows us to collapse hugepages on behalf
> > > > of
> > > > current or another process for a vectored set of ranges.
> > > 
> > > Yes, madvise sounds like a good fit for the purpose.
> > 
> > Agreed on both points.
> > 
> > > > This could be done through a new process_madvise() mode *or* it could be
> > > > a
> > > > flag to MADV_HUGEPAGE since process_madvise() allows for a flag
> > > > parameter
> > > > to be passed.  For example, MADV_F_SYNC.
> > > 
> > > Would this MADV_F_SYNC be applicable to other madvise modes? Most
> > > existing madvise modes do not seem to make much sense. We can argue that
> > > MADV_PAGEOUT would guarantee the range was indeed reclaimed but I am not
> > > sure we want to provide such a strong semantic because it can limit
> > > future reclaim optimizations.
> > > 
> > > To me MADV_HUGEPAGE_COLLAPSE sounds like the easiest way forward.
> > 
> > I guess in the old madvise(2) we could create a new combo of MADV_HUGEPAGE |
> > MADV_WILLNEED with this semantic? But you are probably more interested in
> > process_madvise() anyway. There the new flag would make more sense. But
> > there's
> > also David H.'s proposal for MADV_POPULATE and there might be benefit in
> > considering both at the same time? Should e.g. MADV_POPULATE with
> > MADV_HUGEPAGE
> > have the collapse semantics? But would MADV_POPULATE be added to
> > process_madvise() as well? Just thinking out loud so we don't end up with
> > more
> > flags than necessary, it's already confusing enough as it is.
> > 
> 
> Note that madvise() eats only a single value, not flags. Combinations as you
> describe are not possible.
> 
> Something MADV_HUGEPAGE_COLLAPSE make sense to me that does not need the mmap
> lock in write and does not modify the actual VMA, only a mapping.
> 

Agreed, and happy to see that there's a general consensus for the 
direction.  Benefit of a new madvise mode is that it can be used for 
madvise() as well if you are interested in only a single range of your own 
memory and then it doesn't need to reconcile with any of the already 
overloaded semantics of MADV_HUGEPAGE.

Otherwise, process_madvise() can be used for other processes and/or 
vectored ranges.

Song's use case for this to prioritize thp usage is very important for us 
as well.  I hadn't thought of the madvise(MADV_HUGEPAGE) + 
madvise(MADV_HUGEPAGE_COLLAPSE) use case: I was anticipating the latter 
would allocate the hugepage with khugepaged's gfp mask so it would always 
compact.  But it seems like this would actually be better to use the gfp 
mask that would be used at fault for the vma and left to userspace to 
determine whether that's MADV_HUGEPAGE or not.  Makes sense.

(Userspace could even do madvise(MADV_NOHUGEPAGE) + 
madvise(MADV_HUGEPAGE_COLLAPSE) to do the synchronous collapse but 
otherwise exclude it from khugepaged's consideration if it were inclined.)

Two other minor points:

 - Currently, process_madvise() doesn't use the flags parameter at all so 
   there's the question of whether we need generalized flags that apply to 
   most madvise modes or whether the flags can be specific to the mode 
   being used.  For example, a natural extension of this new mode would be 
   to determine the hugepage size if we were ever to support synchronous 
   collapse into a 1GB gigantic page on x86 (MADV_F_1GB? :)

 - We haven't discussed the future of khugepaged with this new mode: it 
   seems like we could simply implement khugepaged fully in userspace and 
   remove it from the kernel? :)
