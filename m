Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6BE055880
	for <lists+linux-api@lfdr.de>; Tue, 25 Jun 2019 22:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfFYUNZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 25 Jun 2019 16:13:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbfFYUNZ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 25 Jun 2019 16:13:25 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FF72208CB
        for <linux-api@vger.kernel.org>; Tue, 25 Jun 2019 20:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561493604;
        bh=zCv6kKhHIg090YMBMNDY2BYklOSjhYrzuCeFFpymNkU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WedqG7Qsxekzs4sp8b57+T7xTTB/2C7mb5BKmZUeYEwEb1LmnDg1dMRmkgJr8vxNi
         iimzKMWaqrUGb0wQS9y1ch/IscRKU9NH2UEJKkOEFcX5U13+O1PE52RexeOhJcEqnC
         Ly88kyfygoWe9nWUlzqqdNB2Dzp+cRRqlTQXo2sw=
Received: by mail-wr1-f41.google.com with SMTP id p11so45362wre.7
        for <linux-api@vger.kernel.org>; Tue, 25 Jun 2019 13:13:24 -0700 (PDT)
X-Gm-Message-State: APjAAAWofTC5+ToGHj2iIxqCjGFZ6KZZVruQbJ+dyEu6MitOX+Unkqxu
        fyQUav+AQ8bOHNfBbLllZTzT8vrEPNslmzIfOYjKvw==
X-Google-Smtp-Source: APXvYqy+ySl3tS5sUHDWeT6Qzv2P/gAyMriecApQgJWQ0hQyxmac0CpzqMhTDRwVxeQc7qdaMOUkRMBb9g0oFV4s5Dc=
X-Received: by 2002:adf:a443:: with SMTP id e3mr2454wra.221.1561493603008;
 Tue, 25 Jun 2019 13:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <87v9wty9v4.fsf@oldenburg2.str.redhat.com> <201906251131.419D8ACB@keescook>
In-Reply-To: <201906251131.419D8ACB@keescook>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 25 Jun 2019 13:13:11 -0700
X-Gmail-Original-Message-ID: <CALCETrWg+vZWAdY-6etLnh=wyB1aXdG9s8ASUXX=cjjFm7CKZQ@mail.gmail.com>
Message-ID: <CALCETrWg+vZWAdY-6etLnh=wyB1aXdG9s8ASUXX=cjjFm7CKZQ@mail.gmail.com>
Subject: Re: Detecting the availability of VSYSCALL
To:     Kees Cook <keescook@chromium.org>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-x86_64@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Carlos O'Donell" <carlos@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jun 25, 2019 at 1:08 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Jun 25, 2019 at 05:15:27PM +0200, Florian Weimer wrote:
> > Should we try mapping something at the magic address (without MAP_FIXED)
> > and see if we get back a different address?  Something in the auxiliary
> > vector would work for us, too, but nothing seems to exists there
> > unfortunately.
>
> It seems like mmap() won't even work because it's in the high memory
> area. I can't map something a page under the vsyscall page either, so I
> can't distinguish it with mmap, mprotect, madvise, or msync. :(
>

I keep contemplating making munmap() work on it.  That would nicely
answer the question: if munmap() fails, it's not there, and, if
munmap() succeeds, it's not there :)
