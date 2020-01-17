Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24CB014094B
	for <lists+linux-api@lfdr.de>; Fri, 17 Jan 2020 12:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgAQLw3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 17 Jan 2020 06:52:29 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35405 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbgAQLw3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 17 Jan 2020 06:52:29 -0500
Received: by mail-wr1-f68.google.com with SMTP id g17so22397452wro.2;
        Fri, 17 Jan 2020 03:52:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CfaMrw+TYdEFJRwNODCdrVm4OOMZyFpQ0nkjoCPs5oc=;
        b=joiWYM23dUV5fRgLneE6DZ+1UH/i4alcTSHI7MiV4iZNn1nDf5MPxofqkdHbJAfyyH
         3FvHBuS0gfu/qRxN8OU9/ERnrT/HL7ip7tMd12l9xbRiVspPzGLO4NA8j190fddtSjYy
         6uhJVgn0z+0NNy0O37oqOFAzcDyVMsplAbxsB5uXxAwTwMm/T6S7CR3tuuPj3AKwoXkV
         CGQjnGr8wPWHzJbg0cqfABPwdAWMFviZJQWHtfZwYQVEkymAUBYYHFGADhsuDVYclSkG
         pxWlrnbpeuujcAzMhE2PEP8f6MF37KAIeTd90C0GMHUk9tb1dpEW5eUEUE/960fteYuy
         qP0A==
X-Gm-Message-State: APjAAAWVNGcsfDDPZkxE40LsCXBFGSvJYsJqscLy5/MYwU/7JNcNpmuh
        weCVE3LHcPofQfva6qKw0/s=
X-Google-Smtp-Source: APXvYqyFPhokZ7VGCqtGBvrGiYujSUt2mcWg7TDf/fiD867pU8zDvypUZ/CFGECXxUvRKPCo1tfbgw==
X-Received: by 2002:a5d:6a83:: with SMTP id s3mr2496048wru.99.1579261946860;
        Fri, 17 Jan 2020 03:52:26 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id k13sm33558283wrx.59.2020.01.17.03.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 03:52:26 -0800 (PST)
Date:   Fri, 17 Jan 2020 12:52:25 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        John Dias <joaodias@google.com>, ktkhai@virtuozzo.com,
        christian.brauner@ubuntu.com, sjpark@amazon.de
Subject: Re: [PATCH v2 2/5] mm: introduce external memory hinting API
Message-ID: <20200117115225.GV19428@dhcp22.suse.cz>
References: <20200116235953.163318-1-minchan@kernel.org>
 <20200116235953.163318-3-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116235953.163318-3-minchan@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu 16-01-20 15:59:50, Minchan Kim wrote:
> There is usecase that System Management Software(SMS) want to give
> a memory hint like MADV_[COLD|PAGEEOUT] to other processes and
> in the case of Android, it is the ActivityManagerService.
> 
> It's similar in spirit to madvise(MADV_WONTNEED), but the information
> required to make the reclaim decision is not known to the app. Instead,
> it is known to the centralized userspace daemon(ActivityManagerService),
> and that daemon must be able to initiate reclaim on its own without
> any app involvement.
> 
> To solve the issue, this patch introduces new syscall process_madvise(2).
> It uses pidfd of an external processs to give the hint.
> 
>  int process_madvise(int pidfd, void *addr, size_t length, int advise,
> 			unsigned long flag);
> 
> Since it could affect other process's address range, only privileged
> process(CAP_SYS_PTRACE) or something else(e.g., being the same UID)
> gives it the right to ptrace the process could use it successfully.
> The flag argument is reserved for future use if we need to extend the
> API.
> 
> I think supporting all hints madvise has/will supported/support to
> process_madvise is rather risky. Because we are not sure all hints make
> sense from external process and implementation for the hint may rely on
> the caller being in the current context so it could be error-prone.
> Thus, I just limited hints as MADV_[COLD|PAGEOUT] in this patch.
> 
> If someone want to add other hints, we could hear hear the usecase and
> review it for each hint. It's more safe for maintainace rather than
> introducing a buggy syscall but hard to fix it later.

I have brought this up when we discussed this in the past but there is
no reflection on that here so let me bring that up again. 

I believe that the interface has an inherent problem that it is racy.
The external entity needs to know the address space layout of the target
process to do anyhing useful on it. The address space is however under
the full control of the target process though and the external entity
has no means to find out that the layout has changed. So
time-to-check-time-to-act is an inherent problem.

This is a serious design flaw and it should be explained why it doesn't
matter or how to use the interface properly to prevent that problem.
-- 
Michal Hocko
SUSE Labs
