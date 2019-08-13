Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44B038C130
	for <lists+linux-api@lfdr.de>; Tue, 13 Aug 2019 21:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfHMTBO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 13 Aug 2019 15:01:14 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37868 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfHMTBO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 13 Aug 2019 15:01:14 -0400
Received: by mail-lf1-f65.google.com with SMTP id c9so77459142lfh.4;
        Tue, 13 Aug 2019 12:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CVOpJHPgn7fZLLPO6uI/O9bniRMMsZiS2eSUDvyGjF0=;
        b=eibhSIM31XxD1E5+yfK7lMRwVGPXGrHLnIavFPZIBjAEVsmaFTEkBTMADv4aVVBktD
         3gcyndT2yyBm0sFkEGy5uA7fxGjzovlzC8FytdDQXGZpe3UpzL7JtWsRsWj+jjp+qfUG
         UIcP6A+++IdrjPKJNdl4oqF43jxS9cP02UuqssxWUCAjr49d3PBQb5jXaPhwUnr8xVAw
         cmnHU6Tg9jK3whmmj0CLfg5dDJ6j0ZuuI/DGDjyE9Ub3SWsd1vorDTR9/xbeoAD+uRLk
         PUhTky48a/YpBjrZapUFOLR0cFrOU8JRLByKfko3tQ7xMqtbZyRczv0i6NMuVkMRmuQl
         vVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CVOpJHPgn7fZLLPO6uI/O9bniRMMsZiS2eSUDvyGjF0=;
        b=pUrldh05i4yKBjgU8AuLD6QUqrNyc7rIjEW5VilQhVEtiPFaRCnseHcqKBq4m7v9oG
         Zd+CikbthmQe1XcvRbBEKHRqssVHx+Stcx2G5L10UqpOpdMV5wKGLVXZWWryw2wc7/vc
         jc0a63Gy0v34hP0thHgPb2/fUSnWlJYthN/jeF3Izjq8qt622dejSRTZXQAeyW9joiwp
         66rBFnPK/ZFP+e4DJQboEz+FNOdxJoIEcOZFicbCjkont66OEv13/ufnPsvBQrh3dekU
         x3hJqUX8SHIXIy8CTssAFP6JwQLt9pfy1H2i/PE4n2+9VNCWQDieGRGP6AN+KAZz1pe6
         mYsQ==
X-Gm-Message-State: APjAAAWskKRzpPaZocRtAwp5st1s70SDR7oDjev/l4kta7BpeOJ49wh9
        twtF+MtzUYBTpe3KnnbYaU//SesPpSxx+q7AgTvxKfQEy+w=
X-Google-Smtp-Source: APXvYqy9ihD5YjQrktNuqJy73tR2xfmj1QsrkBqJo4sFuDo3kxK1ohAg5317GHr6OAVsc0nYjcyjRPrAkDZDzmVswBA=
X-Received: by 2002:a19:7006:: with SMTP id h6mr23374733lfc.5.1565722872640;
 Tue, 13 Aug 2019 12:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190810010758.16407-1-alistair.francis@wdc.com> <CAK8P3a2wYMsBRm1X-TFo1d7-B7Xug9gwqF77HitoE7wmOqD7rw@mail.gmail.com>
In-Reply-To: <CAK8P3a2wYMsBRm1X-TFo1d7-B7Xug9gwqF77HitoE7wmOqD7rw@mail.gmail.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Tue, 13 Aug 2019 11:57:20 -0700
Message-ID: <CAKmqyKNH7G=_gs2Hfc3OZMFaHzUwU8fSomfu_r92hJrnJHJT3A@mail.gmail.com>
Subject: Re: [PATCH] syscalls: Update the syscall #defines to match uapi
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alistair Francis <alistair.francis@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Aug 12, 2019 at 2:49 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Aug 10, 2019 at 3:11 AM Alistair Francis
> <alistair.francis@wdc.com> wrote:
> >
> > Update the #defines around sys_fstat64() and sys_fstatat64() to match
> > the #defines around the __NR3264_fstatat and __NR3264_fstat definitions
> > in include/uapi/asm-generic/unistd.h. This avoids compiler failures if
> > one is defined.
>
> What is the compiler failure you get?

I don't have it infornt of me but it was along the lines of
sys_fstat64/sys_fstatat64 not being defined when __ARCH_WANT_NEW_STAT
is defined but __ARCH_WANT_STAT64 isn't.

>
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  include/linux/syscalls.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> > index 2bcef4c70183..e4bf5e480d60 100644
> > --- a/include/linux/syscalls.h
> > +++ b/include/linux/syscalls.h
> > @@ -512,7 +512,7 @@ asmlinkage long sys_readlinkat(int dfd, const char __user *path, char __user *bu
> >  asmlinkage long sys_newfstatat(int dfd, const char __user *filename,
> >                                struct stat __user *statbuf, int flag);
> >  asmlinkage long sys_newfstat(unsigned int fd, struct stat __user *statbuf);
> > -#if defined(__ARCH_WANT_STAT64) || defined(__ARCH_WANT_COMPAT_STAT64)
> > +#if defined(__ARCH_WANT_NEW_STAT) || defined(__ARCH_WANT_STAT64)
> >  asmlinkage long sys_fstat64(unsigned long fd, struct stat64 __user *statbuf);
> >  asmlinkage long sys_fstatat64(int dfd, const char __user *filename,
> >                                struct stat64 __user *statbuf, int flag);
>
> I think this is wrong: when __ARCH_WANT_NEW_STAT is set, we are
> on a 64-bit architecture and only want the sys_newfstat{,at} system
> calls, not sys_fstat{,at}64 that gets used on 32-bit machines.

Ah, that would make sense then. I don't think you will see the error then.

Alistair

>
> The #if check in the syscalls.h file also matches the definition of
> the function.
>
>        Arnd
