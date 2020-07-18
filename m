Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C79C224770
	for <lists+linux-api@lfdr.de>; Sat, 18 Jul 2020 02:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgGRAUY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 17 Jul 2020 20:20:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44290 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgGRAUX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 17 Jul 2020 20:20:23 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595031622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jv2VdQnkTr8+XQYFUofp91/Rl2Qzd2VbHJNnxfV1D48=;
        b=lDpR0rTpJMMOiRgZwby1ejqs9XPgPYHc377WZ3Vpnvro+drAuS3SzsLTb99Be47bHGHAQD
        vIoBrHNJpWnhgjUr1sY3s8MjZIUQ92FP2OgszmM3JHnzMZXUezRdwdz+sOpaMgpCrTqxRP
        10n56mNF/2+TRWYR7G76n2BDm0cOjEeiKGPjMlr0plMc2ka0GgoBVCPtdR3oZTDQeWiAVQ
        u+dFohdMIYm3BrHjBJeLzC9K4h+y4C/h9227QnQTXHn+W9YmSZVhRU6tbG0t+jelAUpgjb
        Z1Gz+QMrwxGWY+sUxesB0XMPmo+4sGP3+BGyw3NcW9bOdoALwAzBetThxicC/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595031622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jv2VdQnkTr8+XQYFUofp91/Rl2Qzd2VbHJNnxfV1D48=;
        b=xbrDvoI1YuwSa+uVeaI7kRQXeiJQ8PVQfIANqc2kYJnpEBXhaDMBGBYiJeCPoOyk1zYdJQ
        B0L+Dzv06aS2BFCQ==
To:     Bui Quang Minh <minhquangbui99@gmail.com>,
        minhquangbui99@gmail.com, trivial@kernel.org
Cc:     linux-api@vger.kernel.org
Subject: Re: [PATCH] syscall.h: fix comment
In-Reply-To: <20200717104517.2275-1-minhquangbui99@gmail.com>
References: <20200717104517.2275-1-minhquangbui99@gmail.com>
Date:   Sat, 18 Jul 2020 02:20:21 +0200
Message-ID: <87k0z1ptbu.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Bui Quang Minh <minhquangbui99@gmail.com> writes:

> The comment shows wrong file name that contains the syscalls' definition
>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  include/linux/syscalls.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 1815065d52f3..a3d053f715e2 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -741,7 +741,7 @@ asmlinkage long sys_settimeofday(struct __kernel_old_timeval __user *tv,
>  asmlinkage long sys_adjtimex(struct __kernel_timex __user *txc_p);
>  asmlinkage long sys_adjtimex_time32(struct old_timex32 __user *txc_p);
>  
> -/* kernel/timer.c */
> +/* kernel/sys.c */

How about just removing the file reference completely. It has no value
at all.

Thanks,

        tglx
