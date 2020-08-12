Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7042424BB
	for <lists+linux-api@lfdr.de>; Wed, 12 Aug 2020 06:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgHLEaJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Aug 2020 00:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgHLEaH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Aug 2020 00:30:07 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3883BC06174A
        for <linux-api@vger.kernel.org>; Tue, 11 Aug 2020 21:30:06 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id x24so425317lfe.11
        for <linux-api@vger.kernel.org>; Tue, 11 Aug 2020 21:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GDwgZeCfylHcfAPvU7+q1GMSHtKUMIYb5xnIYWrEEr4=;
        b=B3aVSgoHTMeOnptotypuxeXwzcXLQNuaXirCFngMoQkYUX18nRwhqfYkwT5muF8NNb
         UKxUK5N/shaIWvw0Xb4abZJVmXGDVkhZnbu8HKy2tFr+b4sjrnMDzzOW7KpvC5hKvofh
         644/QVacgEmv5UDIs0jX0SLrxFZRlm9Rtr+/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GDwgZeCfylHcfAPvU7+q1GMSHtKUMIYb5xnIYWrEEr4=;
        b=NzC+GovT5KeQ9Mh/M+m1HdTv9vX2p8ztmzOIzvgx/tKb/ngdQGnijsmJamLV4Kg164
         lpesSgMyPoXmyySHeomt4hkJuNRa5b1VF5LIllH3l2UE0Tr9dB0NvEHVIWpZRVC6D/nz
         h5tOZtsC4LhqzedotbVEZtbR7fCUqg5IQJGIGcAbmrgKA/IQCJuWM1/ASZvtPuJmtMli
         gO9rjqMH1GPHzVASX3EdMj8OzTd+AST0zbVnznCUxnJF9HEXCVjzhnz2GUBn2YwF3Qqp
         8C7T7AB98SnyHjJhXXc10aCj8GJ4C8Y5GVR0WbXiPDX2JK9Wn2L5OXK3JWXxJrIocN4W
         abvA==
X-Gm-Message-State: AOAM530w8f7VckXYvAG3ua7KRCvK0ghH0+cbpmaipeRUvwIsxCMCOjDN
        VVWhZ/NBneCLQ27CETgF3Cg9a9+dy7M=
X-Google-Smtp-Source: ABdhPJwaLxPkfI5HhfitNFAWqDOQ5z5FkTI4XReknMLv9orYBVD8uAyTDOCDAvugCtNARH3UedG3Qg==
X-Received: by 2002:a19:4201:: with SMTP id p1mr4691809lfa.97.1597206604992;
        Tue, 11 Aug 2020 21:30:04 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id g11sm177818lfc.46.2020.08.11.21.30.03
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 21:30:04 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id f26so726140ljc.8
        for <linux-api@vger.kernel.org>; Tue, 11 Aug 2020 21:30:03 -0700 (PDT)
X-Received: by 2002:a2e:92d0:: with SMTP id k16mr4153008ljh.70.1597206603371;
 Tue, 11 Aug 2020 21:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f0724405aca59f64@google.com> <20200812041518.GO1236603@ZenIV.linux.org.uk>
In-Reply-To: <20200812041518.GO1236603@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Aug 2020 21:29:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgHZF+GbPS0=+9C7NWb1QUw4sPKL0t90yPGs07jJ0eczQ@mail.gmail.com>
Message-ID: <CAHk-=wgHZF+GbPS0=+9C7NWb1QUw4sPKL0t90yPGs07jJ0eczQ@mail.gmail.com>
Subject: Re: [PATCH] Re: KASAN: use-after-free Read in path_init (2)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+bbeb1c88016c7db4aa24@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Aug 11, 2020 at 9:15 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> fix breakage in do_rmdir()
>
> putname() should happen only after we'd *not* branched to
> retry, same as it's done in do_unlinkat().

Looks obviously correct.

Do you want me to apply directly, or do you have other fixes pending
and I'll get a pull request?

                  Linus
