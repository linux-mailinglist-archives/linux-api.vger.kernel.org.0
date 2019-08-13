Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 017CF8C1A0
	for <lists+linux-api@lfdr.de>; Tue, 13 Aug 2019 21:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfHMTle (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 13 Aug 2019 15:41:34 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38944 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfHMTle (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 13 Aug 2019 15:41:34 -0400
Received: by mail-qk1-f196.google.com with SMTP id 125so7613244qkl.6;
        Tue, 13 Aug 2019 12:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MCvgFN5GXnda2r43SDXMWKSjfSyNoGtkYFt/JRtKgrU=;
        b=i4HT8YeOngNKCfhfVwlHiFADe+2dFSI1RzR2HBqrv86R/8YCik9iIDdCbzf2uJ1ZWI
         fg2KMOUUO0KZ4f4yTFGFQ3xMmYUkvdSO4ou9Psc9UZu22Lys3tNWvv4EVIFX73Sj2dG7
         rPszXlbhXu11+Xw7OnWu/tvupVT9ow5yan4Furx1idZqcNNnXWY4rIDdQ4IL8O0dhDR8
         HHzA0W/79UQW+hBu1bUUPVkHET1/U5MjEn2rHcaEL+Th5419hDF2l6ApUl9r3yOz3WU2
         8obrev341QVJ80cSbcni7e0WisAXSS6TAjdfLDvMAXRMTLzZf9Hn6gwJWxsy+ytIBXkO
         7e9Q==
X-Gm-Message-State: APjAAAVE1EVL2kxQa60Iy4gGuLsiyde78I3F7VM691qP+qhUvFjBLreS
        ilwLsqRn8IP0N4AhJ/e+VhlpJPHyzfLBYDNb7O2soZmb
X-Google-Smtp-Source: APXvYqwCYEm8WDqUZ9AXa597kLLirzp9B1fRYVLZztN7ofbKzh/wg2jhEWnoRHxLGsp8iip61vuq36gmEXTnqu6XLiw=
X-Received: by 2002:a05:620a:b:: with SMTP id j11mr35177645qki.352.1565725293275;
 Tue, 13 Aug 2019 12:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190810010758.16407-1-alistair.francis@wdc.com>
 <CAK8P3a2wYMsBRm1X-TFo1d7-B7Xug9gwqF77HitoE7wmOqD7rw@mail.gmail.com> <CAKmqyKNH7G=_gs2Hfc3OZMFaHzUwU8fSomfu_r92hJrnJHJT3A@mail.gmail.com>
In-Reply-To: <CAKmqyKNH7G=_gs2Hfc3OZMFaHzUwU8fSomfu_r92hJrnJHJT3A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 13 Aug 2019 21:41:17 +0200
Message-ID: <CAK8P3a0phB6hb=Da6V=CWWmi_oYwUcpSRi6CZTqAPz7QXKFJTA@mail.gmail.com>
Subject: Re: [PATCH] syscalls: Update the syscall #defines to match uapi
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Alistair Francis <alistair.francis@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Aug 13, 2019 at 9:01 PM Alistair Francis <alistair23@gmail.com> wrote:
> On Mon, Aug 12, 2019 at 2:49 AM Arnd Bergmann <arnd@arndb.de> wrote:

> > > diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> > > index 2bcef4c70183..e4bf5e480d60 100644
> > > --- a/include/linux/syscalls.h
> > > +++ b/include/linux/syscalls.h
> > > @@ -512,7 +512,7 @@ asmlinkage long sys_readlinkat(int dfd, const char __user *path, char __user *bu
> > >  asmlinkage long sys_newfstatat(int dfd, const char __user *filename,
> > >                                struct stat __user *statbuf, int flag);
> > >  asmlinkage long sys_newfstat(unsigned int fd, struct stat __user *statbuf);
> > > -#if defined(__ARCH_WANT_STAT64) || defined(__ARCH_WANT_COMPAT_STAT64)
> > > +#if defined(__ARCH_WANT_NEW_STAT) || defined(__ARCH_WANT_STAT64)
> > >  asmlinkage long sys_fstat64(unsigned long fd, struct stat64 __user *statbuf);
> > >  asmlinkage long sys_fstatat64(int dfd, const char __user *filename,
> > >                                struct stat64 __user *statbuf, int flag);
> >
> > I think this is wrong: when __ARCH_WANT_NEW_STAT is set, we are
> > on a 64-bit architecture and only want the sys_newfstat{,at} system
> > calls, not sys_fstat{,at}64 that gets used on 32-bit machines.
>
> Ah, that would make sense then. I don't think you will see the error then.

So we don't need this patch to build riscv32 kernels, right? It's possible
that it was the result of an incorrect forward port of some other patch,
as older riscv32 kernels did provide stat64(), but newer ones only have
statx().

       Arnd
