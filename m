Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED54B1ED9F0
	for <lists+linux-api@lfdr.de>; Thu,  4 Jun 2020 02:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgFDAVQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 3 Jun 2020 20:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgFDAVQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 3 Jun 2020 20:21:16 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C5CC08C5C0
        for <linux-api@vger.kernel.org>; Wed,  3 Jun 2020 17:21:15 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id w7so3247819edt.1
        for <linux-api@vger.kernel.org>; Wed, 03 Jun 2020 17:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rWe2Q0RVzrp4gR0EET85HSpI5Y5evJHsyhPkQ14mL0k=;
        b=bt0TGPg3m1SCTLBdHymXFLfl3E3L3r+udH7rn8D+EBhHjSsJezRKQc5I44quK2Ep95
         n7O9rGE+x0OuzzxK9JDFKVEZNlNil/zWzB2OtsPvSkq3h3Byx+1A/PbyAJD8T+ACtvtF
         KVePdWwwaM3XuFRkXqkGtRQjsVdhDo42Nx8Z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rWe2Q0RVzrp4gR0EET85HSpI5Y5evJHsyhPkQ14mL0k=;
        b=r9AKBeUMBrgl4HM9bfPFrigzPJpaeiWNJ5gic/QPPQ+0US53TYH/c89duhHwaUkjJD
         PlcMmeDQ8Mqz+OQVQaDxrJXjOfKs/s/BQSaQVCGhXvEDErPSZymj+1885ysmhyZqcR5q
         ul5XOYzrhrYDTb39sQ9sd13Fx0KhSrfQCGbBlJmZIUNvd0HjzgjaGU1e4zTwTUy6u7BB
         wAcb3aP17N6fLbhclAAqX46beHKH3CCfvg3Kn2b2EUWohF4Y7zljVqG6rDBfxJ2SxC8M
         L4eAtdoErrbdE9gtLB4k57FyLQUqQypdFF/mr8y9W5XE3jISzDJ1TfDK5nZ1rThpYZFL
         WY7Q==
X-Gm-Message-State: AOAM531qlZLeWQD4YcxYr1hz2VIU4xI4bOOXUMRrKhvRrFWpJyRY0qRY
        rJuLMcE5pbVgr2nuNx8DEzHjd6N5d/I=
X-Google-Smtp-Source: ABdhPJzksin3PkN75zeKyhMNo33PMeVgncI/v29uyWwQpWCB0Q8FKfZoZn2k0kqz8VUH4VVRhgxsLg==
X-Received: by 2002:a05:6402:19a9:: with SMTP id o9mr1813808edz.205.1591230073343;
        Wed, 03 Jun 2020 17:21:13 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id k9sm652110edl.83.2020.06.03.17.21.13
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 17:21:13 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id x13so4205598wrv.4
        for <linux-api@vger.kernel.org>; Wed, 03 Jun 2020 17:21:13 -0700 (PDT)
X-Received: by 2002:a2e:7e0a:: with SMTP id z10mr790807ljc.314.1591229631853;
 Wed, 03 Jun 2020 17:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200602204219.186620-1-christian.brauner@ubuntu.com>
 <CAHk-=wjy234P7tvpQb6bnd1rhO78Uc+B0g1CPg9VOhJNTxmtWw@mail.gmail.com>
 <20200602233355.zdwcfow3ff4o2dol@wittgenstein> <CAHk-=wimp3tNuMcix2Z3uCF0sFfQt5GhVku=yhJAmSALucYGjg@mail.gmail.com>
 <20200603232410.i3opsbmepv5ktsjq@wittgenstein>
In-Reply-To: <20200603232410.i3opsbmepv5ktsjq@wittgenstein>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Jun 2020 17:13:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgTpLOeMjpLOc8hY7KC6Qv+jR-hBacyBSajJ6iUKasmKA@mail.gmail.com>
Message-ID: <CAHk-=wgTpLOeMjpLOc8hY7KC6Qv+jR-hBacyBSajJ6iUKasmKA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] close_range()
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Evans <self@kyle-evans.net>,
        Victor Stinner <victor.stinner@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jun 3, 2020 at 4:24 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> Ok, here's what I have. Does the below look somewhat sane?

Probably. Needs lots of testing. But this one looks wrong:

> +int __close_range(unsigned fd, unsigned max_fd, unsigned int flags)
>  {
> +               if ((max_fd + 1) >= cur_max)
> +                       max_unshare_fds = fd;

A normal value for "close everything starting at X" would have a
max_fd value of ~0.

So "max_fd+1" would overflow to 0, and then this would never trigger.

Other than that it looks what what I imagine my feverdreams were about.

              Linus
