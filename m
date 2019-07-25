Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDE474D7E
	for <lists+linux-api@lfdr.de>; Thu, 25 Jul 2019 13:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404286AbfGYLtv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 25 Jul 2019 07:49:51 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36253 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404287AbfGYLtu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 25 Jul 2019 07:49:50 -0400
Received: by mail-ed1-f65.google.com with SMTP id k21so49989985edq.3
        for <linux-api@vger.kernel.org>; Thu, 25 Jul 2019 04:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qb0U4o7YT9U0VbrF0QHOhn7J92nY/IJnK+dtiIpPk2s=;
        b=W8nZcCuIC42LTrQ+cXgC4rxIwaAgupXOYclF8q9Uu2sxmkv1TzOar8yCZb7d9cQj+L
         qb65n8bo59k4q9hp/sekLL69Gy+kti/bnHpRcw2CQknDwHyoxGOfvszmlujPCoAJvMzd
         hDvWBRn2M9oAlz8ZVK+DWvKczNPv0mEyebMimsuzoX89P2SR30WuY3RQqvu78hAY5NE/
         01wwwmr1XenQs8XxVBJiHfvWKhUs0UL8awthAA43ims7jr9gWaSZmU/HsKtHX2vDCUQK
         gSPnY6wRmn/lTk2DTSjusR1dLjqOFFXjnrZtaMhICzk4Ot3QgUeZhyIWyMxZTzYXpngk
         j3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qb0U4o7YT9U0VbrF0QHOhn7J92nY/IJnK+dtiIpPk2s=;
        b=cttb2SSODdrwh0p6JzrS9xXxGynvM9ybBEwbrCK2JADe8UkMGr9BTNiKt4T1kCV4KI
         XkJ/kmy6b37hM/ED78EioL7UJehhA04yCmqKzNA5A5Skae8SJrOyqvIq00XCGBbj27B0
         IjhBqU93fobKi3vSAApbMwG7mtkm63nfEO6EDZplehomidGtUD4+1VZUommgQDWwfdxK
         /0YN0ERzPTUv9AEyaeMZUA2RfCGsmPNOdPSv1AEc7LbM3xMHihmmmdN3zoPB0ryDJsUM
         V/OQ1P3lDQqLFYLywRTio77dfg7rrfyWdzYda7exSiL0gDz6xMdyrnRutfAK58OoY8Bb
         AaLQ==
X-Gm-Message-State: APjAAAVlykDMfInjgSGcvf1gVzZTcfPJyi6f0Si3z2C0Mj9Pe+wnxgIS
        gkDJ2gYUCSsLpgGaT893/RE=
X-Google-Smtp-Source: APXvYqzta/C7mytsF/sYtTrTny6c5TAQI5i2DpRjUhOVT1P3aLCxDWl2HWiq25oPh0cTbNwujbNFTg==
X-Received: by 2002:a50:871c:: with SMTP id i28mr76751011edb.29.1564054911890;
        Thu, 25 Jul 2019 04:41:51 -0700 (PDT)
Received: from brauner.io (ip5b40f7ec.dynamic.kabel-deutschland.de. [91.64.247.236])
        by smtp.gmail.com with ESMTPSA id r10sm13245342edp.25.2019.07.25.04.41.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 04:41:50 -0700 (PDT)
Date:   Thu, 25 Jul 2019 13:41:49 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, ebiederm@xmission.com,
        keescook@chromium.org, joel@joelfernandes.org, tglx@linutronix.de,
        tj@kernel.org, dhowells@redhat.com, jannh@google.com,
        luto@kernel.org, akpm@linux-foundation.org, cyphar@cyphar.com,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        kernel-team@android.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 4/5] pidfd: add CLONE_WAIT_PID
Message-ID: <20190725114148.bgm37lpiqli7g3ti@brauner.io>
References: <20190724144651.28272-1-christian@brauner.io>
 <20190724144651.28272-5-christian@brauner.io>
 <20190725103543.GF4707@redhat.com>
 <20190725104006.7myahvjtnbcgu3in@brauner.io>
 <20190725112503.GG4707@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190725112503.GG4707@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jul 25, 2019 at 01:25:03PM +0200, Oleg Nesterov wrote:
> On 07/25, Christian Brauner wrote:
> >
> > On Thu, Jul 25, 2019 at 12:35:44PM +0200, Oleg Nesterov wrote:
> > >
> > > I have to admit this feature looks a bit exotic to me...
> >
> > It might look like it from the kernels perspective but from the feedback
> > on this when presenting on this userspace has real usecases for this.
> 
> OK...
> 
> but then perhaps we can make PF_WAIT_PID more flexible.

I've changed this to be a property on signal_struct, i.e. a bitfield
entry following the {is,has}_child_subreaper entries.

> 
> Say, we can add the new WXXX wait option and change eligible_child()
> 
> 	if ((p->flags & PF_WAIT_PID) && (wo->options & WXXX))
> 		return 0;
> 
> this way the parent can tell waitid() whether the PF_WAIT_PID tasks should
> be filtered or not.
> 
> And if we do this we can even add PR_SET_WAIT_PID/PR_CLR_WAIT_PID instead
> of the new CLONE_ flag.

Hm, I prefer to not do this.
The idea is that this is a property of the pidfd itself and not of the
waitid() call. And currently, I don't think it makes sense to change
this property at runtime.
What might make sense is to remove this property when a task gets
reparented, i.e. when its parent has died.
