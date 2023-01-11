Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77835666536
	for <lists+linux-api@lfdr.de>; Wed, 11 Jan 2023 22:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbjAKVCV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 11 Jan 2023 16:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235347AbjAKVBz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 11 Jan 2023 16:01:55 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD957116B
        for <linux-api@vger.kernel.org>; Wed, 11 Jan 2023 13:00:58 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso21419270pjt.0
        for <linux-api@vger.kernel.org>; Wed, 11 Jan 2023 13:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aYATQVBoAHjhOjUPsaD5jki6IaVs4YS9GjtTsAYD90g=;
        b=VmnTEE4msRQnWVteMg0wJkJPSvzWrpzkhjxmGuyt/D/AZ7ywx5MiLmC3npuZzKgNtU
         jE1E60rl+nT+8C3sSCDc08xcVaVud2WfGhdCj7+DpghA9rlRARpxS2DT3k8i1A0QgtRs
         kbzO4MHFb/nlTRn/aSim4myAB0UIhGogQlTSMlk74Tj44HRKLE2CNllJnt02jr+ATxqZ
         HQAobPGteN7xGJCdP9KTU0WmSCDZV5V56/vJggCSRKcrtnCgSeBPO2nxIKSoETiOLKwE
         yBsmfmvd2bqax0m5t2Sv+wAJtVAlpILgHCRb0vy9eO7WTaoVyffNutOWn2DO4qFZi4fb
         egSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aYATQVBoAHjhOjUPsaD5jki6IaVs4YS9GjtTsAYD90g=;
        b=tNdG1Ofid1o2CS6oFTqmaqYZWHz1XBOb1tf2h1p9Es5H7SMBNg+dUBSuP1JuFHYGJz
         LfssE2S9GzaxlKs61hXCv5HEx1Z/3s8tK+U8o38LwqHB7O3D2M/KKWf9J6SFCvuW7O+f
         GZL1hvr3UytF2GoNL1eFqLhhDzzHJI+LPR4ylQZImrTqNleoVd/KsIBcA+O/Id+OdkE9
         fWXlg/5p3do9Qqkfv/ZEDU4Lx3lQwYYu/9qVQDD3xEtTv7PmETWGttNTwe0e1xyXXNFI
         cHSiJ05R7H0hoQUTnWMkhVW7gZ4JgXviNOnPFBHqKFJjvZg7wehQambm6JKfEAcXhBub
         1cAQ==
X-Gm-Message-State: AFqh2kqPj17PYocaP+m1Mpfb+HUI3w6cS43GH/HrWjF2ZgwjhAD/cA/3
        wb6/YNVUgqjm1e/lxJ9ru5T/dBYnAx8k2ia3uALx
X-Google-Smtp-Source: AMrXdXsgdIQ4X4OUTR4u+VAD5j+EGTbU55NeMLJocpClVYburuQJFgP3O9hiZy+wU1Ngxjp9daU/WDQsGB+hBC/8thA=
X-Received: by 2002:a17:902:cec8:b0:192:6675:8636 with SMTP id
 d8-20020a170902cec800b0019266758636mr4279090plg.15.1673470857931; Wed, 11 Jan
 2023 13:00:57 -0800 (PST)
MIME-Version: 1.0
References: <20230109180717.58855-1-casey@schaufler-ca.com> <20230109180717.58855-2-casey@schaufler-ca.com>
In-Reply-To: <20230109180717.58855-2-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 11 Jan 2023 16:00:46 -0500
Message-ID: <CAHC9VhRs6BxukV97BaDuj6GDJwhiy+-vCmDfRUyojJiBUV2z1g@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] LSM: Identify modules by more than name
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jan 9, 2023 at 1:07 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Create a struct lsm_id to contain identifying information
> about Linux Security Modules (LSMs). At inception this contains
> the name of the module, an identifier associated with the security
> module and an integer member "attrs_used" which identifies the API
> related data associated with each security module. The initial set
> of features maps to information that has traditionaly been available
> in /proc/self/attr. They are documented in a new userspace-api file.
> Change the security_add_hooks() interface to use this structure.
> Change the individual modules to maintain their own struct lsm_id
> and pass it to security_add_hooks().
>
> The values are for LSM identifiers are defined in a new UAPI
> header file linux/lsm.h. Each existing LSM has been updated to
> include it's LSMID in the lsm_id.
>
> The LSM ID values are sequential, with the oldest module
> LSM_ID_CAPABILITY being the lowest value and the existing modules
> numbered in the order they were included in the main line kernel.
> This is an arbitrary convention for assigning the values, but
> none better presents itself. The value 0 is defined as being invalid.
> The values 1-99 are reserved for any special case uses which may
> arise in the future. This may include attributes of the LSM
> infrastructure itself, possibly related to namespacing or network
> attribute management. A special range is identified for such attributes
> to help reduce confusion for developers unfamiliar with LSMs.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  Documentation/userspace-api/index.rst |  1 +
>  Documentation/userspace-api/lsm.rst   | 55 +++++++++++++++++++++++++++
>  include/linux/lsm_hooks.h             | 18 ++++++++-
>  include/uapi/linux/lsm.h              | 55 +++++++++++++++++++++++++++
>  security/apparmor/lsm.c               |  9 ++++-
>  security/bpf/hooks.c                  | 13 ++++++-
>  security/commoncap.c                  |  8 +++-
>  security/landlock/cred.c              |  2 +-
>  security/landlock/fs.c                |  2 +-
>  security/landlock/ptrace.c            |  2 +-
>  security/landlock/setup.c             |  6 +++
>  security/landlock/setup.h             |  1 +
>  security/loadpin/loadpin.c            |  9 ++++-
>  security/lockdown/lockdown.c          |  8 +++-
>  security/safesetid/lsm.c              |  9 ++++-
>  security/security.c                   | 12 +++---
>  security/selinux/hooks.c              | 11 +++++-
>  security/smack/smack_lsm.c            |  9 ++++-
>  security/tomoyo/tomoyo.c              |  9 ++++-
>  security/yama/yama_lsm.c              |  8 +++-
>  20 files changed, 226 insertions(+), 21 deletions(-)
>  create mode 100644 Documentation/userspace-api/lsm.rst
>  create mode 100644 include/uapi/linux/lsm.h

Mostly just nitpicky stuff below ...

> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 0a5ba81f7367..6f2cabb79ec4 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1665,6 +1665,20 @@ struct security_hook_heads {
>         #undef LSM_HOOK
>  } __randomize_layout;
>
> +/**
> + * struct lsm_id - identify a Linux Security Module.

According to the kernel-doc documentation it looks like "identify"
should be capitalized.

* https://docs.kernel.org/doc-guide/kernel-doc.html

> + * @lsm: Name of the LSM. Must be approved by the LSM maintainers.
> + * @id: LSM ID number from uapi/linux/lsm.h
> + * @attrs_used: Which attributes this LSM supports.

In a bit of a reversal to the above comment, it appears that the
parameter descriptions should not start with a capital and should not
end with punctuation:

  * @lsm: name of the LSM, must be approved by the LSM maintainers

> + * Contains the information that identifies the LSM.
> + */
> +struct lsm_id {
> +       const u8        *lsm;
> +       u32             id;
> +       u64             attrs_used;
> +};

> @@ -1708,7 +1722,7 @@ extern struct security_hook_heads security_hook_heads;
>  extern char *lsm_names;
>
>  extern void security_add_hooks(struct security_hook_list *hooks, int count,
> -                               const char *lsm);
> +                              struct lsm_id *lsmid);

We should be able to mark @lsmid as a const, right?

> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> new file mode 100644
> index 000000000000..61a91b7d946f
> --- /dev/null
> +++ b/include/uapi/linux/lsm.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Linux Security Modules (LSM) - User space API
> + *
> + * Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
> + * Copyright (C) 2022 Intel Corporation
> + */

This file should be added to the SECURITY SUBSYSTEM section in MAINTAINERS:

  F: include/uapi/linux/lsm.h

> +#ifndef _UAPI_LINUX_LSM_H
> +#define _UAPI_LINUX_LSM_H
> +
> +/*
> + * ID values to identify security modules.
> + * A system may use more than one security module.
> + *
> + * A value of 0 is considered invalid.
> + * Values 1-99 are reserved for future use.
> + * The interface is designed to extend to attributes beyond those which
> + * are active today. Currently all the attributes are specific to the
> + * individual modules. The LSM infrastructure itself has no variable state,
> + * but that may change. One proposal would allow loadable modules, in which
> + * case an attribute such as LSM_IS_LOADABLE might identify the dynamic
> + * modules. Another potential attribute could be which security modules is
> + * associated withnetwork labeling using netlabel. Another possible attribute
> + * could be related to stacking behavior in a namespaced environment.
> + * While it would be possible to intermingle the LSM infrastructure attribute
> + * values with the security module provided values, keeping them separate
> + * provides a clearer distinction.
> + */

As this is in a UAPI file, let's avoid speculation and stick to just
the current facts.  Anything we write here with respect to the future
is likely to be wrong so let's not tempt fate.

Once I reached patch 3/8 I also realized that we may want to have more
than just 0/invalid as a sentinel value, or at the very least we need
to redefine 0 as something slightly different if for no other reason
than we in fs/proc/base.c.  I know it seems a little trivial, but
since we're talking about values that will be used in the UAPI I think
we need to give it some thought and discussion.  The only think I can
think of right now is to redefine 0 as "undefined", which isn't that
far removed from "invalid" and will not look too terrible in patch 3/8
- thoughts?

With all that in mind, I would suggest something like this:

  /*
   * ID tokens to identify Linux Security Modules (LSMs)
   *
   * These token values are used to uniquely identify specific LSMs
   * in the kernel as well in the kernel's LSM userspace API.
   *
   * A value of zero/0 is considered undefined and should not be used
   * outside of the kernel, values 1-99 are reserved for potential
   * future use.
      */
  #define LSM_ID_UNDEF 0

> +#define LSM_ID_CAPABILITY      100
> +#define LSM_ID_SELINUX         101
> +#define LSM_ID_SMACK           102
> +#define LSM_ID_TOMOYO          103
> +#define LSM_ID_IMA             104
> +#define LSM_ID_APPARMOR                105
> +#define LSM_ID_YAMA            106
> +#define LSM_ID_LOADPIN         107
> +#define LSM_ID_SAFESETID       108
> +#define LSM_ID_LOCKDOWN                109
> +#define LSM_ID_BPF             110
> +#define LSM_ID_LANDLOCK                111
> +
> +/*
> + * LSM_ATTR_XXX values identify the /proc/.../attr entry that the
> + * context represents. Not all security modules provide all of these
> + * values. Some security modules provide none of them.
> + */

I'd rather see text closer to this:

  /*
   * LSM attributes
   *
   * The LSM_ATTR_XXX definitions identify different LSM
   * attributes which are used in the kernel's LSM userspace API.
   * Support for these attributes vary across the different LSMs,
   * none are required.
   */

> +#define LSM_ATTR_CURRENT       0x0001
> +#define LSM_ATTR_EXEC          0x0002
> +#define LSM_ATTR_FSCREATE      0x0004
> +#define LSM_ATTR_KEYCREATE     0x0008
> +#define LSM_ATTR_PREV          0x0010
> +#define LSM_ATTR_SOCKCREATE    0x0020
> +
> +#endif /* _UAPI_LINUX_LSM_H */
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index c6728a629437..63ea2a995987 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -24,6 +24,7 @@
>  #include <linux/zstd.h>
>  #include <net/sock.h>
>  #include <uapi/linux/mount.h>
> +#include <uapi/linux/lsm.h>
>
>  #include "include/apparmor.h"
>  #include "include/apparmorfs.h"
> @@ -1217,6 +1218,12 @@ struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
>         .lbs_task = sizeof(struct aa_task_ctx),
>  };
>
> +static struct lsm_id apparmor_lsmid __lsm_ro_after_init = {
> +       .lsm = "apparmor",
> +       .id = LSM_ID_APPARMOR,
> +       .attrs_used = LSM_ATTR_CURRENT | LSM_ATTR_PREV | LSM_ATTR_EXEC,
> +};

Perhaps mark this as const in addition to ro_after_init?  This applies
to all the other @lsm_id defs in this patch too.

> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> index e5971fa74fd7..20983ae8d31f 100644
> --- a/security/bpf/hooks.c
> +++ b/security/bpf/hooks.c
> @@ -5,6 +5,7 @@
>   */
>  #include <linux/lsm_hooks.h>
>  #include <linux/bpf_lsm.h>
> +#include <uapi/linux/lsm.h>
>
>  static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
>         #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> @@ -15,9 +16,19 @@ static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
>         LSM_HOOK_INIT(task_free, bpf_task_storage_free),
>  };
>
> +/*
> + * slot has to be LSMBLOB_NEEDED because some of the hooks
> + * supplied by this module require a slot.
> + */

I don't think we need the above comment here, right?

--
paul-moore.com
