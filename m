Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE341F020E
	for <lists+linux-api@lfdr.de>; Tue,  5 Nov 2019 17:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390046AbfKEQAk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 5 Nov 2019 11:00:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:51814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389760AbfKEQAk (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 5 Nov 2019 11:00:40 -0500
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 360E121D71
        for <linux-api@vger.kernel.org>; Tue,  5 Nov 2019 16:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572969639;
        bh=q2A2uMxzadSGRcZIaYT5uCotN7hZ7KNQChxEY5lqBfc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=la98BUT48pfvW+DHwcuadG5iZNz4+oR5/MwjwcYS/q+eLbsi2eyOW1pVLwxPK46Sf
         BFy0EZhUvBH7RKyVdyf2RuYqHz7s6c22dmVDH/407wHkTmazDieQwp7xJlGSdYwg+g
         3s796AOR/nqirBqmdk5eAT4jg0/8Alxjmio4Lgpc=
Received: by mail-wr1-f41.google.com with SMTP id f2so13119280wrs.11
        for <linux-api@vger.kernel.org>; Tue, 05 Nov 2019 08:00:39 -0800 (PST)
X-Gm-Message-State: APjAAAXGsktLqorQpgCSWSFXBmmq6BBHuEK5aiOpPc8dJAN0SqDKmIQk
        /UwVjbxfMmeBTZ5CErjOmzakXp6qYsARSAg+MaKZzw==
X-Google-Smtp-Source: APXvYqwIyCPkiSNVSjQruqDSEqU8umadRXv+BsUhkRhMyEyMplXNqV0XB7SqebnrdTOdsyPd4gU2dZ/qQ0spOgjmkRU=
X-Received: by 2002:a5d:51c2:: with SMTP id n2mr28174168wrv.149.1572969637572;
 Tue, 05 Nov 2019 08:00:37 -0800 (PST)
MIME-Version: 1.0
References: <1572967777-8812-1-git-send-email-rppt@linux.ibm.com>
 <1572967777-8812-2-git-send-email-rppt@linux.ibm.com> <CAKOZuev93zDGNPX+ySg_jeUg4Z3zKMcpABekUQvHA01kTVn4=A@mail.gmail.com>
In-Reply-To: <CAKOZuev93zDGNPX+ySg_jeUg4Z3zKMcpABekUQvHA01kTVn4=A@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 5 Nov 2019 08:00:26 -0800
X-Gmail-Original-Message-ID: <CALCETrX=VmSjD6kLT6tuZQ4Efhc_13vZrw1mo4Z2iKqZTT-bzg@mail.gmail.com>
Message-ID: <CALCETrX=VmSjD6kLT6tuZQ4Efhc_13vZrw1mo4Z2iKqZTT-bzg@mail.gmail.com>
Subject: Re: [PATCH 1/1] userfaultfd: require CAP_SYS_PTRACE for UFFD_FEATURE_EVENT_FORK
To:     Daniel Colascione <dancol@google.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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

On Tue, Nov 5, 2019 at 7:55 AM Daniel Colascione <dancol@google.com> wrote:
>
> On Tue, Nov 5, 2019 at 7:29 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> > Current implementation of UFFD_FEATURE_EVENT_FORK modifies the file
> > descriptor table from the read() implementation of uffd, which may have
> > security implications for unprivileged use of the userfaultfd.
> >
> > Limit availability of UFFD_FEATURE_EVENT_FORK only for callers that have
> > CAP_SYS_PTRACE.
>
> Thanks. But shouldn't we be doing the capability check at
> userfaultfd(2) time (when we do the other permission checks), not
> later, in the API ioctl?

The ioctl seems reasonable to me.  In particular, if there is anyone
who creates a userfaultfd as root and then drop permissions, a later
ioctl could unexpectedly enable FORK.

This assumes that the code in question is only reachable through
ioctl() and not write().
