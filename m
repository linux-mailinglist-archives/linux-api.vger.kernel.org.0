Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8CABE807A
	for <lists+linux-api@lfdr.de>; Tue, 29 Oct 2019 07:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732480AbfJ2GnU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 29 Oct 2019 02:43:20 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44478 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732178AbfJ2GnT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 29 Oct 2019 02:43:19 -0400
Received: by mail-lj1-f196.google.com with SMTP id c4so13947487lja.11
        for <linux-api@vger.kernel.org>; Mon, 28 Oct 2019 23:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bM2b33Z0Vnc9Ac9V0Lv2X8J2KpK569Z9KH1KOZ+JzRw=;
        b=jVcPIrlteiZGWJDhmwSW8gN61bfxRh0c3p5CvrRq2Uutn/M/Z4KjQtngvA3VJcyYc5
         YXZ9sIef7OrN7ZOqEY4PMinCMzv+/ZDzvjtyOunO2yJ5AiiX+n/5ZFCaJ13cizxGSPAK
         nXC/meNTCcJFEJQOWHU8I1gVfLdsF8M08zfxHQWTtmctMMFqDokZ7BKnkxJPhvEBuuCv
         XXvB7bzp1bHcvIo9d0gtPPU0xGWCmyzCfU8v96zVJRwhw34nxB1G0aEUG0jF9PeYa3Pu
         q/N+8F1BettsLYEHvpxfm/OKi6ulaYQn4orrNthYfuDedlZNaJNsf5PeQDZzEkjNhynU
         +pXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bM2b33Z0Vnc9Ac9V0Lv2X8J2KpK569Z9KH1KOZ+JzRw=;
        b=ZrviNBr5jUWtVl+ynmU0WFKW4BfOKLYQ9bNjz55bT7L+JeqWpxNh+q++6nR4zDllJa
         YXc1amMesrdOuuPc2c7NtRQk4hvbkK1hoYbLVIRyd4TKaMFxVib5s3kgWdFhBojFuU6R
         V95b+3eQyoAzEKBkJaNTfNw5WHh80nEecrwTQqyXGdBo6PQj+o4vOZsrY5WLjaYRj8T/
         dpebraS/uNqg8eIiRgZIuFb17vOPCvcviQJudshucZRXToFmfNvkzf4qX9JxQLqiPNWv
         OGyrArWY/TbdRmXPliI+LLJfyJ83dDKzL/Y8y82l3ya4UnuZVYrv7l8IUfsVnJxVGIls
         WWdg==
X-Gm-Message-State: APjAAAVbsPrG+oJ2NrMnK+p3Uqip85O4CoqZFPoPz3lFTZPk789PCKXk
        wOJRCR9nfkYtbl0X27otw3ehTg==
X-Google-Smtp-Source: APXvYqwKHj+2KaZDa+IJmFG2XN6Sn+iey7LdWii3xyIneSuZVP1c5fnFP+Blz2pSi0VQXRfu6gnkUQ==
X-Received: by 2002:a05:651c:1ae:: with SMTP id c14mr1087381ljn.135.1572331396587;
        Mon, 28 Oct 2019 23:43:16 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q14sm6700067ljc.7.2019.10.28.23.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 23:43:15 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 2E0A9100402; Tue, 29 Oct 2019 09:43:18 +0300 (+03)
Date:   Tue, 29 Oct 2019 09:43:18 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user
 mappings
Message-ID: <20191029064318.s4n4gidlfjun3d47@box>
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
 <1572171452-7958-2-git-send-email-rppt@kernel.org>
 <20191028123124.ogkk5ogjlamvwc2s@box>
 <20191028130018.GA7192@rapoport-lnx>
 <20191028131623.zwuwguhm4v4s5imh@box>
 <CAA9_cmd7f2y2AAT6646S=tco3yfyLgCAC4Qp=1iTQaJqrQcOwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA9_cmd7f2y2AAT6646S=tco3yfyLgCAC4Qp=1iTQaJqrQcOwQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Oct 28, 2019 at 10:43:51PM -0700, Dan Williams wrote:
> On Mon, Oct 28, 2019 at 6:16 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > On Mon, Oct 28, 2019 at 02:00:19PM +0100, Mike Rapoport wrote:
> > > On Mon, Oct 28, 2019 at 03:31:24PM +0300, Kirill A. Shutemov wrote:
> > > > On Sun, Oct 27, 2019 at 12:17:32PM +0200, Mike Rapoport wrote:
> > > > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > > >
> > > > > The mappings created with MAP_EXCLUSIVE are visible only in the context of
> > > > > the owning process and can be used by applications to store secret
> > > > > information that will not be visible not only to other processes but to the
> > > > > kernel as well.
> > > > >
> > > > > The pages in these mappings are removed from the kernel direct map and
> > > > > marked with PG_user_exclusive flag. When the exclusive area is unmapped,
> > > > > the pages are mapped back into the direct map.
> > > >
> > > > I probably blind, but I don't see where you manipulate direct map...
> > >
> > > __get_user_pages() calls __set_page_user_exclusive() which in turn calls
> > > set_direct_map_invalid_noflush() that makes the page not present.
> >
> > Ah. okay.
> >
> > I think active use of this feature will lead to performance degradation of
> > the system with time.
> >
> > Setting a single 4k page non-present in the direct mapping will require
> > splitting 2M or 1G page we usually map direct mapping with. And it's one
> > way road. We don't have any mechanism to map the memory with huge page
> > again after the application has freed the page.
> >
> > It might be okay if all these pages cluster together, but I don't think we
> > have a way to achieve it easily.
> 
> Still, it would be worth exploring what that would look like if not
> for MAP_EXCLUSIVE then set_mce_nospec() that wants to punch out poison
> pages from the direct map. In the case of pmem, where those pages are
> able to be repaired, it would be nice to also repair the mapping
> granularity of the direct map.

The solution has to consist of two parts: finding a range to collapse and
actually collapsing the range into a huge page.

Finding the collapsible range will likely require background scanning of
the direct mapping as we do for THP with khugepaged. It should not too
hard, but likely require long and tedious tuning to be effective, but not
too disturbing for the system.

Alternatively, after any changes to the direct mapping, we can initiate
checking if the range is collapsible. Up to 1G around the changed 4k.
It might be more taxing than scanning if direct mapping changes often.

Collapsing itself appears to be simple: re-check if the range is
collapsible under the lock, replace the page table with the huge page and
flush the TLB.

But some CPUs don't like to have two TLB entries for the same memory with
different sizes at the same time. See for instance AMD erratum 383.

Getting it right would require making the range not present, flush TLB and
only then install huge page. That's what we do for userspace.

It will not fly for the direct mapping. There is no reasonable way to
exclude other CPU from accessing the range while it's not present (call
stop_machine()? :P). Moreover, the range may contain the code that doing
the collapse or data required for it...

BTW, looks like current __split_large_page() in pageattr.c is susceptible
to the errata. Maybe we can get away with the easy way...

-- 
 Kirill A. Shutemov
