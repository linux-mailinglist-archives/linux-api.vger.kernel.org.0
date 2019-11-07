Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5749F2E28
	for <lists+linux-api@lfdr.de>; Thu,  7 Nov 2019 13:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388089AbfKGM0R (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 7 Nov 2019 07:26:17 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37607 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfKGM0Q (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 7 Nov 2019 07:26:16 -0500
Received: by mail-ed1-f66.google.com with SMTP id k14so1736683eds.4;
        Thu, 07 Nov 2019 04:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=5zd4Ac0HKb/eYHdf/6q999KQ0xYxHpxQr0ZZ2RjV40g=;
        b=Yini2AyJnthvIkbE/4+jgfvhe+yNOfCFjhMWGkUu75lY28pYvBIwJagIapT15MOLoi
         ftuNltvHgnWcY8g9qyMQnh5a9WTks96WILHCIIsnZGIK2KyKyaKzYVD/hsd3IdlcSvAC
         Z88YI7vNjZLFgucoRKCZ6NAU1uwipvCo7vBmi0MnXp4IMiEeeUONNk3i3rb50Q9tHfrC
         FI6wHXWYkpenNudF3XTrmq6oHnWXV1YqFcl71tq1yaommu/sJxdFG5G3TmnaHw7z3VjL
         itxUxrhmk93X5qszQ/JMTjSK2cglcHMQGEtHmwmGKrQ9ujB+9NM9Ij2fjdIZw7uasHfF
         Kirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=5zd4Ac0HKb/eYHdf/6q999KQ0xYxHpxQr0ZZ2RjV40g=;
        b=EV+iCmN2rKU8aw4GvY8kjxU/2fAz9qlREX54uxWQJMPXtU2ym4PqmsYV6Gnb35bmOd
         dMj8i08SIpKNa62aKj1YQvWuZggJcQgzC/QQIuf94He+d1VXujgQJ3co7LQZnokGPPkr
         GFOTN3qYgONCgFXzCpQycmd2t+thBwL9sfbLAMfuFAXJuAItjGCGg6WGcxwlu5oWfqD6
         G9g6F/IUfQxYlcL3hpOMhYZowyK996qWm35/Nl9DhlA/lIZFgdUHQk/jN4vIrgLLJ6hU
         LQQQr8clB2A2fb96CEIUu1ZrSfBwX00LwH3xaQhQgDqQdLusZ83xlpsCoXNs1AplTRlY
         lc8w==
X-Gm-Message-State: APjAAAUVTWCfnZr9yJyZpDFrPm9yRrVJOz2XO07MR9qpSzXN4/TjzI/e
        mEaQpn+fr81T3HXGdKudgSwjnjL0nSLBFEmqGZ4=
X-Google-Smtp-Source: APXvYqxO5knDwmjSdOQnZ+aeQqZFYv45U8WxHXl39k2JFkMoBHq7VwmDRixFTjr1hPCXosoehWpzT0P3dCtBTQ578UU=
X-Received: by 2002:a17:906:5c55:: with SMTP id c21mr2636918ejr.214.1573129574736;
 Thu, 07 Nov 2019 04:26:14 -0800 (PST)
MIME-Version: 1.0
References: <CAKgNAkjo2WHq+zESU1iuCHJJ0x-fTNrakS9-d1+BjzUuV2uf2Q@mail.gmail.com>
 <20191025170726.rqsquw4v4cuhduek@wittgenstein>
In-Reply-To: <20191025170726.rqsquw4v4cuhduek@wittgenstein>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Thu, 7 Nov 2019 13:26:03 +0100
Message-ID: <CAKgNAkhzaJmBuphwkXEVD+Kng7i1cHwK0DjPQ9OfNK7FJCsyyA@mail.gmail.com>
Subject: Re: For review: documentation of clone3() system call
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Christian Brauner <christian@brauner.io>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>,
        Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hey, Christian,

Ping!

Cheers,

Michael

On Fri, 25 Oct 2019 at 19:09, Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Fri, Oct 25, 2019 at 06:59:31PM +0200, Michael Kerrisk (man-pages) wrote:
> > Hello Christian and all,
> >
> > I've made a first shot at adding documentation for clone3(). You can
> > see the diff here:
> > https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=faa0e55ae9e490d71c826546bbdef954a1800969
> >
> > In the end, I decided that the most straightforward approach was to
> > add the documentation as part of the existing clone(2) page. This has
> > the advantage of avoiding duplication of information across two pages,
> > and perhaps also makes it easier to see the commonality of the two
> > APIs.
> >
> > Because the new text is integrated into the existing page, I think it
> > makes most sense to just show that page text for review purposes. I
> > welcome input on the below.
> >
> > The notable changes are:
> > * In the first part of the page, up to and including the paragraph
> > with the subheading "The flags bit mask"
> > * Minor changes in the description of CLONE_CHILD_CLEARTID,
> > CLONE_CHILD_SETTID, CLONE_PARENT_SETTID, and CLONE_PIDFD, to reflect
> > the argument differences between clone() and clone2()
> >
> > Most of the resy of page is unchanged.
> >
> > I welcome fixes, suggestions for improvements, etc.
>
> Thank you Michael, for doing this. I will hopefully get around to
> reviewing this soon but it might take a few days (latest after next week
> :( because of OSS/LSS).
>
> Christian



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
