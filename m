Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1657519BBF8
	for <lists+linux-api@lfdr.de>; Thu,  2 Apr 2020 08:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgDBGrT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 2 Apr 2020 02:47:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38362 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgDBGrT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 2 Apr 2020 02:47:19 -0400
Received: by mail-wm1-f67.google.com with SMTP id f6so2315914wmj.3;
        Wed, 01 Apr 2020 23:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=APBnpcrM1igWj8QeRjLF0OhThcauTpIhkpildd1GrUY=;
        b=giqT6qyQgQqI9Pi1mSI/nvq8TIMb+ylztlqgatErgTDGAg2ZLHXJywxNcTeCSFXbPK
         d5YOrdmTpcho97FHLNo/dXbtKQE3Kk68D88NE7nJ/mT1+wy0aQM+jlJIkapskWhVDH+B
         pOzGHAIgfKR0bPrxMUiUNfchfxUnMrkeAyEFR+aeC/Ar9VBh8kjwgsXxGCO/sio1tZxC
         9WoHn8te4S6e7b3uvwEVXHoJ/q5uQ0ZU0SKjoW3VwU7RniswNOFg2xVuinBKSGA7G6T5
         tuXmLambH1FVf+P/3BumzxtmYrcs4aJVSG+0pY72npSLYC6bjHVuNO2sCM3eZ2SCEoCZ
         M/6Q==
X-Gm-Message-State: AGi0PubBi0/5fOXRJHlDwtgfdr4N88luNJInGbYNE8fEArjlQV/2OZ20
        DCfmZv1yEExKLscAeX4777nwqh4Z
X-Google-Smtp-Source: APiQypLx9bRRK8ubCHz/F7Sgxy1DEHRE7CE2kgngLU0tu1PLA9l+KB/7epbuv/jgckcrOWcR0m0odQ==
X-Received: by 2002:a1c:dfd5:: with SMTP id w204mr1795459wmg.153.1585810037523;
        Wed, 01 Apr 2020 23:47:17 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id 19sm5807227wmi.32.2020.04.01.23.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 23:47:16 -0700 (PDT)
Date:   Thu, 2 Apr 2020 08:47:13 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Christie <mchristi@redhat.com>
Cc:     linux-api@vger.kernel.org, david@fromorbit.com,
        masato.suzuki@wdc.com, damien.lemoal@wdc.com,
        darrick.wong@oracle.com, bvanassche@acm.org,
        mtk.manpages@gmail.com, linux-man@vger.kernel.org
Subject: Re: [PATCH] prctl.2: doc PR_SET/GET_IO_FLUSHER - V4
Message-ID: <20200402064713.GD22681@dhcp22.suse.cz>
References: <20200402020850.7218-1-mchristi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402020850.7218-1-mchristi@redhat.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed 01-04-20 21:08:50, Mike Christie wrote:
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

Yes this wording is much better than the previous version.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> 
> V4:
> - Remove internal details.
> - Add CAP_SYS_RESOURCE requirement info.
> 
> V3:
> - Replace emulation device example.
> 
> V2:
> - My initial patch for this was very bad. This version is almost 100%
> taken word for word from Dave Chinner's review comments.
> 
> Signed-off-by: Mike Christie <mchristi@redhat.com>
> 
>  man2/prctl.2 | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/man2/prctl.2 b/man2/prctl.2
> index 720ec04e4..3c3355439 100644
> --- a/man2/prctl.2
> +++ b/man2/prctl.2
> @@ -1381,6 +1381,31 @@ system call on Tru64).
>  for information on versions and architectures.)
>  Return unaligned access control bits, in the location pointed to by
>  .IR "(unsigned int\ *) arg2" .
> +.TP
> +.B PR_SET_IO_FLUSHER (Since Linux 5.6)
> +If a user process is involved in the block layer or file system IO path,
> +and can allocate memory while processing IO requests it must set
> +\fIarg2\fP to 1. This will put the process in the IO_FLUSHER state which
> +allows it special treatment to make progress when allocating memory.
> +If \fIarg2\fP is 0, the process will clear the IO_FLUSHER state, and
> +the default behavior will be used.
> +
> +The calling process must have the
> +.BR CAP_SYS_RESOURCE
> +capability.
> +
> +Examples of IO_FLUSHER applications are FUSE daemons, SCSI device
> +emulation daemons, and daemons that perform error handling like multipath
> +path recovery applications.
> +
> +.TP
> +.B PR_GET_IO_FLUSHER (Since Linux 5.6)
> +Return as the function result 1 if the caller is in the IO_FLUSHER state and
> +0 if not.
> +
> +The calling process must have the
> +.BR CAP_SYS_RESOURCE
> +capability.
>  .SH RETURN VALUE
>  On success,
>  .BR PR_GET_DUMPABLE ,
> @@ -1395,6 +1420,7 @@ On success,
>  .BR PR_GET_SPECULATION_CTRL ,
>  .BR PR_MCE_KILL_GET ,
>  .BR PR_CAP_AMBIENT + PR_CAP_AMBIENT_IS_SET ,
> +.BR PR_GET_IO_FLUSHER ,
>  and (if it returns)
>  .BR PR_GET_SECCOMP
>  return the nonnegative values described above.
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
