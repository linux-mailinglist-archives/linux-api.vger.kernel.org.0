Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D763219F79D
	for <lists+linux-api@lfdr.de>; Mon,  6 Apr 2020 16:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgDFOIl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 6 Apr 2020 10:08:41 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43344 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728405AbgDFOIk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 6 Apr 2020 10:08:40 -0400
Received: by mail-pl1-f193.google.com with SMTP id v23so5946283ply.10;
        Mon, 06 Apr 2020 07:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qiVBZPsdURZP1jhMxDWHye9mEvFMkZlVNadDHV0ejs4=;
        b=aCOZdE+kKjgXwNUh4wa7sd0iC9RrBIh1NeBcPBx4YJ0956l6hfldfq2s4fiZPX+lEl
         XGScgrYshv2BiX4tuViMJ3evSNjGd2ZbtMIgQ9nPhrj4iqZLksyIYDbvBejmOYH6pUyH
         bP/YBd6oM2UHno72Ret0EoO1lJYoX2Py3+VW5NVtrCmJILUBxMFug1MFpJqwAUS5467A
         /lvGRWWoLCMbjM+XAPp5qlKBm8Trf+4IArkY2NZMSQISWQi6oJmVjYyAIbeILTMWiUaF
         vXEKxMOzmU4i69trexUmXEuCVsy2qH31wrm00vShlTHZgEb6huwdYXDxYOoHvIW5Cqka
         zYIw==
X-Gm-Message-State: AGi0PuZPGeANKt/2IzIxM987UtFdYovcKcaxifm/j/kHLXPzUt8PCU2f
        eqbcB9uySbQjYnA17WkjR1g=
X-Google-Smtp-Source: APiQypK4PBijtr6jrSkxbP+qg+JhVIDRUZnqmssM67o2eOuF1E9o8YpsOIerTZkbPlD0P7gpp2RFWw==
X-Received: by 2002:a17:90a:aa95:: with SMTP id l21mr11323852pjq.4.1586182119271;
        Mon, 06 Apr 2020 07:08:39 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id b2sm4506439pgg.77.2020.04.06.07.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 07:08:37 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id DD95740246; Mon,  6 Apr 2020 14:08:36 +0000 (UTC)
Date:   Mon, 6 Apr 2020 14:08:36 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
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
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 1/3] kernel/sysctl: support setting sysctl parameters
 from kernel command line
Message-ID: <20200406140836.GA11244@42.do-not-panic.com>
References: <20200330115535.3215-1-vbabka@suse.cz>
 <20200330115535.3215-2-vbabka@suse.cz>
 <20200330224422.GX11244@42.do-not-panic.com>
 <287ac6ae-a898-3e68-c7d8-4c1d17a40db9@suse.cz>
 <20200402160442.GA11244@42.do-not-panic.com>
 <202004021017.3A23B759@keescook>
 <20200402205932.GM11244@42.do-not-panic.com>
 <202004031654.C4389A04EF@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202004031654.C4389A04EF@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Apr 03, 2020 at 04:57:51PM -0700, Kees Cook wrote:
> On Thu, Apr 02, 2020 at 08:59:32PM +0000, Luis Chamberlain wrote:
> > We modify the copied bootparams to allow new sysctls to map to old boot params?
> 
> This strdup is so that the
> command line can have '\0's injected while it steps through the args
> (and for doing the . and / replacement).

Please ignore the const feedback then.

> > This is the least cumbersome solution I could think of. Other things
> > would require things like using qemu, etc. That seems much more messsy.
> 
> Yes. Doing an internal extension isn't testing the actual code.

But it would.

> > > This is an external interface (boot params), so
> > > I'd rather an external driver handle that testing. We don't have a
> > > common method to do that with the kernel, though.
> > 
> > Right... which begs the question now -- how do we test this sort of
> > stuff? The above would at least get us coverage while we iron something
> > more generic out for boot params.
> > 
> > > > That would test both cases with one kernel.
> > > > 
> > > > You could then also add a bogus new sysctl which also expands to a silly
> > > > raw boot param to test the wrapper you are providing. That would be the
> > > > only new test syctl you would need to add.
> > > 
> > > Sure, that seems reasonable. Supporting externally driven testing makes
> > > sense for this.
> > 
> > But again, what exactly?
> 
> I don't think anything is needed for this series. It can be boot tested
> manually.

Why test it manually when it could be tested automatically with a new kconfig?

  Luis
