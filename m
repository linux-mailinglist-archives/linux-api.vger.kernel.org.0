Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF34E1648EF
	for <lists+linux-api@lfdr.de>; Wed, 19 Feb 2020 16:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgBSPm3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 19 Feb 2020 10:42:29 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37230 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBSPm2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 19 Feb 2020 10:42:28 -0500
Received: by mail-oi1-f193.google.com with SMTP id q84so24229882oic.4
        for <linux-api@vger.kernel.org>; Wed, 19 Feb 2020 07:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5m55kfVwkJi2EKe9BNjAoqNwmjnBNj+rhpNNJ8psMf0=;
        b=m+WyVCnjj1MKoR4h4JIOlgp2fjMP9yF/DEMlRuSkziBg37L/i9PeB+qwHQtq+5TBM6
         SooNA0Wk6Ljhtp5qSzPtSknsnL4DWgLfrCjYHytGQKdcv6POKVRKZfNj2WLGQm/nydCI
         tLJnBS44YGa0T/JV/3kNf+/psgr2j9ltjMIFFiTi5//ha9SRMrTDUxEcO7tDYtXyCNU0
         0W+ISMm5w6/KIDLxt6/6C3JAxunTLQr6+KHCnpMaj0TdKqHVbfPLbNK5F/nDNzZq3/LD
         fJURS56rYXEp2uY/mJftWB6gjcZlAAKUD1/slAZtFwMjuk9DFgtmJPrszBy2PNb1wk3w
         XhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5m55kfVwkJi2EKe9BNjAoqNwmjnBNj+rhpNNJ8psMf0=;
        b=OrljZrUk4//ZgcndINv8o7QyPjk4sOcz7KxVRMOQs62KjFvpQlMSVsuiQmbOSBlzA3
         U2ndbiQ7bv0NrvFk+fX6rfLAb+XcrNjJz2nCN03d4lvWsFEtSN6BIe4ldOsZBPsmQERL
         bEmukDqPq7OsPuJGrqPYFFsdIWBUcnPEVYkEpw0izcFhrzjUJmyO/V81ug2uw+rlZAbA
         7CDOIqRZcpORQsxnbo8fy0+SK9szum6qJO3J6RKUOZygmDOlcyFLwZmMlOaMDcMJZ5Vv
         G+7yDcwWWHRCsW48+sA/tN0SXRbLzT4g80y4WEZFQPmqXXBv/tngRZDtGB7OfH7VK32v
         S5yg==
X-Gm-Message-State: APjAAAUIRKQWeiLuKZRvDNh9qxVwebAHzesIgpilXwMT9uuXWX22StLf
        ePNH8x2sU5FCPEcppVQG/DgKwXVQiU/C/N5ofgwCDg==
X-Google-Smtp-Source: APXvYqzYVTetcJbLAR2lHbzroMwjo5ViVjvR49a/DJvQymhESORCu2lQOkJU6wuyq4SCG9SAJgJJeWDh3Spsw3GeH0I=
X-Received: by 2002:aca:484a:: with SMTP id v71mr5008155oia.39.1582126947895;
 Wed, 19 Feb 2020 07:42:27 -0800 (PST)
MIME-Version: 1.0
References: <20200218143411.2389182-1-christian.brauner@ubuntu.com> <20200218143411.2389182-25-christian.brauner@ubuntu.com>
In-Reply-To: <20200218143411.2389182-25-christian.brauner@ubuntu.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 19 Feb 2020 16:42:01 +0100
Message-ID: <CAG48ez3onfVSYF_qx+jJuz0y+KuZ3U75Or8dxFhiDqMTdXzCZg@mail.gmail.com>
Subject: Re: [PATCH v3 24/25] sys: handle fsid mappings in set*id() calls
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Stephen Barber <smbarber@chromium.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Phil Estes <estesp@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Feb 18, 2020 at 3:37 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> Switch set*id() calls to lookup fsids in the fsid mappings. If no fsid mappings
> are setup the behavior is unchanged, i.e. fsids are looked up in the id
> mappings.
[...]
> @@ -353,7 +354,7 @@ long __sys_setregid(gid_t rgid, gid_t egid)
>         const struct cred *old;
>         struct cred *new;
>         int retval;
> -       kgid_t krgid, kegid;
> +       kgid_t krgid, kegid, kfsgid;
>
>         krgid = make_kgid(ns, rgid);
>         kegid = make_kgid(ns, egid);
> @@ -385,12 +386,20 @@ long __sys_setregid(gid_t rgid, gid_t egid)
>                         new->egid = kegid;
>                 else
>                         goto error;
> +               kfsgid = make_kfsgid(ns, egid);
> +       } else {
> +               kfsgid = kgid_to_kfsgid(new->user_ns, new->egid);
> +       }

Here the "kfsgid" is the new filesystem GID as translated by the
special fsgid mapping...

> +       if (!gid_valid(kfsgid)) {
> +               retval = -EINVAL;
> +               goto error;
>         }
>
>         if (rgid != (gid_t) -1 ||
>             (egid != (gid_t) -1 && !gid_eq(kegid, old->gid)))
>                 new->sgid = new->egid;
> -       new->fsgid = new->egid;
> +       new->kfsgid = new->egid;

... but the "kfsgid" of the creds struct is translated by the normal
gid mapping...

> +       new->fsgid = kfsgid;

... and the local "kfsgid" is stored into the "fsgid" member.

This is pretty hard to follow. Can you come up with some naming scheme
that is clearer and where one name is always used for the
normally-translated fsgid and another name is always used for the
specially-translated fsgid? E.g. something like "pfsgid" (with the "p"
standing for "process", because it uses the same id mappings as used
for process identities) for the IDs translated via the normal gid
mapping?
