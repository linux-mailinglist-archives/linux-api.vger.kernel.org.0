Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA4E1651C0
	for <lists+linux-api@lfdr.de>; Wed, 19 Feb 2020 22:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbgBSVia (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 19 Feb 2020 16:38:30 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39564 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbgBSVia (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 19 Feb 2020 16:38:30 -0500
Received: by mail-io1-f67.google.com with SMTP id c16so2273580ioh.6
        for <linux-api@vger.kernel.org>; Wed, 19 Feb 2020 13:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BpJxLBHatawnfc/YTxNMD/ucEUM4syoJPqlp+g1Kz8Q=;
        b=ZEuMXL1FtfM73aI3r2twzf1ImxMIVuXVXsNvfr/Xv2L9cj6yOITb2an36KFoQYK665
         IV5F52dUV5ZV+lgSd5AxnM2CTVBpgWlaDa0WZx2ZxgX8eaW0ikLCNZfem6s5mEZPCoUJ
         4H+YQ6ZApf5Kd3lltfN9JAkMKrRcyK4JH4wrIfOmnuxwy8gqGBuCB16vuIgfg9e5PKpR
         gY5avyjLUFyc4drTwAq7AJGse85GPvxZ61qNJnaDh2YRGX1+lBWg20/gwJAns6dRr5+S
         0agFIbGbeSsK62DYfOdfqnEGWiKwnWpyaNVl854LdFQEOCfi+OTXPcq7Q81IGPPz7YFm
         c+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BpJxLBHatawnfc/YTxNMD/ucEUM4syoJPqlp+g1Kz8Q=;
        b=JvdOvC8U8/jkTAo1T/jiC7vJ4JiIUQFICcJfNCaWN03DAmCuPl6h2or9NL9RWf9lGc
         Jxv+idh8wZ0bQWAtByiqIdhmwO6l/ixE+pwsgJDvMt2AUHHA/Ly51xe3ZAtF7g15sqNY
         7eIy3BoVvljKWCfwVtUWFkrrruW8OpN4kxjxdgCufbRm3NWQ61dY1IUdxIqW4Z5wGLdx
         7ZvdS0EUbskKft8DGbdAFtvdeiCu4BZbbzhUPyEg1gggXT1UXUKQxkGqyYMnWS1yFKrO
         JFmt+V+SBi2p/mnbZmxaujPMYqkUkT0xQE+ozHSqj7f2/VwreVGuddHwTc6ePDq3u5sk
         L6IQ==
X-Gm-Message-State: APjAAAUy9V7C0YN5ob0dctyppOczrkmNz9UvlRLIRA41lV84vj0Z45Z0
        7T5ju3xYUquGPt4SxQdcea6/ZT6WdG0xUbpVbwUj9A==
X-Google-Smtp-Source: APXvYqwS2+y+j0s1eJlgR262ndskG+GNgdkwNc6r3zFLCDHDsMtkOVp/1i9VaZZGb4LIbmoe909gUhg90CJigN/88MM=
X-Received: by 2002:a02:780f:: with SMTP id p15mr22552578jac.91.1582148309586;
 Wed, 19 Feb 2020 13:38:29 -0800 (PST)
MIME-Version: 1.0
References: <20200218173221.237674-1-bgeffon@google.com> <20200219123955.dc97c43524d6e6ab92722650@linux-foundation.org>
In-Reply-To: <20200219123955.dc97c43524d6e6ab92722650@linux-foundation.org>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Wed, 19 Feb 2020 13:38:18 -0800
Message-ID: <CA+EESO6KCyn54hYs1dZgN5bwDi2fZGGTbgX17-XAhDw65GnaNQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] mm: Add MREMAP_DONTUNMAP to mremap().
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Brian Geffon <bgeffon@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

I've validated the change, that it works for me, through manual
testing. The android runtime changes will follow shortly.

Tested-by: Lokesh Gidra <lokeshgidra@google.com>



On Wed, Feb 19, 2020 at 12:39 PM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Tue, 18 Feb 2020 09:32:20 -0800 Brian Geffon <bgeffon@google.com> wrote:
>
> > When remapping an anonymous, private mapping, if MREMAP_DONTUNMAP is
> > set, the source mapping will not be removed. The remap operation
> > will be performed as it would have been normally by moving over the
> > page tables to the new mapping. The old vma will have any locked
> > flags cleared, have no pagetables, and any userfaultfds that were
> > watching that range will continue watching it.
> >
> > For a mapping that is shared or not anonymous, MREMAP_DONTUNMAP will cause
> > the mremap() call to fail. Because MREMAP_DONTUNMAP always results in moving
> > a VMA you MUST use the MREMAP_MAYMOVE flag. The final result is two
> > equally sized VMAs where the destination contains the PTEs of the source.
> >
> > We hope to use this in Chrome OS where with userfaultfd we could write
> > an anonymous mapping to disk without having to STOP the process or worry
> > about VMA permission changes.
> >
> > This feature also has a use case in Android, Lokesh Gidra has said
> > that "As part of using userfaultfd for GC, We'll have to move the physical
> > pages of the java heap to a separate location. For this purpose mremap
> > will be used. Without the MREMAP_DONTUNMAP flag, when I mremap the java
> > heap, its virtual mapping will be removed as well. Therefore, we'll
> > require performing mmap immediately after. This is not only time consuming
> > but also opens a time window where a native thread may call mmap and
> > reserve the java heap's address range for its own usage. This flag
> > solves the problem."
>
> Thanks.
>
> We're a bit thin on review activity on this one.  Has Lokesh been able
> to review and preferably test the code?  Are you able to identify other
> potential users?  perhaps even glibc?
