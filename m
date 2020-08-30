Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C790256EF1
	for <lists+linux-api@lfdr.de>; Sun, 30 Aug 2020 17:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgH3PG3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 30 Aug 2020 11:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbgH3PGO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 30 Aug 2020 11:06:14 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0408C061236
        for <linux-api@vger.kernel.org>; Sun, 30 Aug 2020 08:06:13 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c8so2121356lfh.9
        for <linux-api@vger.kernel.org>; Sun, 30 Aug 2020 08:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hqQ8AtdFMS0ym9cnkvwXQx8xXEYehPD89tUpAkFBrhM=;
        b=iAF3hF5DV7MaK2Vla97BRmuHRZzXPlTAov2WZVMKuCL2tZHZSZq9cBt6yr7oxyLToo
         bQX3kLIRIJcinshXJHPYhojYeiVW8PqiLGRjzFiABARktiwDXnkw9qSJwFvgBpan7aOO
         +GGOL6mWb0nYteHzB3v2V+OgB4f3L8uNAufxdX/JR3Kz27nIbG1VecMHe/xWyX7b8gaq
         GYb3EtJ6rFUJGlXxOhwHtAIYfwbwavqkVinNZCaWcSiToyIkGOtuOEVjW5KFmHXXrw53
         QZ/5CZpE8dIQklst1vAjbM6W1FB066Y+jUqt2sEQSWUCIGAPIqLtocblf20KmxWuQN2C
         nLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hqQ8AtdFMS0ym9cnkvwXQx8xXEYehPD89tUpAkFBrhM=;
        b=XGEpaGSOMtcV3Y7t39LvwX1IyAgDfnEDWhXHuBxNGja+sa+UcTPddVuELQwu+pY5xL
         qLVLe68qABtp3yW7TgRIrO/i9zyzPokMzmVx6QfbU5wak1vb/x8B0jvDpXyanGhKNT74
         VVCVDe35jW1uMpicepv1N5zpHDMn5X4sDB/5XBJAUUhZeEgPiw2tnAXeKnRuJz0dA+Rd
         I5t6qVrKXNVg5IMm4JSPEq9osUB1A81hTDbq7KiyKgJo8XyBmkp9LQE814udc61l+ssl
         DPq5oQXiNtYyLJBAEP/KPcvlQm7HwtdwORMYEnmfdXCHbq4HN8+YaaaBuEIddF7W21yk
         t9lQ==
X-Gm-Message-State: AOAM532zUPGyRgPHlJ0+u9fLTeca3Mfd1tsok/RhM4tljCvxYjrOEddP
        ZXYhGx7xU+mS/xWBhzQZzYpZhiULa/sobUuoMhP8TA==
X-Google-Smtp-Source: ABdhPJwVwLYPWD7KtU6ZDFzNcrcxstYiGCbmWW1akQet2KsblsR9CgOdMt9+7OuFdIfhjiuts7wSnKpIadr7RNhcKQk=
X-Received: by 2002:a19:2286:: with SMTP id i128mr3570361lfi.45.1598799971846;
 Sun, 30 Aug 2020 08:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200829020002.GC3265@brightrain.aerifal.cx>
In-Reply-To: <20200829020002.GC3265@brightrain.aerifal.cx>
From:   Jann Horn <jannh@google.com>
Date:   Sun, 30 Aug 2020 17:05:45 +0200
Message-ID: <CAG48ez1BExw7DdCEeRD1hG5ZpRObpGDodnizW2xD5tC0saTDqg@mail.gmail.com>
Subject: Re: [RESEND PATCH] vfs: add RWF_NOAPPEND flag for pwritev2
To:     Rich Felker <dalias@libc.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Aug 29, 2020 at 4:00 AM Rich Felker <dalias@libc.org> wrote:
> The pwrite function, originally defined by POSIX (thus the "p"), is
> defined to ignore O_APPEND and write at the offset passed as its
> argument. However, historically Linux honored O_APPEND if set and
> ignored the offset. This cannot be changed due to stability policy,
> but is documented in the man page as a bug.
>
> Now that there's a pwritev2 syscall providing a superset of the pwrite
> functionality that has a flags argument, the conforming behavior can
> be offered to userspace via a new flag.
[...]
> diff --git a/include/linux/fs.h b/include/linux/fs.h
[...]
> @@ -3411,6 +3413,8 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
>                 ki->ki_flags |= (IOCB_DSYNC | IOCB_SYNC);
>         if (flags & RWF_APPEND)
>                 ki->ki_flags |= IOCB_APPEND;
> +       if (flags & RWF_NOAPPEND)
> +               ki->ki_flags &= ~IOCB_APPEND;
>         return 0;
>  }

Linux enforces the S_APPEND flag (set by "chattr +a") only at open()
time, not at write() time:

# touch testfile
# exec 100>testfile
# echo foo > testfile
# cat testfile
foo
# chattr +a testfile
# echo bar > testfile
bash: testfile: Operation not permitted
# echo bar >&100
# cat testfile
bar
#

At open() time, the kernel enforces that you can't use O_WRONLY/O_RDWR
without also setting O_APPEND if the file is marked as append-only:

static int may_open(const struct path *path, int acc_mode, int flag)
{
[...]
  /*
   * An append-only file must be opened in append mode for writing.
   */
  if (IS_APPEND(inode)) {
    if  ((flag & O_ACCMODE) != O_RDONLY && !(flag & O_APPEND))
      return -EPERM;
    if (flag & O_TRUNC)
      return -EPERM;
  }
[...]
}

It seems to me like your patch will permit bypassing S_APPEND by
opening an append-only file with O_WRONLY|O_APPEND, then calling
pwritev2() with RWF_NOAPPEND? I think you'll have to add an extra
check for IS_APPEND() somewhere.


One could also argue that if an O_APPEND file descriptor is handed
across privilege boundaries, a programmer might reasonably expect that
the recipient will not be able to use the file descriptor for
non-append writes; if that is not actually true, that should probably
be noted in the open.2 manpage, at the end of the description of
O_APPEND.
