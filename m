Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75A98D08FF
	for <lists+linux-api@lfdr.de>; Wed,  9 Oct 2019 10:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfJIIBK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 9 Oct 2019 04:01:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46766 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfJIIBJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 9 Oct 2019 04:01:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id o18so1515750wrv.13;
        Wed, 09 Oct 2019 01:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2DTwESPW6g8Sb3sli7ex/7+wAywGokSECc13e5k3bwI=;
        b=Ocr81+FXBcc4X4vkaVve0Cz16SMH54/ksm5B0DqGEBY1ElLUIk7HPx3S1I+QH7HGti
         F7OG+RDQoNxUBBNpS9bqzFl+FkUngaNQzdaQRupmYf76C4+MxtF8gnvIjv5Ma6MtuFqU
         QkczgJVW4QPLuyFPVUfyl04NuXCdEWIO0fLSdaOYdSTpdj4oNkbx2GtKoTgG6ttX7d1M
         ec9CW/sYOaq1zg6mB35vxDRqbxODBaXmjMgq8Av312vfxhuFEE6EdgEqeUzhe99EHWdB
         E9MEJVfGnuQ1p22GMVojurjFQyJyyy9myj6XjJhc3uImCpVJZO2tMRi8v5+MzN7OkWge
         Vwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2DTwESPW6g8Sb3sli7ex/7+wAywGokSECc13e5k3bwI=;
        b=AYKNNazQBlR5GOlEVihmsC4FrUnp574N1vaDiO/iQSmsFUcaPA4uds6U1MbTgry6Vm
         n01it9SbjEt4OWvH+nDc5ybnzL/0KImspUXUsovXfq5mYVFT/A1xV5tAQuUoBZSRsrNK
         +M8EJEt5JnSgYypNVHYw4RM+gpMvY6l2JM9HCxpstSErJpWmY0Z7y/cO7+6B0M5nBKUq
         3IvwElWvwah0KbpcYDlhO/zOvjYeh+fy9jEDoySUO0i5yTBzzvPJJL3/UO/Xn086qWOG
         LBUJUNp23ZEeqG/8K7x+VQIsLm5EwdJ1aqzpbKBCnaDwmt6SIB+ISIK++thJqL6I75dN
         l1dg==
X-Gm-Message-State: APjAAAWgQ3vykgzMC8Mo5kB+iP0ZLML/Kajh+cf9xN1ssZ39+Fn35zdz
        cFCBfx1lP4DxICzZBu7aB1IdXUhO
X-Google-Smtp-Source: APXvYqzOLPPSDu25xkKCUAlxH+SBDgn7aC1u1Mb3sU7asfYrydDF48a/xu1pIFRSqQFUYdsNKFOf+A==
X-Received: by 2002:adf:db47:: with SMTP id f7mr1817888wrj.348.1570608065912;
        Wed, 09 Oct 2019 01:01:05 -0700 (PDT)
Received: from [10.0.20.253] ([95.157.63.22])
        by smtp.gmail.com with ESMTPSA id l18sm1286973wrc.18.2019.10.09.01.01.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 01:01:05 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/3] open.2: add O_EMPTYPATH documentation
To:     Aleksa Sarai <cyphar@cyphar.com>, Al Viro <viro@zeniv.linux.org.uk>
References: <20191003145542.17490-1-cyphar@cyphar.com>
 <20191003145542.17490-3-cyphar@cyphar.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <c4485b10-692d-ed24-a1d9-a047bb1054bf@gmail.com>
Date:   Wed, 9 Oct 2019 10:01:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191003145542.17490-3-cyphar@cyphar.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Aleksa,

You write "5.FOO" in these patches. When do you expect these changes to 
land in the kernel?

On 10/3/19 4:55 PM, Aleksa Sarai wrote:
> Some of the wording around empty paths in path_resolution(7) also needed
> to be reworked since it's now legal (if you pass O_EMPTYPATH).
> 
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>  man2/open.2            | 42 +++++++++++++++++++++++++++++++++++++++++-
>  man7/path_resolution.7 | 17 ++++++++++++++++-
>  2 files changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/man2/open.2 b/man2/open.2
> index b0f485b41589..7217fe056e5e 100644
> --- a/man2/open.2
> +++ b/man2/open.2
> @@ -48,7 +48,7 @@
>  .\" FIXME . Apr 08: The next POSIX revision has O_EXEC, O_SEARCH, and
>  .\" O_TTYINIT.  Eventually these may need to be documented.  --mtk
>  .\"
> -.TH OPEN 2 2018-04-30 "Linux" "Linux Programmer's Manual"
> +.TH OPEN 2 2019-10-03 "Linux" "Linux Programmer's Manual"

No need to update the timestamp. I have scripts that handle this
automatically.

>  .SH NAME
>  open, openat, creat \- open and possibly create a file
>  .SH SYNOPSIS
> @@ -421,6 +421,21 @@ was followed by a call to
>  .BR fdatasync (2)).
>  .IR "See NOTES below" .
>  .TP
> +.BR O_EMPTYPATH " (since Linux 5.FOO)"
> +If \fIpathname\fP is an empty string, re-open the the file descriptor given as

In general, I prefer the general form

.I pathname

over \fIpathname\fP. 

If you would be willing to cahnge that, it would  save me a little work.
(And likewise throughout the rest of the patch.)

> +the \fIdirfd\fP argument to
> +.BR openat (2).
> +This can be used with both ordinary (file and directory) and \fBO_PATH\fP file
> +descriptors, but cannot be used with
> +.BR AT_FDCWD
> +(or as an argument to plain
> +.BR open (2).) When re-opening an \fBO_PATH\fP file descriptor, the same "link

There's a formatting problem here which can be fixed by inserting a 
newline before "When".

> +mode" restrictions apply as with re-opening through
> +.BR proc (5)
> +(see
> +.BR path_resolution "(7) and " symlink (7)
> +for more details.)
> +.TP
>  .B O_EXCL
>  Ensure that this call creates the file:
>  if this flag is specified in conjunction with
> @@ -668,6 +683,13 @@ with
>  (or via procfs using
>  .BR AT_SYMLINK_FOLLOW )
>  even if the file is not a directory.
> +You can even "re-open" (or upgrade) an
> +.BR O_PATH
> +file descriptor by using
> +.BR O_EMPTYPATH
> +(see the section for
> +.BR O_EMPTYPATH
> +for more details.)
>  .IP *
>  Passing the file descriptor to another process via a UNIX domain socket
>  (see
> @@ -958,6 +980,15 @@ is not allowed.
>  (See also
>  .BR path_resolution (7).)
>  .TP
> +.B EBADF
> +.I pathname
> +was an empty string (and
> +.B O_EMPTYPATH
> +was passed) with
> +.BR open (2)
> +(instead of
> +.BR openat (2).)
> +.TP
>  .B EDQUOT
>  Where
>  .B O_CREAT
> @@ -1203,6 +1234,15 @@ The following additional errors can occur for
>  .I dirfd
>  is not a valid file descriptor.
>  .TP
> +.B EBADF
> +.I pathname
> +was an empty string (and
> +.B O_EMPTYPATH
> +was passed), but the provided
> +.I dirfd
> +was an invalid file descriptor (or was
> +.BR AT_FDCWD .)
> +.TP
>  .B ENOTDIR
>  .I pathname
>  is a relative pathname and
> diff --git a/man7/path_resolution.7 b/man7/path_resolution.7
> index 46f25ec4cdfa..85dd354e9a93 100644
> --- a/man7/path_resolution.7
> +++ b/man7/path_resolution.7
> @@ -22,7 +22,7 @@
>  .\" the source, must acknowledge the copyright and authors of this work.
>  .\" %%%LICENSE_END
>  .\"
> -.TH PATH_RESOLUTION 7 2017-11-26 "Linux" "Linux Programmer's Manual"
> +.TH PATH_RESOLUTION 7 2019-10-03 "Linux" "Linux Programmer's Manual"
>  .SH NAME
>  path_resolution \- how a pathname is resolved to a file
>  .SH DESCRIPTION
> @@ -198,6 +198,21 @@ successfully.
>  Linux returns
>  .B ENOENT
>  in this case.
> +.PP
> +As of Linux 5.FOO, an empty path argument can be used to indicate the "re-open"
> +an existing file descriptor if
> +.B O_EMPTYPATH
> +is passed as a flag argument to
> +.BR openat (2),
> +with the
> +.I dfd
> +argument indicating which file descriptor to "re-open". This is approximately
> +equivalent to opening
> +.I /proc/self/fd/$fd

.IR /proc/self/fd/$fd ,

> +where
> +.I $fd
> +is the open file descriptor to be "re-opened".
> +

No blank line here.

>  .SS Permissions
>  The permission bits of a file consist of three groups of three bits; see
>  .BR chmod (1)
> 

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
