Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4881D666B
	for <lists+linux-api@lfdr.de>; Sun, 17 May 2020 09:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgEQHRR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 17 May 2020 03:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgEQHRR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 17 May 2020 03:17:17 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14932C05BD09
        for <linux-api@vger.kernel.org>; Sun, 17 May 2020 00:17:17 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id s69so3181801pjb.4
        for <linux-api@vger.kernel.org>; Sun, 17 May 2020 00:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aftZV1cdZqqyo7nEiKFeSuPiJj3pGPrb2uZIVEZjg8Y=;
        b=KBiEhBvlYFCV1jPF9d8iOLqAJGzwh7eNPC6bjw/QP/iuqlMtONiBt8ZFUtB7iWgxNv
         3pH86rVMJSygxDx2PXR0qO93TSylEmJ6BdzZUxPFC1Iaw37nlMFHzeSkczNnXl04sDBA
         OeNg4gtoFkA7/VEElrs4D0V5Balkk+TMuIXlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aftZV1cdZqqyo7nEiKFeSuPiJj3pGPrb2uZIVEZjg8Y=;
        b=i1IfXjrZPMvCuoHyMVn9M8916U4ov7iieeDsAFuyM2mK3P2LzXx11sI1pYs38OTm6e
         h9YCG/Nl92v+0F44/T4QJH99ByRibz2RY0CbwgBMsSbyru7x4QuQbhjBwGWZJodhb+w5
         j718x2vz6smI/1N1XZYfR/cUcJIx2vIk9e5d4MQtfSxGiM/TpwG6qc4lCd44qjmyQaFc
         OxwGCM15MKWC2nU9gdOTjcmZLLRHujtgSzlxpEfxEkvDf/amFoqtpnXE6LyRs05RUkAt
         u+x6AJJWniiSeB7yc9GNrn5Al2adVXiSZmhXd9YB5E1Q6X+iCi7n0IJiv8y+6Pb11UK6
         +azA==
X-Gm-Message-State: AOAM531i+0O5ojucHBMeOMHYhydn1Atspl6Y+a/qoOd2Jnt3ZopfSohE
        hkYc7+eLhAe6qlKvKBlujjG/iEK+wZA=
X-Google-Smtp-Source: ABdhPJwd6+CN8t5Wf5VOPsRqc5VmU2ipOXvGUOi+z9ARyAEWm4JDbbZbPMN/aZWXpfoSMN4hIEL32w==
X-Received: by 2002:a17:90a:d506:: with SMTP id t6mr357751pju.49.1589699836216;
        Sun, 17 May 2020 00:17:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d2sm5649154pfa.164.2020.05.17.00.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 00:17:15 -0700 (PDT)
Date:   Sun, 17 May 2020 00:17:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        christian.brauner@ubuntu.com, tycho@tycho.ws, cyphar@cyphar.com
Subject: Re: [PATCH] seccomp: Add group_leader pid to seccomp_notif
Message-ID: <202005162344.74A02C2D@keescook>
References: <20200515234005.32370-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515234005.32370-1-sargun@sargun.me>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 15, 2020 at 04:40:05PM -0700, Sargun Dhillon wrote:
> This includes the thread group leader ID in the seccomp_notif. This is
> immediately useful for opening up a pidfd for the group leader, as
> pidfds only work on group leaders.
> 
> Previously, it was considered to include an actual pidfd in the
> seccomp_notif structure[1], but it was suggested to avoid proliferating
> mechanisms to create pidfds[2].
> 
> [1]: https://lkml.org/lkml/2020/1/24/133
> [2]: https://lkml.org/lkml/2020/5/15/481

nit: please use lore.kernel.org/lkml/ URLs

> Suggested-by: Christian Brauner <christian.brauner@ubuntu.com>
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> ---
>  include/uapi/linux/seccomp.h                  |  2 +
>  kernel/seccomp.c                              |  1 +
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 50 +++++++++++++++++++
>  3 files changed, 53 insertions(+)
> 
> diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
> index c1735455bc53..f0c272ef0f1e 100644
> --- a/include/uapi/linux/seccomp.h
> +++ b/include/uapi/linux/seccomp.h
> @@ -75,6 +75,8 @@ struct seccomp_notif {
>  	__u32 pid;
>  	__u32 flags;
>  	struct seccomp_data data;
> +	__u32 tgid;
> +	__u8 pad0[4];
>  };

I think we need to leave off padding and instead use __packed. If we
don't then userspace can't tell when "pad0" changes its "meaning" (i.e.
the size of seccomp_notif becomes 88 bytes with above -- either via
explicit padding like you've got or via implicit by the compiler. If
some other u32 gets added in the future, user space will still see "88"
as the size.

So I *think* the right change here is:

-};
+	__u32 tgid;
+} __packed;

Though tgid may need to go above seccomp_data... for when it grows.
Agh...

_However_, unfortunately, I appear to have no thought this through very
well, and there is actually no sanity-checking in the kernel for dealing
with an old userspace when sizes change. :( For example, if a userspace
doesn't check sizes and calls an ioctl, etc, the kernel will clobber the
user buffer if it's too small.

Even the SECCOMP_GET_NOTIF_SIZES command lacks a buffer size argument.
:(

So:

- should we just declare such userspace as "wrong"? I don't think
  that'll work, especially since what if we ever change the size of
  seccomp_data...  that predated the ..._SIZES command.

- should we add a SECCOMP_SET_SIZES command to tell the kernel what
  we're expecting? There's no "state" associated across seccomp(2)
  calls, but maybe that doesn't matter because only user_notif writes
  back to userspace. For the ioctl, the state could be part of the
  private file data? Sending seccomp_data back to userspace only
  happens here, and any changes in seccomp_data size will just be seen
  as allowing a filter to query further into it.

- should GET_SIZES report "useful" size? (i.e. exclude padding?)

> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c

Yay test updates! :)

> +TEST(user_notification_groupleader)

In my first pass of review I was going to say "can you please also check
the sizes used by the ioctl?" But that triggered the above size checking
mess in my mind.

Let me look at this more closely on Monday, and I'll proposed something.
:P

Thanks!

-Kees

-- 
Kees Cook
