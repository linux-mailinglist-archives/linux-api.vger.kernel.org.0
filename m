Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E7B3D64D2
	for <lists+linux-api@lfdr.de>; Mon, 26 Jul 2021 18:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbhGZQGq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 26 Jul 2021 12:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240777AbhGZQFA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 26 Jul 2021 12:05:00 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB15C0617A0
        for <linux-api@vger.kernel.org>; Mon, 26 Jul 2021 09:44:41 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a26so16524886lfr.11
        for <linux-api@vger.kernel.org>; Mon, 26 Jul 2021 09:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DlqUXAYss0z4CwOkVfGtreR6OseE/eXEXPezp0fcD5Q=;
        b=v/GwQOc/nfVoJOaP+06LI0uq/yjmmZ5T1xMXwDdNwHDrRxLXrNQwJP1e4uwRyy/xrp
         IOsfYH+cdtu62lwlEx6yb2NTKwdzZFS458KkFOrWnizERkKOK6i0bQGNnwFSRZz/fWGp
         IUKWriV5wMB6wC/h+yVzUQwFI1DpjFLSud5NrBDizwqsJstnZB+Xp9j+SsylMZ8dAMa0
         c5vGk2HKgYounGCCH8vn5pJBitXuNwTgVHaH2TLqdTMi19u/hzVUfmrugGVmb0G267k4
         qqIiLUiCwPOwDvDOINBK5Mr9CyRbvnH0wmr+ej6s4ON7UwpM6YzmX8c1kKl6VEmKwpnO
         IOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DlqUXAYss0z4CwOkVfGtreR6OseE/eXEXPezp0fcD5Q=;
        b=h6M+sgN+v2lQ0EeP7tymQ8Z7OKIdDJNTwcQ+NrtTJU+8NbcV+5pEwp5ATVZ8X3fz0e
         5IpfOawF/gQnOOPEbttKIhcM2g5/EPoMZbqPk9F04jC4BVEz4/3K4fGKCxf7g0E3iYHc
         fp3Wunyk2kab65fZ3YNHFxYEFNvvOs9hmDwsOUxXfmV30d5teSpLeLQ7JVas/1+JcWpT
         6Tj9prYokTUvKNvNlbPCB7r+aGJ0mKb9uCT4k9Auvd7Z1oWEIuOh/z+mtmWPaAUPSwWW
         SfMDhRkjOWhMLkJyHz35Tlj0DlLu030uTYWeE6Jb1cyY3rFG8wsKz5t0dJF3ChXZMNrG
         vG3Q==
X-Gm-Message-State: AOAM5305BzwZ5mbcAiITA1o8ks844osSvJAbyWtvjP+yRfRnnef8Weho
        13S/GXzSbgSkSC75huto9buKjPOUVNzorUyiOx58OQ==
X-Google-Smtp-Source: ABdhPJxzBJ3xGLvlzG0KVYzemKw7irNCJbPzXu7HMAIWodwPYqtCqbkZVo0CNJWicFJd4Rc0zQnPhQrIet41JLV3XB0=
X-Received: by 2002:a05:6512:3f8:: with SMTP id n24mr6547107lfq.125.1627317879269;
 Mon, 26 Jul 2021 09:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210716184719.269033-5-posk@google.com> <2c971806-b8f6-50b9-491f-e1ede4a33579@uwaterloo.ca>
 <CAPNVh5cmhFEWr4bmODkDDFhV=mHLcO0DZJ432GEL=OitzPP80g@mail.gmail.com>
 <c8ea4892-51e5-0dc2-86c6-b705e8a23cde@uwaterloo.ca> <CAFTs51XW0H1UJKv0t2tq+5VLfgPMtZmDcxQVUQ5HkgDe38jHpw@mail.gmail.com>
 <5790661b-869c-68bd-86fa-62f580e84be1@uwaterloo.ca> <CAPNVh5ecidSmKFW2ck0ASw44GUnP20m7baSP1+KXnGfkM8FLLg@mail.gmail.com>
 <e1403574-1151-8399-0ce9-bb80852ec56b@uwaterloo.ca>
In-Reply-To: <e1403574-1151-8399-0ce9-bb80852ec56b@uwaterloo.ca>
From:   Peter Oskolkov <posk@google.com>
Date:   Mon, 26 Jul 2021 09:44:27 -0700
Message-ID: <CAPNVh5fug5cPu7gPoAR7ZiKzAZ5i8007=Hs9_MG+fCTL3XkLBQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4 v0.3] sched/umcg: RFC: implement UMCG syscalls
To:     Thierry Delisle <tdelisle@uwaterloo.ca>
Cc:     Peter Oskolkov <posk@posk.io>, Andrei Vagin <avagin@google.com>,
        Ben Segall <bsegall@google.com>, Jann Horn <jannh@google.com>,
        Jim Newsome <jnewsome@torproject.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-api@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul Turner <pjt@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Buhr <pabuhr@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jul 23, 2021 at 12:06 PM Thierry Delisle <tdelisle@uwaterloo.ca> wrote:
>
>  > In my tests reclaimed nodes have their next pointers immediately set
>  > to point to the list head. If the kernel gets a node with its @next
>  > pointing to something else, then yes, things break down (the kernel
>  > kills the process); this has happened occasionally when I had a bug in
>  > the userspace code.
>
> I believe that approach is fine for production, but for testing it may
> not detect some bugs. For example, it may not detect the race I detail
> below.

While I think I have the idle servers list working, I now believe that
what peterz@ was suggesting is not much slower in the common case
(many idle workers; few, if any, idle servers) than having a list of
idle servers exposed to the kernel: I think having a single idle
server at head, not a list, is enough: when a worker is added to idle
workers list, a single idle server at head, if present, can be
"popped" and woken; the userspace can maintain the list of idle
servers itself; having the kernel wake only one is enough - it will
pop all idle workers and decide whether any other servers are needed
to process the newly available work.

[...]

>  > Workers are trickier, as they can be woken by signals and then block
>  > again, but stray signals are so bad here that I'm thinking of actually
>  > not letting sleeping workers wake on signals. Other than signals
>  > waking queued/unqueued idle workers, are there any other potential
>  > races here?
>
> Timeouts on blocked threads is virtually the same as a signal I think. I
> can see that both could lead to attempts at waking workers that are not
> blocked.

I've got preemption working well enough to warrant a new RFC patchset
(also have timeouts done, but these were easy). I'll clean things up,
change the idle servers logic to only one idle server exposed to the
kernel, not a list, add some additional documentation (state
transitions, userspace code snippets, etc.) and will post v0.4 RFC
patchset to LKML later this week.

[...]
