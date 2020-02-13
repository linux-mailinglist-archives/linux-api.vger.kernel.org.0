Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F95A15CA2C
	for <lists+linux-api@lfdr.de>; Thu, 13 Feb 2020 19:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgBMSVN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 13 Feb 2020 13:21:13 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46309 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgBMSVN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 13 Feb 2020 13:21:13 -0500
Received: by mail-ed1-f66.google.com with SMTP id m8so7948158edi.13
        for <linux-api@vger.kernel.org>; Thu, 13 Feb 2020 10:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ckYAtFkLGTpqFasss2Yh3sgNnvC6X5fXw2I1Fp2BCnI=;
        b=dcS6pegO12bP6j8/IxZRcJacM50FbD1iRPyqN51QsgWQuddjlR5/CEHWNuIeE9aA3J
         m7T0l7tq2/Gcod87ssIr+J94iXOhbqETJnhWbz8UtLia+BEPXix4UP2NHFcQrNy0NNoO
         I9LF6zTMEL2mdpfCuweuZ08YKBckzPkf4JAFtJlnnAIDYYqB6touDFQccxfDXWXmVo8q
         RYejfAEVD1DrZcyUxTqTcmucp6CwA+iVZuOpyRGNDZL9MWbPi47AtWH2/Il6ez6JQNv3
         u3cMYgodLRvwzyGKKU17fkEX23SDPg/uYhyBUuk3wITZPNplSPlzZU3cf8y8PHJGgCvn
         0iDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ckYAtFkLGTpqFasss2Yh3sgNnvC6X5fXw2I1Fp2BCnI=;
        b=QNoy1VW6pydejRP/GWxI2yDOsyI/t/E06ECSYhnzc7Gxnj0RjFwn1tBMkYzjVPh/IT
         9ZfBz3Yd5itaK1bn9SB8g0wpe09iSIhspFKoqzKFF+nTitU9qIXhvIPhmBqG/NEAHDEY
         R7Nt2vNMnzG9657HRmAvgnasNQnzu9e1rQyqPagBsiHg+zU3/ZeTfP/pdAdH0ghnYICX
         Jph17842iOv/KpzsINXRa/j+b+fkl5DEs17A9ryj6MTNKMt0DGnrXwLcP92lghhwRYjn
         LWodGJ8fOuDiOMTQSh/jjYtlrz+oMC0BME9fTdcyWTN5wBkSOlrZQ4r3fHhb/c+s7XH6
         IhKg==
X-Gm-Message-State: APjAAAWxlETCaZEFNA3h7e2WYZCLtFcika+ziqvCNcYLPBbzJENKsF6W
        u5Web4nMfr5rgqSEgWKHofhyvu+mPzoUMqvzb6fF5g==
X-Google-Smtp-Source: APXvYqwiJPQ8Fg+Dw3qWjh34zdXDeJrcERoGTVCIyZvCpVoBcfFB4U15IkYT3Sgub2qcfUBd9eIRuKLQ1/iNvIecqKg=
X-Received: by 2002:a17:906:4e01:: with SMTP id z1mr17455077eju.46.1581618070828;
 Thu, 13 Feb 2020 10:21:10 -0800 (PST)
MIME-Version: 1.0
References: <20200207201856.46070-1-bgeffon@google.com> <20200210104520.cfs2oytkrf5ihd3m@box>
 <CADyq12wcwvRLwueucHFV2ErL67etOJdFGYQdqVFM2WAeOkMGQA@mail.gmail.com> <20200213120813.myanzyjmpyzixghf@box>
In-Reply-To: <20200213120813.myanzyjmpyzixghf@box>
From:   Brian Geffon <bgeffon@google.com>
Date:   Thu, 13 Feb 2020 10:20:44 -0800
Message-ID: <CADyq12wWOhGDeUeOB74dxuRKjPhduMWZLBMxOxpm5-yHOpjaRw@mail.gmail.com>
Subject: Re: [PATCH v4] mm: Add MREMAP_DONTUNMAP to mremap().
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
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
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Florian Weimer <fweimer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Kirill,

> But if you do the operation for the VM_LOCKED vma, you'll have two locked
> VMA's now, right? Where do you account the old locked vma you left behind?

You bring up a good point. In a previous iteration of my patch I had
it clearing the locked flags on the old VMA as technically the locked
pages had migrated. I talked myself out of that but the more I think
about it we should probably do that. Something along the lines of:

+    if (vm_flags & VM_LOCKED) {
+      /* Locked pages would have migrated to the new VMA */
+      vma->vm_flags &= VM_LOCKED_CLEAR_MASK;
+      if (new_len > old_len)
+              mm->locked_vm += (new_len - old_len) >> PAGE_SHIFT;
+   }

I feel that this is correct. The only other possible option would be
to clear only the VM_LOCKED flag on the old vma leaving VM_LOCKONFAULT
to handle the MCL_ONFAULT mlocked situation, thoughts? Regardless I'll
have to mail a new patch because that part where I'm incrementing the
mm->locked_vm lost the check on VM_LOCKED during patch versions.

Thanks again for taking the time to review.

Brian
