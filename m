Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08FE015C013
	for <lists+linux-api@lfdr.de>; Thu, 13 Feb 2020 15:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbgBMOJ1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 13 Feb 2020 09:09:27 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44932 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729957AbgBMOJ1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 13 Feb 2020 09:09:27 -0500
Received: by mail-ot1-f66.google.com with SMTP id h9so5632711otj.11
        for <linux-api@vger.kernel.org>; Thu, 13 Feb 2020 06:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4nw33WMxyw6QKvLrJuL4ZGQuHIvhtKY96hrtTChK5+k=;
        b=JMV5ecx9htpNi/FbHm837TWxQQnIS6MVyND+7+89vN4DdcJcTh4Gh4bRtl65ipvEjN
         EEHs4NTVx7M4oasK/DXdft+jw/aFsnnd0U95KdIgaWn6KiJkQMEl1dva2kskv2Q7A7ZF
         GK1/tnTUCRzZ/HxVdt6Xr7GAuMCUM299X8jjMXD2V6dOwV5W1/zk2CbvKlxK2fy7jQ2u
         FBok0zxVLa/eP6cevo1zALXoniqhlQwS3zBWhvsGPSVsSlbiBEk/JZYamujGtpRl0/E5
         TFh3Ndm7Ude+Y5TPcbUAN+tW/kabbK0oyXMXeJLp5BzmsfDmB7mqHVuPb2VH1uJiHu+0
         pJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4nw33WMxyw6QKvLrJuL4ZGQuHIvhtKY96hrtTChK5+k=;
        b=CfLg4eNSn8HEKjW2oMi5CstobPrNyV1FYlEigIbT7C7883JBmqD+Wye3CpsmygS7rf
         dCMfnUJekq+oJqc4h5zRJ7cXjdfocXeSdFoJkCHmy4tXQcc67clqQ9Owdiv2cNgOayMs
         1UqXX1mNCN3yDjXhjVvzFU0xO/BCg66rVsCvtrpPJiTznQ+lHVKNQ4hC93c/4pp4eOcS
         t/IkBCJ6EkYjmTb0DxXWkaf/taxouLwEgk5WfwvFAiR5N7LH01oDLfR8RgebtDstbEDq
         RiF+wUg9x5yFdSRZU2N6uiiWrErikS8D8nSaK+3mWhdutr1wP1v8MDgqw4xtnKrgS5G/
         nYEw==
X-Gm-Message-State: APjAAAXSkrqY3pGbe9z/SrMNwJVup69F0jSUaeRTXA+1XA/E5lbmwRqv
        mPwT0iioIZB6kCWZCAX14wxHjKtIK1t51BXxB8IqRA==
X-Google-Smtp-Source: APXvYqzs69ilwTt7mpNYz5FifCXRctI+mL576v4dQGuxV30QGmONxcX//NJyceEQjiY2JgsqWK+0BKXq9WztgI5XJac=
X-Received: by 2002:a05:6830:1d6e:: with SMTP id l14mr13199499oti.32.1581602965935;
 Thu, 13 Feb 2020 06:09:25 -0800 (PST)
MIME-Version: 1.0
References: <20200212233946.246210-1-minchan@kernel.org> <20200212233946.246210-3-minchan@kernel.org>
In-Reply-To: <20200212233946.246210-3-minchan@kernel.org>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 13 Feb 2020 15:08:59 +0100
Message-ID: <CAG48ez27=pwm5m_N_988xT1huO7g7h6arTQL44zev6TD-h-7Tg@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] mm: introduce external memory hinting API
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Feb 13, 2020 at 12:40 AM Minchan Kim <minchan@kernel.org> wrote:
> To solve the issue, this patch introduces a new syscall process_madvise(2).
> It uses pidfd of an external process to give the hint.
[...]
> +       mm = mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
> +       if (IS_ERR_OR_NULL(mm)) {
> +               ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
> +               goto release_task;
> +       }
> +
> +       ret = do_madvise(task, start, len_in, behavior);

When you're accessing another task, you should ensure that the other
task doesn't gain new privileges by executing a setuid binary in the
middle of being accessed. mm_access() does that for you; it holds the
->cred_guard_mutex while it is looking up the task's ->mm and doing
the security check. mm_access() then returns you an mm pointer that
you're allowed to access without worrying about such things; an
mm_struct never gains privileges, since a setuid execution creates a
fresh mm_struct. However, the task may still execute setuid binaries
and such things.

This means that after you've looked up the mm with mm_access(), you
have to actually *use* that pointer. You're not allowed to simply read
task->mm yourself.

Therefore, I think you should:

 - change patch 1/8 ("mm: pass task to do_madvise") to also pass an
mm_struct* to do_madvise (but keep the task_struct* for patch 4/8)
 - in this patch, pass the mm_struct* from mm_access() into do_madvise()
 - drop patch 3/8 ("mm: validate mm in do_madvise"); it just papers
over a symptom without addressing the underlying problem
