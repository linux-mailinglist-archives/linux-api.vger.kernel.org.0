Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7162115F60C
	for <lists+linux-api@lfdr.de>; Fri, 14 Feb 2020 19:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbgBNSrM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Feb 2020 13:47:12 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:36868 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729488AbgBNSrL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 14 Feb 2020 13:47:11 -0500
Received: by mail-ed1-f50.google.com with SMTP id t7so669442edr.4
        for <linux-api@vger.kernel.org>; Fri, 14 Feb 2020 10:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SiWqUpdh4i6ijlaIGQ6h9I93/rzJCmHhBbrF7O5i8NM=;
        b=Q0XhyH6Xlhrpl2gwB631HswEjt4oCyWy3lLVptoDwWxl0HG3Q3C88cYuIRC4OBPf6w
         auhtMnSkhu8J6PeB+HyjnZFro/At+yFVhwPKlWilHic9FKPWhKmFaP4DkfrtfAuum9mS
         LUqDX+lJPCC892vzT6mJ5j1dI9Xpb7ZjQU85WsW6rnIZ4F4jbixPzQ6fZYsdSYa/0g53
         jUmfiKCGOYHTOgfi/GWQ02YtcPM5tphrucdmwLiHMuMdGPgTQCfhlIT5CyRdNbli20Sh
         T7HcP9jyAHwBdOPmJdubumHSDbsffx622LiG2f5QAwsrbLB7JjhMhSLPs6tG9rngpZjJ
         O3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SiWqUpdh4i6ijlaIGQ6h9I93/rzJCmHhBbrF7O5i8NM=;
        b=XeBQe3l05g+GHo1TucdYDlCMN/uFwqFaMtsE+2fA3uK8/aqCFLHUzc/95zPIAlU/Wp
         NbCAhPwgxjP3cdBPScBf2OigeqBiJZE04l/89Q3c2ofUeGzJJDEMB2/AwDVHLFuQVbDk
         aOJTXEtFgsSxrLF8iHm2TIK8aMelAMfAsyot5AJ6jYwK34xfIhX+1IsSSiXlMhcb0y72
         fwRFP9Hw6EOgxPozVyB5/qHL5uf6g7dI/xBz9C8zsprQ8AtdCB/B+ZeHOAOdMK6LzASu
         qc2t6Ks8vpCKG2F/sVgsSGyYNk6ZhtbwJ4rQdnJqqYigNIZSoAyrFU5qzGVY/767PxWp
         J1pg==
X-Gm-Message-State: APjAAAVtBm01o3dkafWLnADdRoTHwd+F1SHW8avCJJjLfMmFj1SCCZt6
        nwGzM8SVznDwMuzSrBgfRqg4LZO0feP/KmFOieZUDw==
X-Google-Smtp-Source: APXvYqzmUmMjxVo5zkPNo6yTS3RZoS0fNS3ryC6PdeYOUMtGdiDcZrTLR/xmBbN/aHCEcd4ePB3zkA4ob6/2yQnLqns=
X-Received: by 2002:a05:6402:61a:: with SMTP id n26mr3817911edv.135.1581706029817;
 Fri, 14 Feb 2020 10:47:09 -0800 (PST)
MIME-Version: 1.0
References: <20200207201856.46070-1-bgeffon@google.com> <20200214040952.43195-1-bgeffon@google.com>
 <20200214142857.kcmjiequhfl3sot2@box>
In-Reply-To: <20200214142857.kcmjiequhfl3sot2@box>
From:   Brian Geffon <bgeffon@google.com>
Date:   Fri, 14 Feb 2020 10:46:43 -0800
Message-ID: <CADyq12z8ZAPs6pAvrmSrzW5t9wqktCdVM+45FGrcX5Yf9i1wxw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] mm: Add MREMAP_DONTUNMAP to mremap().
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

> > -     if (vm_flags & VM_LOCKED) {
> > -             mm->locked_vm += new_len >> PAGE_SHIFT;
> > -             *locked = true;
> > -     }
> > -
>
> Ah. You moved this piece. Why?

Because we're not unmapping, do_munmap would have adjusted
mm->locked_vm by decreasing it by old_len so then we have to add back
in the new_len in the normal case (non. MREMAP_DONTUNMAP), but since
we're not doing the unmap I want to skip the increase by new_len and
just adjust accordingly. In the MREMAP_DONTUNMAP case if the VMA got
smaller then the do_munmap on that portion would have decreased it by
new_len - old_len, and the accounting is correct. In the case of an
unchanged VMA size there is nothing to do, but in the case where it
grows we're responsible for adding new_len - old_len because of the
decision to jump that block and now the accounting is right for all
cases.

If we were to leave the original block and not jump over it then we
would have to remove old_len bytes and then we're doing the same thing
but now special casing the situation where new_len < old_len because
the unmap on the removed part would have reduced it by new_len -
old_len so backing old_len would be too much and we'd have to add back
in new_len - old_len. I hope that explains it all.

By doing it this way, IMO it makes it easier to see how the locked_vm
accounting is happening because the vm_locked incrementing happens in
only one of two places based on the type of remap that is happening.
But I definitely can clean up the code a bit to drop the levels of
indentation, maybe this:

        /*
         * locked_vm accounting: if the mapping remained the same size
         * it will have just moved and we don't need to touch locked_vm
         * because we skip the do_unmap. If the mapping shrunk before
         * being moved then the do_unmap on that portion will have
         * adjusted vm_locked. Only if the mapping grows do we need to
         * do something special; the reason is locked_vm only accounts
         * for old_len, but we're now adding new_len - old_len locked
         * bytes to the new mapping.
         */
        if (vm_flags & VM_LOCKED && new_len > old_len) {
          mm->locked_vm += (new_len - old_len) >> PAGE_SHIFT;
          *locked = true;
        }

        /* We always clear VM_LOCKED[ONFAULT] on the old vma */
        vma->vm_flags &= VM_LOCKED_CLEAR_MASK;
        goto out;
     }

Having only one place where locked_vm is accounted and adjusted based
on the type of remap seems like it will be easier to follow and less
error prone later. What do you think about this?

> > +     if (flags & MREMAP_FIXED) {
>
> I think it has to be
>
>         if (!(flags & MREMAP_DONTUNMAP)) {
>
> No?

No. Because we dropped the requirement to use MREMAP_FIXED with
MREMAP_DONTUNMAP, if we're not using MREMAP_FIXED we don't need to
unmap anything at dest if it already exists because
get_unmapped_area() below will not be using the MAP_FIXED flag either,
instead it will search for a new unmapped area. If we were to change
it then we wouldn't be able to do MREMAP_FIXED | MREMAP_DONTUNMAP, so
I think this is correct.

> > -     if (flags & MREMAP_FIXED) {
> > +     if (flags & MREMAP_FIXED || flags & MREMAP_DONTUNMAP) {
>
>         if (flags & (MREMAP_FIXED | MREMAP_DONTUNMAP)) {

Sure, I can change that.

If you're good with all of that I can mail a new patch today.

Thanks again,
Brian
