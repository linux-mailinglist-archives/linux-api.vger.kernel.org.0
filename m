Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 603D4E418B
	for <lists+linux-api@lfdr.de>; Fri, 25 Oct 2019 04:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390073AbfJYCc7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 24 Oct 2019 22:32:59 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41110 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbfJYCc7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 24 Oct 2019 22:32:59 -0400
Received: by mail-pl1-f196.google.com with SMTP id t10so421063plr.8
        for <linux-api@vger.kernel.org>; Thu, 24 Oct 2019 19:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=g1ns30NWBvyr7boX6LL1Xy9XjoQxnnSYF9EZ4Db7JXo=;
        b=pTMCWdIkG2cC3CrrCS6QNFDxjPVipsYh4cnjbLOMvo/dRNvfEgjpLq085gUwWBxFI7
         oW1yDmWGuCoUBtppG8o5fzQ84VjmJxenG3SWZwrEd9/irg7P9GghSu4xIjpQMllExLmO
         IwRRhGZt8peS8UzhqKhVzfAvtwE/2kuxn/C4z5QUmWLo3xL/o5wAPxXOTMB2pFtDknpd
         aOOQJjxTN+2eWKVYjBl3cRroPcjT5Mzk99ZLS7j/iFml1r3qRFvB4Y895bqdewPlk6sW
         nL1rYXHyfkVHoYNtwSKzXYWDIkXrdKkSuGcr99FBismEKHoTHzLqFFVtJlV5MW3WZyU4
         UAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=g1ns30NWBvyr7boX6LL1Xy9XjoQxnnSYF9EZ4Db7JXo=;
        b=sMoFv4VumLAcwZUHCc1FiZ/B72jNNTqZEGaUnGeBTbxEDGehMQzjzUEsBaJEtzM03G
         ULtrVZIT2huafvTE8vsBAtY8hYaRNFnOST9ZwjHie9wrIjvpuI+84oGa4Asoa5b1JQRE
         XXOilCJTT75Bx5WREK5c+tfhljZcIdvtP/Q7LWRshVIKJLFrkYDY3j2v23bvf5Dtvn8T
         aLLMZIX9mPgFUA+ruwDC2GuvdryKDJN6Ih+PnfDWp87GIEkX6C5mRC65pYzHlsX5sq85
         EPEbw7AzMg1e8/aMLQR21FxF31HtJVn9B3Tv7BCrCvAqmw1PvGK/JFb6vW1Y+pMnR7Vw
         EQ0Q==
X-Gm-Message-State: APjAAAWfFvUsd/2ylaO7eJYtlQu9e8cQROSUVUpwA9HvJH1J3avRtVlm
        IuwdFqiCWdjjaJNA5ZFL/qpg2Q==
X-Google-Smtp-Source: APXvYqzBwaAIQFbX3bMEtf0GQp6J6XBRgOCr8x81MVhZh1qy1hbfTEFcOAEv5o2X8PBCHhwS3S4rAA==
X-Received: by 2002:a17:902:44d:: with SMTP id 71mr1069193ple.320.1571970775667;
        Thu, 24 Oct 2019 19:32:55 -0700 (PDT)
Received: from [100.112.92.218] ([104.133.9.106])
        by smtp.gmail.com with ESMTPSA id b13sm366035pgd.58.2019.10.24.19.32.54
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Oct 2019 19:32:54 -0700 (PDT)
Date:   Thu, 24 Oct 2019 19:32:39 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Li Xinhai <xinhai.li@outlook.com>
cc:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] mm: allow unmapped hole at head side of mbind range
In-Reply-To: <c90d668a-9abc-df1b-8b9c-70a6e6afd94a@suse.cz>
Message-ID: <alpine.LSU.2.11.1910241900070.1096@eggly.anvils>
References: <TY2PR04MB29753892EBAD17D9E8FECBAEE86A0@TY2PR04MB2975.apcprd04.prod.outlook.com> <c90d668a-9abc-df1b-8b9c-70a6e6afd94a@suse.cz>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, 24 Oct 2019, Vlastimil Babka wrote:

> + linux-api
> 
> On 10/24/19 9:35 AM, Li Xinhai wrote:
> > From: Li Xinhai  <xinhai.li@outlook.com>
> > 
> > mbind_range silently ignore unmapped hole at middle and tail of the 
> > specified range, but report EFAULT if hole at head side.
> 
> 
> Hmm that's unfortunate. mbind() manpage says:
> 
> EFAULT Part or all of the memory range specified by nodemask and maxnode
> points outside your accessible address space.  Or, there was an unmapped
> hole in  the  specified  memory range specified by addr and len.
> 
> That sounds like any hole inside the specified range should return
> EFAULT.

Yes (though an exception is allowed when restoring to default).

> But perhaps it can be also interpreted as you suggest, that the
> whole range is an unmapped hole.  There's some risk of breaking existing
> userspace if we change it either way.
> 
> > It is more reasonable to support silently ignore holes at any part of 
> > the range, only report EFAULT if the whole range is in hole.
> > 
> > Signed-off-by: Li Xinhai <xinhai.li@outlook.com>

Xinhai, I'm sceptical about this patch: is it something you found
by code inspection, or something you found when using mbind()?

I've not looked long enough to be certain, nor experimented, but:

mbind_range() is only one stage of the mbind() syscall implementation,
and is preceded by queue_pages_range(): look what queue_pages_test_walk()
does when MPOL_MF_DISCONTIG_OK not set.

My impression is that mbind_range() is merely correcting an omission
from the checks already made my queue_pages_test_walk() (an odd way
to proceed, I admit: would be better to check initially than later).

I do think that you should not make this change without considering
MPOL_MF_DISCONTIG_OK and its intention.

Hugh

> > ---
> > 
> >  mm/mempolicy.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > 
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 4ae967bcf954..ae160d9936d9 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -738,7 +738,7 @@ static int mbind_range(struct mm_struct *mm, unsigned long start,
> >         unsigned long vmend;
> >  
> >         vma = find_vma(mm, start);
> > -       if (!vma || vma->vm_start > start)
> > +       if (!vma || vma->vm_start >= end)
> >                 return -EFAULT;
> >  
> >         prev = vma->vm_prev;
> > 
