Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5C65E7FCF
	for <lists+linux-api@lfdr.de>; Tue, 29 Oct 2019 06:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731851AbfJ2FoD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 29 Oct 2019 01:44:03 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38458 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732037AbfJ2FoD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 29 Oct 2019 01:44:03 -0400
Received: by mail-io1-f68.google.com with SMTP id u8so13432277iom.5;
        Mon, 28 Oct 2019 22:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TwIi5AOjL+xogOCvS6bHBwjeQf/wLwbiipgSMMh0034=;
        b=KNzW/V7sWJosoX1Wgya+9xFpsAsFfo6DDBqfmWMNyaScGVynI6XSo7d+lwmrMWZxZL
         DvRnMNBLvZ0EHRASZudom7+529D69Ioa/0D7baXzLTNV1FPTwLomqDyT/QmJcxb5Du1U
         NSTkEadBjUQMLQPVj82sdWfYNZOwCSsWTG+L0Qx8obhz7U70EuP25ilO3ICo4oNGcrO3
         sP0elWbXJEHp6oYJxQSMdD7e5pm22CHlDhcBkpOgjJK1GmkKT8A2loNgtllFUY87GsSZ
         jNGDO3LVk14ot8lzEpFm3D45nS/xqU+HmDNj9xCjAxZlph83JhmRRF+2rMkfYu3bGp43
         DIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TwIi5AOjL+xogOCvS6bHBwjeQf/wLwbiipgSMMh0034=;
        b=Hr3UfIUxeJkkUpxdoby5qlofCYoaIbUG2I+JbBiQ5BlzoQUCSo77oisL0Pd74CcT+i
         mO9aJIpzkdZ+ZugckyBTsLP4MV3YTw5eS6IUvytclS5Q1jLZ1mBK2RHIa1QtapvTyeMI
         pqzAFx1UaCyUh6jN+iPieDwWpYqyn9XztA8SZ4SufGoVvakXQvlE1qWhNn+GxayyXJyW
         xNbdD669PYV8h6Dy6124t01FrLCUwDqY0UrpsWE8d3ftyNvoemHCtOsMheaHXuP1elxx
         RGZ5+KOVAyT9Rve/ofL60VOlq8YOr1AVl78jP16KZJEcDrq7Bbvl3blmL2IoQTu4lr8o
         DSVw==
X-Gm-Message-State: APjAAAVwArOFtn5/ntqbW7vD7SWZhdGg6IllHeFj5qkXr1olUluN9gzs
        73rX7B1eQBy0S1b5wQiEJ1YcFR8vOmx0mZHu7Zg=
X-Google-Smtp-Source: APXvYqwfnx5VqN5e72dkTUgm4SNDz5ZOunVAy0hTGiBY9L2ixHUF+ZWjMafnA/vc/o+iuu7rYO8ulvkWS150jm+d+Kc=
X-Received: by 2002:a5d:9b83:: with SMTP id r3mr1724580iom.5.1572327842597;
 Mon, 28 Oct 2019 22:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
 <1572171452-7958-2-git-send-email-rppt@kernel.org> <20191028123124.ogkk5ogjlamvwc2s@box>
 <20191028130018.GA7192@rapoport-lnx> <20191028131623.zwuwguhm4v4s5imh@box>
In-Reply-To: <20191028131623.zwuwguhm4v4s5imh@box>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 28 Oct 2019 22:43:51 -0700
Message-ID: <CAA9_cmd7f2y2AAT6646S=tco3yfyLgCAC4Qp=1iTQaJqrQcOwQ@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user mappings
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
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
        "the arch/x86 maintainers" <x86@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Oct 28, 2019 at 6:16 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Mon, Oct 28, 2019 at 02:00:19PM +0100, Mike Rapoport wrote:
> > On Mon, Oct 28, 2019 at 03:31:24PM +0300, Kirill A. Shutemov wrote:
> > > On Sun, Oct 27, 2019 at 12:17:32PM +0200, Mike Rapoport wrote:
> > > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > >
> > > > The mappings created with MAP_EXCLUSIVE are visible only in the context of
> > > > the owning process and can be used by applications to store secret
> > > > information that will not be visible not only to other processes but to the
> > > > kernel as well.
> > > >
> > > > The pages in these mappings are removed from the kernel direct map and
> > > > marked with PG_user_exclusive flag. When the exclusive area is unmapped,
> > > > the pages are mapped back into the direct map.
> > >
> > > I probably blind, but I don't see where you manipulate direct map...
> >
> > __get_user_pages() calls __set_page_user_exclusive() which in turn calls
> > set_direct_map_invalid_noflush() that makes the page not present.
>
> Ah. okay.
>
> I think active use of this feature will lead to performance degradation of
> the system with time.
>
> Setting a single 4k page non-present in the direct mapping will require
> splitting 2M or 1G page we usually map direct mapping with. And it's one
> way road. We don't have any mechanism to map the memory with huge page
> again after the application has freed the page.
>
> It might be okay if all these pages cluster together, but I don't think we
> have a way to achieve it easily.

Still, it would be worth exploring what that would look like if not
for MAP_EXCLUSIVE then set_mce_nospec() that wants to punch out poison
pages from the direct map. In the case of pmem, where those pages are
able to be repaired, it would be nice to also repair the mapping
granularity of the direct map.
