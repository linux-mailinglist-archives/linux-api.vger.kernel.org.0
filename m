Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED0D344BB
	for <lists+linux-api@lfdr.de>; Tue,  4 Jun 2019 12:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfFDKto (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 4 Jun 2019 06:49:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55766 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbfFDKto (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 4 Jun 2019 06:49:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id 16so9916330wmg.5
        for <linux-api@vger.kernel.org>; Tue, 04 Jun 2019 03:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vViK9iDBq0w7sSxA4M0XBnW0Fmujup3yxcFIA5uIpT8=;
        b=OG89WYXTcHrbkkEkToBjQKNuSkXw/t8xOy/BkSMU3xc9KaBQYczgbGjv25yIoDTps5
         lCpf5uaq5nTUGNZ8PcpvrjcFU6WzGDSwpS4jXWCCvdoCRQFKUG9jIA4sRZyb5vz3qY2T
         9lT0yTFWNzhcPqRDNp0psJ2F71DXuhvP8YCPss0MKRhIZEsl2xy5DKi8MEZhKn+7o8gA
         vvmXJQi2dme9aZV7HgGJlrzfmuY+pDDjkH76aTY9tqUqTJYsh99c9R9YiQNK63wXg8i7
         6+ji2m6nQI50pqSQ58KU3Crju0zAu5S78uu8JgVE8wQCCmDqrKNLEkXWKRPP1u0RrH1O
         aLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vViK9iDBq0w7sSxA4M0XBnW0Fmujup3yxcFIA5uIpT8=;
        b=Ezxh5iWyACHzxlz+bTnp3Xmve7cB7YJkLUevSMcRGO5/22tMSL2Fkj6RS7b5g5rPoB
         ZUetGQ/P/fLMvvnjLVPDM9GOUPI8NQoQlek/WHdZRMaOM6AMM7cR/Z13hd6P+qu9dkGs
         gCdRRmqp/LIzpN0/5VJZ562e3rHvHIIwyw2lzZUkJ/mpOel8F1wb/Ek8b5R8QA6g4U5E
         JX8DtbRrrFv2RtNSomv3Ezw7r0eWT3esyp/TVyFBYgf/DIIxbq0vRRPk+SrUZtDC0NBQ
         6fgDp/yyBGc9jf3QYUha9c12UkKNw4jfxSXVZtj4cW0k87Ue+ZeYdxctvxMjnZZWuLPt
         LMfg==
X-Gm-Message-State: APjAAAUnYZ1f70ubWCLgLd2ql3J6s7i5sd3XzJ/eo/nieVPgvjbe/74n
        eh0ySXAGSLdTCkGHjhNKZnWgiA==
X-Google-Smtp-Source: APXvYqy0w2T8R3fUWh6dUOaQLjmFlN3Lf+wNQ+2da0sBml+vM01wMS4XK1ysNqktEP9sAxCQos1hkA==
X-Received: by 2002:a7b:ca4c:: with SMTP id m12mr16736629wml.37.1559645381967;
        Tue, 04 Jun 2019 03:49:41 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id k2sm29193302wrg.41.2019.06.04.03.49.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 03:49:41 -0700 (PDT)
Date:   Tue, 4 Jun 2019 12:49:40 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] fork: add clone3
Message-ID: <20190604104939.e7qhojiarfb2m3rh@brauner.io>
References: <20190603144331.16760-1-christian@brauner.io>
 <CAK8P3a0qBaQGu2h3yG45kvf=cgiQfkeiFw60WvD47H4BoEJiyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a0qBaQGu2h3yG45kvf=cgiQfkeiFw60WvD47H4BoEJiyQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jun 04, 2019 at 12:36:24PM +0200, Arnd Bergmann wrote:
> On Mon, Jun 3, 2019 at 4:44 PM Christian Brauner <christian@brauner.io> wrote:
> 
> > +
> > +#ifdef __ARCH_WANT_SYS_CLONE
> > +asmlinkage long sys_clone3(struct clone_args __user *uargs, size_t size);
> > +#endif
> 
> I would leave it outside of __ARCH_WANT_SYS_CLONE, as far
> as I can tell the only reason for that #ifdef is so architectures that
> have their own sys_clone implementation can opt out of the generic
> one, but we don't want that for new syscalls.
> 
> In fact, I'd prefer to drop the symbol entirely and have a different
> symbol with the opposite meaning such as
> __ARCH_NONSTANDARD_SYS_CLONE that only gets
> selected by sparc, ia64 and m68k. That should be a separate
> patch though, and I'm not asking you to do it, unless you
> want to clean up a little more.

I am totally up for this but I would prefer if we land clone3() in the
5.3 merge window and then for 5.3 rc{2,3} do the cleanups that David and
you suggested.
This leaves this patchset lean and easy to review.

Christian
