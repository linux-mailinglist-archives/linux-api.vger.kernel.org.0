Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 488C78C415
	for <lists+linux-api@lfdr.de>; Wed, 14 Aug 2019 00:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfHMWIS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 13 Aug 2019 18:08:18 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37170 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfHMWIS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 13 Aug 2019 18:08:18 -0400
Received: by mail-lf1-f65.google.com with SMTP id c9so77810206lfh.4;
        Tue, 13 Aug 2019 15:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JFGwhT3banpa12Fxx8S2CP3E/IXNhK9b8PVywok9QKs=;
        b=t4wwaGnkEzTCH3aAm+M2T9hNat1FD2i9kGrvuSgfmh8LphQjLAsxzT4ijEZIuJk0Qi
         f/xKb1Mv8EbJwxMRfmJ4XG0jv1DxbaGRbwE8FeccDUjy4lQqMVFvd/KG6hztxGFG9HWV
         r1uvRLLQVzISnKiN6cFp76CCYtesxB+oO6RRQWNM9W7U5JB9tIBKNfQhnJc2pwLxdRRk
         ZLYwBKIhyxQCSNNM3wefSWq5jJPosdxoEi7jwOuSIZZctD5nQAkAdVEs8nxzAIoZRYjt
         Tpy7JD6s6tm52tJEf4GV0aHGzixCdO0XRjFc/3nbvTpdNkj9nXjNgn0qpZ5txKIXSlcS
         qPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JFGwhT3banpa12Fxx8S2CP3E/IXNhK9b8PVywok9QKs=;
        b=b/dEOMZFDkxNxiOtSLwcyMesUr5iZ/qmmKk22BazvgzXETmIF47otL0Jr46+c6SejN
         vD4XayL6u5hU08qwd0tFYpp60Z4WKSUA46++2Rj1+XZfeKHYC9BvQA6e2DXHxfQSJ8/Y
         BvSv3LUcPzWnydZaMXBdYQ6QbAsHidVG+YuRCEheEgKE3N6mO7EuTd92eIDJuv1iZmBM
         9m6T/GG4M7uXKctG6VgrULbJjfzEhJoolz0GNBzznLWp4Sm/DPjXx505+99MsMRRt6hi
         cyDk1Ph8b60dLQSobW7/WmPN7EI4oX7jH+MSpJ1+sal56RnCtDqSPFUpUuiMlweSFl9R
         mHcg==
X-Gm-Message-State: APjAAAVBomedNIoZPMVjHJfs+LDNq6M68UMcxIMvnoXmSryVQHoKHSMR
        aQahcM1MuHX7LbuelAdD1eVeJrz2iyUeUuAgwoI=
X-Google-Smtp-Source: APXvYqzs0CxK5xXugyGLQxoO1rILU6zVMMZR8e35OF07ixB51ImwzgOCuVP9v621dPVZEl1v3zsg98mnUzf1ZYC/RtU=
X-Received: by 2002:a19:c6d4:: with SMTP id w203mr23887675lff.135.1565734096262;
 Tue, 13 Aug 2019 15:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190810010758.16407-1-alistair.francis@wdc.com>
 <CAK8P3a2wYMsBRm1X-TFo1d7-B7Xug9gwqF77HitoE7wmOqD7rw@mail.gmail.com>
 <CAKmqyKNH7G=_gs2Hfc3OZMFaHzUwU8fSomfu_r92hJrnJHJT3A@mail.gmail.com> <CAK8P3a0phB6hb=Da6V=CWWmi_oYwUcpSRi6CZTqAPz7QXKFJTA@mail.gmail.com>
In-Reply-To: <CAK8P3a0phB6hb=Da6V=CWWmi_oYwUcpSRi6CZTqAPz7QXKFJTA@mail.gmail.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Tue, 13 Aug 2019 15:04:24 -0700
Message-ID: <CAKmqyKMxN1_DQOngTeUkh2EOX28trcbgsfOEXCaN2YK9EBdD8g@mail.gmail.com>
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

On Tue, Aug 13, 2019 at 12:41 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Aug 13, 2019 at 9:01 PM Alistair Francis <alistair23@gmail.com> wrote:
> > On Mon, Aug 12, 2019 at 2:49 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> > > > diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> > > > index 2bcef4c70183..e4bf5e480d60 100644
> > > > --- a/include/linux/syscalls.h
> > > > +++ b/include/linux/syscalls.h
> > > > @@ -512,7 +512,7 @@ asmlinkage long sys_readlinkat(int dfd, const char __user *path, char __user *bu
> > > >  asmlinkage long sys_newfstatat(int dfd, const char __user *filename,
> > > >                                struct stat __user *statbuf, int flag);
> > > >  asmlinkage long sys_newfstat(unsigned int fd, struct stat __user *statbuf);
> > > > -#if defined(__ARCH_WANT_STAT64) || defined(__ARCH_WANT_COMPAT_STAT64)
> > > > +#if defined(__ARCH_WANT_NEW_STAT) || defined(__ARCH_WANT_STAT64)
> > > >  asmlinkage long sys_fstat64(unsigned long fd, struct stat64 __user *statbuf);
> > > >  asmlinkage long sys_fstatat64(int dfd, const char __user *filename,
> > > >                                struct stat64 __user *statbuf, int flag);
> > >
> > > I think this is wrong: when __ARCH_WANT_NEW_STAT is set, we are
> > > on a 64-bit architecture and only want the sys_newfstat{,at} system
> > > calls, not sys_fstat{,at}64 that gets used on 32-bit machines.
> >
> > Ah, that would make sense then. I don't think you will see the error then.
>
> So we don't need this patch to build riscv32 kernels, right? It's possible
> that it was the result of an incorrect forward port of some other patch,
> as older riscv32 kernels did provide stat64(), but newer ones only have
> statx().

The issue came up when I was just changing some things for testing and
I thought it was a bug that others might run into. It isn't directly
related to the riscv32 kernel.

Alistair

>
>        Arnd
