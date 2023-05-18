Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D827708A66
	for <lists+linux-api@lfdr.de>; Thu, 18 May 2023 23:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjERV0t (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 May 2023 17:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjERV0s (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 May 2023 17:26:48 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B23F5
        for <linux-api@vger.kernel.org>; Thu, 18 May 2023 14:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684445206; bh=8B9ZJRvku4+3DdS6LUvbPMtAT0ZmPuMkfq5Lg560Igw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=UaW99pZJOiboIs7tcTI61j91iYM9j7clGiYlCCuQd87gd0/Hm98P0doUPrF8+eGiakNyM2oCtIbnWjIl5mS0Am+KCHq8LVPYXBSDVjno1EYnpGlr0GbNozS9rKzp9kY2AGI5JaCZN9BPXaW5IflGkqx4Mr055xP2czlWoOsFlRQaJExwNyCz0NMrJ6phcB2itB6Ph+//pqglNExxjyWu/jZpJRMEksFftnVz5f3dSLpOphYNc0HjqzQ9AWjCkjv1TWqMWPw1XAE/uL8TG78YYGGSmHVIEFL6x6oJ5WRpYMk6HYiP/r7BFLMXBlmHIkV2KbVZ6cAiRrkS5FNR/wne7g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684445206; bh=isJczNXLaMjCuMpvR1R+IXoKX+h4YWk+rRzSEMP5FPO=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=MB4JNPVsOyZBQj7FMeNc5dWQUS0jEujOft22abD2pArmP96ckupmmYKV89DmbESMxGZzOJAL01FQsb9lGnKG3OiwdoOz4Q8ZmcG5wfUQbsei6LJYVziNwH6j6gzJ8Pe+PF3uqXD3PvDGB8Bnys3Twgu8o2mo702Ast/PzG6ZomNu27ZCUFYtg1nRBwypS+dPv0IRD8JS0CO7jtqQteUu+3BV2UHvtPmulTCm8AxhlYfsIeVxqPehC6v1XUFjWDvk7eRAvabPOfhjF8VXskNgxorBVaiEYt6qNft5D3eIyZyriq4RBhRBWCRPxgyVaSQ9xm0GlDo8plJClgYKplaYDA==
X-YMail-OSG: ._LI9UQVM1k9XPXFTNDrrLxtFo2SnWOAcPlbSYJt3tWzznEQ0XAGleoEpM4YHd1
 YvN4SEeGr_grBFPvU_jCM_rW3oZAJksGOnurWEg_mJuKQ1Fh5bzArt7mxGnKi5..JrgM5XR95BtL
 l4GwESJqT5nvZ5EyeNWSzdQQEZFWdE51wiBSlZrGdEF3LpVpCxSbqOEKIIZHad7aan.dfvEsDD8I
 9t43GQ_SKike08anE8EKF.Zw3oU4wWss4leF4ZmoehW6uaU1f0qIjU1J2CXPRAFMPafTTzrJajkb
 wLalxF9OB1lPLBqxHoMKQJ5JSuyGeELtOoL5sPsKXZDzoouzgeatUA_izFjAPeslra8i8tbA3t90
 81.gSBnXNLp_CN1qkZEQqnva0dfvoSIUwzD5DdjCjZmWhLlbIWEW1dRBV.YqLCwlyhlOtWJ_wM9S
 beFwY3EcwfQfvLl8WDeV1.WtM3jOkLuZXOazGKD8t8uQ.tXYCaHmbGej9Fsg8hLrfHHyx7xcGfTE
 5.7Gx8SMExgT4JvSItGNi4lcWyxG618VHmAmAhD0gfHpzlgcA1U1rl9jOGwb8kQwdzc488lztf.S
 JXjOoYHrltIKrKUW_H1lw.njYw2JsdSGtth2aEtTwnD8C3EUE0I06cRmXCJlIAsuhasuqb0O2FJA
 2lbVpQudAroxVkckIcwL2H.mD9G94DY72PslTJyGBcme1PCHyv.ryDA.tuF8JzxajmKDzfpCb786
 cCmrTOaJVAd1PUpCcMo0h0.pko5bBpUUpv5txmsImr.5g_fL.hu0PIXRgIOKDTKvzjtSDbj638aI
 wzzNXAtfzp3Y_QuOqpS.KTJXL58gbL.xN23uPwp_RvUUGThpIJ4WdXVgQbRy8eqTRR4Mu84LC7AY
 aD.ZKUbNI_YsCmx4EVNPsKtvCGZGQv28oStVmQPSZw1UGQ4mMd4ExkNQPT9S1e5CJ3.4mZuuWbEG
 8nfQzH7vdObANqWh1rL3r5UJufryvp0GQQeL2k4hsIeOr8N1fWfvHS1JzpIf3ZuEfbWY6CkyaIBv
 OUeXGAN.QhHwLP_OCEwAn.0KstuWWHDJE73xU5f_XAC3vIFxqa.6IiDWsdFeCJkFpeKHAODJPj7R
 KitfPgyqdOKIIn.B2srInXswTRGvMiRUI8PtLC8JQqiDVN4J91b8gHWEpc5hhhXkRPbWpXrgK7T4
 B.5JGMQ0pbuTtUvxoDYdH2Jx8z30dXdACYHTBD3IBYK86c1H2WVr80kjIdl5TO5vYg072CQjSh4B
 tGvzOVKcqcioLkzqYsGojXKj5_97k6ZEzn8MOjrp4FHVsOdOY9V3VbDJlE.rh0EjBTGOyrD34pEx
 uINWBAr3cx0OgoQF7eFON5RWbujuzRCPkBhdjZzRh6Tz4gSFTZbE_ih5bxTbrAz_OB8nWmd4BHmK
 oOzyKnh_wOjKJfL3rFPoqJS3b_waAdIeNfDPtKTbsEn_3EooBHrMWWaL6IEc5IjU0qkUA6H9aHS0
 AxKgdLkPZXSqUV388lkYMvdPwMM135jMLwn6CCW6yCaj69DZRKtbHG.PTeSlq2Sp_jFwMgw2onKs
 HtiduemNRBMyeNQEyfbml3Cq2UJ22ZgiHPw80mR14oSKWeRKG1_jSfP8LSuDwFbV1tuPeFyoicF_
 .9CfPBlorS5olIvzw1DqMS4MdIwfyuZVDlFaDqRxdWuAMKE0WAC9Iz706qpQy9u5xTPKZlnk8Dwn
 ltJvjusMf938WcT5DhiOIxxykRF7K2rIp8yCItKZftkLplhsmF502DVazepMGeoZ8Ke6.lqXlCOF
 Dv5qorY9HnKJ1VBTWgLM0S9B6OKR3gWMKzxAr1AQrU_JXHr9S6d7K8lJRqlmMjegYUOVtu6wBCns
 8knFa_TUTRncLUo8FzSE4nY_VPujIjbNvogR1zmBsA_otQ8WgBYotV61RXhezTTLLOW91t9meJAF
 Ru6hKZqbgZwCn1cnqOAmszTzpJJc3Ehe9xrhj_rWVRydnZMfSRCp_qv5UXAW4_suj0LAj3DM1kmy
 x1VtrP2aT8Bwkkx6klOaVpVPFpnatTmIP5cnB3sOcvKMFlV3TfBIKcizLI0YN8mflKLPzJ3KFR2Z
 t01CIuEh9wKZ.WdRW6dzIUPSYroM.9jIllb9iqOTqN_NCSw9l_xV0CpYuZiYiFZg2rqpzzO9QwFg
 .FuHCQZDD_p.Dwey.MY__Vb9ZB7QF49a7tcxnngSeEGhag8v9um7oQ2JoOmWzMAE3ARVRusUQcPa
 AYA4STxf.umtU1sXSBTJrPnu.S9VFAb_fvdxNkIL0crDlDXFfOZ9fUDwX1W4ja.GicLS0UgfIIfz
 AWcN1fRfXHg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 0c729d1d-a627-43c7-ae17-4b2558945fa1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 18 May 2023 21:26:46 +0000
Received: by hermes--production-gq1-6db989bfb-bkq9d (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 39bd191eef4300165fee30aa24f26e69;
          Thu, 18 May 2023 21:26:43 +0000 (UTC)
Message-ID: <a42875a0-d4c5-e2ac-d115-d4222e229f7d@schaufler-ca.com>
Date:   Thu, 18 May 2023 14:26:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] lsm: adds process attribute getter for Landlock
Content-Language: en-US
To:     Shervin Oloumi <enlightened@chromium.org>, mic@digikod.net
Cc:     linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jeffxu@chromium.org,
        allenwebb@chromium.org, gnoack3000@gmail.com, areber@redhat.com,
        criu@openvz.org, linux-api@vger.kernel.org, jannh@google.com,
        brauner@kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <ce44fc98-1234-fa53-5067-cd624866f44a@digikod.net>
 <20230518204549.3139044-1-enlightened@chromium.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230518204549.3139044-1-enlightened@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21471 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 5/18/2023 1:45 PM, Shervin Oloumi wrote:
> Adds a new getprocattr hook function to the Landlock LSM, which tracks
> the landlocked state of the process. This is invoked when user-space
> reads /proc/[pid]/attr/domain

Please don't add a Landlock specific entry directly in the attr/
directory. Add it only to attr/landlock.

Also be aware that the LSM maintainer (Paul Moore) wants to move
away from the /proc/.../attr interfaces in favor of a new system call,
which is in review.

>  to determine whether a given process is
> sand-boxed using Landlock. When the target process is not sand-boxed,
> the result is "none", otherwise the result is empty, as we still need to
> decide what kind of domain information is best to provide in "domain".

Unless it's too late, you should consider using a term other than "domain".
Domain is used in many contexts already, and your use could be confused
with any number of those.

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
>  fs/proc/base.c             | 11 +++++++++++
>  security/landlock/fs.c     | 38 ++++++++++++++++++++++++++++++++++++++
>  security/landlock/fs.h     |  1 +
>  security/landlock/ptrace.c |  4 ++--
>  security/landlock/ptrace.h |  3 +++
>  5 files changed, 55 insertions(+), 2 deletions(-)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 9e479d7d202b..b257ea704666 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2851,6 +2851,13 @@ static const struct pid_entry apparmor_attr_dir_stuff[] = {
>  LSM_DIR_OPS(apparmor);
>  #endif
>  
> +#ifdef CONFIG_SECURITY_LANDLOCK
> +static const struct pid_entry landlock_attr_dir_stuff[] = {
> +	ATTR("landlock", "domain", 0444),
> +};
> +LSM_DIR_OPS(landlock);
> +#endif
> +
>  static const struct pid_entry attr_dir_stuff[] = {
>  	ATTR(NULL, "current",		0666),
>  	ATTR(NULL, "prev",		0444),
> @@ -2866,6 +2873,10 @@ static const struct pid_entry attr_dir_stuff[] = {
>  	DIR("apparmor",			0555,
>  	    proc_apparmor_attr_dir_inode_ops, proc_apparmor_attr_dir_ops),
>  #endif
> +#ifdef CONFIG_SECURITY_LANDLOCK
> +	DIR("landlock",                  0555,
> +	    proc_landlock_attr_dir_inode_ops, proc_landlock_attr_dir_ops),
> +#endif
>  };
>  
>  static int proc_attr_dir_readdir(struct file *file, struct dir_context *ctx)
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index adcea0fe7e68..2f8b0837a0fd 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -1280,6 +1280,42 @@ static int hook_file_truncate(struct file *const file)
>  	return -EACCES;
>  }
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

Please read the kernel style documentation. "//" comments are
not used in the kernel.

> +	if (landlocked(current))
> +		if (current == task || !task_is_scoped(current, task))
> +			return -EACCES;
> +
> +	// The only supported attribute is "domain".
> +	if (strcmp(name, "domain") != 0)
> +		return -EINVAL;
> +
> +	if (!landlocked(task))
> +		val = "none";
> +
> +	slen = strlen(val);
> +	*value = val;
> +	return slen;
> +}
> +
>  static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(inode_free_security, hook_inode_free_security),
>  
> @@ -1302,6 +1338,8 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(file_alloc_security, hook_file_alloc_security),
>  	LSM_HOOK_INIT(file_open, hook_file_open),
>  	LSM_HOOK_INIT(file_truncate, hook_file_truncate),
> +
> +	LSM_HOOK_INIT(getprocattr, landlock_getprocattr),
>  };
>  
>  __init void landlock_add_fs_hooks(void)
> diff --git a/security/landlock/fs.h b/security/landlock/fs.h
> index 488e4813680a..64145e8b5537 100644
> --- a/security/landlock/fs.h
> +++ b/security/landlock/fs.h
> @@ -13,6 +13,7 @@
>  #include <linux/init.h>
>  #include <linux/rcupdate.h>
>  
> +#include "ptrace.h"
>  #include "ruleset.h"
>  #include "setup.h"
>  
> diff --git a/security/landlock/ptrace.c b/security/landlock/ptrace.c
> index 4c5b9cd71286..de943f0f3899 100644
> --- a/security/landlock/ptrace.c
> +++ b/security/landlock/ptrace.c
> @@ -47,8 +47,8 @@ static bool domain_scope_le(const struct landlock_ruleset *const parent,
>  	return false;
>  }
>  
> -static bool task_is_scoped(const struct task_struct *const parent,
> -			   const struct task_struct *const child)
> +const bool task_is_scoped(const struct task_struct *const parent,
> +			  const struct task_struct *const child)
>  {
>  	bool is_scoped;
>  	const struct landlock_ruleset *dom_parent, *dom_child;
> diff --git a/security/landlock/ptrace.h b/security/landlock/ptrace.h
> index 265b220ae3bf..c6eb08951fc1 100644
> --- a/security/landlock/ptrace.h
> +++ b/security/landlock/ptrace.h
> @@ -11,4 +11,7 @@
>  
>  __init void landlock_add_ptrace_hooks(void);
>  
> +const bool task_is_scoped(const struct task_struct *const parent,
> +			  const struct task_struct *const child);
> +
>  #endif /* _SECURITY_LANDLOCK_PTRACE_H */
