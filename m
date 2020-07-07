Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9922168D7
	for <lists+linux-api@lfdr.de>; Tue,  7 Jul 2020 11:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbgGGJO4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 Jul 2020 05:14:56 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:43226 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgGGJO4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 7 Jul 2020 05:14:56 -0400
Received: by mail-wr1-f51.google.com with SMTP id j4so41937966wrp.10;
        Tue, 07 Jul 2020 02:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d1fV6kPM36TD326Nzxg7Z+ipDhi5SrBR72LA2cwak+8=;
        b=EHif8dqWLZUl9y9rwWvC7kHopzbjBT1vUeAUXKuDnnOFAp22PqmTL87dm94iO+HImu
         HrIsM++GEHdg8oaj7yay+wpqMZ+ShKUpIsIzP0cxS1sVjgaSNFhPiwM2/vmFUg9Kw9r4
         xCYWCWca94Ur64AFkIZKD4gFLmsB4qwsWuXYzcHl2yzU8FruJWyokR3uiIoHdabjsW6S
         GSIR5S9OVN6xqmUPPsemoKLDAUsMIyePMe+wCKdd36iFcXS1aVZYLlaVxIlfbDox+7JM
         9cgTqEhMH28Kd+1e1TuncHTZ8caX8HwYXLEIWKjefAtWtAzbOZHNLY8puRukC6BL1PRL
         n79g==
X-Gm-Message-State: AOAM532zLATfWE5I8M1X8JBHvHrBD5mbnOtQC6BkvQrT5MR1ZwA4fZ3J
        KRXvw4c1mNG0mCbdZZYEing=
X-Google-Smtp-Source: ABdhPJzFu/LXDAQqw0UoyFr80RTenCH282ojT9C7p2oH1LQMP7cch/sujIzsdADrs5lAs/XWoztr4g==
X-Received: by 2002:a5d:4d0b:: with SMTP id z11mr23258665wrt.24.1594113294131;
        Tue, 07 Jul 2020 02:14:54 -0700 (PDT)
Received: from localhost (ip-37-188-179-51.eurotel.cz. [37.188.179.51])
        by smtp.gmail.com with ESMTPSA id w13sm111649wrr.67.2020.07.07.02.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 02:14:53 -0700 (PDT)
Date:   Tue, 7 Jul 2020 11:14:51 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alexander Graf <graf@amazon.com>
Cc:     Jann Horn <jannh@google.com>, Pavel Machek <pavel@ucw.cz>,
        "Catangiu, Adrian Costin" <acatan@amazon.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "wad@chromium.org" <wad@chromium.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "bonzini@gnu.org" <bonzini@gnu.org>,
        "MacCarthaigh, Colm" <colmmacc@amazon.com>,
        "Singh, Balbir" <sblbir@amazon.com>,
        "Sandu, Andrei" <sandreim@amazon.com>,
        "Brooker, Marc" <mbrooker@amazon.com>,
        "Weiss, Radu" <raduweis@amazon.com>,
        "Manwaring, Derek" <derekmn@amazon.com>
Subject: Re: [RFC]: mm,power: introduce MADV_WIPEONSUSPEND
Message-ID: <20200707091451.GB5913@dhcp22.suse.cz>
References: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com>
 <20200703224411.GC25072@amd>
 <CAG48ez0oWQd42a-H-Dzw1Wq7HgB5PpFRGCZeYxP8ohxaoZHmvQ@mail.gmail.com>
 <20200704114820.GA16083@amd>
 <57ab4fb3-3f82-d34f-ad74-2214b45a4dd9@amazon.com>
 <CAG48ez1tAAD+x6n07uCisXpqVpDUPX7xBWiKFkS3u2azHqd41A@mail.gmail.com>
 <20200707074425.GC3820@dhcp22.suse.cz>
 <efa55313-ce8a-bac9-15df-167f93c672b3@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efa55313-ce8a-bac9-15df-167f93c672b3@amazon.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue 07-07-20 10:01:23, Alexander Graf wrote:
> On 07.07.20 09:44, Michal Hocko wrote:
> > On Mon 06-07-20 14:52:07, Jann Horn wrote:
> > > On Mon, Jul 6, 2020 at 2:27 PM Alexander Graf <graf@amazon.com> wrote:
> > > > Unless we create a vsyscall that returns both the PID as well as the
> > > > epoch and thus handles fork *and* suspend. I need to think about this a
> > > > bit more :).
> > > 
> > > You can't reliably detect forking by checking the PID if it is
> > > possible for multiple forks to be chained before the reuse check runs:
> > > 
> > >   - pid 1000 remembers its PID
> > >   - pid 1000 forks, creating child pid 1001
> > >   - pid 1000 exits and is waited on by init
> > >   - the pid allocator wraps around
> > >   - pid 1001 forks, creating child pid 1000
> > >   - child with pid 1000 tries to check for forking, determines that its
> > > PID is 1000, and concludes that it is still the original process
> > 
> > I must be really missing something here because I really fail to see why
> > there has to be something new even invented. Sure, checking for pid is
> > certainly a suboptimal solution because pids are terrible tokens to work
> > with. We do have a concept of file descriptors which a much better and
> > supports signaling. There is a clear source of the signal IIUC
> > (migration) and there are consumers to act upon that (e.g. crypto
> > backends). So what does really prevent to use a standard signal delivery
> > over fd for this usecase?
> 
> I wasn't part of the discussions on why things like WIPEONFORK were invented
> instead of just using signalling mechanisms, but the main reason I can think
> of are libraries.

Well, I would argue that WIPEONFORK is conceptually different. It is
one time initialization mechanism with a very clear life time semantic.
So any programming model is really as easy as, the initial state is
always 0 for a new task without any surprises later on because you own
the memory (essentially an extension to initialized .data section on
exec to any new task).

Compare that to a completely async nature of this interface. Any read
would essentially have to be properly synchronized with the external
event otherwise the state could have been corrupted. Such a consistency
model is really cumbersome to work with.

> As a library, you are under no control of the main loop usually, which means
> you just don't have a way to poll for an fd. As a library author, I would
> usually try to avoid very hard to create such a dependency, because it makes
> it really hard to glue pieces together.
> 
> The same applies to signals btw, which would also be a possible way to
> propagate such events.

Just to clarify I didn't really mean posix signals here. Those would be
quite clumsy indeed. But I can imagine that a library registers to a
system wide means to get a notification. There are many examples for
that, including a lot of usage inside libraries. All different *bus
interfaces.

-- 
Michal Hocko
SUSE Labs
