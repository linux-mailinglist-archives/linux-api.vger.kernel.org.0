Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D96BD3633
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 02:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfJKAjC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Oct 2019 20:39:02 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38751 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727609AbfJKAjB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 Oct 2019 20:39:01 -0400
Received: by mail-lf1-f66.google.com with SMTP id u28so5734527lfc.5
        for <linux-api@vger.kernel.org>; Thu, 10 Oct 2019 17:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pm/TZSzXy437wu+vyWK0Qjm9IhWSg3vJAsAFSwxSnrk=;
        b=1KcesDffcGnKA4GAzrknPzqvQrPTCqS9t2/rckO1iG3HulAZG3zPkLOIB4rv9R2qm1
         cYK5lMtArrFF57CeA2o5TZF9NYI1WYOiaZQ8jRjc6DGgrpvU1cKMJEQGMnUwzFG9eOQL
         QubM+E7t070B7K+SENHzNKM83N5bfzYlNct+yvWYwNb7ONj4jpPp1fB2aVwMmRZJOuCJ
         JLWOCEG9U1Az0cT3rZOmZLSFoxZqFlXSNi632LpISf8g5LANO33I819fqUC4Y3msBH3t
         Az/5MQmT+V6oQZhDIEF/9UeUDII17W0qJJhQ0RrtmnQv3E6NBA1WraU96da6QpQto2Zu
         zaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pm/TZSzXy437wu+vyWK0Qjm9IhWSg3vJAsAFSwxSnrk=;
        b=KVFj3gT6RlvG9myWqpZ9tJRMo4IQ9tq0mbxloAI5TbP0pWQyJcii1hpBwohkfIDGOO
         7McqUugVt03XUQzB2pg9P9wAmc3mlivzl9UxT/8s/RFI3VWXHqFvOMmWJ6w7Gn5ofhF1
         00OAS7GzNf0tLqbRFcT6E5PU6Q0V7ODtAwjBiksstONARuULDC+9WxFCXCVQ6vcX/URV
         VSc6A0KjRRzts2qM2AJVq+ia6zIM406nEZy2xTE4vyNKYSRr3FN+Zo4zDViJTvqjeL7R
         uSLJHLqrXuKloxkkrRPM8oDFzrST0oUmyeFJgNsKmOxOUeysqdZEhdrOiQhtxSaH14xq
         B4kA==
X-Gm-Message-State: APjAAAVTk1U1A7nQdpTTt+ysdGmqqqxqFZUrNFA9OVp82Kpxg3TlaWFY
        udRoWkO4YzLYQI491bTCwRR6I8Bb4mRnj5ahP5SKjK0=
X-Google-Smtp-Source: APXvYqxG/pSHweUE1uKB7QkPj7LT5EXlmpz5kWU352mmZUeLqkWI276AG/DSr8XDfskTEFx9V66sNy0xCK/wzAtSSqQ=
X-Received: by 2002:ac2:5542:: with SMTP id l2mr7186058lfk.119.1570754338909;
 Thu, 10 Oct 2019 17:38:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568834524.git.rgb@redhat.com> <71b75f54342f32f176c2b6d94584f2a666964e68.1568834524.git.rgb@redhat.com>
In-Reply-To: <71b75f54342f32f176c2b6d94584f2a666964e68.1568834524.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 10 Oct 2019 20:38:47 -0400
Message-ID: <CAHC9VhQYVzGKRx48dgX1j3CJOe1N0widkhWb=_-3ohnOdZHhUw@mail.gmail.com>
Subject: Re: [PATCH ghak90 V7 05/21] audit: log drop of contid on exit of last task
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, omosnace@redhat.com, dhowells@redhat.com,
        simo@redhat.com, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com, Dan Walsh <dwalsh@redhat.com>,
        mpatel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 18, 2019 at 9:24 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> Since we are tracking the life of each audit container indentifier, we
> can match the creation event with the destruction event.  Log the
> destruction of the audit container identifier when the last process in
> that container exits.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/audit.c   | 32 ++++++++++++++++++++++++++++++++
>  kernel/audit.h   |  2 ++
>  kernel/auditsc.c |  2 ++
>  3 files changed, 36 insertions(+)
>
> diff --git a/kernel/audit.c b/kernel/audit.c
> index ea0899130cc1..53d13d638c63 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2503,6 +2503,38 @@ int audit_set_contid(struct task_struct *task, u64 contid)
>         return rc;
>  }
>
> +void audit_log_container_drop(void)
> +{
> +       struct audit_buffer *ab;
> +       uid_t uid;
> +       struct tty_struct *tty;
> +       char comm[sizeof(current->comm)];
> +
> +       if (!current->audit || !current->audit->cont ||
> +           refcount_read(&current->audit->cont->refcount) > 1)
> +               return;
> +       ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_CONTAINER_OP);
> +       if (!ab)
> +               return;
> +
> +       uid = from_kuid(&init_user_ns, task_uid(current));
> +       tty = audit_get_tty();
> +       audit_log_format(ab,
> +                        "op=drop opid=%d contid=%llu old-contid=%llu pid=%d uid=%u auid=%u tty=%s ses=%u",
> +                        task_tgid_nr(current), audit_get_contid(current),
> +                        audit_get_contid(current), task_tgid_nr(current), uid,
> +                        from_kuid(&init_user_ns, audit_get_loginuid(current)),
> +                        tty ? tty_name(tty) : "(none)",
> +                                audit_get_sessionid(current));
> +       audit_put_tty(tty);
> +       audit_log_task_context(ab);
> +       audit_log_format(ab, " comm=");
> +       audit_log_untrustedstring(ab, get_task_comm(comm, current));
> +       audit_log_d_path_exe(ab, current->mm);
> +       audit_log_format(ab, " res=1");
> +       audit_log_end(ab);
> +}

Why can't we just do this in audit_cont_put()?  Is it because we call
audit_cont_put() in the new audit_free() function?  What if we were to
do it in __audit_free()/audit_free_syscall()?

--
paul moore
www.paul-moore.com
