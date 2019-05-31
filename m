Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB7031702
	for <lists+linux-api@lfdr.de>; Sat,  1 Jun 2019 00:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfEaWOA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 31 May 2019 18:14:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42814 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfEaWOA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 31 May 2019 18:14:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id o12so304004wrj.9
        for <linux-api@vger.kernel.org>; Fri, 31 May 2019 15:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e0zehylnRNwEoLMrCtDr0FIIIv+bm7246N0/VnWTSdI=;
        b=BAC3ltmN+JNBuMnr+fmkqoJ/R2Jl5ZglI9F+hoi3aeqvqtSHvB7KjA9durJerJCZlL
         MbdlR5Ed+iyDoBNWR+pPGjhyb1smmWtfOWf2XXKElsdhddUjuTys9W6XUQdRrhBbFGjF
         mGaH1m6kD7e1H3TOp+L36cVvw2k3E5sR3x7XZuw40NQOYOo6OJLn7ZluWzrAIebz0o6Y
         gkRwYNYL2BjdADyxBLHOw7HPuyGtEeOasqUgH/wGNYi17Q6PNJUqpytlGTWAJHgRmBLh
         NfxaABdmTQ7txQpL3XyymcvLMOEUt+nvKjIzNK9mXONEoUOTpXefg4E4OUQ1PyvBZM/3
         N6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e0zehylnRNwEoLMrCtDr0FIIIv+bm7246N0/VnWTSdI=;
        b=MyJlRn6rxN33OTlYBKC+K2CuB0thK8sVbR2RtnUyud5+x7FfR3Ip4xSM/W7Uen3HiU
         5Gpn2JNFGFuh89oMNPbsk2PCs7MsbqXdeoBNnFbz5qPI1ociM9p10tKf1Hyl7cyMPPi2
         xL1j+O7V/lNw4Td9OQOFkMT6DPEHcOHv0Lth2ltvIkYy84i/+YvbsYGDTJHjTxLBwXmE
         mR/QkmzhJlfAW9dluqfP5/SYRp53OB0PFejaxziqbSCdIKtuiR0C9opdVjiRmvwd+swl
         p21kZfGYntDddJuUYur5L6TBPK71OxtCN5/prkn5X5yyfMqQLiFlrXphWAbdyry9WSWf
         c77w==
X-Gm-Message-State: APjAAAXtpHjVqYOIqLhkLSIX7RNezctTMPmfhKrIFEthMQUmLOVcACDt
        B+VekS4pRj/FnV0ahokitM3wXA==
X-Google-Smtp-Source: APXvYqw0OR/H3EuEp5fqjZFM8TZ/nEGygjIjvRDRDc9VEOCCRUu9NNHqaeGl81tYfFTPe2EALCE5+A==
X-Received: by 2002:adf:e583:: with SMTP id l3mr7751345wrm.1.1559340838726;
        Fri, 31 May 2019 15:13:58 -0700 (PDT)
Received: from brauner.io (93-32-55-82.ip32.fastwebnet.it. [93.32.55.82])
        by smtp.gmail.com with ESMTPSA id k2sm7898056wrx.84.2019.05.31.15.13.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 15:13:58 -0700 (PDT)
Date:   Sat, 1 Jun 2019 00:13:57 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrei Vagin <avagin@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] fork: add clone3
Message-ID: <20190531221356.uekyzxhtuijgj4pg@brauner.io>
References: <20190529152237.10719-1-christian@brauner.io>
 <20190529222414.GA6492@gmail.com>
 <CAHk-=whQP-Ykxi=zSYaV9iXsHsENa+2fdj-zYKwyeyed63Lsfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whQP-Ykxi=zSYaV9iXsHsENa+2fdj-zYKwyeyed63Lsfw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 31, 2019 at 01:38:29PM -0700, Linus Torvalds wrote:
> On Wed, May 29, 2019 at 3:24 PM Andrei Vagin <avagin@gmail.com> wrote:
> >
> > Thank you for thinking about time namespaces. I looked at this patch
> > quickly and I would suggest to move a termination signal out of flags. I
> > think we can add a separate field (exit_signal) into clone_args. Does it
> > make sense? For me, exit_signal in flags always looked weird...
> 
> I agree - the child signal in flags was always just a "it fits" kind
> of thing, and that was obviously true back then, but is not true now.

(Traveling until Monday, so sorry for delayed responses.)

Yip, I agree that this is a good idea (answered Andrei's mail just now
saying the same thing). I'll send out a new version of the patch with
these changes added next week.

Christian
