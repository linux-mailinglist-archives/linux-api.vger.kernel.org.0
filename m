Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240C0329314
	for <lists+linux-api@lfdr.de>; Mon,  1 Mar 2021 22:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239643AbhCAU7O (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 1 Mar 2021 15:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243735AbhCAU4w (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 1 Mar 2021 15:56:52 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576CCC0617A7
        for <linux-api@vger.kernel.org>; Mon,  1 Mar 2021 12:56:12 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id o188so5681537pfg.2
        for <linux-api@vger.kernel.org>; Mon, 01 Mar 2021 12:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=aKfF3alorFUH2Sfxr377YFS/FLDvTTuPGkr1txbpzfE=;
        b=fmlnWl+F1L7aHevhdvuJMOrhIkIsAB4LL2iKlq/YY1BFe1i6oxbYOFPgw7nFhKWQuh
         2yVsyCAUoGGZKNGqWHm+QuZvEYn2GpNvbUkeIK5dezJ8d2LV+EwLRtsRM/c9ULADzcp1
         TDujFfPdsyZ7Xt5ou5On45h61UBaJEg1FUzgroubl8Gse0jxsUpgZuTeMW69yrFAIsXL
         JIIQOGCoBmJIfVq5/Cr/wHSngsnhTy+kh9u0hyTUxadEDbVhUDjWfAVyQ+2nNcaLNNYj
         TSZFQ7ZUvsOnkux0QZxF9B6aeDfJuv6vVJHPiEHqhAPCB6+vojVkyW+UZigIt2MTtc0P
         CLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=aKfF3alorFUH2Sfxr377YFS/FLDvTTuPGkr1txbpzfE=;
        b=t8aLPGmWgXi6pWTTlwYJdf0Tn+PTrlq/Gy73wK3394KkPj+s5kSS37bJYsTd52N8D2
         eLN4zz8/VbfNM2/vcQs9X1nhzz2bPJch3hnsj0NwWgbhWgC5A4c08jZMOtR5KuYnje9v
         5hlIdkfCiLoxP00+T56fKM4G2vmNe5QDprZyCPQTp9nnoWYg6Qkx3J8dYweVBi82H/4E
         yysIEqJsZVfyOrqTmNwfDqSc6QaeD6XP4dP4g8xjZY5k12BWb+/aQTHdPaXLV6nmA53M
         UZUKDtz37m8tioleWTuEwdXKHc68Sguy2QusDLYpEFaFyILjenT4piVIA5OXG9borFG/
         APog==
X-Gm-Message-State: AOAM531epWrW85mPfiZla+pivAFz4lFEp1GKVprcZr/5MK3ca6uMXb9j
        p2jyQPngqoyWe3EP1eimE8ReCw==
X-Google-Smtp-Source: ABdhPJxu5zQwkM2bTrndEGxVnNeG6KkNKVB0vEkmSnhtwG0S4ImL+bKVlU6rrZD33WtiittGVRTTqQ==
X-Received: by 2002:a62:2e83:0:b029:1db:8bd9:b8ad with SMTP id u125-20020a622e830000b02901db8bd9b8admr197900pfu.74.1614632171597;
        Mon, 01 Mar 2021 12:56:11 -0800 (PST)
Received: from [2620:15c:17:3:91e9:d3d2:53fd:5d0f] ([2620:15c:17:3:91e9:d3d2:53fd:5d0f])
        by smtp.gmail.com with ESMTPSA id 186sm15017391pfx.132.2021.03.01.12.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 12:56:10 -0800 (PST)
Date:   Mon, 1 Mar 2021 12:56:10 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Chris Kennelly <ckennelly@google.com>, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [RFC] Hugepage collapse in process context
In-Reply-To: <25d9347b-9359-efab-e1e3-f98bd0012af9@linux.alibaba.com>
Message-ID: <544df052-f9f3-f068-f69e-343cc69d994b@google.com>
References: <d098c392-273a-36a4-1a29-59731cdf5d3d@google.com> <YCzSDPbBsksCX5zP@dhcp22.suse.cz> <0b51a213-650e-7801-b6ed-9545466c15db@suse.cz> <600ee57f-d839-d402-fb0f-e9f350114dce@redhat.com> <5127b9c-a147-8ef5-c942-ae8c755413d0@google.com>
 <25d9347b-9359-efab-e1e3-f98bd0012af9@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, 24 Feb 2021, Alex Shi wrote:

> > Agreed, and happy to see that there's a general consensus for the 
> > direction.  Benefit of a new madvise mode is that it can be used for 
> > madvise() as well if you are interested in only a single range of your own 
> > memory and then it doesn't need to reconcile with any of the already 
> > overloaded semantics of MADV_HUGEPAGE.
> 
> It's a good idea to let process deal with its own THP policy.
> but current applications will miss the benefit w/o changes, and change is
> expensive for end users. So except this work, may a per memcg collapse benefit
> apps and free for them, we often deploy apps in cgroups on server now.
> 

Hi Alex,

I'm not sure that I understand: this MADV_COLLAPSE would be possible for 
process_madvise() as well and by passing a vectored set of ranges so a 
process can do this on behalf of other processes (it's the only way that 
we could theoretically move khugepaged to userspace, although that's not 
an explicit end goal).

How would you see this working with memcg involved?  I had thought this 
was entirely orthogonal to any cgroup.
