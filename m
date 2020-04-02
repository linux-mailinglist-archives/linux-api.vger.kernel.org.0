Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD2F819BA29
	for <lists+linux-api@lfdr.de>; Thu,  2 Apr 2020 04:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387442AbgDBCIh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 1 Apr 2020 22:08:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50386 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733213AbgDBCIh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 1 Apr 2020 22:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585793316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c/BadM6Esq5VbShny8fu+LSoSc+N7/WtObDYzZ4i4H4=;
        b=IP89XuHj5ulqVJKhn89QpjIbp2SuGO26D7NMoxlMGLGw73lNPIeOe+s6mZle4xhBlHgV25
        l38o5ChL2rqYgN/rLLmgk4jlY/OCzNswpvBv5s4AFUxRdg1d/b2BEjn2tMXs5xUFcA1m7y
        7wRc3waYSNKtWDDQPGwUpioPthsYnH0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-WXfeoEyZOxqXJI8FEHgXmA-1; Wed, 01 Apr 2020 22:08:32 -0400
X-MC-Unique: WXfeoEyZOxqXJI8FEHgXmA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DEC91005513;
        Thu,  2 Apr 2020 02:08:30 +0000 (UTC)
Received: from [10.10.112.7] (ovpn-112-7.rdu2.redhat.com [10.10.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 80479100EBBD;
        Thu,  2 Apr 2020 02:08:29 +0000 (UTC)
Subject: Re: [PATCH 1/1] prctl.2: doc PR_SET/GET_IO_FLUSHER
To:     linux-api@vger.kernel.org, david@fromorbit.com, mhocko@suse.com,
        masato.suzuki@wdc.com, damien.lemoal@wdc.com,
        darrick.wong@oracle.com, bvanassche@acm.org,
        mtk.manpages@gmail.com, linux-man@vger.kernel.org
References: <20200402020732.7127-1-mchristi@redhat.com>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5E85491C.4040407@redhat.com>
Date:   Wed, 1 Apr 2020 21:08:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20200402020732.7127-1-mchristi@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Sorry. Ignore this patch. It was an old version.

On 04/01/2020 09:07 PM, Mike Christie wrote:
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
> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
> 
> V3:
> - Replace emulation device example.
> 
> V2:
> - My initial patch for this was very bad. This version is almost 100%
> taken word for word from Dave Chinner's review comments.
> 
> Signed-off-by: Mike Christie <mchristi@redhat.com>
> ---
>  man2/prctl.2 | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/man2/prctl.2 b/man2/prctl.2
> index 720ec04e4..58d77bf2e 100644
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
> +Examples of IO_FLUSHER applications are FUSE daemons, SCSI device
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
> 

