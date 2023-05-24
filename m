Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE89A70FBEF
	for <lists+linux-api@lfdr.de>; Wed, 24 May 2023 18:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbjEXQtD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 May 2023 12:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjEXQtD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 May 2023 12:49:03 -0400
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [83.166.143.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8157CBB
        for <linux-api@vger.kernel.org>; Wed, 24 May 2023 09:49:00 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4QRHFk6LNSzMqwn3;
        Wed, 24 May 2023 18:48:58 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4QRHFj3C5Vz1J4N;
        Wed, 24 May 2023 18:48:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1684946938;
        bh=UrDEkJbAFr+Rtur3DuzRcOGCf8EYOtMD0v7O1l+5mFI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sDxflh0uQittGRoCS/vasSrkDjEZX+uDSQ+kmB9PccyWYzTo1oSRam5cl3V2QLzdo
         GCoqTYJZ32HrN6c827gCCwxJQ3+7pSrh7W/biVZ5R5j/iJ0ztJQ/4d5nHquUC9DrRR
         I2td02oQP2fFSdtV1XRQep9pqzlqt/OZ/1es0iCQ=
Message-ID: <d3839544-ddea-d913-6ad1-25811a560bbe@digikod.net>
Date:   Wed, 24 May 2023 18:48:56 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v2] lsm: adds process attribute getter for Landlock
Content-Language: en-US
To:     Shervin Oloumi <enlightened@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jeffxu@chromium.org,
        allenwebb@chromium.org, gnoack3000@gmail.com, areber@redhat.com,
        criu@openvz.org, linux-api@vger.kernel.org, jannh@google.com,
        brauner@kernel.org
References: <ce44fc98-1234-fa53-5067-cd624866f44a@digikod.net>
 <20230518204549.3139044-1-enlightened@chromium.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230518204549.3139044-1-enlightened@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


On 18/05/2023 22:45, Shervin Oloumi wrote:
> Adds a new getprocattr hook function to the Landlock LSM, which tracks
> the landlocked state of the process. This is invoked when user-space
> reads /proc/[pid]/attr/domain to determine whether a given process is
> sand-boxed using Landlock. When the target process is not sand-boxed,
> the result is "none", otherwise the result is empty, as we still need to
> decide what kind of domain information is best to provide in "domain".
> 
> The hook function also performs an access check. The request is rejected
> if the tracing process is the same as the target process, or if the
> tracing process domain is not an ancestor to the target process domain.
> 
> Adds a new directory for landlock under the process attribute
> filesystem, and defines "domain" as a read-only process attribute entry
> for landlock.
> 
> Signed-off-by: Shervin Oloumi <enlightened@chromium.org>
> ---
>   fs/proc/base.c             | 11 +++++++++++
>   security/landlock/fs.c     | 38 ++++++++++++++++++++++++++++++++++++++
>   security/landlock/fs.h     |  1 +
>   security/landlock/ptrace.c |  4 ++--
>   security/landlock/ptrace.h |  3 +++
>   5 files changed, 55 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 9e479d7d202b..b257ea704666 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2851,6 +2851,13 @@ static const struct pid_entry apparmor_attr_dir_stuff[] = {
>   LSM_DIR_OPS(apparmor);
>   #endif
>   
> +#ifdef CONFIG_SECURITY_LANDLOCK
> +static const struct pid_entry landlock_attr_dir_stuff[] = {
> +	ATTR("landlock", "domain", 0444),
> +};
> +LSM_DIR_OPS(landlock);
> +#endif
> +
>   static const struct pid_entry attr_dir_stuff[] = {
>   	ATTR(NULL, "current",		0666),
>   	ATTR(NULL, "prev",		0444),
> @@ -2866,6 +2873,10 @@ static const struct pid_entry attr_dir_stuff[] = {
>   	DIR("apparmor",			0555,
>   	    proc_apparmor_attr_dir_inode_ops, proc_apparmor_attr_dir_ops),
>   #endif
> +#ifdef CONFIG_SECURITY_LANDLOCK
> +	DIR("landlock",                  0555,
> +	    proc_landlock_attr_dir_inode_ops, proc_landlock_attr_dir_ops),
> +#endif
>   };
>   
>   static int proc_attr_dir_readdir(struct file *file, struct dir_context *ctx)
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index adcea0fe7e68..2f8b0837a0fd 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -1280,6 +1280,42 @@ static int hook_file_truncate(struct file *const file)
>   	return -EACCES;
>   }
>   
> +/* process attribute interfaces */
> +
> +/**
> + * landlock_getprocattr - Landlock process attribute getter
> + * @task: the object task
> + * @name: the name of the attribute in /proc/.../attr
> + * @value: where to put the result
> + *
> + * Performs access checks and writes any applicable results to value
> + *
> + * Returns the length of the result inside value or an error code
> + */
> +static int landlock_getprocattr(struct task_struct *task, const char *name,
> +				char **value)
> +{
> +	char *val = "";
> +	int slen;
> +
> +	// If the tracing process is landlocked, ensure its domain is an
> +	// ancestor to the target process domain.
> +	if (landlocked(current))
> +		if (current == task || !task_is_scoped(current, task))

ptrace_may_access() checks more things than task_is_scoped(), but we 
should also make sure that that the current domain is taken into account 
(with a simple domain comparison). Tests should check these cases.


> +			return -EACCES;
> +
> +	// The only supported attribute is "domain".
> +	if (strcmp(name, "domain") != 0)
> +		return -EINVAL;
> +
> +	if (!landlocked(task))
> +		val = "none";

I think the return values, for a dedicated syscall, would be "unknown", 
"unrestricted", "restricted". This could just be a returned enum.


> +
> +	slen = strlen(val);
> +	*value = val;
> +	return slen;
> +}

This should be part of the ptrace.c file, which would also avoid 
exporting functions.


> +
>   static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(inode_free_security, hook_inode_free_security),
>   
> @@ -1302,6 +1338,8 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(file_alloc_security, hook_file_alloc_security),
>   	LSM_HOOK_INIT(file_open, hook_file_open),
>   	LSM_HOOK_INIT(file_truncate, hook_file_truncate),
> +
> +	LSM_HOOK_INIT(getprocattr, landlock_getprocattr),
>   };
>   
>   __init void landlock_add_fs_hooks(void)
> diff --git a/security/landlock/fs.h b/security/landlock/fs.h
> index 488e4813680a..64145e8b5537 100644
> --- a/security/landlock/fs.h
> +++ b/security/landlock/fs.h
> @@ -13,6 +13,7 @@
>   #include <linux/init.h>
>   #include <linux/rcupdate.h>
>   
> +#include "ptrace.h"
>   #include "ruleset.h"
>   #include "setup.h"
>   
> diff --git a/security/landlock/ptrace.c b/security/landlock/ptrace.c
> index 4c5b9cd71286..de943f0f3899 100644
> --- a/security/landlock/ptrace.c
> +++ b/security/landlock/ptrace.c
> @@ -47,8 +47,8 @@ static bool domain_scope_le(const struct landlock_ruleset *const parent,
>   	return false;
>   }
>   
> -static bool task_is_scoped(const struct task_struct *const parent,
> -			   const struct task_struct *const child)
> +const bool task_is_scoped(const struct task_struct *const parent,
> +			  const struct task_struct *const child)
>   {
>   	bool is_scoped;
>   	const struct landlock_ruleset *dom_parent, *dom_child;
> diff --git a/security/landlock/ptrace.h b/security/landlock/ptrace.h
> index 265b220ae3bf..c6eb08951fc1 100644
> --- a/security/landlock/ptrace.h
> +++ b/security/landlock/ptrace.h
> @@ -11,4 +11,7 @@
>   
>   __init void landlock_add_ptrace_hooks(void);
>   
> +const bool task_is_scoped(const struct task_struct *const parent,
> +			  const struct task_struct *const child);
> +
>   #endif /* _SECURITY_LANDLOCK_PTRACE_H */
