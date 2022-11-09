Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC42C62378E
	for <lists+linux-api@lfdr.de>; Thu, 10 Nov 2022 00:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbiKIXfr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 9 Nov 2022 18:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbiKIXfe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 9 Nov 2022 18:35:34 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F1C2E9E5
        for <linux-api@vger.kernel.org>; Wed,  9 Nov 2022 15:35:34 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id h132so258245oif.2
        for <linux-api@vger.kernel.org>; Wed, 09 Nov 2022 15:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=shy1bSg5ln0S2oADqhwWw8EsMzx5HDdKaMPKkyMf+gs=;
        b=HIa78ftndFCy7LJ6aLzwGXh4jG/89gIZ8W+9hUOfwDK+w0NqtyNwkcOGWvBJLENdRJ
         WRNfCtX+lYc6L/KxD7wiKwkkJzJmlCKSXiEKD7eEIA0rgvazFLoo2ORVYbcvCBKlu9Sc
         zBB2441tuvg2ps+NP7JFxP3mzKZf2dC12AGMomip8SW2vMODOk5eZmIeHuaI94WnwayM
         sJ5sVZweeOd+qOEGnKMI+4IAhLTKnxMwQ5kN7LNVuGU8wpwkZReb6YkOTsw2Mqgl6s83
         he233b6EBjO+h+l2GBibExBY8Rh2Xelvjbo6G7OuP7J3vnEa5ZJWXCBhueNi0UflExtV
         +e8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=shy1bSg5ln0S2oADqhwWw8EsMzx5HDdKaMPKkyMf+gs=;
        b=sIkrb4qUmjVQF9ptFOCpPgBYeuGWNWPRf+PFSZOvvrIcgdIy+BXIcKQ2nbBDX09C6d
         oFFOgEG8LTxLeEerFu6xGZw0GBgZz/jDMaVTJtPCXES6hK2m7BmD/Q2ebPhS2G5//gFd
         dzEnMaAICObgFcjgrVzGRkgCTrnhKVJtpjoYx1bklpMagdNX54TGfrjeHG6WcUn0EYdO
         n9V2dmXT4+wOV0vLjpnhL0sF76jU6fMxodhI2u8f5xiu58Ayg95JsFq/7o8zGega0KIJ
         o1inXj931h/fCs/fRRnSlTAImnoD4+baYdTfiTkg9iDJLbpTdA+MTbPaWUjPne2GUm0a
         lCbg==
X-Gm-Message-State: ACrzQf0b9uiX6gg96XOXzjD8adMKagpUxMHFlrwAHXWtU8gnHnlSYOy9
        x+g/mjo7wV8qVYQzMk/jqSHVdn2n1RghTt8K2BiI
X-Google-Smtp-Source: AMsMyM6Ynx4zzeC51isR9kHn9lxVD7jUvWH20IzPJ5yVXl4cEzR3M3wOItJzn73/yBJ+RiLCwVZcXKowSVoizK7R+6A=
X-Received: by 2002:a05:6808:1525:b0:35a:57ef:83b0 with SMTP id
 u37-20020a056808152500b0035a57ef83b0mr761763oiw.172.1668036933664; Wed, 09
 Nov 2022 15:35:33 -0800 (PST)
MIME-Version: 1.0
References: <20221025184519.13231-1-casey@schaufler-ca.com> <20221025184519.13231-8-casey@schaufler-ca.com>
In-Reply-To: <20221025184519.13231-8-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Nov 2022 18:35:22 -0500
Message-ID: <CAHC9VhQ5Jrt3Ns+m7DFZ+_pP81AWqSx588HMZR+7MUuMfSZoig@mail.gmail.com>
Subject: Re: [PATCH v1 7/8] LSM: Create lsm_module_list system call
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Oct 25, 2022 at 2:48 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
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
>  include/linux/syscalls.h |  1 +
>  kernel/sys_ni.c          |  1 +
>  security/lsm_syscalls.c  | 38 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+)

...

> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> index da0fab7065e2..cd5db370b974 100644
> --- a/security/lsm_syscalls.c
> +++ b/security/lsm_syscalls.c
> @@ -154,3 +154,41 @@ SYSCALL_DEFINE3(lsm_self_attr,
>         kfree(final);
>         return rc;
>  }
> +
> +/**
> + * lsm_module_list - Return a list of the active security modules
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

Let's make a promise that for this syscall we will order the LSM IDs
in the array in the same order as which they are configured/executed.
I'm doubtful that only a *very* small number of applications will care
about this (if any), but this is something we can do so let's do it
now while we can.

> +SYSCALL_DEFINE3(lsm_module_list,
> +               unsigned int __user *, ids,
> +               size_t __user *, size,
> +               unsigned int, flags)

--
paul-moore.com
