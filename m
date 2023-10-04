Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2DA7B8D81
	for <lists+linux-api@lfdr.de>; Wed,  4 Oct 2023 21:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243752AbjJDTiA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Oct 2023 15:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbjJDTiA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Oct 2023 15:38:00 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4AFAD
        for <linux-api@vger.kernel.org>; Wed,  4 Oct 2023 12:37:55 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d8162698f0dso266971276.0
        for <linux-api@vger.kernel.org>; Wed, 04 Oct 2023 12:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1696448275; x=1697053075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQGn2Phe0RwYW5SGubGGOv+c/hAGSSs2LrA09w+wOG8=;
        b=TilTgkhZouIPuv7GuwoG4+G6t7andK6GaOW7wftIFaIREBfgJYPJjkN6KSK+Avay1v
         okj2r3PfUPtWwxcVfYzuc5MIEkhfTszqWOo4sILSQ+TwvnDqz3vm/FRq/pTgPApIJcuR
         xeu8lYuf4TL5C3DOHXnWsxMwLmJ8NFRWzBd9dMgzmLbzx2UVGMEkHFAy7LdbgWhwznu9
         q4MPPTMc+XkAxik+CKCeMKAMl6Ppmmh6L4Fb2iaAJqVXH69Q8w9yDfPkAQh5pDn7RGoo
         QKUSyOL5Kit6+OQz+MneFcrB66bi0fLGTNflIfkoKvSCaS7dbthDD6qpSpwI/e+ED9en
         /4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696448275; x=1697053075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQGn2Phe0RwYW5SGubGGOv+c/hAGSSs2LrA09w+wOG8=;
        b=ZRMdcc0VB92Jn3+9zoTtF49BZ6R9TTG4sUgtwQyIwq/6gBxS7KfVC4/zfL7DbYfLnf
         5hgzNM3Yb/pk5A2guTcxQcKoFl3SV0lGT2ModyVJFMLazE8wfV/mqmwxZgfNfG+GjEWA
         ara0SOZQbZ30gmuWAGSv7GmielVaFGHDDIUhldrh6fkqWQb/cxQDCXf0m28YiYwO7Z+8
         xreVCwZOxQHbQYnh0+ZANdfJjgYahP62JW9VH+s0MEimLeMJlsOpawW4/K6G4HcV55sZ
         uBJzkHQc6n5I12c9o/1bEn5GzSpzK6BC//AseyAiNsIRYE79+aC9U9E+fKkQ0F4HbA/R
         yQdw==
X-Gm-Message-State: AOJu0YyIYNBGyaL9sTHke64jzUYs3VrIgxPAewPILuvV5pedioH6ATjj
        qxoPHZzh72fCtBHSNYPQ0LD81fbatRyUVbsxxnrz
X-Google-Smtp-Source: AGHT+IF/30kkFHZBZjg3KbcOdEkEVasuK1il9LqueAt4mYRrIgMYFlqbwoL44JXav1232SSuhV3Vc5nqAWjjxjk5xw0=
X-Received: by 2002:a05:6902:18c9:b0:d1a:955f:304d with SMTP id
 ck9-20020a05690218c900b00d1a955f304dmr3631465ybb.64.1696448274671; Wed, 04
 Oct 2023 12:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230928130147.564503-1-mszeredi@redhat.com> <20230928130147.564503-5-mszeredi@redhat.com>
In-Reply-To: <20230928130147.564503-5-mszeredi@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 4 Oct 2023 15:37:43 -0400
Message-ID: <CAHC9VhQD9r+Qf5Vz1XmxUdJJJO7HNTKdo8Ux=n+xkxr=JGFMrw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] add listmount(2) syscall
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 28, 2023 at 9:04=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.com=
> wrote:
>
> Add way to query the children of a particular mount.  This is a more
> flexible way to iterate the mount tree than having to parse the complete
> /proc/self/mountinfo.
>
> Lookup the mount by the new 64bit mount ID.  If a mount needs to be queri=
ed
> based on path, then statx(2) can be used to first query the mount ID
> belonging to the path.
>
> Return an array of new (64bit) mount ID's.  Without privileges only mount=
s
> are listed which are reachable from the task's root.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  arch/x86/entry/syscalls/syscall_32.tbl |  1 +
>  arch/x86/entry/syscalls/syscall_64.tbl |  1 +
>  fs/namespace.c                         | 69 ++++++++++++++++++++++++++
>  include/linux/syscalls.h               |  3 ++
>  include/uapi/asm-generic/unistd.h      |  5 +-
>  include/uapi/linux/mount.h             |  3 ++
>  6 files changed, 81 insertions(+), 1 deletion(-)

...

> diff --git a/fs/namespace.c b/fs/namespace.c
> index 3326ba2b2810..050e2d2af110 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4970,6 +4970,75 @@ SYSCALL_DEFINE4(statmount, const struct __mount_ar=
g __user *, req,
>         return ret;
>  }
>
> +static long do_listmount(struct vfsmount *mnt, u64 __user *buf, size_t b=
ufsize,
> +                        const struct path *root, unsigned int flags)
> +{
> +       struct mount *r, *m =3D real_mount(mnt);
> +       struct path rootmnt =3D {
> +               .mnt =3D root->mnt,
> +               .dentry =3D root->mnt->mnt_root
> +       };
> +       long ctr =3D 0;
> +       bool reachable_only =3D true;
> +       int err;
> +
> +       err =3D security_sb_statfs(mnt->mnt_root);
> +       if (err)
> +               return err;
> +
> +       if (flags & LISTMOUNT_UNREACHABLE) {
> +               if (!capable(CAP_SYS_ADMIN))
> +                       return -EPERM;
> +               reachable_only =3D false;
> +       }
> +
> +       if (reachable_only && !is_path_reachable(m, mnt->mnt_root, &rootm=
nt))
> +               return capable(CAP_SYS_ADMIN) ? 0 : -EPERM;
> +
> +       list_for_each_entry(r, &m->mnt_mounts, mnt_child) {
> +               if (reachable_only &&
> +                   !is_path_reachable(r, r->mnt.mnt_root, root))
> +                       continue;

I believe we would want to move the security_sb_statfs() call from
above to down here; something like this I think ...

  err =3D security_sb_statfs(r->mnt.mnt_root);
  if (err)
    /* if we can't access the mount, pretend it doesn't exist */
    continue;

> +               if (ctr >=3D bufsize)
> +                       return -EOVERFLOW;
> +               if (put_user(r->mnt_id_unique, buf + ctr))
> +                       return -EFAULT;
> +               ctr++;
> +               if (ctr < 0)
> +                       return -ERANGE;
> +       }
> +       return ctr;
> +}

--=20
paul-moore.com
