Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA2933845A
	for <lists+linux-api@lfdr.de>; Fri, 12 Mar 2021 04:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbhCLD1U (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 11 Mar 2021 22:27:20 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:50504 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231819AbhCLD1R (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 11 Mar 2021 22:27:17 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 12C3RCTm028168;
        Fri, 12 Mar 2021 04:27:12 +0100
Date:   Fri, 12 Mar 2021 04:27:12 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org
Subject: Re: Why is the bit size different between a syscall and its wrapper?
Message-ID: <20210312032712.GB27924@1wt.eu>
References: <CAK7LNAQYMKqixm8dVbbMvgt+=MEROSg-JG_kHS8T+xmrgeLABg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQYMKqixm8dVbbMvgt+=MEROSg-JG_kHS8T+xmrgeLABg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Mar 12, 2021 at 11:48:11AM +0900, Masahiro Yamada wrote:
> Hi.
> 
> I think I am missing something, but
> is there any particular reason to
> use a different bit size between
> a syscall and its userspace wrapper?
> 
> 
> 
> For example, for the unshare syscall,
> 
> unshare(2) says the parameter is int.
> 
> 
> SYNOPSIS
>        #define _GNU_SOURCE
>        #include <sched.h>
> 
>        int unshare(int flags);
> 
> 
> 
> 
> In the kernel, it is unsigned long.
> 
> 
> SYSCALL_DEFINE1(unshare, unsigned long, unshare_flags)
> {
>         return ksys_unshare(unshare_flags);
> }

The syscalls must have a well defined interface for a given architecture.
Thus in practice the ABI will define that arg1 goes into this register,
arg2 into this one etc, regardless of their type (plenty of them are
pointers for example). The long is the size of a register so it can carry
any of the types we care about. So by defining each syscall as a function
taking 1 to 6 fixed-size arguments you can implement about all syscalls.

Regarding the libc, it has to offer an interface which is compatible with
the standard definition of the syscalls as defined by POSIX or as commonly
found on other OSes, and this regardless of the platform.

For example look at recv(), it takes an int, a pointer, a size_t and an
int. It requires to be defined like this for portability, but at the OS
level all these will typically be passed as a register each.

Hoping this helps,
Willy
