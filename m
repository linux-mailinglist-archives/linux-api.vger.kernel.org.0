Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 941CD2B268
	for <lists+linux-api@lfdr.de>; Mon, 27 May 2019 12:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfE0Kpl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 May 2019 06:45:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37392 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfE0Kpl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 27 May 2019 06:45:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id a23so9393047pff.4
        for <linux-api@vger.kernel.org>; Mon, 27 May 2019 03:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aE2uyZ37ZTI8bLLwug7sYYZgqvxeNTU6PhXTmRA7gLg=;
        b=dQu9VJgdBq7ZkSxnXd6Vnw51QDGw13b6nH0fHvlJf3Rl6cRbyT8Xqfyu7bDEJFWESa
         cHCLs/VwkcJluIRiY7IjbjeJxhkIGMdG8LMKC2tP0xErcmbqWsaCrjees9Sd33cXBpz8
         vP4hJSvZRwBnhjHOx85hMczgGxEefDY5j9gN9f3ud7mMIVtLi02fjUmrKx8L766ahCgU
         EFSme7aD96SMkFThjGlM+XqSAxDAZnBxlrPqgzuTv6hzNA4tEeaNGoc1zYQzHdNTw3s+
         0XAhJBcSCJ1pcDsaZADdOhkMdNXLOcknyCtAlfbWUmUmxDRE+5NA1UDMJ14R/HTCuFwJ
         0qwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aE2uyZ37ZTI8bLLwug7sYYZgqvxeNTU6PhXTmRA7gLg=;
        b=uXvMiIta17nO62WVo+l8OOrGvojRS1JZl6znKSm4sCdqp6fI62x6lm0FFoDKbGSH7E
         u4xSCsSGSDS7EfoIQOnDfBWHn2mlhGQc021s9SDqTUctseH08mgdLu/PdKgkVp78tgI/
         AIRiBJZWThemZ8fv2O32vcYP/OCHVlpVpauKM5j+jK/JIdfjVuOoWLogE1s+/qCRvgvS
         5oWopZcP2jXhWv4EodZFgGYboxsqNdsS3pYTKRTgLElf3mpVQVL0RtZDuxzT03YfjU8O
         05ZuPVdAk4c8sbOZ5VLy4GqVhm1fpDvAbOtEPWB7YkF9BEr3lCciEiol2VSq/9OgUERd
         VaWA==
X-Gm-Message-State: APjAAAWmOrDcBleFmYUK/fgYYK9DCha21m0MmrzRuVMtZg+EUD/7ujFi
        yHc2VU45arOERZ6tqfjZ6iinjg==
X-Google-Smtp-Source: APXvYqxTnrwU1eKgSc9iQ0ApboFyS1UaBX+5oO/GHfL453T0/+RmxCYvvW89PUAefXa1VP6IaLpVvw==
X-Received: by 2002:a17:90a:d803:: with SMTP id a3mr30625374pjv.48.1558953940763;
        Mon, 27 May 2019 03:45:40 -0700 (PDT)
Received: from brauner.io ([208.54.39.129])
        by smtp.gmail.com with ESMTPSA id x7sm11077579pfm.82.2019.05.27.03.45.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 27 May 2019 03:45:40 -0700 (PDT)
Date:   Mon, 27 May 2019 12:45:30 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH 2/2] arch: wire-up clone6() syscall on x86
Message-ID: <20190527104528.cao7wamuj4vduh3u@brauner.io>
References: <20190526102612.6970-1-christian@brauner.io>
 <20190526102612.6970-2-christian@brauner.io>
 <CAK8P3a1Ltsna_rtKxhMU7X0t=UOXDA75tKpph6s=OZ4itJe7VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a1Ltsna_rtKxhMU7X0t=UOXDA75tKpph6s=OZ4itJe7VQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, May 27, 2019 at 12:02:37PM +0200, Arnd Bergmann wrote:
> On Sun, May 26, 2019 at 12:27 PM Christian Brauner <christian@brauner.io> wrote:
> >
> > Wire up the clone6() call on x86.
> >
> > This patch only wires up clone6() on x86. Some of the arches look like they
> > need special assembly massaging and it is probably smarter if the
> > appropriate arch maintainers would do the actual wiring.
> 
> Why do some architectures need special cases here? I'd prefer to have
> new system calls always get defined in a way that avoids this, and
> have a common entry point for everyone.
> 
> Looking at the m68k sys_clone comment in
> arch/m68k/kernel/process.c, it seems that this was done as an
> optimization to deal with an inferior ABI. Similar code is present
> in h8300, ia64, nios2, and sparc. If all of them just do this to
> shave off a few cycles from the system call entry, I really
> couldn't care less.

I'm happy to wire all arches up at the same time in the next revision. I
just wasn't sure why some of them were assemblying the living hell out
of clone; especially ia64. I really didn't want to bother touching all
of this just for an initial RFC.

Christian
