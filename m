Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3433204091
	for <lists+linux-api@lfdr.de>; Mon, 22 Jun 2020 21:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgFVTgj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 22 Jun 2020 15:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728435AbgFVTgi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 22 Jun 2020 15:36:38 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20DCC061573;
        Mon, 22 Jun 2020 12:36:38 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b5so8853504pfp.9;
        Mon, 22 Jun 2020 12:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SL19nea2/x/BTVEfq3tEcv8dczThi2gQ+pctAMjhBis=;
        b=jX6laj/GLKW8OrK62WrqFv1Ix+RuTRrkjsPWJ66J4iz7W021DvRBARhZb/NFV31mYT
         J7reeZI3hJhOGbmrFl6UIZGftFqGWpH4XNyxc6i1HeuvU8xVo8v4Xm0UleSiHswNTRXN
         3bRfknYIwZbME+HpCyINSMnOdIQULa338Cn5lxOxzvk/QKpmOcooZGwoJvq5FGZPKz2Z
         U4wm0mmFaoohpNkOmmY0W7YZizyu9g89tFGAipnZIvgEd5xZ0z2A/t4Qvdv95e/wgdJX
         5JvieE0PbMR0ITFtPHFIqjiC579ANAGr7aG3tiKGis+3Mrn5i9YBbgzEJ156YTCHJWju
         /ekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=SL19nea2/x/BTVEfq3tEcv8dczThi2gQ+pctAMjhBis=;
        b=n3ZMgB/QkPJqCDfs6QE6yFz3wJ09T2l7s7aPsTreGGIPr4MnszNdUYx/GSWJUy1CP9
         ujDH+f+UkZRyfJ2nrNY23oSjJAfux367orxEkquESNmP8hg/w8qH/3tUB6wQ2ZLGOCbE
         XygvvDbIyFnq7nQP66gdipiRHROEcSh/HZnMnlT+TmPKfaUtJbP8x55TXViARowcx4Sj
         7ntl/OwT/zyTQoebp5Cgrn1fAf/5ID//u5huzRFfYiwHYQ8xJr36Ln6wpgxP8WVxLxhh
         Ti8RahqT+ddkAT3zMdp3dZ4OOB6Ex1P6KR2e533T0k9bh81FjWisQPpIQX8uztWlquBU
         Li5Q==
X-Gm-Message-State: AOAM530pYsT0c6cUVEYV0PdcKznfpj4hlrsVuwl9hL97TtAvZ+VYjqCi
        toz7qdwiKKmLEBwvUmdBLZ4=
X-Google-Smtp-Source: ABdhPJy+H1EKZ69bUI9csC6dh59Q7kZNckMpQjEugrWLNPuK6AfQLQWrFFbrCuTbD9Sp5VFvDrTkiA==
X-Received: by 2002:aa7:972b:: with SMTP id k11mr22374035pfg.299.1592854598029;
        Mon, 22 Jun 2020 12:36:38 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id b71sm5269965pfb.125.2020.06.22.12.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 12:36:37 -0700 (PDT)
Date:   Mon, 22 Jun 2020 12:36:35 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>, oleksandr@redhat.com
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com, sj38.park@gmail.com,
        David Rientjes <rientjes@google.com>,
        Arjun Roy <arjunroy@google.com>
Subject: Re: [PATCH v8 0/4]  introduce memory hinting API for external process
Message-ID: <20200622193635.GA23000@google.com>
References: <20200622192900.22757-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622192900.22757-1-minchan@kernel.org>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jun 22, 2020 at 12:28:56PM -0700, Minchan Kim wrote:
> Now, we have MADV_PAGEOUT and MADV_COLD as madvise hinting API. With that,
> application could give hints to kernel what memory range are preferred to be
> reclaimed. However, in some platform(e.g., Android), the information
> required to make the hinting decision is not known to the app.
> Instead, it is known to a centralized userspace daemon(e.g., ActivityManagerService),
> and that daemon must be able to initiate reclaim on its own without any app
> involvement.
> 
> To solve the concern, this patch introduces new syscall - process_madvise(2).
> Bascially, it's same with madvise(2) syscall but it has some differences.
> 
> 1. It needs pidfd of target process to provide the hint
> 2. It supports only MADV_{COLD|PAGEOUT} at this moment.
>    Other hints in madvise will be opened when there are explicit requests from
>    community to prevent unexpected bugs we couldn't support.
> 3. Only privileged processes can do something for other process's address
>    space.
> 
> For more detail of the new API, please see "mm: introduce external memory hinting API"
> description in this patchset.
> 
> * from v7 -  http://lore.kernel.org/r/20200302193630.68771-1-minchan@kernel.org
>   * dropping pid support from new syscall and fold releated patches into syscall patch
>   * dropping KSM patch by discussion - Oleksandr, I lost the discussion.
>     Please resend the single patch against of the patchset if you resolves the discussion.
>     https://lore.kernel.org/linux-api/20200302193630.68771-8-minchan@kernel.org/

Oleksandr, it seems you discussed something with Vlastimil but couldn't
find conclustion yet and Since Jann put an a new note in the thread,
I detach the patch from this patchset.

Please send the KSM patch based on this patchset if you belive there is
no need to be actionable for comments.
