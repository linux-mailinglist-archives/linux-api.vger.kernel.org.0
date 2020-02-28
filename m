Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B06231741ED
	for <lists+linux-api@lfdr.de>; Fri, 28 Feb 2020 23:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgB1WWx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 28 Feb 2020 17:22:53 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37102 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgB1WWx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 28 Feb 2020 17:22:53 -0500
Received: by mail-vs1-f67.google.com with SMTP id h5so2026638vsc.4
        for <linux-api@vger.kernel.org>; Fri, 28 Feb 2020 14:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3leODBZgI1wn5rT6+IG8JL0u+wwlT+mFgWEDYIowxnM=;
        b=QqFkXbni803CbMFsPllFF8VtTlmkShHFA0dBvma1pHpI17Ow/D6B3s8kfNeZ1W8Qks
         UeIOZ3z5ogst2O0WGHULt8GfrR2MFyniXs5Tic7mTIICJGgi2VO0J2Crwiokrw4vcR6m
         3YeRgKcluhVO8rIamGWPRwE48ofPWx3iYlQfXUcdlYRXdVufOY1RwlOdIFftRpLdHN68
         vYTAP1QeN/JaSnnEOzCNZjsJXmf5bObEavHcEljWuC+V8MK2uoP/JJ4VQkXLLsIxamSq
         0JMyyeZ+JnFUH05Bh8wdNrJrwWVL8nQNIHhCesC7vrJ9au4a6fj07MD7++eTZPFNfDUi
         Mzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3leODBZgI1wn5rT6+IG8JL0u+wwlT+mFgWEDYIowxnM=;
        b=K2F7JrS4jDbWz24sE+g/5fwIegzA26m4Fhwqgld6viy9EQH4CKtpd8vuFf9DSeGrHl
         m7yHpzrwStJQnIWn0nRal5Jb26R43jnjCmzfxz8iN8TloEAVZXj/1gWTa9l3XnSz05/F
         427R/zNJGnt4ZQCqxtP+ZQQDH1ega8bAy2j5u4rxayQhUPCKg/K4VxRm2arnwrvlECBf
         tTAKuzmz1Hr37KvIOMpIhJ41UrUnBCV5pMVn0fCHJ498WHCeWqvS1oSKXy/H1Df4QAMh
         NT2o+NjA9PGdPvHyQ6GhHsCJ+yU7XrvgalAQ/PCR49CTqOShdg/PYA6wGyWTH7O9SEoS
         BLmg==
X-Gm-Message-State: ANhLgQ0/rWKx6JuVeGVSHh2+uR3jiPoKFpsAOMVbtldgRaFvHkGgNEqn
        eI6wi4+99jMw15Ia1Y4xK1lVtsrZmLpnpOjWjIftAw==
X-Google-Smtp-Source: ADFU+vulVMRO9hqXsq6DyGOcza2Ezp8x3iGhT2uVR5PRNG8Bbs+pnvNbGwRXw0H365h7s7hHAKh2ma/PAcAGP/kQ/6I=
X-Received: by 2002:a05:6102:303a:: with SMTP id v26mr3987849vsa.119.1582928571863;
 Fri, 28 Feb 2020 14:22:51 -0800 (PST)
MIME-Version: 1.0
References: <20200219014433.88424-1-minchan@kernel.org> <20200219014433.88424-5-minchan@kernel.org>
In-Reply-To: <20200219014433.88424-5-minchan@kernel.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 28 Feb 2020 14:22:40 -0800
Message-ID: <CAJuCfpFRkayitpbkDdH_JOeYjMJB=4HYJywwgRnoCDQzHg8sLQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/7] pid: move pidfd_get_pid function to pid.c
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>, sj38.park@gmail.com,
        alexander.h.duyck@linux.intel.com, Jann Horn <jannh@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Feb 18, 2020 at 5:44 PM Minchan Kim <minchan@kernel.org> wrote:
>
> process_madvise syscall needs pidfd_get_pid function to translate
> pidfd to pid so this patch move the function to kernel/pid.c.
>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Christian Brauner <christian@brauner.io>
> Suggested-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  include/linux/pid.h |  1 +
>  kernel/exit.c       | 17 -----------------
>  kernel/pid.c        | 17 +++++++++++++++++
>  3 files changed, 18 insertions(+), 17 deletions(-)
>
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index 998ae7d24450..993f68cb45c2 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -75,6 +75,7 @@ extern const struct file_operations pidfd_fops;
>  struct file;
>
>  extern struct pid *pidfd_pid(const struct file *file);
> +struct pid *pidfd_get_pid(unsigned int fd);
>
>  static inline struct pid *get_pid(struct pid *pid)
>  {
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 0b81b26a872a..43375f9d8bbc 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -1470,23 +1470,6 @@ static long do_wait(struct wait_opts *wo)
>         return retval;
>  }
>
> -static struct pid *pidfd_get_pid(unsigned int fd)
> -{
> -       struct fd f;
> -       struct pid *pid;
> -
> -       f = fdget(fd);
> -       if (!f.file)
> -               return ERR_PTR(-EBADF);
> -
> -       pid = pidfd_pid(f.file);
> -       if (!IS_ERR(pid))
> -               get_pid(pid);
> -
> -       fdput(f);
> -       return pid;
> -}
> -
>  static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
>                           int options, struct rusage *ru)
>  {
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 0f4ecb57214c..360ba480a2a9 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -496,6 +496,23 @@ struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
>         return idr_get_next(&ns->idr, &nr);
>  }
>
> +struct pid *pidfd_get_pid(unsigned int fd)
> +{
> +       struct fd f;
> +       struct pid *pid;
> +
> +       f = fdget(fd);
> +       if (!f.file)
> +               return ERR_PTR(-EBADF);
> +
> +       pid = pidfd_pid(f.file);
> +       if (!IS_ERR(pid))
> +               get_pid(pid);
> +
> +       fdput(f);
> +       return pid;
> +}
> +
>  /**
>   * pidfd_create() - Create a new pid file descriptor.
>   *
> --
> 2.25.0.265.gbab2e86ba0-goog
>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>
