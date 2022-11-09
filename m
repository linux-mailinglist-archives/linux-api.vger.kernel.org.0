Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0FF62377C
	for <lists+linux-api@lfdr.de>; Thu, 10 Nov 2022 00:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiKIXeA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 9 Nov 2022 18:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiKIXd7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 9 Nov 2022 18:33:59 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74987FCCB
        for <linux-api@vger.kernel.org>; Wed,  9 Nov 2022 15:33:58 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id j25-20020a056830015900b0066ca2cd96daso250409otp.10
        for <linux-api@vger.kernel.org>; Wed, 09 Nov 2022 15:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7dLiDnqXQpyBzsozj56gFcsd4WQsntSnrI1Dq8cPcBA=;
        b=tAoQMDHytMmH7nFKf9VCji2q1tB1MAtwBjWjOsgH0kuasg86nWhbMehYoTZQa2tCIs
         3JC+5qYx9RPgmzc2WnpNJiFpcJqIHJxtEtyPhFWLp0VJUvAegB88t+cBEBnz9ADvXjKK
         PPYgPvw6HaCcpGmM6kv8Sq5jCliQ+kPFVbFD7QM/xMpygIa2ROCx1vBxsTsBUUxxsmeB
         /EZSur0XUfMYlMiF00TyjX3CwUzrXkSZcEibGpL/Ecl3XuLD9eCV7wKhUZtg9LIQ6DC3
         i2uLpe3eJ1nRdSd3iDzc4j6na8Oqb/7a0xAo7ljjvrBZyHB0onMSEo1kYeK5okdbjSwO
         ljnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7dLiDnqXQpyBzsozj56gFcsd4WQsntSnrI1Dq8cPcBA=;
        b=SqR3AFe0NSvYnapKt4MiJI0s2aCyOnOedrdn8ybx85iNQiEjLIeqXBC6nNh0w0bYGl
         V8M1mcu96YXGzO0V1e+K6kO47OQ+QXj4286XVUZhaCdsHSGAHUqvI4qHgn9inRMk4HZL
         11lctMt/6WKggKI+wP0mXt7fMK3Y92DgGV31hoWurJK/GqhGNz7dDoVEDnaVqgBVsl9Q
         p+Ktz73AHXASlKIYU4gT9id0PNbzR9bYOop/3tARQ1LftMteUG2T8ayWU12/qUAcwiqL
         dfuKg03yhNsGIA+v0aC2c/DbPZEYtgi5KDyUsRj4mO6qc/9ywGoQkEsl29zP0KpzHnwy
         iJIw==
X-Gm-Message-State: ACrzQf0gbSmz6YnNMAMgsnpbRqqIZxme7Ye69n2IvWUnZDBPWKMs8xkJ
        ijrHmYVG4DOURxYJRsAtYDj8+ZheTx3/THp46+yG
X-Google-Smtp-Source: AMsMyM68dDXBbuqVEKDurPj0t5g4PgiQwtOK4V8TKADlLJagug+5vKGH3zECUny4I28XV/Ze4A8ZpmgXi6asaEJNvMQ=
X-Received: by 2002:a9d:1aa:0:b0:66c:6922:8640 with SMTP id
 e39-20020a9d01aa000000b0066c69228640mr870217ote.34.1668036837558; Wed, 09 Nov
 2022 15:33:57 -0800 (PST)
MIME-Version: 1.0
References: <20221025184519.13231-1-casey@schaufler-ca.com> <20221025184519.13231-3-casey@schaufler-ca.com>
In-Reply-To: <20221025184519.13231-3-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Nov 2022 18:33:46 -0500
Message-ID: <CAHC9VhQONd9zFJswcAsY9-xQcRhoYwXtwyo4zT5XsSPTEtvuRg@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] LSM: Add an LSM identifier for external use
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Oct 25, 2022 at 2:45 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Add an integer member "id" to the struct lsm_id. This value is
> a unique identifier associated with each security module. The
> values are defined in a new UAPI header file. Each existing LSM
> has been updated to include it's LSMID in the lsm_id.
>
> The LSM ID values are sequential, with the oldest module
> LSM_ID_CAPABILITY being the lowest value and the existing
> modules numbered in the order they were included in the
> main line kernel. The first 32 values (0 - 31) are reserved
> for some as yet unknown but important use.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h    |  1 +
>  include/uapi/linux/lsm.h     | 32 ++++++++++++++++++++++++++++++++
>  security/apparmor/lsm.c      |  2 ++
>  security/bpf/hooks.c         |  2 ++
>  security/commoncap.c         |  2 ++
>  security/landlock/setup.c    |  2 ++
>  security/loadpin/loadpin.c   |  2 ++
>  security/lockdown/lockdown.c |  2 ++
>  security/safesetid/lsm.c     |  2 ++
>  security/selinux/hooks.c     |  2 ++
>  security/smack/smack_lsm.c   |  2 ++
>  security/tomoyo/tomoyo.c     |  2 ++
>  security/yama/yama_lsm.c     |  2 ++
>  13 files changed, 55 insertions(+)
>  create mode 100644 include/uapi/linux/lsm.h

Unless you're getting paid by the patch, I'd rather you combine
patches 1/8 and 2/8 into a single patch.  They are both pretty small,
very related, and I don't want to see 1/8 merged anywhere without 2/8.

> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index e383e468f742..dd4b4d95a172 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1607,6 +1607,7 @@ struct security_hook_heads {
>   */
>  struct lsm_id {
>         const char      *lsm;           /* Name of the LSM */
> +       int             id;             /* LSM ID */
>  };

At the very least let's define lsm_id::id as an 'unsigned int' type,
but since we are going to see the lsm_id::id token used as part of the
kernel ABI (likely not in this struct) I agree with Greg's comments
about making the size more explicit.  I would suggest __u32/u32 as
32-bits should be plenty for this token.

Given the other upstream discussions we may want to do something
similar with lsm_id::lsm and __u8/u8.  I'm pretty sure I saw a similar
comment (by Greg?) elsewhere in this patchset when I was quickly
skimming these on my phone while away ...

--
paul-moore.com
