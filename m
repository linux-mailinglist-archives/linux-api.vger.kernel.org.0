Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5B8F166687
	for <lists+linux-api@lfdr.de>; Thu, 20 Feb 2020 19:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgBTSqO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Feb 2020 13:46:14 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45671 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbgBTSqO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Feb 2020 13:46:14 -0500
Received: by mail-ed1-f68.google.com with SMTP id v28so34908221edw.12
        for <linux-api@vger.kernel.org>; Thu, 20 Feb 2020 10:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3pzTOf6vYrNpBzwrv5P8vGUEMGl4yTghrNTGfR5M7Oc=;
        b=t/iabB7zJkaoluyOjIOJfc2zOAmtCMc0F/y/TF2fj7jW83AkZqMCidXI1cWAbd1seh
         NrPIkCTa7wgPP3M5+5W4Nd8wCviO86LJDU/66mUTKdZUNRZSGcNC+WNlPLabRaKp4SR+
         orsRRi/sfSaMIAGI3SoDi7MDtWF06zukVhMxyMS8/yfYakd+jGja2CyT12U5oXkmI8sN
         z5jMtx62wuJh4j4W5bIO2P70wW6bBQ278/BBWp++v1TyluKJlkdg9fCLT1VNOntUyF2q
         Dp4wBg6EPgY/049JRWKGl3hU5FeH12hRn285BsTec8q28s4O1DhJH6apj0UVzQYbrXgZ
         AeHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3pzTOf6vYrNpBzwrv5P8vGUEMGl4yTghrNTGfR5M7Oc=;
        b=SMJcr0nEWaC/gJ0nx5iSS6BG9bHIdKRufRD5bJjCkXswKBYiy/KsYN5DycPL4VqvbN
         Kahu0kta6C+o9t9NXxmvToz4YcbuFcCo9XKETaDzx70ViCcDtGGHGbkA04xV2HgBbpQn
         8/Li8Twzw4j3ztMQ5ZrsNrnDHfn9zCtakc2XsrXr0Diy01y7grcFx8esZ1h5Cxr3x8qS
         042z3SPyKdvYYWsN3AxeioAEXbNiKPj/E3PqvAa+M0JNNqBF2Z2/PtfKJWXkke0DtbgS
         lpM/B48vPJfRGE0XuiC1jiJRQ3GEez/d+amZljIXR4zRYdlNQZsan+oSXPNQD0b4hqEZ
         VKhQ==
X-Gm-Message-State: APjAAAW4KSQoMqZy3gmEg4/i4kYaDjzqiZNjVXFLzdijDM1gseYsrWTh
        yR9V1vE6YdT+ZBXlHbMBmyqPvdSylIAOVy1VKHGjAw==
X-Google-Smtp-Source: APXvYqxLLjMlzm9n1gTBdsGBP2Dd4mIMoNz+RxUJ/scsjYrcKm8cv5eKltlsAg/aIqFp91+eAChxVZYEb3UQBPTKYf4=
X-Received: by 2002:a17:906:1e48:: with SMTP id i8mr28875694ejj.189.1582224370598;
 Thu, 20 Feb 2020 10:46:10 -0800 (PST)
MIME-Version: 1.0
References: <20200218173221.237674-1-bgeffon@google.com> <20200220171554.GA44866@google.com>
 <CADyq12zUEq9kcyuR_Qm9MrU1ii-+9n8T2hK6QNzj=kH5zn0VrA@mail.gmail.com>
In-Reply-To: <CADyq12zUEq9kcyuR_Qm9MrU1ii-+9n8T2hK6QNzj=kH5zn0VrA@mail.gmail.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Thu, 20 Feb 2020 10:45:44 -0800
Message-ID: <CADyq12xz-g1geCBE5ie+Uffvp1YAgdsVq1yjQGydu=AZH-FxGA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] mm: Add MREMAP_DONTUNMAP to mremap().
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
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

Sorry I should clarify that this is the behavior with MREMAP_FIXED is
used, and to expand on that, it would potentially even have unmapped
the region at the destination address and then fail in vma_to_resize
too, so I hope that explains why that check landed there. But should
these situations be considered a bug?

Brian

On Thu, Feb 20, 2020 at 10:36 AM Brian Geffon <bgeffon@google.com> wrote:
>
> Hi Minchan,
>
> > And here we got error if the addr is in non-anonymous-private vma so the
> > syscall will fail but old vma is gone? I guess it's not your intention?
>
> This is exactly what happens today in several situations, because
> vma_to_resize is called unconditionally. For example if the old vma
> has VM_HUGETLB and old_len < new_len it would have unmapped a portion
> and then in vma_to_resize returned -EINVAL, similarly when old_len = 0
> with a non-sharable mapping it will have called do_munmap only to fail
> in vma_to_resize, if the vma has VM_DONTEXPAND set and you shrink the
> size with old_len < new_len it would return -EFAULT after having done
> the unmap on the decreased portion. So I followed the pattern to keep
> the change simple and maintain consistency with existing behavior.
>
> But with that being said, Kirill made the point that resizing a VMA
> while also using MREMAP_DONTUNMAP doesn't have any clear use case and
> I agree with that, I'm unable to think of a situation where you'd want
> to resize a VMA and use MREMAP_DONTUNMAP. So I'm tempted to mail a new
> version which returns -EINVAL if old_len != new_len that would resolve
> this concern here as nothing would be unmapped ever at the old
> position add it would clean up the change to very few lines of code.
>
> What do you think?
>
> Thank you for taking the time to review.
>
> Brian
