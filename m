Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F800E2429
	for <lists+linux-api@lfdr.de>; Wed, 23 Oct 2019 22:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbfJWUPf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 23 Oct 2019 16:15:35 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37100 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391482AbfJWUPf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 Oct 2019 16:15:35 -0400
Received: by mail-lf1-f67.google.com with SMTP id g21so16072501lfh.4
        for <linux-api@vger.kernel.org>; Wed, 23 Oct 2019 13:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=816t39R7woXwpi4P0kaDZ51TulQhFsv/sI1rickj8mI=;
        b=bmXkO63NtJoUxakzTF2eVeCibnH18VL+m6U+RxQXcqjGwaDE50VnfmaPgUESOXh2v2
         Zp60EhLG5l8J57GRXh83GnxEctvxLWQj4gTiMkGxaphmhn7/Z5TYukqP3tif0I87yEld
         twzwabTE+KLDhegSN3Jqq4G19wBI0H8Fdu+iY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=816t39R7woXwpi4P0kaDZ51TulQhFsv/sI1rickj8mI=;
        b=gyS2Lf6VZPLW/0A3qIFASc6+HpVCmWDNpujqpji+hRICw3sgG2OsUqgS/ESjU+4FXc
         Jb0n9hc0pt6NLO9pH1ZdJG/oDpOlxgOv0vEGOGGZqGYgYmFo9l3w/EWsoKYGIxG+GZgh
         sR/LNJzTq0omkAfW59QxVP7ldcWYK1dkG2+KM+XMJES6jGURJ6Vb++gApINZ4vIe9s9H
         iNWZkxfbs8m/YLd6S9hSBmeOWcwxjYVkcWEL8YllPf3O97+kdKBe7/211NRnUqNK3hrR
         Fbe/Xl9pPsvqg4kNOvs9UlXEAvaJieJ/040+mDEbhFPrBLO/ANh0rUIDITte0wVdhwCQ
         SfWA==
X-Gm-Message-State: APjAAAW+zd14InqzR8vFo1AfGisRAyERCdAvF+M8qUX18E4EsJ5QPrQ+
        kWcnXYYVmdlR13GAK/BFWNBMp6cQJQSfMw==
X-Google-Smtp-Source: APXvYqxPHS2h3D6lFVBwlFm2Qf1fcvJFyQSqS+NMu2CTzaC4ZeGPfY/n1yFvZBjLU3zlFcbSQfDecA==
X-Received: by 2002:ac2:414f:: with SMTP id c15mr14722151lfi.157.1571861731528;
        Wed, 23 Oct 2019 13:15:31 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id s1sm9101370lfd.14.2019.10.23.13.15.29
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2019 13:15:29 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id d1so22444278ljl.13
        for <linux-api@vger.kernel.org>; Wed, 23 Oct 2019 13:15:29 -0700 (PDT)
X-Received: by 2002:a2e:2e10:: with SMTP id u16mr3404094lju.97.1571861729069;
 Wed, 23 Oct 2019 13:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <20191012191602.45649-1-dancol@google.com> <20191012191602.45649-4-dancol@google.com>
 <CALCETrVZHd+csdRL-uKbVN3Z7yeNNtxiDy-UsutMi=K3ZgCiYw@mail.gmail.com>
 <CAKOZuevUqs_Oe1UEwguQK7Ate3ai1DSVSij=0R=vmz9LzX4k6Q@mail.gmail.com>
 <CALCETrUyq=J37gU-MYXqLdoi7uH7iNNVRjvcGUT11JA1QuTFyg@mail.gmail.com>
 <CAG48ez3P27-xqdjKLqfP_0Q_v9K92CgEjU4C=kob2Ax7=NoZbA@mail.gmail.com> <20191023190959.GA9902@redhat.com>
In-Reply-To: <20191023190959.GA9902@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Oct 2019 16:15:12 -0400
X-Gmail-Original-Message-ID: <CAHk-=wgC-RGcTOrtY+ZQLdZ74EULBvD_+uiPToqhAAMNjAHM6g@mail.gmail.com>
Message-ID: <CAHk-=wgC-RGcTOrtY+ZQLdZ74EULBvD_+uiPToqhAAMNjAHM6g@mail.gmail.com>
Subject: Re: [PATCH 3/7] Add a UFFD_SECURE flag to the userfaultfd API.
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>,
        Daniel Colascione <dancol@google.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Tim Murray <timmurray@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Oct 23, 2019 at 3:10 PM Andrea Arcangeli <aarcange@redhat.com> wrote:
>
> That wouldn't break the ABI, no more than when if you boot a kernel
> built with CONFIG_USERFAULTFD=n.

What? No.

You're entirely incorrect.

If USEFAULTFD no longer works, and if people depend on it, then it's
breaking the ABI. End of story. No weaselwording of "as if built with
CONFIG_USERFAULTFD=n" allowed, no garbage.

Btw, the whole "breaking the ABI" is misleading wording anyway. It's
irrelevant. You can "break" the ABI all you want by changing
semantics, adding or removing features, or making it do anything else
- as long as nobody notices.

Because the only thing that matters is that it doesn't break any user
workflows. That's _all_ that matters, but it's a big deal, and it
means that your fantasy reading of what "ABI" means is irrelevant.
Just because there's a config option to turn something off, doesn't
mean that you can then claim that you can do whatever.

So your statement is nonsensical and pointless.

Please don't spread this kind of bogus claims.

                Linus
