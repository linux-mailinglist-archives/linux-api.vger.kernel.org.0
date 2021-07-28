Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E643D96F9
	for <lists+linux-api@lfdr.de>; Wed, 28 Jul 2021 22:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhG1UoR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 28 Jul 2021 16:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbhG1UoQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Jul 2021 16:44:16 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E5CC061757;
        Wed, 28 Jul 2021 13:44:14 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id u15so2269030wmj.1;
        Wed, 28 Jul 2021 13:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QwRtAIHBAblWSqdgtiYL3wGwUxmkxW1veLnj4lNgaJk=;
        b=I7tXiajS8T6PWN9z5pbl8pTXv8EvQTBNmlFDf5BuVo4Q2KfKVmJPZQoJ+WfsFr1oyl
         mckUAbN3UGEDAwUDOnSh4RH5VqxN3Ieu1h7suk5DnuINWEy0FfXGcTQILuuM22vdy4O/
         JzDXg00uwQlC9I3NNGK1CYzqwkqfsiU0HmyLOv8E4qrvWn5Se0QYmk+1/jOJBxewRvAJ
         4SB9ob4d1zOOwGUiwM0kb7PjkCSDtBGN2uHza8Q6M5xirjC9TT13cQu1wT+L4tIZfZ6J
         WMAJHF7J/9UcYRrjCpcapAb1YsKU7dj0k1GYXaBKuVHB+Fp31Exnp5fmVTBvxxohRFS3
         30ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QwRtAIHBAblWSqdgtiYL3wGwUxmkxW1veLnj4lNgaJk=;
        b=mIlKYlsapoLYClJcginuUuq5kiTWoYNbFHZO5Pab4ry+lCXd5MFGpK8FyAb0QyvzXT
         J2bviFoUyszsR9tEbkRSlqvgpMUFTIyhZONcg4qK1HZGSQSfB6TVGJOLt45EG5awEwR4
         LICUbQO/g8Z4JsYrOi91WOSMTNvwumVgPFrgzkkcL2UvN6pr1oGfXXBdZyVGCtn0mXE8
         3ZBhQ5yHs/84R0yNK97X3fQQKZjHhpeftaHt5qOlwlxLIzUycsWe+3Q9+AkO35i9oZwd
         fE+W6iTN4mdvTAf+tnlTcQIsuGQkccaZa23JEpnYsJY6oA0sigtKPM14wPkPHEYJ4DnE
         iBqw==
X-Gm-Message-State: AOAM531LUKMyebVJqe8kq+IaLPkkLK9OTiXhmcVEMa31c7Ksc/p7W1EQ
        BeEBLaW7/arfGMqvGevK1dc=
X-Google-Smtp-Source: ABdhPJxtDYjy2yKD3KajngrcwcITQKBvXMLuR/Wq2cSTmntAqXf0XFJnSW867yJv8Ph8Ynym7vqE3g==
X-Received: by 2002:a1c:9a97:: with SMTP id c145mr11214324wme.42.1627505053167;
        Wed, 28 Jul 2021 13:44:13 -0700 (PDT)
Received: from [10.8.0.150] ([195.53.121.100])
        by smtp.gmail.com with ESMTPSA id d16sm898060wrx.76.2021.07.28.13.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 13:44:12 -0700 (PDT)
Subject: Re: [PATCH] man2: new page describing memfd_secret() system call
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Mike Rapoport <rppt@linux.ibm.com>, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org, linux-mm@kvack.org,
        Michael Kerrisk <mtk.manpages@gmail.com>
References: <20210727124140.1487079-1-rppt@kernel.org>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <0baf11d7-2958-ee45-64cf-fc93dc0d69b1@gmail.com>
Date:   Wed, 28 Jul 2021 22:44:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210727124140.1487079-1-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Mike,

On 7/27/21 2:41 PM, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
> 
> Hi,
> 
> There were a lot of changes to memfd_secret implementation since the
> previous posting of this man page, so its contents also changed
> significantly and there is not much sense to call it v2.

Please see some minor comments below.
Other than that, the page looks good to me.

Thanks,

Alex

> 
>   man2/memfd_secret.2 | 143 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 143 insertions(+)
>   create mode 100644 man2/memfd_secret.2
> 
> diff --git a/man2/memfd_secret.2 b/man2/memfd_secret.2
> new file mode 100644
> index 000000000..e6eee7018
> --- /dev/null
> +++ b/man2/memfd_secret.2
> @@ -0,0 +1,143 @@
> +.\" Copyright (c) 2021, IBM Corporation.
> +.\" Written by Mike Rapoport <rppt@linux.ibm.com>
> +.\"
> +.\" Based on memfd_create(2) man page
> +.\" Copyright (C) 2014 Michael Kerrisk <mtk.manpages@gmail.com>
> +.\" and Copyright (C) 2014 David Herrmann <dh.herrmann@gmail.com>
> +.\"
> +.\" %%%LICENSE_START(GPLv2+)
> +.\"
> +.\" This program is free software; you can redistribute it and/or modify
> +.\" it under the terms of the GNU General Public License as published by
> +.\" the Free Software Foundation; either version 2 of the License, or
> +.\" (at your option) any later version.
> +.\"
> +.\" This program is distributed in the hope that it will be useful,
> +.\" but WITHOUT ANY WARRANTY; without even the implied warranty of
> +.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> +.\" GNU General Public License for more details.
> +.\"
> +.\" You should have received a copy of the GNU General Public
> +.\" License along with this manual; if not, see
> +.\" <http://www.gnu.org/licenses/>.
> +.\" %%%LICENSE_END
> +.\"
> +.TH MEMFD_SECRET 2 2020-08-02 Linux "Linux Programmer's Manual"
> +.SH NAME
> +memfd_secret \- create an anonymous file to access secret memory regions
> +.SH SYNOPSIS
> +.nf
> +.BI "int memfd_secret(unsigned int " flags ");"
> +.fi
> +.PP
> +.IR Note :
> +There is no glibc wrapper for this system call; see NOTES.

Please see the new syntax we're using for syscalls without a wrapper. 
You can check for example membarrier(2):
<https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/man2/membarrier.2>

Also please make sure you provide a complete include list for normal 
usage of the syscall (that is, includes providing syscall(2), 
SYS_memfd_secret, and any other constants used by the syscall).

> +.SH DESCRIPTION
> +.BR memfd_secret ()
> +creates an anonymous file and returns a file descriptor that refers to it.
> +The file provides a way to create and access memory regions
> +with stronger protection than usual RAM-based files and
> +anonymous memory mappings.
> +Once all references to the file are dropped, it is automatically released.
> +The initial size of the file is set to 0.
> +Following the call, the file size should be set using
> +.BR ftruncate (2).
> +.PP
> +The memory areas backing the file created with
> +.BR memfd_create(2)
> +are visible only to the contexts that have access to the file descriptor.
> +These areas are removed from the kernel page tables
> +and only the page tables of the processes holding the file descriptor
> +map the corresponding physical memory.
> +.PP
> +The following values may be bitwise ORed in
> +.IR flags

s/.IR/.I/

> +to control the behavior of
> +.BR memfd_secret (2):
> +.TP
> +.BR FD_CLOEXEC

s/.BR/.B/

> +Set the close-on-exec flag on the new file descriptor.
> +See the description of the
> +.B O_CLOEXEC
> +flag in
> +.BR open (2)
> +for reasons why this may be useful.
> +.PP
> +As its return value,
> +.BR memfd_secret ()
> +returns a new file descriptor that can be used to refer to an anonymous file.
> +This file descriptor is opened for both reading and writing
> +.RB ( O_RDWR )
> +and
> +.B O_LARGEFILE
> +is set for the file descriptor.
> +.PP
> +With respect to
> +.BR fork (2)
> +and
> +.BR execve (2),
> +the usual semantics apply for the file descriptor created by
> +.BR memfd_secret ().
> +A copy of the file descriptor is inherited by the child produced by
> +.BR fork (2)
> +and refers to the same file.
> +The file descriptor is preserved across
> +.BR execve (2),
> +unless the close-on-exec flag has been set.
> +.PP
> +The memory regions backed with
> +.BR memfd_secret ()
> +are locked in the same way as
> +.BR mlock (2),
> +however the implementation will not try to
> +populate the whole range during the
> +.BR mmap (2)
> +call.
> +The amount of memory allowed for memory mappings
> +of the file descriptor obeys the same rules as
> +.BR mlock (2)
> +and cannot exceed
> +.BR RLIMIT_MEMLOCK .
> +.SH RETURN VALUE
> +On success,
> +.BR memfd_secret ()
> +returns a new file descriptor.
> +On error, \-1 is returned and
> +.I errno
> +is set to indicate the error.
> +.SH ERRORS
> +.TP
> +.B EINVAL
> +.I flags
> +included unknown bits.
> +.TP
> +.B EMFILE
> +The per-process limit on the number of open file descriptors has been reached.
> +.TP
> +.B EMFILE
> +The system-wide limit on the total number of open files has been reached.
> +.TP
> +.B ENOMEM
> +There was insufficient memory to create a new anonymous file.
> +.TP
> +.B ENOSYS
> +.BR memfd_secret ()
> +is not implemented on this architecture.
> +.SH VERSIONS
> +The
> +.BR memfd_secret (2)
> +system call first appeared in Linux 5.14.
> +.SH CONFORMING TO
> +The
> +.BR memfd_secret (2)
> +system call is Linux-specific.
> +.SH NOTES
> +.PP
> +Glibc does not provide a wrapper for this system call; call it using
> +.BR syscall (2).

We removed these notes when we changed the syntax in the synopsis.
See commit 39df5bd6bc66eccd25fdfac4e9c3381219c6686f (man-pages) as an 
example.

> +.SH SEE ALSO
> +.BR fcntl (2),
> +.BR ftruncate (2),
> +.BR mlock (2),
> +.BR mmap (2),
> +.BR setrlimit (2)
> 


-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
