Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAAF8147161
	for <lists+linux-api@lfdr.de>; Thu, 23 Jan 2020 20:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgAWTEP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 23 Jan 2020 14:04:15 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36552 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbgAWTEM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 23 Jan 2020 14:04:12 -0500
Received: by mail-ed1-f67.google.com with SMTP id j17so4462749edp.3
        for <linux-api@vger.kernel.org>; Thu, 23 Jan 2020 11:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HbVZOQvmDLYul0lKSvQQMmCFWhXIMyG0jD9qHeDuze0=;
        b=UlikmW0lzuBMSt5Oc/ZFq3MNhzsCt5bC0Aba93HdKIJCtCGnlHvWPekf5GiVNW6lIV
         iGlx/8rBEIvVjU2KGoUFrUuHmLyC6YnTYhk60424Tp2gjjHOaReX4D3vxtXY9fg1mc43
         ZhsbXm6qygilUWFEdsgbkFOUA1s7ZgfSduXUB99GvqzGBsXeYFUSupq7AwVzhels6MOb
         S1Ulo8jVifExSZG3UToV6XVlRQXpc0p37UqCNyAMyFT7zZ8jLIA0/p0Hxv/G/11lpYLK
         VYJTfoi9D32v4+h+DBR9Lc3zlZkici+0e3OXmrK3DV6cBhYD51Iwl39qfDvluakamOH9
         o3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HbVZOQvmDLYul0lKSvQQMmCFWhXIMyG0jD9qHeDuze0=;
        b=TwGFLb+0h0MJcS7bq48qc9YGGEacVQf1Kqp8HgUoUemvPREz/5BZF5lsPoXpC1/xtY
         t3GE0at08VSY/01UA8fDZzcb2/5pNVHupbrkVL6oE2wYEohA52/dlNnHbbXXe2FcbeIS
         jyma6R9nXcwxiEXuzG3upOny+0d8ZBaylNBEaR5muSOvqOzyKKpvEgnR1Xawuz0bb6PI
         9sz/XXgKQ0eqxsTmoDkGqCd9RxYoQI9XGp1GvG4H1XRAkmZQXn+rmioBKHyWA5IK1hjD
         CY5bz25Jzo314GU42ZqxEPMaJFKAu+zegafVQGZzARC831DnE2anhZ2itJDikAUpOzXm
         mluw==
X-Gm-Message-State: APjAAAUJu14/8o6nipOZIlfMmCly0cQSQn5Whmxlho+YqKtOC/sfbqLn
        80/Nmwy0HqeYp1aL3dsp8WEL72jigyMy99CWrWdpYA==
X-Google-Smtp-Source: APXvYqz+g3XsKBoe1r6awz5wE3JqrkD3YD2kS/0bT9IOZn+i4OcdPU8HSsrlwBCCkON0WX50n+lqkzFTeklQPIQpxMY=
X-Received: by 2002:a17:906:1e48:: with SMTP id i8mr7637324ejj.189.1579806250136;
 Thu, 23 Jan 2020 11:04:10 -0800 (PST)
MIME-Version: 1.0
References: <20200123014627.71720-1-bgeffon@google.com> <CD5EA896-7364-40E2-8709-A014973FFBC8@amacapital.net>
In-Reply-To: <CD5EA896-7364-40E2-8709-A014973FFBC8@amacapital.net>
From:   Brian Geffon <bgeffon@google.com>
Date:   Thu, 23 Jan 2020 11:03:44 -0800
Message-ID: <CADyq12zvTnCtkBjDZjj_dQHapFYuTh=W=KXCEa9Hy5M9DXpugg@mail.gmail.com>
Subject: Re: [PATCH] mm: Add MREMAP_DONTUNMAP to mremap().
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>, Jesse Barnes <jsbarnes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Andy,

Thanks, yes, that's a much clearer description of the feature. I'll
make sure to update the description with subsequent patches and with
later man page updates.

Brian

On Wed, Jan 22, 2020 at 7:02 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
>
>
>
> > On Jan 22, 2020, at 5:46 PM, Brian Geffon <bgeffon@google.com> wrote:
> >
> > =EF=BB=BFMREMAP_DONTUNMAP is an additional flag that can be used with
> > MREMAP_FIXED to move a mapping to a new address. Normally, mremap(2)
> > would then tear down the old vma so subsequent accesses to the vma
> > cause a segfault. However, with this new flag it will keep the old
> > vma with zapping PTEs so any access to the old VMA after that point
> > will result in a pagefault.
>
> This needs a vastly better description. Perhaps:
>
> When remapping an anonymous, private mapping, if MREMAP_DONTUNMAP is set,=
 the source mapping will not be removed. Instead it will be cleared as if a=
 brand new anonymous, private mapping had been created atomically as part o=
f the mremap() call.  If a userfaultfd was watching the source, it will con=
tinue to watch the new mapping.  For a mapping that is shared or not anonym=
ous, MREMAP_DONTUNMAP will cause the mremap() call to fail.
>
> Or is it something else?
>
> >
> > This feature will find a use in ChromeOS along with userfaultfd.
> > Specifically we will want to register a VMA with userfaultfd and then
> > pull it out from under a running process. By using MREMAP_DONTUNMAP we
> > don't have to worry about mprotecting and then potentially racing with
> > VMA permission changes from a running process.
>
> Does this mean you yank it out but you want to replace it simultaneously?
>
> >
> > This feature also has a use case in Android, Lokesh Gidra has said
> > that "As part of using userfaultfd for GC, We'll have to move the physi=
cal
> > pages of the java heap to a separate location. For this purpose mremap
> > will be used. Without the MREMAP_DONTUNMAP flag, when I mremap the java
> > heap, its virtual mapping will be removed as well. Therefore, we'll
> > require performing mmap immediately after. This is not only time consum=
ing
> > but also opens a time window where a native thread may call mmap and
> > reserve the java heap's address range for its own usage. This flag
> > solves the problem."
>
> Cute.
