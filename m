Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 330B1EB965
	for <lists+linux-api@lfdr.de>; Thu, 31 Oct 2019 22:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbfJaVw7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 31 Oct 2019 17:52:59 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46667 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729018AbfJaVw7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 31 Oct 2019 17:52:59 -0400
Received: by mail-io1-f68.google.com with SMTP id c6so8501791ioo.13;
        Thu, 31 Oct 2019 14:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S6nzwdV69bS3qMmnYiEeOyRFqJ5MsMzJLi/ghgWFyCk=;
        b=QH4xISMARBbOmmD3a9sgevwM4oEP3QBvRNmTOkMVYDdAKztdrYBiftDBJKA0Vzldim
         02CjCPjP7ff7F/zqEeXFSTQ43DmYwvd4owfRWPEL28BYSnw6QBnx1uXHY3ZQfH8+h1hQ
         jA7qdGHxzHXoz/fKWM2xzzGWqVQvKy/cp82yCB6I4dMUGs8aghFdymxrCW2FaMa/Kpme
         5W7k3/vmCV0gi/sSh/qE01UlCsWWp5xLa2uOzNCs+irygA64lpLzQwsNhw64u017X4Bt
         WDqwrayYdr3GjBsa49HTeGcGx2QQWX1DXM3UEXjl1pA1CLnzlj7qlloaeGXzaCfrWac4
         h2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S6nzwdV69bS3qMmnYiEeOyRFqJ5MsMzJLi/ghgWFyCk=;
        b=mzfujrVPFPoHyE7kqdMMEvQ6h2QoLFq+YdYhUeEptpXUtf3prsLknIZ7wuSnY3VQ3t
         knI4ILdw0fYILMdoF1OhsPVtBM4yGKgSaxTKKs9Q4qWvJDyFhuu1EnWivFJ2hWg/u8j3
         EkBy48JYcrmB5g4/u6O9xFAQFGUwpvHWN5zxNP3L/HjvepPeOrKe7316BvTjDH98Jf8W
         1dxLQa5a+vUtqAo4qVgVLobxQjVZhqAGYEocdnOVYdBnXtQDNQmDBZlsxz1Ef/2aLlLy
         9yyLTaIKR85asDIN1jS8SSfc07qTPv94i1abZKN929xQrppi+egnBwKxLJHTEEYVApgi
         fw+A==
X-Gm-Message-State: APjAAAUi5eWh8fjv6TcahOv5NCdvjv64DF1rUqEXT+/PrV5CGVLRQ24N
        0UajAOe/fb989dOOz7yDOSxEAULrSzmbIixsYzk=
X-Google-Smtp-Source: APXvYqw1GGuyhktv3L0CWRwAE5jFdB3YHTBZ/G3in7KXjy4nSlz8MqaOjQ1BkXcRJhHFs83nIz1yDhXZBSuI2dNiaZg=
X-Received: by 2002:a02:330e:: with SMTP id c14mr1725697jae.5.1572558778301;
 Thu, 31 Oct 2019 14:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
 <1572171452-7958-2-git-send-email-rppt@kernel.org> <085ed07e-e646-f7a4-0370-06f33a2a4e4a@redhat.com>
 <20191030081529.GB20624@rapoport-lnx> <9eae3941-64cf-4ea1-0287-0e64bab192c6@redhat.com>
 <20191031191651.GA26165@rapoport-lnx>
In-Reply-To: <20191031191651.GA26165@rapoport-lnx>
From:   Dan Williams <dan.j.williams@gmail.com>
Date:   Thu, 31 Oct 2019 14:52:46 -0700
Message-ID: <CAA9_cmdCmiu5wVs=Jo4c6VNw6N1raPTDXg4d9OuUj3w0+e5JHQ@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user mappings
To:     Mike Rapoport <rppt@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
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

On Thu, Oct 31, 2019 at 12:17 PM Mike Rapoport <rppt@kernel.org> wrote:
>
> On Wed, Oct 30, 2019 at 09:19:33AM +0100, David Hildenbrand wrote:
> > On 30.10.19 09:15, Mike Rapoport wrote:
> > >On Tue, Oct 29, 2019 at 12:02:34PM +0100, David Hildenbrand wrote:
> > >>On 27.10.19 11:17, Mike Rapoport wrote:
> > >>>From: Mike Rapoport <rppt@linux.ibm.com>
> > >>>
> > >>>The mappings created with MAP_EXCLUSIVE are visible only in the context of
> > >>>the owning process and can be used by applications to store secret
> > >>>information that will not be visible not only to other processes but to the
> > >>>kernel as well.
> > >>>
> > >>>The pages in these mappings are removed from the kernel direct map and
> > >>>marked with PG_user_exclusive flag. When the exclusive area is unmapped,
> > >>>the pages are mapped back into the direct map.
> > >>>
> > >>
> > >>Just a thought, the kernel is still able to indirectly read the contents of
> > >>these pages by doing a kdump from kexec environment, right?
> > >
> > >Right.
> > >
> > >>Also, I wonder
> > >>what would happen if you map such pages via /dev/mem into another user space
> > >>application and e.g., use them along with kvm [1].
> > >
> > >Do you mean that one application creates MAP_EXCLUSIVE and another
> > >applications accesses the same physical pages via /dev/mem?
> >
> > Exactly.
> >
> > >
> > >With /dev/mem all physical memory is visible...
> >
> > Okay, so the statement "information that will not be visible not only to
> > other processes but to the kernel as well" is not correct. There are easy
> > ways to access that information if you really want to (might require root
> > permissions, though).
>
> Right, but /dev/mem is an easy way to extract any information in any
> environment if one has root permissions...
>

I don't understand this concern with /dev/mem. Just add these pages to
the growing list of the things /dev/mem is not allowed to touch.
