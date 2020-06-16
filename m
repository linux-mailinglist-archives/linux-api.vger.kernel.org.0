Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312A11FBE1E
	for <lists+linux-api@lfdr.de>; Tue, 16 Jun 2020 20:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgFPSfu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Jun 2020 14:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgFPSft (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 16 Jun 2020 14:35:49 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4C4C061573
        for <linux-api@vger.kernel.org>; Tue, 16 Jun 2020 11:35:48 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id v24so8763252plo.6
        for <linux-api@vger.kernel.org>; Tue, 16 Jun 2020 11:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gv5SyNbN+YalOOMpT+lUR6zrSKOxyXFsPO4eN2yYyhE=;
        b=AIBG74jGGwjgO6WBXM4vpHq8cFCM4p4Psqbxkb87Jqwbz68+d4zZle3XICqvnmKg9t
         6G7DW5BrZDAeXEvDllsiq4n65S1+BsdnQf1eWYTN7zFu4VjIZ8MlVpW5fEDEMrw8tSVT
         uUCSHHX4FBSHO1H3yJ7TrYinRqzogRKaDRzI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gv5SyNbN+YalOOMpT+lUR6zrSKOxyXFsPO4eN2yYyhE=;
        b=fuobHIwUxbmBchLWfQwsQhdp7DNfJvzP3nJAiAcETcJD82PhnVKNajYJSiwKRWtW2+
         +L3/+Hycb61gEkYS80+0UbOKvvsNg5l+Cxj0hAItKM43iH0LxEZJDNExWivFMELxP7xf
         gkXF2TkPCMW2erNW3K90Z5wtOeOtPZom123q9B6XzRF0s2AMMIr4irTSgkWPByxt2sIh
         dPFYdENYADfQA5INCnEU8aUcLMqVjVH+yi/L++OyxXm1dJud4olMQSDloxWHXUJqLQyt
         4EMsBIeBx0pQtmiOXUmUOXc0FA0tf/lFkdzd1gsUUoC+AUHvz35jNAHgiz65ZK3MIQNN
         gwlg==
X-Gm-Message-State: AOAM531rkqfVO7hICKnq6OxrNxkyi4VqpBqkyBrj8GEEgvTLRUNwtQCH
        BO9MV7+D8pF5w9sv7VrpmYm1oA==
X-Google-Smtp-Source: ABdhPJyorPz/hN0z0htsbMGKXDwxSMUZOCNVD6vqJvCbF6cB9/KRHU4TiB0xlr8glLU8oty9rAKq5w==
X-Received: by 2002:a17:902:201:: with SMTP id 1mr3268685plc.195.1592332548117;
        Tue, 16 Jun 2020 11:35:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d184sm7822774pfd.85.2020.06.16.11.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 11:35:47 -0700 (PDT)
Date:   Tue, 16 Jun 2020 11:35:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Sargun Dhillon <sargun@sargun.me>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        "zhujianwei (C)" <zhujianwei7@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Hehuazhen <hehuazhen@huawei.com>, X86 ML <x86@kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [RFC][PATCH 0/8] seccomp: Implement constant action bitmaps
Message-ID: <202006161131.5A21C01@keescook>
References: <20200616074934.1600036-1-keescook@chromium.org>
 <CALCETrVLA22khom-iSu5iTJGKfUykOnwyz8j7Tm9g6hWW_e0Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVLA22khom-iSu5iTJGKfUykOnwyz8j7Tm9g6hWW_e0Aw@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jun 16, 2020 at 10:01:43AM -0700, Andy Lutomirski wrote:
> On Tue, Jun 16, 2020 at 12:49 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > Hi,
> >
> 
> > In order to build this mapping at filter attach time, each filter is
> > executed for every syscall (under each possible architecture), and
> > checked for any accesses of struct seccomp_data that are not the "arch"
> > nor "nr" (syscall) members. If only "arch" and "nr" are examined, then
> > there is a constant mapping for that syscall, and bitmaps can be updated
> > accordingly. If any accesses happen outside of those struct members,
> > seccomp must not bypass filter execution for that syscall, since program
> > state will be used to determine filter action result.
> 
> >
> > During syscall action probing, in order to determine whether other members
> > of struct seccomp_data are being accessed during a filter execution,
> > the struct is placed across a page boundary with the "arch" and "nr"
> > members in the first page, and everything else in the second page. The
> > "page accessed" flag is cleared in the second page's PTE, and the filter
> > is run. If the "page accessed" flag appears as set after running the
> > filter, we can determine that the filter looked beyond the "arch" and
> > "nr" members, and exclude that syscall from the constant action bitmaps.
> 
> This is... evil.  I don't know how I feel about it.  It's also

Thank you! ;)

> potentially quite slow.

I got the impression that (worst-case: a "full" filter for every
arch/syscall combo) ~900 _local_ TLB flushes per filter attach wouldn't be
very slow at all. (And the code is optimized to avoid needless flushes.)

> I don't suppose you could, instead, instrument the BPF code to get at
> this without TLB hackery?  Or maybe try to do some real symbolic
> execution of the BPF code?

I think the "simple emulator" path[1] might get us a realistically large
coverage. I'm going to try it out, and see what it looks like.

-Kees

[1] https://lore.kernel.org/lkml/202006160757.99FD9B785@keescook/

-- 
Kees Cook
