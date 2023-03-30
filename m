Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14A66CF891
	for <lists+linux-api@lfdr.de>; Thu, 30 Mar 2023 03:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjC3BNK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 29 Mar 2023 21:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjC3BNJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 29 Mar 2023 21:13:09 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7308B5277
        for <linux-api@vger.kernel.org>; Wed, 29 Mar 2023 18:13:03 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id k17so21665265ybm.11
        for <linux-api@vger.kernel.org>; Wed, 29 Mar 2023 18:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1680138782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXJuH4+zi+/MMgrdfkbLfVL94s0Gkym3lpLnVhFgnPI=;
        b=Ya57IjZqn3R/knpdkFDNWTnpqO1nF9sa9ZtXoRj3N9gyG3h6UOysD16RMv4WcS/QN7
         qnNA3Mkr+uPa5bzE7TylZb63MxWB2+rJyzmetuCVHJyb+306IA2zr0cXgbdYNENVj5dY
         aq1YBAbDb+o4XT3xBqvTIx1ZpdcehR2vXkhqok4rGf913AFv0bYJ7WJEF+7tih3qOE1+
         8XA3FL6MuU0Ndr2Vh8fJ0j3m0yU9uF+gnJIAspxx3KqubipTJIP1S6E3Dxe0daROawsD
         O6ut/OBesdTxPwkwBNhXnEH5KgHfNG65Yj9wxq99xvukBXZgkBM9Yl2X2X72x+XzDgzB
         BZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680138782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXJuH4+zi+/MMgrdfkbLfVL94s0Gkym3lpLnVhFgnPI=;
        b=UtX6NJIlZW/sEUoUYnfu8wP0K8041cGfBfp72MuqjWSmwXnyqVHoOZ1TtX2W59YM3G
         bhSdAdzl6rnsKD41Nt8GonTcl39WoK9ZHO820lxJOOa3fCG7wJeb7j5VDrXCmk5qCH/x
         wWYXNMJjQ9pRXDjezMlR554u6cyFdwZLA1WCuIspB9brA/ojV0EJcqOtgfPCd1Y/2oqH
         d2NR/x19FWuepQXbkACSs7Slliw+RAiwX19bVPDtGZ/DRmvNTNwBvaQitJYF26IM72XR
         R2Bk6//OgfD+gz/ekPdL7rFH7a82cICZOv9oxaO+ox6dBGj2ohMdyEPASNRtRYOAz1lg
         NH5A==
X-Gm-Message-State: AAQBX9fE/Breh7FG9ydfaXClx/Ms0jflxrqSuIsOJy1zP/oc94jiLYlT
        +2oWUGY92lO6X04nv1O6AZ5mFGdpBE0apmSJ96JR
X-Google-Smtp-Source: AKy350Z2yN4kbSDx95+6XZH60LES+XR6Emn1TIIxi2Oa1YE8MnNCgKw3ExsdxuD7KyItixgjDglwUMX+dwrjl/3PAPM=
X-Received: by 2002:a05:6902:72e:b0:b6c:f26c:e5ab with SMTP id
 l14-20020a056902072e00b00b6cf26ce5abmr14718432ybt.3.1680138782566; Wed, 29
 Mar 2023 18:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230315224704.2672-1-casey@schaufler-ca.com> <20230315224704.2672-6-casey@schaufler-ca.com>
In-Reply-To: <20230315224704.2672-6-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 29 Mar 2023 21:12:51 -0400
Message-ID: <CAHC9VhR8WycNQ_mxeB9icN6ddQKtNCkkzTPtdJJKDW-qQXL3ug@mail.gmail.com>
Subject: Re: [PATCH v7 05/11] LSM: Create lsm_list_modules system call
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Mar 15, 2023 at 6:48=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> Create a system call to report the list of Linux Security Modules
> that are active on the system. The list is provided as an array
> of LSM ID numbers.
>
> The calling application can use this list determine what LSM
> specific actions it might take. That might include chosing an
> output format, determining required privilege or bypassing
> security module specific behavior.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  Documentation/userspace-api/lsm.rst |  3 +++
>  include/linux/syscalls.h            |  1 +
>  kernel/sys_ni.c                     |  1 +
>  security/lsm_syscalls.c             | 39 +++++++++++++++++++++++++++++
>  4 files changed, 44 insertions(+)

...

> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> index feee31600219..6efbe244d304 100644
> --- a/security/lsm_syscalls.c
> +++ b/security/lsm_syscalls.c
> @@ -53,3 +53,42 @@ SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr,=
 struct lsm_ctx __user *,
>  {
>         return security_getselfattr(attr, ctx, size, flags);
>  }
> +
> +/**
> + * sys_lsm_list_modules - Return a list of the active security modules
> + * @ids: the LSM module ids
> + * @size: size of @ids, updated on return
> + * @flags: reserved for future use, must be zero
> + *
> + * Returns a list of the active LSM ids. On success this function
> + * returns the number of @ids array elements. This value may be zero
> + * if there are no LSMs active. If @size is insufficient to contain
> + * the return data -E2BIG is returned and @size is set to the minimum
> + * required size. In all other cases a negative value indicating the
> + * error is returned.
> + */
> +SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, size_t __user *, si=
ze,
> +               u32, flags)
> +{
> +       size_t total_size =3D lsm_active_cnt * sizeof(*ids);
> +       size_t usize;
> +       int i;
> +
> +       if (flags)
> +               return -EINVAL;

In other patches in this patchset you use 'if (flags !=3D 0)'; I don't
care too much which approach you take, but please be consistent.

Actually, I guess you might as well just go with 'if (flags)' since
I'm pretty sure someone later down the line will end up wasting
reviewer time by changing '(flags !=3D 0)' into '(flags)' ...


> +       if (get_user(usize, size))
> +               return -EFAULT;
> +
> +       if (put_user(total_size, size) !=3D 0)
> +               return -EFAULT;
> +
> +       if (usize < total_size)
> +               return -E2BIG;
> +
> +       for (i =3D 0; i < lsm_active_cnt; i++)
> +               if (put_user(lsm_idlist[i]->id, ids++))
> +                       return -EFAULT;
> +
> +       return lsm_active_cnt;
> +}
> --
> 2.39.2

--
paul-moore.com
