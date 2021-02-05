Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B187F310753
	for <lists+linux-api@lfdr.de>; Fri,  5 Feb 2021 10:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhBEJIc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 5 Feb 2021 04:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhBEJDp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 5 Feb 2021 04:03:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8951C0613D6;
        Fri,  5 Feb 2021 01:02:22 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612515741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PI2qDxyliIROzaHP65iJZdDI7TEweADPsyK8kuQaxNk=;
        b=zBi0MQhP9nKeni7mdwBHlfEkPnsq6w7qX5hPJLpE8k2GAAOTU5T5MzuiWaVAO6QpZ9R2uh
        39j5VzTSW9apNTGLzvkf5dJYsR+GdYFWssTQGgxJYeRv2UNNBlFukr+t0uzWIJxYXqGigG
        if1LapcEXuOo3ME3NDKpg9VvSL4wt5V/8yN4GYUUI33k3E4oOD8g3jClfnSZJZrXACfWFI
        DWqRpILF+fVG/UUtGMYKZ/Md/buLbltRmmMiT56GxRWSDvew1Vfjmo3W+f2kK7htGogQca
        zreluAt0uUGEv307Hk4bSyI9nKFprANnz0gd83c0bLc9Uuegvuqx06BBXw2E+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612515741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PI2qDxyliIROzaHP65iJZdDI7TEweADPsyK8kuQaxNk=;
        b=fmLm5xAkfO4+HxyVQpfy9TXnBr0fqZxm3WoGHV88cd2O4DXF4UKTXWLHVnerMd+XTHCfH5
        ayCGPpFngheKIWCw==
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Linux API <linux-api@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH RESEND] entry: Use different define for selector variable in SUD
In-Reply-To: <20210204184028.1516328-1-krisman@collabora.com>
References: <20210204184028.1516328-1-krisman@collabora.com>
Date:   Fri, 05 Feb 2021 10:02:20 +0100
Message-ID: <87ft2aanvn.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Gabriel,

On Thu, Feb 04 2021 at 13:40, Gabriel Krisman Bertazi wrote:
> Michael Kerrisk suggested that, from an API perspective, it is a bad
> idea to share the PR_SYS_DISPATCH_ defines between the prctl operation
> and the selector variable.  Therefore, define two new constants to be
> used by SUD's selector variable, and the corresponding documentation.
>
> While this changes the API, it is backward compatible, as the values
> remained the same and the old defines are still in place.  In addition,
> SUD has never been part of a Linux release, it will show up for the
> first time in 5.11.

> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -251,5 +251,7 @@ struct prctl_mm_map {
>  #define PR_SET_SYSCALL_USER_DISPATCH	59
>  # define PR_SYS_DISPATCH_OFF		0
>  # define PR_SYS_DISPATCH_ON		1
> +# define PR_SYS_DISPATCH_FILTER_ALLOW	0
> +# define PR_SYS_DISPATCH_FILTER_BLOCK	1

This is still confusing because the defines are kinda associated to the
prctl(). But ALLOW/BLOCK are the values which for the user space
selector which allows to runtime filter the dispatching without the
overhead of prctl().

So they want to be visualy seperated and not part of the PR_
namespace. Something like the below.

#define PR_SET_SYSCALL_USER_DISPATCH	59
# define PR_SYS_DISPATCH_OFF		0
# define PR_SYS_DISPATCH_ON		1

/* Control values for the syscall dispatch runtime selector (filter) */
# define SYSCALL_DISPATCH_FILTER_ALLOW	0
# define SYSCALL_DISPATCH_FILTER_BLOCK	1

Hmm?

Thanks,

        tglx
