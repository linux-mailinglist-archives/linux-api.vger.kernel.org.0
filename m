Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEC97F0242
	for <lists+linux-api@lfdr.de>; Tue,  5 Nov 2019 17:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389571AbfKEQH3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 5 Nov 2019 11:07:29 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45839 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389918AbfKEQH2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 5 Nov 2019 11:07:28 -0500
Received: by mail-lj1-f195.google.com with SMTP id n21so8869083ljg.12
        for <linux-api@vger.kernel.org>; Tue, 05 Nov 2019 08:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YLw5SYrodBEqy2waMxo41K2A0f7ArdzoSUTOLYie6s4=;
        b=eri7qH+7uZFLsQ1nBXM7tctm6BOw+ve7hZW/6tQlf9hNm1WjWAPsqiY0Yhh6c8nJ3C
         Xnn6dPx2b1yQNwdIRtZ0JNE5YnWD9wT4uWdQ88Alt8ix7dhCBHf1+3hKwuNpsBgC0NGc
         ukdLhq7GYGzfbGDIUwM59OXJAAblz15nAU/hswHpLXqSIMcjqv2fwEBMUCFFkxQbTh6C
         /Lu8vp0rEgL5fU8oJBcOT/dgw9PjRG+jLqHd2zO7jznoU26UzkHwv9gr6GQOjL28gyt7
         uZ8vXn/mCyVxCwOnw56QpWCAoHsMV0n6qF29a/MAE/+msYFQNuy8S+uJKSCQHHYjv0EG
         m2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YLw5SYrodBEqy2waMxo41K2A0f7ArdzoSUTOLYie6s4=;
        b=rozty4Fc1EzUmn8FBzN7p4PiRZVPUU2Zv6mOj2Mb75DqLQoA8pEcZTbNxuWODQkRKV
         reHrwa4pzn3fZyjO4xcS64S6cAe3pqBhiZ6KQBuSmtvJtHxnj097LnDFoWgtPi9zc8Rk
         vRj7bzPPX/AJlB52CGgbmvSW3vZQhImU4XyzXKV2n1YGH0eqDRA7ONjB4GnYCrp7RVOr
         O0BE9C0Rg5T0NEnClGbAuFQPlrbO9zEBj64+nbRPGIG422986bjLflu3/c9FrRVBZyzb
         LlaQugKlWTkcK2oyWkcfy8y0XLUZIwlFqYBR/T/IF9Y8eK8QrfPibp44OHOE+QS2XyaR
         JGAA==
X-Gm-Message-State: APjAAAWEaRXX2kGT5z2cDKPkxJdH2WzjI1m8K2RDFykLZsBrvLbalPmo
        WGgmDpvvLt2ZgXtgazO7+/UmS6xGCd5+yD/oPzN8qQ==
X-Google-Smtp-Source: APXvYqyfeC8M/8bOUxBWxwGOy++KCeRE1AqSp/eH8U72Cip1RCmkWIqkShJuw/Lzbce5kF+wF/uaswMUtDkVjGbpmA4=
X-Received: by 2002:a2e:81c6:: with SMTP id s6mr1063081ljg.61.1572970045838;
 Tue, 05 Nov 2019 08:07:25 -0800 (PST)
MIME-Version: 1.0
References: <1572967777-8812-1-git-send-email-rppt@linux.ibm.com>
 <1572967777-8812-2-git-send-email-rppt@linux.ibm.com> <CAKOZuev93zDGNPX+ySg_jeUg4Z3zKMcpABekUQvHA01kTVn4=A@mail.gmail.com>
 <CALCETrX=VmSjD6kLT6tuZQ4Efhc_13vZrw1mo4Z2iKqZTT-bzg@mail.gmail.com>
In-Reply-To: <CALCETrX=VmSjD6kLT6tuZQ4Efhc_13vZrw1mo4Z2iKqZTT-bzg@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 5 Nov 2019 08:06:49 -0800
Message-ID: <CAKOZuetu0QWUDAycTOFzC4HEbjH99EtOhb4gJnHAuovT_StpzA@mail.gmail.com>
Subject: Re: [PATCH 1/1] userfaultfd: require CAP_SYS_PTRACE for UFFD_FEATURE_EVENT_FORK
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 5, 2019 at 8:00 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Tue, Nov 5, 2019 at 7:55 AM Daniel Colascione <dancol@google.com> wrote:
> >
> > On Tue, Nov 5, 2019 at 7:29 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > >
> > > Current implementation of UFFD_FEATURE_EVENT_FORK modifies the file
> > > descriptor table from the read() implementation of uffd, which may have
> > > security implications for unprivileged use of the userfaultfd.
> > >
> > > Limit availability of UFFD_FEATURE_EVENT_FORK only for callers that have
> > > CAP_SYS_PTRACE.
> >
> > Thanks. But shouldn't we be doing the capability check at
> > userfaultfd(2) time (when we do the other permission checks), not
> > later, in the API ioctl?
>
> The ioctl seems reasonable to me.  In particular, if there is anyone
> who creates a userfaultfd as root and then drop permissions, a later
> ioctl could unexpectedly enable FORK.

Sure, but the same argument applies to all the other permission checks
that we do at open time, not at ioctl time. For better or for worse,
the DAC-ish model used in most places is that access checks happen at
file object creation time and anyone who has the FD can perform those
operations later. Confusing the model by doing *some* permission
checks at open time and *some* permission checks at usage time makes
the system harder to understand.
