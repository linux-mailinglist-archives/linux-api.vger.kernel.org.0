Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C7D1A92E6
	for <lists+linux-api@lfdr.de>; Wed, 15 Apr 2020 08:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441091AbgDOGIR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Apr 2020 02:08:17 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39060 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389822AbgDOGIL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Apr 2020 02:08:11 -0400
Received: by mail-pl1-f196.google.com with SMTP id k18so869301pll.6;
        Tue, 14 Apr 2020 23:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZUFRFKP5XHm+tVn1iBb6i8NUmk+hMwix7vSoVxV5lZQ=;
        b=m1tlQU+ZP2UNHqbmik7h67ZLbEvfQidvBkK1KXYMdJKwuraHTXVGMiz+c5D7oSM5gh
         U8RvrMLqkTRo2EmUq/AoM7UYWY/9CQVnAPPMG0chk1TZAYp2f3/oI9PCXidqvaDbS4LY
         5qFZt9c+8GKFPdXdiyM24JNoJVeDyCxEda+++pjORGcCXEzsQHDGzAPHgvVmb1Nn+0pf
         mZIKlJPWYyxkyKbsYwtqlkL4WbmLUD+8L+2Lp9dc0AvXsBkCa0QAGQoTp0bGCEgJ2uEg
         In9f/uQzMccBAgYnRy/x53PXkmTanVi1BmY3JJGngqFpQo/vCyyGgNBjouMbOvHrGyfd
         LnMw==
X-Gm-Message-State: AGi0PubKnWJ/oco0AvrIpmzx80beQq5BWzdDj202I2D4Y5ww+2XYORKG
        q5Xz35aYmfsEfw+xO2BSRHY=
X-Google-Smtp-Source: APiQypITe0Jo2LSazeCPOlLHzXhdbcDlQkPI1hUI+ssy+AUoQcqqY+hqTknibeyRkw3bWyzsVGcAig==
X-Received: by 2002:a17:90a:aa0e:: with SMTP id k14mr4382466pjq.74.1586930890545;
        Tue, 14 Apr 2020 23:08:10 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id q131sm7947640pfq.115.2020.04.14.23.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 23:08:08 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id DA59D40277; Wed, 15 Apr 2020 06:08:07 +0000 (UTC)
Date:   Wed, 15 Apr 2020 06:08:07 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 1/3] kernel/sysctl: support setting sysctl parameters
 from kernel command line
Message-ID: <20200415060807.GR11244@42.do-not-panic.com>
References: <20200330224422.GX11244@42.do-not-panic.com>
 <287ac6ae-a898-3e68-c7d8-4c1d17a40db9@suse.cz>
 <20200402160442.GA11244@42.do-not-panic.com>
 <202004021017.3A23B759@keescook>
 <20200402205932.GM11244@42.do-not-panic.com>
 <202004031654.C4389A04EF@keescook>
 <20200406140836.GA11244@42.do-not-panic.com>
 <202004060856.6BC17C5C99@keescook>
 <20200406170822.GE11244@42.do-not-panic.com>
 <7585f0b0-c5d2-b527-aac7-eeafdd15ffad@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7585f0b0-c5d2-b527-aac7-eeafdd15ffad@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Apr 14, 2020 at 01:25:07PM +0200, Vlastimil Babka wrote:
> On 4/6/20 7:08 PM, Luis Chamberlain wrote:
> > On Mon, Apr 06, 2020 at 08:58:50AM -0700, Kees Cook wrote:
> >> On Mon, Apr 06, 2020 at 02:08:36PM +0000, Luis Chamberlain wrote:
> >> > > Yes. Doing an internal extension isn't testing the actual code.
> >> > 
> >> > But it would.
> >> > 
> >> > [...]
> >> > > I don't think anything is needed for this series. It can be boot tested
> >> > > manually.
> >> > 
> >> > Why test it manually when it could be tested automatically with a new kconfig?
> >> 
> >> So, my impression is that adding code to the internals to test the
> >> internals isn't a valid test (or at least makes it fragile) because the
> >> test would depend on the changes to the internals (or at least depend on
> >> non-default non-production CONFIGs).
> > 
> > The *internal* aspect here is an extension to boot params under a
> > kconfig which would simply append to it, as if the user would have
> 
> So there's no such kconfig yet to apply boot parameters specified by configure,
> right? That would itself be a new feature.

I cannot say, there is no easy grammatical expression for this. For
kernel testing, no, I am not aware of one.

> Or could we use bootconfig? (CC Masami)

Neat, yeah, that seems like a set of helpers of which could help for
sure.

> >> Regardless of testing, I think this series is ready for -mm.
> > 
> > I'm happy for it to go in provided we at least devise a follow up plan
> > for testing. Otherwise -- like other things, it won't get done.
> 
> OK I'll send a v2 and we can discuss the test driver details. I don't want to
> neglect testing, but also not block the new functionality,

So long as the testing part gets done, I'm happy :)

> in case it means
> testing means adding another new functionality.

Yeah, I can see how some new code may need to be added for that, its a
good point.

But think about this for a second, if we *didn't* have such code added,
how could it have easily been tested before? The question is rhetorical,
as I'm alluding to that a lot of old code wasn't designed for easy unit
testing either, and I'd invite one to consider the value of the change
in philosophy on first code design when one *does* take that into
consideration. There are certain best practices that I'd wager are
probably good for us to evaluate for the long term of kernel evolution,
and I think that always advocating designing testing around new
functionality would be one.

Once and if you do add your testing, and if such testing is expanded to
test parsing the cmdline further, and to purposely break it, who knows
what other bugs bugs we'll find.

But maybe Masami already uncovered all the fun bugs.

  Luis
