Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE0B3383FC
	for <lists+linux-api@lfdr.de>; Fri, 12 Mar 2021 03:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhCLCts (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 11 Mar 2021 21:49:48 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:18671 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbhCLCtZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 11 Mar 2021 21:49:25 -0500
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 12C2mmv5009162;
        Fri, 12 Mar 2021 11:48:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 12C2mmv5009162
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1615517329;
        bh=wMjay7gGWuK+Px6K/J9CW6U4nl+A8g80EMfuMm2LMxE=;
        h=From:Date:Subject:To:From;
        b=sqzW9PmgFRjPwWbHkojHQEIAU4jlh4SmziwkUJWMRVQe1Ytv6GTwCuY0PsIVyjOFs
         IwLCBIoBWTu5i2AlKWEwS1YkENfBFVypwaa6JRQd5Lw4mN7oXO8ByLMbLbT8m529zv
         wQda2MaJgTmrc4WpSrmAiJzDEw2BHGTCPHYKk8pZV8tIr2xZOlpF1N+MZ5PoD5n3N6
         x1NDLsYbNE3E+NuLvMw6rbNXHXz9xWZ+wuf6IcZChUH4/o8HvdPQFsdCi8twXId+G7
         NDW1joKweIFI5210ewCQI//32xkvS9BVJ9KhLQD6PZ0C8sk2A9a6ziMhbYWTUOnFQl
         f64EZIwYcTZZw==
X-Nifty-SrcIP: [209.85.214.179]
Received: by mail-pl1-f179.google.com with SMTP id a8so4709952plp.13;
        Thu, 11 Mar 2021 18:48:48 -0800 (PST)
X-Gm-Message-State: AOAM530Tyi5M3pnIluWN7jOG/0jzDKE53fEPLjaxiuMApFKvpaIrcWJT
        +56qVfdI5F+ZMRIm+YL5F6a5Nc99k2sAvy3msEU=
X-Google-Smtp-Source: ABdhPJw1mBizxB+9VF3KwFNYc0n0Vomc2EfwSnBUJvdOXP49AwVjQva3yAW6HDyZBgDTHPEyOunHOR2XKSYGEMfQvAc=
X-Received: by 2002:a17:90a:3b0e:: with SMTP id d14mr12121760pjc.198.1615517328278;
 Thu, 11 Mar 2021 18:48:48 -0800 (PST)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 12 Mar 2021 11:48:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQYMKqixm8dVbbMvgt+=MEROSg-JG_kHS8T+xmrgeLABg@mail.gmail.com>
Message-ID: <CAK7LNAQYMKqixm8dVbbMvgt+=MEROSg-JG_kHS8T+xmrgeLABg@mail.gmail.com>
Subject: Why is the bit size different between a syscall and its wrapper?
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi.

I think I am missing something, but
is there any particular reason to
use a different bit size between
a syscall and its userspace wrapper?



For example, for the unshare syscall,

unshare(2) says the parameter is int.


SYNOPSIS
       #define _GNU_SOURCE
       #include <sched.h>

       int unshare(int flags);




In the kernel, it is unsigned long.


SYSCALL_DEFINE1(unshare, unsigned long, unshare_flags)
{
        return ksys_unshare(unshare_flags);
}




I guess the upper 32-bit will be
zeroed out in the c library when
sizeof(int) != sizeof(unsigned long)
(i.e. 64-bit system), but I'd like to know
why we do it this way.


-- 
Best Regards
Masahiro Yamada
