Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D57C7D4DC
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2019 07:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbfHAFYF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 1 Aug 2019 01:24:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbfHAFYE (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 1 Aug 2019 01:24:04 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F9E8217D6
        for <linux-api@vger.kernel.org>; Thu,  1 Aug 2019 05:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564637043;
        bh=HDQb70tI5fA9NqOE+dvamkWfpgPoM26ltFSdWMc7wL4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HsWvrTIAdRkF4tcGWBxEbeydCuGZLpHtpNY14BazC4G/XuqzzegLLTLixxZpdjB4g
         A1df+JaBlOW3sNi01JgIZQMqN8oX8iNz5D6OtJWjXTtZBWlzs7pNzphKmVpjnN49E4
         RSwP41EJqLgfK2Q03OiU7DQ8+UhkJPX42vW2uyyY=
Received: by mail-wm1-f49.google.com with SMTP id u25so51558514wmc.4
        for <linux-api@vger.kernel.org>; Wed, 31 Jul 2019 22:24:03 -0700 (PDT)
X-Gm-Message-State: APjAAAWWVrnulLp0wsMrMjI4FhuO+Lb67DaRV3WvzoDi2OZPiD7sqcBK
        88rO/bNbans33fO36U9C7G91Fbi4hZC3YOLuqCuvPQ==
X-Google-Smtp-Source: APXvYqwe9647Ls7CjH1zr/SzdtRdvCPKZd4VYXb1e6vdxjHQpcQDdnw0z/LdvkU3PZ2S0zI2Nclhg8OezGY4DS/y8FU=
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr114656661wmk.79.1564637039930;
 Wed, 31 Jul 2019 22:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190729215758.28405-1-dima@arista.com> <20190729215758.28405-22-dima@arista.com>
In-Reply-To: <20190729215758.28405-22-dima@arista.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 31 Jul 2019 22:23:48 -0700
X-Gmail-Original-Message-ID: <CALCETrW4YpndyXHLxCuBSaXX2V9UYNs3d6kLv1MS-vt0FxOvAw@mail.gmail.com>
Message-ID: <CALCETrW4YpndyXHLxCuBSaXX2V9UYNs3d6kLv1MS-vt0FxOvAw@mail.gmail.com>
Subject: Re: [PATCHv5 21/37] x86/vdso: Restrict splitting VVAR VMA
To:     Dmitry Safonov <dima@arista.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        criu@openvz.org, Linux API <linux-api@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jul 29, 2019 at 2:58 PM Dmitry Safonov <dima@arista.com> wrote:
>
> Although, time namespace can work with VVAR VMA split, it seems worth
> to forbid splitting VVAR resulting in stricter ABI and reducing amount
> of corner-cases to consider while working further on VDSO.
>
> I don't think there is any use-case for partial mremap() of vvar,
> but if there is any - this patch can be easily reverted.

Seems reasonable to me.
