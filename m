Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A539B5BFAF
	for <lists+linux-api@lfdr.de>; Mon,  1 Jul 2019 17:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfGAPYU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 1 Jul 2019 11:24:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33595 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfGAPYT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 1 Jul 2019 11:24:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so14371257wru.0
        for <linux-api@vger.kernel.org>; Mon, 01 Jul 2019 08:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=og76osagZkW1HyYwuJ93MYzDpl1HEiuEE5P8qHSHdLE=;
        b=H+xqiH5PfginiAgTwhUbH9wCmLV1UFNM1AruiHCLnLNEOxsj90mjn1WOyemsl0OcGQ
         H5pCZ+IBPULsoB6YbcAutjgEngJbEJRyAHJ3ChMgibw9l9hMjgVDm4vb08T05suVNfX6
         GRiOSf0+pKhaXJc0FN2vBz6acALVhU9sscRqttb+EOIPooENpSOsqMQXAq3tpb6KmJSK
         bPlxFsGLndTC7vMqZJ9eshhHQbcywOp/wbW9hgZREhhTwxzsP14QCcc2t+HhPgQbN247
         CLH9ZhqDLDWXDDQVV3t3F57Hy4Rllw/T56Vp9nekZ6EYNS9U/rBlQUElLD3uwhaGBYiQ
         sevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=og76osagZkW1HyYwuJ93MYzDpl1HEiuEE5P8qHSHdLE=;
        b=PO9EChol6sQaWx8HbbpqPecbSqDsYlun1pkV63XgGBRLD0n+OGLyC76TgVJ6ac/8WD
         R+p561UlmAA4fUnGkczLSjpTU0Mhnikak3fjz15bLg3/wmZQoT4xM10jSnwGPnauAghx
         YveRw6DLWatroNmFEYruNiDnzWOhRZo9StKz5uX8RjaIAKJXLNUYmLMOJCqv4AR1kT3v
         D12781dREp8oUWBlGg7GRqA8BA3H8J2+VSVmKkwPJ+Iw0iFVLfVdtEF5zvkFHXqtGjFa
         899tV4yir5fKQFQhUEHDNu2r92PLvrjXsGFzIhL87Ktp03liWxcmajTMMiTpNc7R5kLI
         IPKg==
X-Gm-Message-State: APjAAAWszrUhE1XbrBqJXIi58/d+eKFsgLgjzSyX9u5Tah8AXlGDPhvS
        p5Zz9OLhrTv8s5R9Y3oChh05UA==
X-Google-Smtp-Source: APXvYqy861d3WDBNflH8j6EQtsx9tZtxwBE6L3gfYqvrwNliI8KUrcX+yDQcDkn3n3Zvqx07g+7tEg==
X-Received: by 2002:a5d:6b90:: with SMTP id n16mr8744868wrx.206.1561994657545;
        Mon, 01 Jul 2019 08:24:17 -0700 (PDT)
Received: from brauner.io (p4FC0A2B8.dip0.t-ipconnect.de. [79.192.162.184])
        by smtp.gmail.com with ESMTPSA id f1sm9038727wml.28.2019.07.01.08.24.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 08:24:16 -0700 (PDT)
Date:   Mon, 1 Jul 2019 17:24:14 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Ley Foon Tan <lftan@altera.com>,
        "moderated list:NIOS2 ARCHITECTURE" 
        <nios2-dev@lists.rocketboards.org>
Subject: Re: [PATCH v3 2/2] arch: wire-up clone3() syscall
Message-ID: <20190701152413.zfwsxwtgeqtveie6@brauner.io>
References: <20190604160944.4058-1-christian@brauner.io>
 <20190604160944.4058-2-christian@brauner.io>
 <20190620184451.GA28543@roeck-us.net>
 <20190620221003.ciuov5fzqxrcaykp@brauner.io>
 <CAK8P3a2iV7=HkHBVL_puvCQN0DmdKEnVs2aG9MQV_8Q58JSfTA@mail.gmail.com>
 <20190621111839.v5yqlws6iw7mx4aa@brauner.io>
 <CAK8P3a0T1=eg5ONbMFhHi=vmk1K5uogZ+5=wpsXvjVDzn6vS=Q@mail.gmail.com>
 <20190621153012.fxwhx25mzmzueqh7@brauner.io>
 <CAK8P3a0f_=q88JB=t7fbmweAbZ2E2_uCMt+2JoBYx3od_M6fHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a0f_=q88JB=t7fbmweAbZ2E2_uCMt+2JoBYx3od_M6fHQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jul 01, 2019 at 05:14:51PM +0200, Arnd Bergmann wrote:
> On Fri, Jun 21, 2019 at 5:30 PM Christian Brauner <christian@brauner.io> wrote:
> > On Fri, Jun 21, 2019 at 04:20:15PM +0200, Arnd Bergmann wrote:
> > > On Fri, Jun 21, 2019 at 1:18 PM Christian Brauner <christian@brauner.io> wrote:
> > Hm, if you believe that this is fine and want to "vouch" for it by
> > whipping up a patch that replaces the wiring up done in [1] I'm happy to
> > take it. :) Otherwise I'd feel more comfortable not adding all arches at
> > once.
> >
> > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=clone
> 
> Sorry for my late reply. I had actually looked at the implementations
> in a little
> more detail and I think you are right that adding these are better
> left to the arch
> maintainers in case of clone3.

Perfect, thanks!

Christian
