Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9A97F0329
	for <lists+linux-api@lfdr.de>; Tue,  5 Nov 2019 17:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390193AbfKEQkF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 5 Nov 2019 11:40:05 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38172 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390060AbfKEQkE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 5 Nov 2019 11:40:04 -0500
Received: by mail-lf1-f65.google.com with SMTP id q28so15677451lfa.5
        for <linux-api@vger.kernel.org>; Tue, 05 Nov 2019 08:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fZq9/Aaey+SN0l5GZyRu+H8Ix+9Q121u+Zli7RR28cM=;
        b=dpE3RFaxGC2yX2g7QtFyT4MP1J4SEpPTm67DT/BUSSOJJeXrGc9iwGkOymna6/w9uD
         lLIBtKOpUDSqsi/miR1szIUzurpCjB4jV7rVtVe4gTLBVuAbmc2srBL57cbBW5dVz5Wy
         2LstfRmABNveD5zGcn6Rna+1QQq8xqfD8uuCctL5tkHR0yCqBdyh8gqj3OI5VWRMoXMr
         HEju8amylItNdnUR8tZtFpc3BJ/lfi+REgf6BdEYyCYn0PRbQg+XIKPOcsoSnljyC3js
         HbDZ3DlGcYOmBx7lu8ovKuDJjXc5E2UxG7WzJuWyWi6O8nCKdymnpgiPrYQMxKbuFhyT
         rK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fZq9/Aaey+SN0l5GZyRu+H8Ix+9Q121u+Zli7RR28cM=;
        b=bJHEVOztHTZzZ0PjM/zC5RN6hW2Yzm4fADHUv568yG9hR3e9wdtzRpeuIArGOWG7aX
         b3Rir5YyCgmnmWPJH6mRnhl6qMS2sHFtPc5lzJQ3atwv3Zz7fuxjHyXszCO0n93HN2zR
         ZfVh61qps9LySwsWIsf/8ES7tg4TPi/sHHFUWl9iKZnUh0804SyZNoqXNPPfj6woSyLS
         XAZfEzTSzrrSWaYqE8cvt7JXMzca/KjwW3CR0Z9LZtsa+3PwwVrabzYUMC7UP7n6M/ux
         GqEK0OQhqv2p8ZM8M5hzf0wWvQnsV9h5nqOKW21zQgm/mWnySP43A/AnWPGZ0EF5jrjP
         pPSA==
X-Gm-Message-State: APjAAAVjDBKqLjsCzqyS6r55AAHmAQUyjhLfSM507n3skx8or4AHNyvL
        /BqLKO+3NoI7QQ5+u/ErMuikFx7f2OdrZTl7nNTDjA==
X-Google-Smtp-Source: APXvYqxDz7vYxn0I8N6/Nm40gjJSZsMVwWDW2LlwIjWat1+S/f9QVe+9VtUJH2n2yiwqFwxoN/MW67Pff05B2iT02Mk=
X-Received: by 2002:ac2:561b:: with SMTP id v27mr21936445lfd.186.1572972002286;
 Tue, 05 Nov 2019 08:40:02 -0800 (PST)
MIME-Version: 1.0
References: <1572967777-8812-1-git-send-email-rppt@linux.ibm.com>
 <1572967777-8812-2-git-send-email-rppt@linux.ibm.com> <CAKOZuev93zDGNPX+ySg_jeUg4Z3zKMcpABekUQvHA01kTVn4=A@mail.gmail.com>
 <CALCETrX=VmSjD6kLT6tuZQ4Efhc_13vZrw1mo4Z2iKqZTT-bzg@mail.gmail.com>
 <CAKOZuetu0QWUDAycTOFzC4HEbjH99EtOhb4gJnHAuovT_StpzA@mail.gmail.com> <20191105163316.GI30717@redhat.com>
In-Reply-To: <20191105163316.GI30717@redhat.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 5 Nov 2019 08:39:26 -0800
Message-ID: <CAKOZuet1Hrdd7U4VVBmXNCkE6xwiUPERRHjP=A3bX6B9A4BQRQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] userfaultfd: require CAP_SYS_PTRACE for UFFD_FEATURE_EVENT_FORK
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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

On Tue, Nov 5, 2019 at 8:33 AM Andrea Arcangeli <aarcange@redhat.com> wrote:
>
> On Tue, Nov 05, 2019 at 08:06:49AM -0800, Daniel Colascione wrote:
> > Sure, but the same argument applies to all the other permission checks
> > that we do at open time, not at ioctl time. For better or for worse,
> > the DAC-ish model used in most places is that access checks happen at
> > file object creation time and anyone who has the FD can perform those
> > operations later. Confusing the model by doing *some* permission
> > checks at open time and *some* permission checks at usage time makes
> > the system harder to understand.
>
> The only case that requires change is if userland requested the
> UFFD_FEATURE_EVENT_FORK feature (which AFIK only CRIU does) and that
> request is done in the UFFDIO_API call not during the syscall.
>
> Doing the check in the syscall would then break all non privileged
> users like if we'd set /proc/sys/vm/unprivileged_userfaultfd to
> zero.

I'm not suggesting that we fail userfaultfd(2) without CAP_SYS_PTRACE.
That would, as you point out, break things. I'm talking about
recording *whether* we had CAP_SYS_PTRACE in an internal flag in the
uffd context when we create the thing --- and then, at ioctl time,
checking that flag, not the caller's CAP_SYS_PTRACE, to see whether
UFFD_FEATURE_EVENT_FORK should be made available. This way, the
security check hinges on whether the caller *at create time* was
privileged.
