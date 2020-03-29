Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AADCF19705A
	for <lists+linux-api@lfdr.de>; Sun, 29 Mar 2020 22:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgC2UtO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 29 Mar 2020 16:49:14 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42531 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbgC2UtO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 29 Mar 2020 16:49:14 -0400
Received: by mail-ed1-f66.google.com with SMTP id cw6so17668212edb.9;
        Sun, 29 Mar 2020 13:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=CBrZCY262yJqZoWVYzJDLziYuDtLCOEuJP1pAWpEfsg=;
        b=jnwvy92LwSffGa10CcijkNob4skNB32haEpszHXlP3JpTyUx7VsBaLTqjoLLkM3RZE
         ATktXr1wkB5ID7zgdlLkJjalYY7gcmAyfycvXqPIx6Jmfns5uBSnz43R6BnAhgprC15p
         wIAJenNNgQlwXV4vHuMI22FX8C1LF2ghfUMcPk4exMAfscdR3pj5sGgMD6m3U+VjspJ+
         KW/z7YZAcZNxPDjPCJmujWppRw1W9FnoilPXdiMnRDc42PmGcxtRK4ZyrM6I+HoRocIh
         RGkAsV7QH+cOg3nZ3Ap00EmsCgWBrDgeSRfacbGyYXEBQSJTgcg1ncpcxDKbSAcMWZ0A
         U+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=CBrZCY262yJqZoWVYzJDLziYuDtLCOEuJP1pAWpEfsg=;
        b=jOu4kJwa9arYrM1V5iPCvAU0qVwNlKwwR/lM29Y/W5b10jo9rQXN82TmkCSzCuEOLi
         0LWnK/j2lfQ9rP0OZzoH7vfgEixIN44dNKggfMO3EShDZ1xCMFYA+MQynw18UCrB1CEX
         CMr3O0GbZKIn1DpSWSEnAAMhIHAg/BE8sIS/rnuDxLoOir656dnZGvhpA4FHlpDXLmYm
         9UpUY2ZcU0CCDlOiZK/if9nJyeUCuZdS+zicwaMFA2TNjUQDgO3wHcr+GB7mSWfCNKkC
         cc6SAz0LSwYWBvyBH9tpC2t3B4xKHdFNcaq02Df74biRtZws4xQK7I72LhEB4IxbQSuQ
         K23A==
X-Gm-Message-State: ANhLgQ1AwW2WW7yHL3ulifeq16ZJ71UObdtG8KMYnF9xuJtBPsf4rVrm
        Uv0l9YRQQXXeYa1JR57IKEh3OZc4ZKkOM4WZ4wc=
X-Google-Smtp-Source: ADFU+vs7d42gGJdwKipFf5RwR68cUNNlz0MoLkmh98QcAOIqRaGIUtg9TG6d4NPbzJyMlT7d4rLb3CVhJJFi4Rjd1BY=
X-Received: by 2002:a50:8046:: with SMTP id 64mr8717182eda.332.1585514952374;
 Sun, 29 Mar 2020 13:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <CA+zRj8U5_NaY4ZQXj9r=f58KcO3pq5k9HZt9KxRYHnOOk=e1WQ@mail.gmail.com>
 <a225bae5-e342-fee4-b7fa-c3093ca52fa0@gmail.com>
In-Reply-To: <a225bae5-e342-fee4-b7fa-c3093ca52fa0@gmail.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Sun, 29 Mar 2020 22:49:00 +0200
Message-ID: <CAKgNAkhzOq2-H8Ka2Dx9ijrVZkaH9cNzKkAENM9hyQx9MBnAKQ@mail.gmail.com>
Subject: Re: clock_settime(2) error for non-settable clocks
To:     Eric Rannaud <eric.rannaud@gmail.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
Cc:     Aleksa Sarai <asarai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, 26 Mar 2020 at 09:37, Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> Eric,
>
> On 3/20/20 7:02 PM, Eric Rannaud wrote:
> > If clock_id is a valid clock on the system (i.e. it can be passed to
> > clock_gettime(2)), clock_settime(clock_id, &ts) sets errno to, either:
> >
> >   - EINVAL if CONFIG_POSIX_TIMERS is not enabled (kernel/posix-stubs.c)=
;
> >   - EINVAL if CONFIG_POSIX_TIMERS is enabled (kernel/posix-timers.c)
> > and the k_clock has no set function (e.g. CLOCK_BOOTTIME);
> >   - EACCES for dynamic posix clock devices that lack F_WRITE
> > (kernel/posix-time.c);
> >   - EOPNOTSUPP for dynamic posix clock devices that have F_WRITE but
> > don't have a clock_settime op.
> >   - EOPNOTSUPP for drivers/ptp/ptp_kvm.c (they provide a clock_settime
> > op that returns -EOPNOTSUPP directly, rather than opt to leave
> > clock_settime NULL which would do the same thing, see previous point).
> >
> > The manpage for clock_settime(2) is not very clear:
> >
> >        EINVAL The clk_id specified is not supported on this system.
> >
> >        EPERM  clock_settime() does not have permission to set the clock=
  indi=E2=80=90
> >               cated.
> >
> > To me, the manpage reads like EPERM should be expected when trying to
> > set a clock that is not settable.
> >
> > Should we update the manpage to more fully explain the range of
> > possible errors or instead try to have more consistent errors? For
> > syscalls, what's the backward-compatibility contract for errno values?
>
> A man-pages patch would be most appropriate. Would you be able to put
> something together?

I have in the meantime added this patch:

commit 238442a2de3821921e9b78117bf89519f8093c42 (HEAD -> master)
Author: Michael Kerrisk <mtk.manpages@gmail.com>
Date:   Sun Mar 29 22:36:19 2020 +0200

    clock_getres.2: ERRORS: add EINVAL for attempt to set a nonsettable clo=
ck

    Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>

diff --git a/man2/clock_getres.2 b/man2/clock_getres.2
index ed9310208..66ed84c5c 100644
--- a/man2/clock_getres.2
+++ b/man2/clock_getres.2
@@ -237,6 +237,13 @@ is negative or
 .I tp.tv_nsec
 is outside the range [0..999,999,999].
 .TP
+.B EINVAL
+The
+.I clk_id
+specified in a call to
+.BR clock_settime ()
+is not a settable clock.
+.TP
 .BR EINVAL " (since Linux 4.3)"
 .\" commit e1d7ba8735551ed79c7a0463a042353574b96da3
 A call to

Thanks,

Michael

--=20
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
