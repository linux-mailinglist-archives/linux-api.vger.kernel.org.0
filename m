Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3836289A5F
	for <lists+linux-api@lfdr.de>; Mon, 12 Aug 2019 11:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfHLJtN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 12 Aug 2019 05:49:13 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43212 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfHLJtN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 12 Aug 2019 05:49:13 -0400
Received: by mail-qk1-f193.google.com with SMTP id m2so12168491qkd.10;
        Mon, 12 Aug 2019 02:49:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xAybZyOMngteP+D+qSW1GDTJYmxvpwNRj3u8iw1H9iI=;
        b=rN1aR9JKoiGfcWFGMSnj10dIV201pjpEywckSPKdInPsX53LHC6KaIU/eK+mfRCQBQ
         jwWi+Q45cwpsV/FHlvG6UTNg6YNKEMBJloJCha2VyarfGHz3SFdTMjmEak7iJHJ5TXen
         8nCMFW9ULj2Bvr7F+lDlG/y3LAubOdLwLyPlSN+1qce+kHIbjGCZXc6rKQtrHTlxWLDz
         D3hZj7fSZl8gl5tW/rGitv1km54YWf39dPwV/fThQaNLPmLJpOfn5kFrm6Ck82bsDdBj
         cHeBlB55AWuuZXildfVNzEI9ZFw/IQ/7vPd1Ua4FA6DUzknddz5wwqKSiIeWbJLD+9Fq
         qCfA==
X-Gm-Message-State: APjAAAUEnGpXQmHghU84qVzuFNvjkSKi0Fq+4fBNScOPfqjFEyib7E01
        CuwZZ9Dyrb02GijKa9kAYzhpiXqhRRPp4MgO5EY=
X-Google-Smtp-Source: APXvYqxWhPrGiOhkXhbkKSICcchKatCxf1zXyWL2+I28AuQWo2+ZrVMsn4RzrL5HBF9AufYw6bbRI4V/aUKfXIn8ATk=
X-Received: by 2002:a37:5f45:: with SMTP id t66mr29267714qkb.286.1565603352161;
 Mon, 12 Aug 2019 02:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190810010758.16407-1-alistair.francis@wdc.com>
In-Reply-To: <20190810010758.16407-1-alistair.francis@wdc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 12 Aug 2019 11:48:55 +0200
Message-ID: <CAK8P3a2wYMsBRm1X-TFo1d7-B7Xug9gwqF77HitoE7wmOqD7rw@mail.gmail.com>
Subject: Re: [PATCH] syscalls: Update the syscall #defines to match uapi
To:     Alistair Francis <alistair.francis@wdc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Aug 10, 2019 at 3:11 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> Update the #defines around sys_fstat64() and sys_fstatat64() to match
> the #defines around the __NR3264_fstatat and __NR3264_fstat definitions
> in include/uapi/asm-generic/unistd.h. This avoids compiler failures if
> one is defined.

What is the compiler failure you get?

> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  include/linux/syscalls.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 2bcef4c70183..e4bf5e480d60 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -512,7 +512,7 @@ asmlinkage long sys_readlinkat(int dfd, const char __user *path, char __user *bu
>  asmlinkage long sys_newfstatat(int dfd, const char __user *filename,
>                                struct stat __user *statbuf, int flag);
>  asmlinkage long sys_newfstat(unsigned int fd, struct stat __user *statbuf);
> -#if defined(__ARCH_WANT_STAT64) || defined(__ARCH_WANT_COMPAT_STAT64)
> +#if defined(__ARCH_WANT_NEW_STAT) || defined(__ARCH_WANT_STAT64)
>  asmlinkage long sys_fstat64(unsigned long fd, struct stat64 __user *statbuf);
>  asmlinkage long sys_fstatat64(int dfd, const char __user *filename,
>                                struct stat64 __user *statbuf, int flag);

I think this is wrong: when __ARCH_WANT_NEW_STAT is set, we are
on a 64-bit architecture and only want the sys_newfstat{,at} system
calls, not sys_fstat{,at}64 that gets used on 32-bit machines.

The #if check in the syscalls.h file also matches the definition of
the function.

       Arnd
