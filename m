Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507A17271C4
	for <lists+linux-api@lfdr.de>; Thu,  8 Jun 2023 00:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjFGWdF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 7 Jun 2023 18:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjFGWdD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Jun 2023 18:33:03 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97608173A
        for <linux-api@vger.kernel.org>; Wed,  7 Jun 2023 15:32:59 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-75d536afa43so1561185a.1
        for <linux-api@vger.kernel.org>; Wed, 07 Jun 2023 15:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1686177178; x=1688769178;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hZXIJgO0yR4cIcee4w+UOn0ROi+cGZITxROBHRvLSZY=;
        b=X/riXzpOF/e1z57/D1w9xWtuZFR8Os282CJJh2gLbfofZgnft5MCwx9btiFxP+SPXz
         7EMWTmqedtsCzEOJ5t3SPnQMC4tKXzBhvAchmLqVwvd/tHSbJVnAtiStxoy/6Rg8/ZBs
         SsLpQomYqNS0dZxyoOuDMMXFFYViM5VBTVjBO8jJghJylkLYhdE/fZzuxDB1HcL43z/d
         udOGdC6ep/Aa0ZOctcsQDOZKtl164NB4MINCniJ5ALeyb1zkmXqvw2Kdb6cJgNoY3Z6n
         3OlhfQFiJ74wn5kpJbFao1c06C6MFEQGLMJAnjh7iCYy/xGrKwB32vn/8Ff/rhGTBE+G
         tqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686177178; x=1688769178;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hZXIJgO0yR4cIcee4w+UOn0ROi+cGZITxROBHRvLSZY=;
        b=M52P0BiDV9alWtE6qXVAGp0k537Qv8BI7DR3kvUJvnXUlo9EWK/GxVm7tJ58lznt/C
         NMCSf7LTBEDqTc5l40KJr/h5zWJ3eh/ybRQYbYYLbPTCgcoUKnG/O+W0x2wN6iriqskg
         LX/ikYE3E+vLnzBfCPO7HHOUMKSZkBkBfytFic0ogZVtkEO+rK3V3ugqVE7x9b1W3jgY
         vWH/Wg0C+F7JBep2HMNgTx0RJO8p/lHlrCy0/u6b2UC1jmJJRJFLPBP6oS5gs4tKNuS9
         4LxFM+vgS+8dp3JpC0+hHSFrcMHAeHG+C/DbdeUdeOzLjHnY0OIfuHAR8zIGt3VRfIsb
         CY7Q==
X-Gm-Message-State: AC+VfDwZXO6L6QLzXe/AMzZCOSlSJda3n6FtJ0jLpaeL4XV3q1+snRYy
        GKH3r5mQns0CjK+LF3YC6C0n
X-Google-Smtp-Source: ACHHUZ4ljeQYPeMYOngSGH6rrRjK7lkZHuzETaiNhVR7vi0sls0jlJ5lAUXFvNAVKeJFtrXsOX5ZPQ==
X-Received: by 2002:a05:620a:8c3:b0:75d:1145:8151 with SMTP id z3-20020a05620a08c300b0075d11458151mr611357qkz.12.1686177178558;
        Wed, 07 Jun 2023 15:32:58 -0700 (PDT)
Received: from localhost (static-96-237-115-254.bstnma.fios.verizon.net. [96.237.115.254])
        by smtp.gmail.com with ESMTPSA id y8-20020a37e308000000b0075ecdc937ffsm221321qki.41.2023.06.07.15.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 15:32:58 -0700 (PDT)
Date:   Wed, 07 Jun 2023 18:32:57 -0400
Message-ID: <76f37cf7b20b8c63cf78d4ddca5a7375.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: Re: [PATCH v10 4/11] LSM: syscalls for current process attributes
References: <20230428203417.159874-5-casey@schaufler-ca.com>
In-Reply-To: <20230428203417.159874-5-casey@schaufler-ca.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Apr 28, 2023 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Create a system call lsm_get_self_attr() to provide the security
> module maintained attributes of the current process.
> Create a system call lsm_set_self_attr() to set a security
> module maintained attribute of the current process.
> Historically these attributes have been exposed to user space via
> entries in procfs under /proc/self/attr.
> 
> The attribute value is provided in a lsm_ctx structure. The structure
> identifies the size of the attribute, and the attribute value. The format
> of the attribute value is defined by the security module. A flags field
> is included for LSM specific information. It is currently unused and must
> be 0. The total size of the data, including the lsm_ctx structure and any
> padding, is maintained as well.
> 
> struct lsm_ctx {
>         __u64 id;
>         __u64 flags;
>         __u64 len;
>         __u64 ctx_len;
>         __u8 ctx[];
> };
> 
> Two new LSM hooks are used to interface with the LSMs.
> security_getselfattr() collects the lsm_ctx values from the
> LSMs that support the hook, accounting for space requirements.
> security_setselfattr() identifies which LSM the attribute is
> intended for and passes it along.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  Documentation/userspace-api/lsm.rst |  15 ++++
>  include/linux/lsm_hook_defs.h       |   4 +
>  include/linux/lsm_hooks.h           |   9 +++
>  include/linux/security.h            |  19 +++++
>  include/linux/syscalls.h            |   5 ++
>  include/uapi/linux/lsm.h            |  36 +++++++++
>  kernel/sys_ni.c                     |   4 +
>  security/Makefile                   |   1 +
>  security/lsm_syscalls.c             |  55 ++++++++++++++
>  security/security.c                 | 112 ++++++++++++++++++++++++++++
>  10 files changed, 260 insertions(+)
>  create mode 100644 security/lsm_syscalls.c

...

> diff --git a/security/security.c b/security/security.c
> index 5a48b1b539e5..94b78bfd06b9 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2176,6 +2176,118 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
>  }
>  EXPORT_SYMBOL(security_d_instantiate);
>  
> +/**
> + * security_getselfattr - Read an LSM attribute of the current process.
> + * @attr: which attribute to return
> + * @ctx: the user-space destination for the information, or NULL
> + * @size: the size of space available to receive the data
> + * @flags: special handling options. LSM_FLAG_SINGLE indicates that only
> + * attributes associated with the LSM identified in the passed @ctx be
> + * reported
> + *
> + * Returns the number of attributes found on success, negative value
> + * on error. @size is reset to the total size of the data.
> + * If @size is insufficient to contain the data -E2BIG is returned.
> + */
> +int security_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
> +			 size_t __user *size, u32 flags)
> +{
> +	struct security_hook_list *hp;
> +	struct lsm_ctx lctx = { .id = LSM_ID_UNDEF, };
> +	u8 __user *base = (u8 __user *)ctx;
> +	size_t total = 0;
> +	size_t entrysize;
> +	size_t left;
> +	bool toobig = false;
> +	int count = 0;
> +	int rc;
> +
> +	if (attr == 0)
> +		return -EINVAL;
> +	if (size == NULL)
> +		return -EINVAL;
> +	if (get_user(left, size))
> +		return -EFAULT;
> +
> +	if ((flags & LSM_FLAG_SINGLE) == LSM_FLAG_SINGLE) {
> +		if (!ctx)
> +			return -EINVAL;
> +		if (copy_struct_from_user(&lctx, sizeof(lctx), ctx, left))
> +			return -EFAULT;
> +		if (lctx.id == LSM_ID_UNDEF)
> +			return -EINVAL;
> +	} else if (flags) {
> +		return -EINVAL;
> +	}
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.getselfattr, list) {
> +		if (lctx.id != LSM_ID_UNDEF && lctx.id != hp->lsmid->id)
> +			continue;

I think we're missing a copy_struct_from_user() call somewhere; how
does @lctx get populated in the non-LSM_FLAG_SINGLE case?  How does
it move to the next entry in the buffer?

Am I missing something obvious?  Was this code tested?

> +		entrysize = left;
> +		if (base)
> +			ctx = (struct lsm_ctx __user *)(base + total);
> +		rc = hp->hook.getselfattr(attr, ctx, &entrysize, flags);
> +		if (rc == -EOPNOTSUPP) {
> +			rc = 0;
> +			continue;
> +		}
> +		if (rc == -E2BIG) {
> +			toobig = true;
> +			left = 0;
> +			continue;
> +		}
> +		if (rc < 0)
> +			return rc;
> +
> +		left -= entrysize;
> +		total += entrysize;
> +		count += rc;
> +	}
> +	if (put_user(total, size))
> +		return -EFAULT;
> +	if (toobig)
> +		return -E2BIG;
> +	if (count == 0)
> +		return LSM_RET_DEFAULT(getselfattr);
> +	return count;
> +}
> +
> +/**
> + * security_setselfattr - Set an LSM attribute on the current process.
> + * @attr: which attribute to set
> + * @ctx: the user-space source for the information
> + * @size: the size of the data
> + * @flags: reserved for future use, must be 0
> + *
> + * Set an LSM attribute for the current process. The LSM, attribute
> + * and new value are included in @ctx.
> + *
> + * Returns 0 on success, -EINVAL if the input is inconsistent, -EFAULT
> + * if the user buffer is inaccessible or an LSM specific failure.
> + */
> +int security_setselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
> +			 size_t size, u32 flags)
> +{
> +	struct security_hook_list *hp;
> +	struct lsm_ctx lctx;
> +
> +	if (flags)
> +		return -EINVAL;

Once again, I don't see a reasonable way to support setting an
attribute across multiple LSMs, but for the sake of consistency
across both the getselfattr and setselfattr syscalls, what do
people think about *requiring* the LSM_FLAG_SINGLE flag here in
the setselfattr syscalls since it can only operate on a single
LSM at a time?  A zero flag value would return -EINVAL.

> +	if (size < sizeof(*ctx))
> +		return -EINVAL;
> +	if (copy_from_user(&lctx, ctx, sizeof(*ctx)))
> +		return -EFAULT;
> +	if (size < lctx.len || size < lctx.ctx_len + sizeof(ctx) ||
> +	    lctx.len < lctx.ctx_len + sizeof(ctx))
> +		return -EINVAL;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.setselfattr, list)
> +		if ((hp->lsmid->id) == lctx.id)
> +			return hp->hook.setselfattr(attr, ctx, size, flags);
> +
> +	return LSM_RET_DEFAULT(setselfattr);
> +}
> +
>  int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
>  			 char **value)
>  {
> -- 
> 2.39.2

--
paul-moore.com
