Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1456ADE09
	for <lists+linux-api@lfdr.de>; Tue,  7 Mar 2023 12:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjCGLxZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 Mar 2023 06:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjCGLw6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 7 Mar 2023 06:52:58 -0500
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [IPv6:2001:1600:3:17::8fad])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4CB37566
        for <linux-api@vger.kernel.org>; Tue,  7 Mar 2023 03:52:00 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PWDM31h7BzMrFwl;
        Tue,  7 Mar 2023 12:51:59 +0100 (CET)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4PWDM22dYdzMsF6X;
        Tue,  7 Mar 2023 12:51:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1678189919;
        bh=YjJ2ef/Ze47sRCjE2utSzfwweH1a5iYf+bp9+hpT4Qg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Zgq0jNMwJbNWonPM8m/71Cmj4/aQeBI7fJ7vW+bEvXmkzyVrWPkG3kSIm0ixYBdJR
         gw5H0S3Hsg0WGtnbrM5sPA1rRch+J30rqA6oamyA08NsmjB8MRA2F5JuURLp6t7qgH
         LSo27o8Y3j2phFXIPmw/fBWKcJzTbz28EKwmIl4M=
Message-ID: <405ff748-dea0-794b-fa58-18b0a4703587@digikod.net>
Date:   Tue, 7 Mar 2023 12:51:57 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v6 04/11] LSM: syscalls for current process attributes
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <20230222200838.8149-1-casey@schaufler-ca.com>
 <20230222200838.8149-5-casey@schaufler-ca.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230222200838.8149-5-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


On 22/02/2023 21:08, Casey Schaufler wrote:
> Create a system call lsm_get_self_attr() to provide the security
> module maintained attributes of the current process.
> Create a system call lsm_set_self_attr() to set a security
> module maintained attribute of the current process.
> Historically these attributes have been exposed to user space via
> entries in procfs under /proc/self/attr.
> 
> The attribute value is provided in a lsm_ctx structure. The structure
> identifys the size of the attribute, and the attribute value. The format
> of the attribute value is defined by the security module. A flags field
> is included for LSM specific information. It is currently unused and must
> be 0. The total size of the data, including the lsm_ctx structure and any
> padding, is maintained as well.
> 
> struct lsm_ctx {
>          __u64   id;
>          __u64   flags;
>          __u64   len;
>          __u64   ctx_len;
>          __u8    ctx[];
> };
> 
> Two new LSM hooks are used to interface with the LSMs.
> security_getselfattr() collects the lsm_ctx values from the
> LSMs that support the hook, accounting for space requirements.
> security_setselfattr() identifies which LSM the attribute is
> intended for and passes it along.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>   Documentation/userspace-api/lsm.rst |  15 ++++
>   include/linux/lsm_hook_defs.h       |   4 ++
>   include/linux/lsm_hooks.h           |   9 +++
>   include/linux/security.h            |  19 +++++
>   include/linux/syscalls.h            |   4 ++
>   include/uapi/linux/lsm.h            |  33 +++++++++
>   kernel/sys_ni.c                     |   4 ++
>   security/Makefile                   |   1 +
>   security/lsm_syscalls.c             | 104 ++++++++++++++++++++++++++++
>   security/security.c                 |  82 ++++++++++++++++++++++
>   10 files changed, 275 insertions(+)
>   create mode 100644 security/lsm_syscalls.c
> 

[...]

> +/**
> + * security_setselfattr - Set an LSM attribute on the current process.
> + * @attr: which attribute to return
> + * @ctx: the user-space source for the information
> + * @size: the size of the data
> + *
> + * Set an LSM attribute for the current process. The LSM, attribute
> + * and new value are included in @ctx.
> + *
> + * Returns 0 on seccess, an LSM specific value on failure.
> + */
> +int security_setselfattr(u64 __user attr, struct lsm_ctx __user *ctx,
> +			 size_t __user size)
> +{
> +	struct security_hook_list *hp;
> +	struct lsm_ctx lctx;
> +
> +	if (size < sizeof(*ctx))

If the lsm_ctx struct could grow in the future, we should check the size 
of the struct to the last field for compatibility reasons, see 
Landlock's copy_min_struct_from_user().


> +		return -EINVAL;
> +	if (copy_from_user(&lctx, ctx, sizeof(*ctx)))
> +		return -EFAULT;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.setselfattr, list)
> +		if ((hp->lsmid->id) == lctx.id)
> +			return hp->hook.setselfattr(attr, ctx, size);
> +
> +	return LSM_RET_DEFAULT(setselfattr);
> +}
> +
>   int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
>   			 char **value)
>   {
