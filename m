Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3B861582C9
	for <lists+linux-api@lfdr.de>; Mon, 10 Feb 2020 19:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbgBJSj1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 10 Feb 2020 13:39:27 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35182 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbgBJSj1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 10 Feb 2020 13:39:27 -0500
Received: by mail-ed1-f68.google.com with SMTP id f8so1554120edv.2
        for <linux-api@vger.kernel.org>; Mon, 10 Feb 2020 10:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jlsflCZJObjYz2WQ+bj1XSIApVgJryVHpJZHj+0ZcAs=;
        b=H2shC/nd3zFW54NxtxygSOrpF6OwRFEDTka0iPLEjvdmPLu7I1VoTylWyDE9d2D+qI
         EaHAStTYKnt2CD1l2Zz+cfM7QiO704trJ+peNsxgkBU3FEKzUlKxB2pt9YPxjtMp+lQ3
         rnpI5yCYwGvVC7zvtAVwkF3zQXwf0bEOEgmKhfH1OevTWXAJ++HYzjbCnQHcU5j0LKci
         9IGm+2E1QRYL7K/vb5LVHmZWy5bKbDQGsTpQLpdGIrL/D+RcQ0N9sq9087whnjF34ypn
         fO5r5TfVrAOv/CMJMV4Ij0zQVkGrCJL741Pz0LDu5acNaVb6v1TT5bi1S7LkXEAvEhY7
         L19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jlsflCZJObjYz2WQ+bj1XSIApVgJryVHpJZHj+0ZcAs=;
        b=nGyQWzLulKLJEiEpyq3eXDntXGzIsM4tzw8dWRQXvmybKYMun9JW7NNkhBT5HQGr1E
         M8wt+RpM6FYOut4SUXkwziQ9GV4VNoPyeWfZQ2BtB3g4oieUg2N1z7wL43z5i+Lhkg+P
         rDDe/Hdmlc7qqqBH1ekQFRt6atfhQsky4JJVx5hq5i0DvBZD4QkSv+77CbAua7TXsM/z
         GBDq+ks2hE3IzP/NXu2Izm2UEeGv8aQCsyJpKyZaPFfpQgaBxpLvMgY5ZdaVoZu5MwAT
         S8sGcHVWucqNt6OOOYl6Fuc5KnXGXmiVhfR3R5kSrRhW76nlSMux3pJ/l1IXnDoMG5hi
         4M+g==
X-Gm-Message-State: APjAAAXvh22wXxIfbLOmQaDD7REcFYSwF04mnj+3dUWfTmydLejmq61N
        tMFio7U1J5b0bZhanEd7Xus+bjzi3PCVFyQM7xnvSw==
X-Google-Smtp-Source: APXvYqxgm95mync8C8GByW2W2TIAYK9hKbNNty/1Wj/xekWtRBxXp0AvW0aop3onKwfYvOCHSXt1Nf6K7areZr5SZIc=
X-Received: by 2002:a17:906:b208:: with SMTP id p8mr2527452ejz.191.1581359965172;
 Mon, 10 Feb 2020 10:39:25 -0800 (PST)
MIME-Version: 1.0
References: <20200207201856.46070-1-bgeffon@google.com> <20200209172140.aa60488e10e0408c4f74f11b@linux-foundation.org>
In-Reply-To: <20200209172140.aa60488e10e0408c4f74f11b@linux-foundation.org>
From:   Brian Geffon <bgeffon@google.com>
Date:   Mon, 10 Feb 2020 10:38:58 -0800
Message-ID: <CADyq12yJRauv3Xkyv6vVYT7n_Fe6rw-DMw5KJyqG=j_-rzhgUw@mail.gmail.com>
Subject: Re: [PATCH v4] mm: Add MREMAP_DONTUNMAP to mremap().
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Thank you Andrew. I'll get working on some self-tests.

Brian

On Sun, Feb 9, 2020 at 5:21 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri,  7 Feb 2020 12:18:56 -0800 Brian Geffon <bgeffon@google.com> wrote:
>
> > When remapping an anonymous, private mapping, if MREMAP_DONTUNMAP is
> > set, the source mapping will not be removed. Instead it will be
> > cleared as if a brand new anonymous, private mapping had been created
> > atomically as part of the mremap() call.  If a userfaultfd was watching
> > the source, it will continue to watch the new mapping.  For a mapping
> > that is shared or not anonymous, MREMAP_DONTUNMAP will cause the
> > mremap() call to fail. Because MREMAP_DONTUNMAP always results in moving
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
> This seems useful and reasonably mature, so I'll queue it for
> additional testing and shall await review feedback.
>
> Could we please get some self-test code for this feature in
> tools/testing/selftests/vm?  Perhaps in userfaultfd.c?
>
