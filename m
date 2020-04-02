Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15A5E19C0ED
	for <lists+linux-api@lfdr.de>; Thu,  2 Apr 2020 14:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387971AbgDBMQK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 2 Apr 2020 08:16:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36908 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387730AbgDBMQK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 2 Apr 2020 08:16:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so3955366wrm.4;
        Thu, 02 Apr 2020 05:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GYU3X1f6lmymwhHA7CNltuWt4heqcKNa3pNloylo6PE=;
        b=FWIPt6Yku393+iHdeSkqpgK7N4DFD2M0qCekK0gf/nsNcEiLzbbGutjiPf/xC1dCsV
         WuUPtBwPto60NhfA+AOSMyC75ypMSTbdJ1rFRfvzhP50aeb2r9RO97BX27mG5NBEHnfO
         tkReN2llrB2d61mH9ceKxohWMK33H6fMa/UXtO9knDOvlOgccFZMfnqnysA09jwfZPD9
         Xj27j6WY74+tqvGE1phd4iG5qr4kEEl9mNi1LEBpi5ziI8vxC0mbJEzFQJepCHBSwj4v
         o54OTLR/8+0mWNI9f7jcPyrwDOBUMTIX6BgCVfZhwlaVsem/VqVhbzCuVJ23J6NY/2Ol
         n1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GYU3X1f6lmymwhHA7CNltuWt4heqcKNa3pNloylo6PE=;
        b=hRt6AalCpLmyhsF49cyNS9FFgBlp8IhopyCHDSiDYxgjeIjiGxB1e4eXURhU7aDwg8
         fgvh81lEH/dyEPymZMp+oAwQeN68aWBQPnraRGpcLdGFYgdqzkpL3DEy9CKsIUaXWoxa
         VRd6htcBctzBU9pZRxqVYgwnf+2AUy93qWMf0rmorISDD1qN4f5HPNanDVb3QzVt4/SN
         WnUzrPlj4rDZyUPimhpzvObWJn2v+ocXkogZLZPd748qFKbUDt9GDgBiWWsh+mBIncLz
         4JOU2RIW2QDhwGoXBcbbqpR0Dl6N/lnBc7yA1ufHwWFrPdTCQI6V1G27hYmi6cdd38xa
         7Tgg==
X-Gm-Message-State: AGi0PuaItiRVuxKJrajRboUPSoUB6pPpDRLPMdn0hZ7UahL2uVriCMLF
        NE5SprQnGUb0hHAVosO5J7Y=
X-Google-Smtp-Source: APiQypKjUKTH+IQCZ7EeeCrcRr2Fh4RUlUcJYeJZRu24IYOW+NNRJoJHWtUsPbOuGJTUSXPMOe6EfQ==
X-Received: by 2002:a5d:526d:: with SMTP id l13mr3315442wrc.135.1585829767601;
        Thu, 02 Apr 2020 05:16:07 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:3351:6160:8173:cc31? ([2001:a61:2482:101:3351:6160:8173:cc31])
        by smtp.gmail.com with ESMTPSA id f12sm7289866wrm.94.2020.04.02.05.16.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 05:16:06 -0700 (PDT)
Cc:     mtk.manpages@gmail.com
Subject: Re: [PATCH] prctl.2: doc PR_SET/GET_IO_FLUSHER - V4
To:     Mike Christie <mchristi@redhat.com>, linux-api@vger.kernel.org,
        david@fromorbit.com, mhocko@suse.com, masato.suzuki@wdc.com,
        damien.lemoal@wdc.com, darrick.wong@oracle.com, bvanassche@acm.org,
        linux-man@vger.kernel.org
References: <20200402020850.7218-1-mchristi@redhat.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <111926f0-942c-66ea-4e43-9f90e7b43549@gmail.com>
Date:   Thu, 2 Apr 2020 14:16:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200402020850.7218-1-mchristi@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Mike,

On 4/2/20 4:08 AM, Mike Christie wrote:
> This patch documents the PR_SET_IO_FLUSHER and PR_GET_IO_FLUSHER
> prctl commands added to the linux kernel for 5.6 in commit:
> 
> commit 8d19f1c8e1937baf74e1962aae9f90fa3aeab463
> Author: Mike Christie <mchristi@redhat.com>
> Date:   Mon Nov 11 18:19:00 2019 -0600> 
>     prctl: PR_{G,S}ET_IO_FLUSHER to support controlling memory reclaim
> 
> Signed-off-by: Mike Christie <mchristi@redhat.com>

I've applied this patch, but I have some questions:

(a) What happens to the IO_FLUSHER setting in the child of fork(2)?
(b) What happens to the IO_FLUSHER setting during an execve(2)?
    (Is it preserved, reset, something else?)

Thanks,

Michael

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
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
