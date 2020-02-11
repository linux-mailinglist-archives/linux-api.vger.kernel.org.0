Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 395681591B3
	for <lists+linux-api@lfdr.de>; Tue, 11 Feb 2020 15:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbgBKORa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 11 Feb 2020 09:17:30 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:47721 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbgBKOR3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 11 Feb 2020 09:17:29 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j1WLu-0007U1-J8; Tue, 11 Feb 2020 14:17:26 +0000
Date:   Tue, 11 Feb 2020 15:17:25 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Mike Christie <mchristi@redhat.com>, mtk.manpages@gmail.com
Cc:     linux-api@vger.kernel.org, david@fromorbit.com, mhocko@suse.com,
        masato.suzuki@wdc.com, damien.lemoal@wdc.com,
        darrick.wong@oracle.com, bvanassche@acm.org,
        linux-man@vger.kernel.org
Subject: Re: [PATCH 1/1] prctl.2: doc PR_SET/GET_IO_FLUSHER
Message-ID: <20200211141725.4vbnh3iifbbaquec@wittgenstein>
References: <20200210221557.8021-1-mchristi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200210221557.8021-1-mchristi@redhat.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

I think you've missed:
mtk.manpages@gmail.com
linux-man@vger.kernel.org

:)

Christian

On Mon, Feb 10, 2020 at 04:15:57PM -0600, Mike Christie wrote:
> This patch documents the PR_SET_IO_FLUSHER and PR_GET_IO_FLUSHER
> prctl commands added to the linux kernel for 5.6 in commit:
> 
> commit 8d19f1c8e1937baf74e1962aae9f90fa3aeab463
> Author: Mike Christie <mchristi@redhat.com>
> Date:   Mon Nov 11 18:19:00 2019 -0600
> 
>     prctl: PR_{G,S}ET_IO_FLUSHER to support controlling memory reclaim
> 
> Signed-off-by: Mike Christie <mchristi@redhat.com>
> ---
> 
> V2:
> - My initial patch for this was very bad. This version is almost 100%
> taken word for word from Dave Chinner's review comments.
> 
> 
>  man2/prctl.2 | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/man2/prctl.2 b/man2/prctl.2
> index 720ec04e4..b481d186b 100644
> --- a/man2/prctl.2
> +++ b/man2/prctl.2
> @@ -1381,6 +1381,30 @@ system call on Tru64).
>  for information on versions and architectures.)
>  Return unaligned access control bits, in the location pointed to by
>  .IR "(unsigned int\ *) arg2" .
> +.TP
> +.B PR_SET_IO_FLUSHER (Since Linux 5.6)
> +An IO_FLUSHER is a user process that the kernel uses to issue IO
> +that cleans dirty page cache data and/or filesystem metadata. The
> +kernel may need to clean this memory when under memory pressure in
> +order to free it. This means there is potential for a memory reclaim
> +recursion deadlock if the user process attempts to allocate memory
> +and the kernel then blocks waiting for it to clean memory before it
> +can make reclaim progress.
> +
> +The kernel avoids these recursion problems internally via a special
> +process state that prevents recursive reclaim from issuing new IO.
> +If \fIarg2\fP is 1, the \fPPR_SET_IO_FLUSHER\fP control allows a userspace
> +process to set up this same process state and hence avoid the memory
> +reclaim recursion deadlocks in the same manner the kernel avoids them.
> +If \fIarg2\fP is 0, the process will clear the IO_FLUSHER state, and the
> +default behavior will be used.
> +
> +Examples of IO_FLUSHER applications are FUSE daemons, zoned disk
> +emulation daemons, etc."
> +.TP
> +.B PR_GET_IO_FLUSHER (Since Linux 5.6)
> +Return as the function result 1 if the caller is in the IO_FLUSHER state and
> +0 if not.
>  .SH RETURN VALUE
>  On success,
>  .BR PR_GET_DUMPABLE ,
> @@ -1395,6 +1419,7 @@ On success,
>  .BR PR_GET_SPECULATION_CTRL ,
>  .BR PR_MCE_KILL_GET ,
>  .BR PR_CAP_AMBIENT + PR_CAP_AMBIENT_IS_SET ,
> +.BR PR_GET_IO_FLUSHER ,
>  and (if it returns)
>  .BR PR_GET_SECCOMP
>  return the nonnegative values described above.
> -- 
> 2.21.0
> 
