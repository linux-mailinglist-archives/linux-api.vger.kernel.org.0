Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E33ADF01F6
	for <lists+linux-api@lfdr.de>; Tue,  5 Nov 2019 16:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389096AbfKEPz6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 5 Nov 2019 10:55:58 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35624 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389571AbfKEPz5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 5 Nov 2019 10:55:57 -0500
Received: by mail-lj1-f194.google.com with SMTP id r7so13748902ljg.2
        for <linux-api@vger.kernel.org>; Tue, 05 Nov 2019 07:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JBjPVawkw1D9alty2gxLh6X6OcB+iTnvmGu5mIHwLJg=;
        b=uv+lqTeLWQdQa3Az+claLZ2Why5fQC8C3uqj/IVPZrAu/WNR4AVwgyjksYefYB//Lb
         6MQfsmN9eqwJC8gCdiVTJqA6uNqBe3y3dmPqF2me9g9Jg33v8hzZBWCT0tt+bHnA8HIk
         almprJnYwnBhBEVLwEWJtGqpKDYAKJfmY3cssi4VAasH8tZfn/UgUFxJyhyVkwD0hVwX
         bUskZyfPEsz8sxqVqdaGQ0g7EVvRetUYPr0XpAxLBuWk2VppC53JYQ4cvvyw/Tk32c3g
         Y48KJDS8SIgYst++jQrQDEExvG07MbUpzJPdRNXfXVIYCsNtIBzk+7qIeQIMKt5h1aU5
         x0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JBjPVawkw1D9alty2gxLh6X6OcB+iTnvmGu5mIHwLJg=;
        b=Sgcc5Qmjs3fs61ns3HcaUk4rLqDAqwGg4tC5RRsx1v3PKwX1DrhvAxIfnrQwj0QTMd
         Yw/KQQ0FRlPI5+YVDvdJxASzeOSe0PfBDjMjbUtoZKaLPujRDg3QAEBG0NmBZH/l7MBs
         gOCyzyATRoFDpOwvJS6IofM7RXyN7GeOvHBSQTwCOigohvDqflbUgs+7nQVNM3qa0GT4
         gCxxmTyVuFGDozwGHGJiaIRZB9dtfEnd8GXoE/XetVhAikEUZVeK5ZVeNrz5ljJgmcIV
         d5PCJ85zG9bdOgjFLVwnbL2NTUxrdv7keNOsxyW0cj88WPyKv8htR0l30uJu/bBhR5UN
         2p/A==
X-Gm-Message-State: APjAAAVLYnQGIP8kbJ63/pNjiLL340F5ax9NgfMAK1bJl6/nNJRdTX6+
        ZcSlZNRExpLGf1NlJtxOM2powhXr8z71GnqIL265zg==
X-Google-Smtp-Source: APXvYqxzXAYCCtN4vYGeUwBs7NzYo7aq+jmkHe7kRaIoNYXrHcoEVfLgw9HeYSsNg1dpsk5d7gY8SOAg2C6mzEQPfuY=
X-Received: by 2002:a2e:b4aa:: with SMTP id q10mr19425669ljm.250.1572969353779;
 Tue, 05 Nov 2019 07:55:53 -0800 (PST)
MIME-Version: 1.0
References: <1572967777-8812-1-git-send-email-rppt@linux.ibm.com> <1572967777-8812-2-git-send-email-rppt@linux.ibm.com>
In-Reply-To: <1572967777-8812-2-git-send-email-rppt@linux.ibm.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 5 Nov 2019 07:55:17 -0800
Message-ID: <CAKOZuev93zDGNPX+ySg_jeUg4Z3zKMcpABekUQvHA01kTVn4=A@mail.gmail.com>
Subject: Re: [PATCH 1/1] userfaultfd: require CAP_SYS_PTRACE for UFFD_FEATURE_EVENT_FORK
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
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

On Tue, Nov 5, 2019 at 7:29 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> Current implementation of UFFD_FEATURE_EVENT_FORK modifies the file
> descriptor table from the read() implementation of uffd, which may have
> security implications for unprivileged use of the userfaultfd.
>
> Limit availability of UFFD_FEATURE_EVENT_FORK only for callers that have
> CAP_SYS_PTRACE.

Thanks. But shouldn't we be doing the capability check at
userfaultfd(2) time (when we do the other permission checks), not
later, in the API ioctl?
