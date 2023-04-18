Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66606E6EA8
	for <lists+linux-api@lfdr.de>; Tue, 18 Apr 2023 23:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjDRVvp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 18 Apr 2023 17:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbjDRVvl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 18 Apr 2023 17:51:41 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3ED93C7
        for <linux-api@vger.kernel.org>; Tue, 18 Apr 2023 14:51:37 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-54fe82d8bf5so162714247b3.3
        for <linux-api@vger.kernel.org>; Tue, 18 Apr 2023 14:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1681854696; x=1684446696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bS8u4Ikaa66x0dKQnSLt0T4EeOHh6siINt+8q3mYgU=;
        b=IdxfrzEVF8ipu50M2fzMmApVqbzs075jgqFvZZk+Y848LHNEwZCPGF+1SQOSbkG4ey
         qp1Lsgl5M4XP5pSbD/9ieXUTVd8nSKeUyCNTKspOmox35763C1ytOFJFy3xoSghxC8n4
         /+niRJbaLy0rannApLFjjdDoNhx+rNA/3qk6o9K6OcNMUgZdJBfLVfjYw+mbdYLwwxHR
         L2WDiWz7D4YIrJNrUexffNPQNAEouDp9fDsNWXzbSW308ZVYpMEr4WhPdMN6bOXx+NMz
         GQcPdoELy1/bIRv/B2MOmHj4hq0307NJMgBVyu2NKAfqEna1c1ykVD0A33kqbq6R4NPm
         Do4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681854696; x=1684446696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/bS8u4Ikaa66x0dKQnSLt0T4EeOHh6siINt+8q3mYgU=;
        b=gJe0xKLXKGe4wIAxWz1LcdyRiWtIpa9D8csTIfi/yWbj4ShbWRsSDhdX9ouoJlvE4N
         aHa7dJr/kO90wbP3U647daqEKpvtP/mKBFlg5m/Gz9bsrR+LP/fAXMQnwCiyZ9o4FJ6K
         VEZ+IvghO6oU8brlwNU+sei6fQF0XiSR+NlCqQLfO1AX9E9AL91K7bWVTVitjY2JPOCx
         HemOeDoL449H11YhJ4PWzy/2vwDKM1EGmiuV6RCDoCj5XSazDhD2cwZw+0WXq17/QiLa
         XLK+/RQua1dTb5bhnNJiq9HQiDRN7GHkpLYsrG1tPt4HPPL0tsIq+/W37CmXSJvcCdtY
         qvRA==
X-Gm-Message-State: AAQBX9cpr7C0jrFBjjXzjlh99qpty2yCfylSPsUOtpBFdtRUXlo5yh1G
        H1c5o9zFDhNtdFfFGc9fuUA9LJFNU0HmCDPHSsnyOWt8PLCupOA=
X-Google-Smtp-Source: AKy350ZRdPRJ9oxB33BDZoE/ufCet87zltLytIuCHu6OWmcg2NMuRUpNuAmwjaKBcG+3qtcDhM+k/geOuScTrsaGDzI=
X-Received: by 2002:a81:d302:0:b0:54f:69a4:151e with SMTP id
 y2-20020a81d302000000b0054f69a4151emr721790ywi.8.1681854694933; Tue, 18 Apr
 2023 14:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230411155921.14716-1-casey@schaufler-ca.com> <20230411155921.14716-8-casey@schaufler-ca.com>
In-Reply-To: <20230411155921.14716-8-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 18 Apr 2023 17:51:24 -0400
Message-ID: <CAHC9VhTX-JnS11Ywfwf2aTvh1J3KBdsfCp3k1C=8WyLcgRNDig@mail.gmail.com>
Subject: Re: [PATCH v8 07/11] LSM: Helpers for attribute names and filling an lsm_ctx
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Apr 11, 2023 at 12:02=E2=80=AFPM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
>
> Add lsm_name_to_attr(), which translates a text string to a
> LSM_ATTR value if one is available.
>
> Add lsm_fill_user_ctx(), which fills a struct lsm_ctx, including
> the trailing attribute value. The .len value is padded to a multiple
> of the size of the structure for alignment.
>
> All are used in module specific components of LSM system calls.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/security.h | 13 +++++++++++
>  security/lsm_syscalls.c  | 24 ++++++++++++++++++++
>  security/security.c      | 48 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 85 insertions(+)

...

> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> index 6efbe244d304..67106f642422 100644
> --- a/security/lsm_syscalls.c
> +++ b/security/lsm_syscalls.c
> @@ -17,6 +17,30 @@
>  #include <linux/lsm_hooks.h>
>  #include <uapi/linux/lsm.h>
>
> +/**
> + * lsm_name_to_attr - map an LSM attribute name to its ID
> + * @name: name of the attribute
> + *
> + * Returns the LSM attribute value associated with @name, or 0 if
> + * there is no mapping.
> + */
> +u64 lsm_name_to_attr(const char *name)
> +{
> +       if (!strcmp(name, "current"))
> +               return LSM_ATTR_CURRENT;
> +       if (!strcmp(name, "exec"))
> +               return LSM_ATTR_EXEC;
> +       if (!strcmp(name, "fscreate"))
> +               return LSM_ATTR_FSCREATE;
> +       if (!strcmp(name, "keycreate"))
> +               return LSM_ATTR_KEYCREATE;
> +       if (!strcmp(name, "prev"))
> +               return LSM_ATTR_PREV;
> +       if (!strcmp(name, "sockcreate"))
> +               return LSM_ATTR_SOCKCREATE;
> +       return 0;
> +}

Thank you :)

>  /**
>   * sys_lsm_set_self_attr - Set current task's security module attribute
>   * @attr: which attribute to set
> diff --git a/security/security.c b/security/security.c
> index bfe9a1a426b2..453f3ff591ec 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -752,6 +752,54 @@ static int lsm_superblock_alloc(struct super_block *=
sb)
>         return 0;
>  }
>
> +/**
> + * lsm_fill_user_ctx - Fill a user space lsm_ctx structure
> + * @ctx: an LSM context to be filled
> + * @context: the new context value
> + * @context_size: the size of the new context value
> + * @id: LSM id
> + * @flags: LSM defined flags
> + *
> + * Fill all of the fields in a user space lsm_ctx structure.
> + * Caller is assumed to have verified that @ctx has enough space
> + * for @context.
> + *
> + * The total length is padded to an integral number of lsm_ctx.

Considering that lsm_ctx is variable length I'm not sure that makes a
lot of sense, how about we pad the total length so that the @ctx entry
is a multiple of 64-bits?  If needed we can always change this later
as the lsm_ctx struct is inherently variable in length and userspace
will need to deal with the buffer regardless of alignment.

> + * Returns 0 on success, -EFAULT on a copyout error.
> + */
> +int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
> +                     size_t context_size, u64 id, u64 flags)
> +{
> +       struct lsm_ctx *lctx;
> +       size_t locallen;
> +       u8 *composite;
> +       int rc =3D 0;
> +
> +       locallen =3D sizeof(*ctx);
> +       if (context_size)
> +               locallen +=3D sizeof(*ctx) * ((context_size / sizeof(*ctx=
)) + 1);

It seems cleaner to use the kernel's ALIGN() macro:

  /* ensure the lsm_ctx length is a multiple of 64-bits */
  locallen =3D ALIGN(sizeof(*ctx) + context_size, 8);
  lctx =3D kzalloc(locallen, GFP_KERNEL)
  if (!lctx)
    return -ENOMEM;

> +       composite =3D kzalloc(locallen, GFP_KERNEL);
> +       if (composite =3D=3D NULL)
> +               return -ENOMEM;
> +
> +       lctx =3D (struct lsm_ctx *)composite;
> +       lctx->id =3D id;
> +       lctx->flags =3D flags;
> +       lctx->ctx_len =3D context_size;
> +       lctx->len =3D locallen;
> +
> +       memcpy(composite + sizeof(*lctx), context, context_size);

Is there a problem with doing `memcpy(lctx->ctx, context,
context_size)` in place of the memcpy above?  That is easier to read
and we can get rid of @composite.

> +       if (copy_to_user(ctx, composite, locallen))
> +               rc =3D -EFAULT;
> +
> +       kfree(composite);
> +
> +       return rc;
> +}

I understand Micka=C3=ABl asked you to do a single copy_to_user(), but I'm
not sure it is worth it if we have to add a temporary buffer
allocation like that.  How about something like below (v7 with some
tweaks/padding)?  You could be a bit more clever with the memset if
you want, I was just typing this up quickly ...

int lsm_fill_user_ctx(...)
{
  struct lsm_ctx lctx;

  /* ensure the lctx length is a multiple of 64-bits */
  lctx.len =3D ALIGN(sizeof(lctx) + context_size, 8);

  lctx.id =3D id;
  lctx.flags =3D flags;
  lctx.ctx_len =3D context_size;

  memset(ctx, 0, lctx.len);
  if (copy_to_user(ctx, &lctx, sizeof(lctx))
    return -EFAULT;
  if (copy_to_user(&ctx[1], context, context_size)
    return -EFAULT;

  return 0;
}

--
paul-moore.com
