Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDEFD58EBB
	for <lists+linux-api@lfdr.de>; Fri, 28 Jun 2019 01:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfF0XrB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 27 Jun 2019 19:47:01 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43457 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfF0XrA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 27 Jun 2019 19:47:00 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so1983107pfg.10;
        Thu, 27 Jun 2019 16:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tqaLuK1L6bNY5cuzUVYngg+bgb4Q6R92tXoWTRxzMkI=;
        b=iIbAJ0+HhXrBNS1hsYpHT5C8buG1Mj/g0OAh2U5znFpi+186BSN2teqxdBdTVnG77F
         kdmHZoJFZTmnQcuWpqWSsFQ7aV3JXDpLk2CMUhfdtzimCljVRwmrNReQEth9UZ8hLlJp
         muc1DByzKkRp7dKSApxi5Ni4p2ChvaDByCNBv13j548c+icCoMjfhS6Oh6rl/Va/KCvB
         p7mes9TkQtNb26gesa/N8zHNnrTaGRRtgvjKTr8VcKGMHdr9h7HjZ8ueQi7wmBRV1PcN
         ftvXHt1qCDylmsN++jRgEpNLeXmJCPojhhNR7rTKPKAbVkaC2ruAdiG9DIyM+OD2/SQe
         cBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tqaLuK1L6bNY5cuzUVYngg+bgb4Q6R92tXoWTRxzMkI=;
        b=UFKKbcbLZZiF2L9XEEotHqvtRaBNfa6I/MyRUjb4KTpRVoo29pIC5o0cn08koxaB+3
         KLpX3bAZbW74rWCpyOAfBfmyfHcaUpo/78s/3Ge77M+hWoL4xYCJ0qKto8vCz4tYvUbW
         cSKBkd4gtGzHskKOegW93DXTR6fE51H3QDco3VmmaDZtKbG8+P0QFeVlN6gA/GCVC1aP
         I+Tr0dPkJENc/sO2uR5ifT1c7rEJzhXW5nvxcFShnSLT0GaF8PFwsc1daEuK3iGzndl/
         od2C99znnL77hAnV/tbDm3rFt7l5Zo6CHATWldfX44zb8F/eFFFhNXhJdFCwFon9yXPZ
         QLDw==
X-Gm-Message-State: APjAAAUKs8t2uojgx6EQVyRY7NRNfQKDxfTNvvPhqb35hlm3xJ07ZSae
        eVczhZPVDJouUzA73R2VIu4=
X-Google-Smtp-Source: APXvYqzpbRDUIvQ5FKcZ778NrsrMCXHQoQCWNiYvEEW/PsDymyV52tRB/FTO9qLcw1VQh1WcXNh5Cg==
X-Received: by 2002:a17:90a:9bc5:: with SMTP id b5mr9330442pjw.109.1561679220004;
        Thu, 27 Jun 2019 16:47:00 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id e6sm197854pfn.71.2019.06.27.16.46.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 16:46:58 -0700 (PDT)
Date:   Fri, 28 Jun 2019 08:46:52 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>, oleksandr@redhat.com,
        hdanton@sina.com, lizeb@google.com,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v3 1/5] mm: introduce MADV_COLD
Message-ID: <20190627234652.GB33052@google.com>
References: <20190627115405.255259-1-minchan@kernel.org>
 <20190627115405.255259-2-minchan@kernel.org>
 <343599f9-3d99-b74f-1732-368e584fa5ef@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <343599f9-3d99-b74f-1732-368e584fa5ef@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jun 27, 2019 at 06:13:36AM -0700, Dave Hansen wrote:
> On 6/27/19 4:54 AM, Minchan Kim wrote:
> > This patch introduces the new MADV_COLD hint to madvise(2) syscall.
> > MADV_COLD can be used by a process to mark a memory range as not expected
> > to be used in the near future. The hint can help kernel in deciding which
> > pages to evict early during memory pressure.
> > 
> > It works for every LRU pages like MADV_[DONTNEED|FREE]. IOW, It moves
> > 
> > 	active file page -> inactive file LRU
> > 	active anon page -> inacdtive anon LRU
> 
> Is the LRU behavior part of the interface or the implementation?

It's a just implementation. What user should expect with this API is they just
informs to the kernel "this memory in the regions wouldn't access in the near
future" so how kernel will handle memory in there is up to the kernel.

> 
> I ask because we've got something in between tossing something down the
> LRU and swapping it: page migration.  Specifically, on a system with
> slower memory media (like persistent memory) we just migrate a page
> instead of discarding it at reclaim:
> 
> > https://lore.kernel.org/linux-mm/20190321200157.29678-4-keith.busch@intel.com/
> 
> So let's say I have a page I want to evict from DRAM to the next slower
> tier of memory.  Do I use MADV_COLD or MADV_PAGEOUT?  If the LRU
> behavior is part of the interface itself, then MADV_COLD doesn't work.

IMHO, if it's one of storage in the memory hierarchy, that shouldn't be transparent
for the user? What I meant is VM moves inactive pages to the persistent memory
before the reclaiming. IOW, VM would have one more level LRU or extened inactive
LRU to cover the persistent memory.

> 
> Do you think we'll need a third MADV_ flag for our automatic migration
> behavior?  MADV_REALLYCOLD?  MADV_MIGRATEOUT?

I believe it depends on how we abstract the persistent memory of cache hierarchy.
If we abstract it as diffrent storage with DRAM, manybe, that should be part of
other syscall like like move_pages. 
If we abstract it as part of DRAM, that should be part of additional LRU
or extended inactive LRU.
