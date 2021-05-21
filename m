Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133B438CEDA
	for <lists+linux-api@lfdr.de>; Fri, 21 May 2021 22:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhEUUUq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 May 2021 16:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbhEUUUp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 May 2021 16:20:45 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405B2C06138B
        for <linux-api@vger.kernel.org>; Fri, 21 May 2021 13:19:21 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id lg14so32201340ejb.9
        for <linux-api@vger.kernel.org>; Fri, 21 May 2021 13:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aVEzTQ8I4J/3yp3MgA3FQPj62TME7oEjwi3UB54+9j4=;
        b=y5acabY0hHaFulLVyRw96Upc3Tfg5b6Vkr2way0sktzbQKqkTD9yR07FT7pm2dbtK2
         OmIX/Fgm2xBpq1gKrI2N3x9jMvF7NuA98vf/xJIjcCcJndHdWK2E02xm9dExvkQ5GvlT
         h0DXHodT+NB8JKTBfAsvxDtMdKm5KcxkiQcmBzjtyoKUWgK2oHjZtxvU8b6+lwdlDQjc
         D5hZyeGTTzmQ2/4wUyAApkMxFk9M65r/4JDnrXFYNPAeRoAD80OVIQWfeFAH/8N1BNVg
         qn061UVWCxSDmBHw6mCcH4UI/nRyNhP8vsZk5WokXPfE22Hielso21jzz8/mj0UnuA1U
         Ha5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aVEzTQ8I4J/3yp3MgA3FQPj62TME7oEjwi3UB54+9j4=;
        b=Bmnza2FwZDKupaAo/9ItarJN+ipZ2FY94ai+BitooyeT05E0eB6VcL5xzCzukPApF6
         /L3cdMUQQwM40a3OVJMmGH+k4364OwhThxrbX32tkN0zBa/9PMOVoGu1jy+UmONTAxRa
         5/Os+fMIYDw7q4clP246UveJbvDz+JspRRKHvqe+LFH6TdeWUPgOc36rB7zHA92pHdYA
         ZUHS2wZqDSFgxAISqZ8Q6Ku4UjVVla+O1IN3JKgTkKmnEQhqUK27KIyyyw3g0ljELEhk
         IBDjljK6b4gVZPzqO4rOnylINPwzXoUNnTugOEnfnTsEPRtufXkzPYbXoOQq8A6oIVtB
         zDzg==
X-Gm-Message-State: AOAM5332mNjrEtxgwFjcqgyklP2qYjyw8CsIQOZUD1/Sw9BPIeFVreSt
        TqNsLS9AJRoXD4G2k60WqPdKDUOqosHQoq1F1IVB
X-Google-Smtp-Source: ABdhPJziKJYfK7MvqTrwnHeo+NPoz2FUDF+4sST5fBaH9Y8+nll4YIEPRA92LUzjYQjCfkAjrte8Kmy6TkEhHB1xuyQ=
X-Received: by 2002:a17:906:7e0f:: with SMTP id e15mr11771196ejr.398.1621628359745;
 Fri, 21 May 2021 13:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210513200807.15910-1-casey@schaufler-ca.com>
 <20210513200807.15910-15-casey@schaufler-ca.com> <202105141218.21BDA22F@keescook>
 <c1ab101a-7ee3-6d20-c8b1-cff5bcdfe98c@schaufler-ca.com>
In-Reply-To: <c1ab101a-7ee3-6d20-c8b1-cff5bcdfe98c@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 May 2021 16:19:08 -0400
Message-ID: <CAHC9VhScDhmr2k5RpNhj1=6FpO_xPN1C6_qFqbXb6SWUbBiENA@mail.gmail.com>
Subject: Re: [PATCH v26 14/25] LSM: Specify which LSM to display
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Kees Cook <keescook@chromium.org>, casey.schaufler@intel.com,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, May 17, 2021 at 3:53 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 5/14/2021 12:23 PM, Kees Cook wrote:
> > On Thu, May 13, 2021 at 01:07:56PM -0700, Casey Schaufler wrote:
> >> Create a new entry "interface_lsm" in the procfs attr directory for
> >> controlling which LSM security information is displayed for a
> >> process. A process can only read or write its own display value.
> >>
> >> The name of an active LSM that supplies hooks for
> >> human readable data may be written to "interface_lsm" to set the
> >> value. The name of the LSM currently in use can be read from
> >> "interface_lsm". At this point there can only be one LSM capable
> >> of display active. A helper function lsm_task_ilsm() is
> >> provided to get the interface lsm slot for a task_struct.
> >>
> >> Setting the "interface_lsm" requires that all security modules using
> >> setprocattr hooks allow the action. Each security module is
> >> responsible for defining its policy.
> >>
> >> AppArmor hook provided by John Johansen <john.johansen@canonical.com>
> >> SELinux hook provided by Stephen Smalley <stephen.smalley.work@gmail.com>
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> Cc: Kees Cook <keescook@chromium.org>
> >> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> >> Cc: Paul Moore <paul@paul-moore.com>
> >> Cc: John Johansen <john.johansen@canonical.com>
> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Cc: linux-api@vger.kernel.org
> >> Cc: linux-doc@vger.kernel.org
> >> ---
> >>  .../ABI/testing/procfs-attr-lsm_display       |  22 +++
> >>  Documentation/security/lsm.rst                |  14 ++
> >>  fs/proc/base.c                                |   1 +
> >>  include/linux/lsm_hooks.h                     |  17 ++
> >>  security/apparmor/include/apparmor.h          |   3 +-
> >>  security/apparmor/lsm.c                       |  32 ++++
> >>  security/security.c                           | 166 ++++++++++++++++--
> >>  security/selinux/hooks.c                      |  11 ++
> >>  security/selinux/include/classmap.h           |   2 +-
> >>  security/smack/smack_lsm.c                    |   7 +
> >>  10 files changed, 256 insertions(+), 19 deletions(-)
> >>  create mode 100644 Documentation/ABI/testing/procfs-attr-lsm_display

...

> >> @@ -2171,23 +2203,110 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
> >>                              char **value)
> >>  {
> >>      struct security_hook_list *hp;
> >> +    int ilsm = lsm_task_ilsm(current);
> >> +    int slot = 0;
> >> +
> >> +    if (!strcmp(name, "interface_lsm")) {
> >> +            /*
> >> +             * lsm_slot will be 0 if there are no displaying modules.
> >> +             */
> >> +            if (lsm_slot == 0)
> >> +                    return -EINVAL;
> >> +
> >> +            /*
> >> +             * Only allow getting the current process' interface_lsm.
> >> +             * There are too few reasons to get another process'
> >> +             * interface_lsm and too many LSM policy issues.
> >> +             */
> >> +            if (current != p)
> >> +                    return -EINVAL;
> > ... but context isn't established by just checking "current", as this
> > file handle may have been given to another process.
> >
> > I suspect the security_get/setprocattr needs to gain a pointer to "file"
> > so that the f_cred struct can be examined[1] (i.e. compare opener
> > against reader/writer).
> >
> > [1] https://www.kernel.org/doc/html/latest/security/credentials.html#open-file-credentials
>
> It's not credentials being checked here. The check is whether the task that
> would be affected is "current". Process A can't open /proc/B/attr/interface_lsm
> with write access. The only process that can open it for write access is B.
> If process B opens /proc/B/attr/interface_lsm for write access it could send
> the file handle to process A, but process A can't write to the file because
> (current != p) that is, (A != B).

Agreed.

Acked-by: Paul Moore <paul@paul-moore.com>


--
paul moore
www.paul-moore.com
