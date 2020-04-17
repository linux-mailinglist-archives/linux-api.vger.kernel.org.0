Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0422C1ADC51
	for <lists+linux-api@lfdr.de>; Fri, 17 Apr 2020 13:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbgDQLjz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 17 Apr 2020 07:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730267AbgDQLjy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 17 Apr 2020 07:39:54 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F71C061A0C;
        Fri, 17 Apr 2020 04:39:54 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id d16so1228109edq.7;
        Fri, 17 Apr 2020 04:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=5hTJSKfRbKsRe/E+iFRO++tT2JBgJd6o61Jbgclxcm8=;
        b=ksSKJ9cmX2optSlDV3ljbVvjfO/sw/dRKGmf7RUDPJ4xA6iB3+XOoSzA7Hwgqclxnv
         k8gwEayH3BEf+Es4hZ3M4icUM/RJOIZy+QjTqoPeIhhdykKG7i7L8g7A3VHppHmRnlx0
         L2BrPn3iTxLf6bS8jJCDD+VGr9wJjU2OpUjvloIJY3J51VbM+Szi43hoFdcrkD6i85sb
         qebvjTlmQ+Pu/gd4W3Q/A9YKWQGRQUVVeiPAmcnJa8Q1GkOsI4Neo7TJ4OSlgN9IbszK
         kufCg6yqqpyWnShCT6jIgXagcS4eK9DO2J8QLtLGeIe48hP96g5oLaF9NECFfct/LSgi
         3eMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=5hTJSKfRbKsRe/E+iFRO++tT2JBgJd6o61Jbgclxcm8=;
        b=HLCJ5smHExwRUcUrAiwrwDuH+fdmz5REU8AOnCVTuRFqWTYMZBqVczmdl5Wxx3L4My
         RvKcNJZyRt9OL/L+IV34mr9bywhPZU5hrc5RfM9X6A5DKcfDVRI1oEvbSy5YBkl0hdGt
         hx5k0bNxz/nlyksbrEgqAv7cPW8ZkF/KZ98l7YCjA8Im70eHL9VmGMEMvcawbKUyAwx2
         oXSKIzX9+TI2zcI03cOygco8OWmyWSLJ1OwmPQppY1+O0/kOtrrULqAcxIYr7IC75gVh
         2O/o9IwaF+JRgxu8+13kLmeAAsIrYtGZR2IgGCGuiEyJBPZUqYPbLVufBZz3H9d4SpSh
         zwVw==
X-Gm-Message-State: AGi0PuZpfV3g8mvz2qokMF1W4+J8qchc5HsYRaXHnx19v/sZ44gnSO6H
        BEiqy8ZEB885O4d5PEkQssUO+YZMsI4pElNjlu7TTA==
X-Google-Smtp-Source: APiQypICqozsQTHXwxl/21aHLETknfQ6VcXGhd6dZ7BrrUDeGWSG/StWgevBoqi0zdOgpC+5mk2HF9lkBD3zK/hxd34=
X-Received: by 2002:a05:6402:7d6:: with SMTP id u22mr2448651edy.149.1587123593068;
 Fri, 17 Apr 2020 04:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <20191003145542.17490-1-cyphar@cyphar.com> <20191003145542.17490-2-cyphar@cyphar.com>
In-Reply-To: <20191003145542.17490-2-cyphar@cyphar.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Fri, 17 Apr 2020 13:39:40 +0200
Message-ID: <CAKgNAkiqU0TtmoZ8A89FT4zSYS7AcvWX6oc=1-45L95XbSkUog@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] symlink.7: document magic-links more completely
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Aleksa,

Re our discussion of documentation to be added for magic symlinks,
there was the patch below, which got paused. I guess this just needs a
light refresh?

Thanks,

Michael

On Thu, 3 Oct 2019 at 16:56, Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> Traditionally, magic-links have not been a well-understood topic in
> Linux. Given the new changes in their semantics (related to the link
> mode of trailing magic-links), it seems like a good opportunity to shine
> more light on magic-links and their semantics.
>
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>  man7/path_resolution.7 | 15 +++++++++++++++
>  man7/symlink.7         | 39 ++++++++++++++++++++++++++++++---------
>  2 files changed, 45 insertions(+), 9 deletions(-)
>
> diff --git a/man7/path_resolution.7 b/man7/path_resolution.7
> index 07664ed8faec..46f25ec4cdfa 100644
> --- a/man7/path_resolution.7
> +++ b/man7/path_resolution.7
> @@ -136,6 +136,21 @@ we are just creating it.
>  The details on the treatment
>  of the final entry are described in the manual pages of the specific
>  system calls.
> +.PP
> +Since Linux 5.FOO, if the final entry is a "magic-link" (see
> +.BR symlink (7)),
> +and the user is attempting to
> +.BR open (2)
> +it, then there is an additional permission-related restriction applied to the
> +operation: the requested access mode must not exceed the "link mode" of the
> +magic-link (unlike ordinary symlinks, magic-links have their own file mode.)
> +For example, if
> +.I /proc/[pid]/fd/[num]
> +has a link mode of
> +.BR 0500 ,
> +unprivileged users are not permitted to
> +.BR open ()
> +the magic-link for writing.
>  .SS . and ..
>  By convention, every directory has the entries "." and "..",
>  which refer to the directory itself and to its parent directory,
> diff --git a/man7/symlink.7 b/man7/symlink.7
> index 9f5bddd5dc21..33f0ec703acd 100644
> --- a/man7/symlink.7
> +++ b/man7/symlink.7
> @@ -84,6 +84,25 @@ as they are implemented on Linux and other systems,
>  are outlined here.
>  It is important that site-local applications also conform to these rules,
>  so that the user interface can be as consistent as possible.
> +.SS Magic-links
> +There is a special class of symlink-like objects known as "magic-links" which
> +can be found in certain pseudo-filesystems such as
> +.BR proc (5)
> +(examples include
> +.IR /proc/[pid]/exe " and " /proc/[pid]/fd/* .)
> +Unlike normal symlinks, magic-links are not resolved through
> +pathname-expansion, but instead act as direct references to the kernel's own
> +representation of a file handle. As such, these magic-links allow users to
> +access files which cannot be referenced with normal paths (such as unlinked
> +files still referenced by a running program.)
> +.PP
> +Because they can bypass ordinary
> +.BR mount_namespaces (7)-based
> +restrictions, magic-links have been used as attack vectors in various exploits.
> +As such (since Linux 5.FOO), there are additional restrictions placed on the
> +re-opening of magic-links (see
> +.BR path_resolution (7)
> +for more details.)
>  .SS Symbolic link ownership, permissions, and timestamps
>  The owner and group of an existing symbolic link can be changed
>  using
> @@ -99,16 +118,18 @@ of a symbolic link can be changed using
>  or
>  .BR lutimes (3).
>  .PP
> -On Linux, the permissions of a symbolic link are not used
> -in any operations; the permissions are always
> -0777 (read, write, and execute for all user categories),
>  .\" Linux does not currently implement an lchmod(2).
> -and can't be changed.
> -(Note that there are some "magic" symbolic links in the
> -.I /proc
> -directory tree\(emfor example, the
> -.IR /proc/[pid]/fd/*
> -files\(emthat have different permissions.)
> +On Linux, the permissions of an ordinary symbolic link are not used in any
> +operations; the permissions are always 0777 (read, write, and execute for all
> +user categories), and can't be changed.
> +.PP
> +However, magic-links do not follow this rule. They can have a non-0777 mode,
> +which is used for permission checks when the final
> +component of an
> +.BR open (2)'s
> +path is a magic-link (see
> +.BR path_resolution (7).)
> +
>  .\"
>  .\" The
>  .\" 4.4BSD
> --
> 2.23.0
>


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
