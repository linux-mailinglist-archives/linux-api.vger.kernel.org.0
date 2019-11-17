Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB70DFFB4D
	for <lists+linux-api@lfdr.de>; Sun, 17 Nov 2019 19:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfKQSCI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 17 Nov 2019 13:02:08 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43204 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfKQSCI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 17 Nov 2019 13:02:08 -0500
Received: by mail-wr1-f66.google.com with SMTP id n1so16754491wra.10;
        Sun, 17 Nov 2019 10:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SOAiGCqxLeDKAkL4etz5e5bf2Xgdy9ztobordpDu2OI=;
        b=DvWbNOi6s1QCbTHH3IG+N1UxXf/sR006yJr5f7m3tb3OQejwMUR5gCV/CVBGaYrVSB
         ykMFyH5Mg0zHanGRtLW6Wmjk7Qb/5PqVIDVVTAL9igEbtHw1P7VFcO0nn/x3Rmk9wwED
         aGCsN0Ye/WcoGaCn0WTozQoUELp3TRe21aKaeDcifLndSus3OzLVZSTgQ6qEy50KjlYt
         iNK1AixlQK32ARdSRYnaUPuuotPBeZqKg6d/pVltRIaNCgXUSnE5E98r1x4wbvuUeLDx
         5dbFS2O8M2hyvAa5cYm41CJjonew96c12Y2/1WUGaryW10XYGjXVir15A76X3WNiGoZg
         7vFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SOAiGCqxLeDKAkL4etz5e5bf2Xgdy9ztobordpDu2OI=;
        b=YW6GwsHTj3Bqdl/3p+ywjsgTbusywPdInjmvgu0YBAbwBRzHgww/GZK5jn7OcEItJt
         Zcx5188BEehJrG2tVDoigP8q8XykitH20I/SLL5hr1dpJHuguZtfMQ/DhU4cc1mmfQij
         10683ifUss5xzB9AGlv+I8Ql/olzBBK70JW28w9mkHtUosujxlZe01wF4DLcPAKT7JYE
         GGgo0xFklxQe/I3WacuXt2px+yk7SODe6cTnSBYgYt4NPCu6PLbwFNQR5JlCnQDrJJks
         bqWSTnb8xdq2Oh2I+Y0hAa6jknG+7e2CfAywXQad7AG2psNHd3ftwz5n4IjbQg+ZodAC
         ChKQ==
X-Gm-Message-State: APjAAAVwarqOkrKWwQCBmcAljxFyW7+h0xYI0bd2+O8GP2Jolbd/0Q9L
        t1x8cTQaC3JErqzgR1dED6U=
X-Google-Smtp-Source: APXvYqwWDHWTfRap0lX/smQFWjenIK1h8drtcSETj80gJG+UbrIl40rXwO1Pk7XHwaHi7wa5QhE0Rg==
X-Received: by 2002:a5d:4410:: with SMTP id z16mr7232355wrq.85.1574013725847;
        Sun, 17 Nov 2019 10:02:05 -0800 (PST)
Received: from [192.168.178.53] (x5f752d31.dyn.telefonica.de. [95.117.45.49])
        by smtp.gmail.com with ESMTPSA id g5sm18303675wmf.37.2019.11.17.10.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Nov 2019 10:02:05 -0800 (PST)
Cc:     mtk.manpages@gmail.com, adrian@lisas.de, akpm@linux-foundation.org,
        arnd@arndb.de, avagin@gmail.com, christian.brauner@ubuntu.com,
        dhowells@redhat.com, fweimer@redhat.com, jannh@google.com,
        keescook@chromium.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
        mingo@elte.hu, oleg@redhat.com, xemul@virtuozzo.com
Subject: Re: [PATCH 3/3] clone.2: Use pid_t for clone3() {child,parent}_tid
To:     Christian Brauner <christian@brauner.io>
References: <20191116114114.7066-1-christian@brauner.io>
 <20191116114114.7066-3-christian@brauner.io>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <c70c0ddf-1cd2-9d33-c2f6-95c8faa546cf@gmail.com>
Date:   Sun, 17 Nov 2019 19:02:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191116114114.7066-3-christian@brauner.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 11/16/19 12:41 PM, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
>
> Advertise to userspace that they should use proper pid_t types for
> arguments returning a pid.
> The kernel-internal struct kernel_clone_args currently uses int as type
> and since POSIX mandates that pid_t is a signed integer type and glibc
> and friends use int this is not an issue. After the merge window for
> v5.5 closes we can switch struct kernel_clone_args over to using pid_t
> as well without any danger in regressing current userspace.
> Also note, that the new set tid feature which will be merged for v5.5
> uses pid_t types as well.

Thanks taking a further pass throuh this page, Christian, 

Patch applied.

Cheers,

Michael

 
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  man2/clone.2 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/man2/clone.2 b/man2/clone.2
> index faff2ada6..bf2d7c731 100644
> --- a/man2/clone.2
> +++ b/man2/clone.2
> @@ -183,9 +183,9 @@ is a structure of the following form:
>  struct clone_args {
>      u64 flags;        /* Flags bit mask */
>      u64 pidfd;        /* Where to store PID file descriptor
> -                         (\fIint *\fP) */
> +                         (\fIpid_t *\fP) */
>      u64 child_tid;    /* Where to store child TID,
> -                         in child's memory (\fIint *\fP) */
> +                         in child's memory (\fIpid_t *\fP) */
>      u64 parent_tid;   /* Where to store child TID,
>                           in parent's memory (\fIint *\fP) */
>      u64 exit_signal;  /* Signal to deliver to parent on
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
