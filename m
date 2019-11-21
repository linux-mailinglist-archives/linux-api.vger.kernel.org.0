Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE278104FB3
	for <lists+linux-api@lfdr.de>; Thu, 21 Nov 2019 10:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfKUJx5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 21 Nov 2019 04:53:57 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35467 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfKUJx5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 21 Nov 2019 04:53:57 -0500
Received: by mail-wm1-f65.google.com with SMTP id 8so2957489wmo.0;
        Thu, 21 Nov 2019 01:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HRI7jMsfZg/6yN9y8QeBJ/0eCsSXgHr+K32uQq/2e9o=;
        b=h/C2/TL3A8u3PVkEFv2fCeeSVIQB/ieJ6Z4tj51otWleTHIFNWzLtOcklguFdiy1v/
         QqPPCv96AZ6Qv5X4Q8JdP1x3WOE3Z2vWJ/lNyCUM94jQOzYvmgIS24UXkiID85I+gIhk
         My+s+CAayNoQhwC0lISLjTYl9bkUWiSIUyLTYz+rcYTWGcVeQc6CyD9sciCiPgbH6YS/
         Jg++igReFZkZR/69jN6GgCEKAXqF8JAvvrWGIk8u03p3m5rifIixtGuQPbT4/mFjeZvg
         xlbSFRmC5v8vcehSRybrB6iKobgHaxsGa7JEDRgoI58xDF1J69DhvXlrqgo84g27tOFd
         mXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HRI7jMsfZg/6yN9y8QeBJ/0eCsSXgHr+K32uQq/2e9o=;
        b=oTb3+Zfkqk7PR+0z2QBUQrn+yzniqka9+npw+5WnadFYIBHtWFWFjmEyMXkPAK6OqD
         QFPtRDhWOEDz4NXfdkMmFuE11a+4VD/yY6fw0dZ/vJUkznMSjgdBrEC5YfXUMSqQBD6m
         42FE/OTtMAVQbyeQbLtTHEBkG/RTX+trO9FkA66bHeCvfQ2T3oVrqTjMSQFixWKM21Vw
         rGOSOirhoDe9Lo+hwNWUyLecAofvW4Zfokgv3S1Kjz4SE7Euba7XGr75jNF5NmPwwaIk
         6hWDBxbLurvKWdO2hNEkGfoeNP3vtnaahdtxMl1tZNqNg39i8gyt0j1eMfNJWCa5iqgx
         EM7A==
X-Gm-Message-State: APjAAAXNlYYElZWViSrfpweOLHtfQGophqOG10pa2XiYTBT7U9h6MG1z
        XgghHIjgwGMBkosZzdRnlj0=
X-Google-Smtp-Source: APXvYqxPaiuw+IrHUCpSDRwFSn5UEjFS4ACeKRDkFBKGvOyoSQiRNrDoyvOrqyqMjaWGHDCOPtyZkQ==
X-Received: by 2002:a7b:c08c:: with SMTP id r12mr8642794wmh.67.1574330034733;
        Thu, 21 Nov 2019 01:53:54 -0800 (PST)
Received: from ?IPv6:2001:a61:3a4e:101:8d4d:f454:a7e5:543d? ([2001:a61:3a4e:101:8d4d:f454:a7e5:543d])
        by smtp.gmail.com with ESMTPSA id w4sm2219462wmk.29.2019.11.21.01.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 01:53:53 -0800 (PST)
Cc:     mtk.manpages@gmail.com, adrian@lisas.de, akpm@linux-foundation.org,
        arnd@arndb.de, avagin@gmail.com, christian.brauner@ubuntu.com,
        dhowells@redhat.com, fweimer@redhat.com, jannh@google.com,
        keescook@chromium.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
        mingo@elte.hu, oleg@redhat.com, xemul@virtuozzo.com
Subject: Re: [PATCH] clone.2: Mention that CLONE_PARENT is off-limits for
 inits
To:     Christian Brauner <christian@brauner.io>
References: <20191120104504.22411-1-christian@brauner.io>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <ac6c1644-c6d3-c7eb-48b1-28eb9342a468@gmail.com>
Date:   Thu, 21 Nov 2019 10:53:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191120104504.22411-1-christian@brauner.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Christian,

On 11/20/19 11:45 AM, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> The CLONE_PARENT flag cannot but used by init processes. Let's mention
> this in the manpages to prevent suprises.
> 
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  man2/clone.2 | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/man2/clone.2 b/man2/clone.2
> index f0f29d6f1..aa98ab79b 100644
> --- a/man2/clone.2
> +++ b/man2/clone.2
> @@ -646,6 +646,13 @@ if
>  .B CLONE_PARENT
>  is set, then the parent of the calling process, rather than the
>  calling process itself, will be signaled.
> +.IP
> +The kernel will not allow global init and init processes in pid
> +namespaces to use the
> +.B CLONE_PARENT
> +flag. This is done to prevent the creation of multi-rooted process
> +trees. It also avoids unreapable zombies in the initial pid
> +namespace.
>  .TP
>  .BR CLONE_PARENT_SETTID " (since Linux 2.5.49)"
>  Store the child thread ID at the location pointed to by

Thank. I applied, and then tweaked the text a little,
and noted the associated EINVAL error. In the end, the
change is as below.

Cheers,

Michael

index 60e746151..382f6b791 100644
--- a/man2/clone.2
+++ b/man2/clone.2
@@ -648,6 +648,14 @@ if
 .B CLONE_PARENT
 is set, then the parent of the calling process, rather than the
 calling process itself, will be signaled.
+.IP
+The
+.B CLONE_PARENT
+flag can't be used in clone calls by the
+global init process (PID 1 in the initial PID namespace)
+and init processes in other PID namespaces.
+This restriction prevents the creation of multi-rooted process trees
+as well as the creation of unreapable zombies in the initial PID namespace.
 .TP
 .BR CLONE_PARENT_SETTID " (since Linux 2.5.49)"
 Store the child thread ID at the location pointed to by
@@ -1273,6 +1281,11 @@ were specified in the
 .IR flags
 mask.
 .TP
+.BR EINVAL " (since Linux 2.6.32)"
+.\" commit 123be07b0b399670a7cc3d82fef0cb4f93ef885c
+.BR CLONE_PARENT
+was specified, and the caller is an init process.
+.TP
 .B EINVAL
 Returned by the glibc
 .BR clone ()



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
