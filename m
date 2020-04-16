Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEC81ACC01
	for <lists+linux-api@lfdr.de>; Thu, 16 Apr 2020 17:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896686AbgDPPxj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 Apr 2020 11:53:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38447 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896648AbgDPPxa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 Apr 2020 11:53:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id y25so1846445pfn.5;
        Thu, 16 Apr 2020 08:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OJ1LhAU7febKN7iQIuormh5NmKS7oObKFw3LJa4CTas=;
        b=UmEch370OxfQKZ1j2M+YEmaOSVU5ijnuRMPx05LO4GsAbkgX1kUSNPA6Wll7hds9uM
         Alu2YWMq/ER2bPEa3scmPgH4kg4xOly4znoR7wHjB1gtfBlLaWJoFkN/LDD2u3CI0TNM
         IuZpWEWeZW0scf3KNbTs3sUOsBTuFTASh+6Cl3ixKwsWboKLS/cWXbKE1WDaugjpG16U
         TRRKNGWGqdytEP8jzTGpN/3WVMIzQO7Rxabk7dGXnsl12gpPg6z+hBZKQDO8uMZbR+bM
         6C1pkudm3uVpVzOGrhxpvwgLpBO9aLm1fj8QDU3TOHoG3OPrmmW6QNc9kc3vg8BuQBrO
         HqXA==
X-Gm-Message-State: AGi0PuYcrIRYmLo/A2GQIHsTn3LHss452idX7NAW8rlaRFfwst4AaV2x
        +wIqQvi//v2fuWE+DujYeJQ=
X-Google-Smtp-Source: APiQypL0bCBep50MvO+I1irfI6M146DVq6XZM9/sttMzKb5K92PS7O9TaiV4Z2X9iDlZuALlgjDLLQ==
X-Received: by 2002:a63:894a:: with SMTP id v71mr33642388pgd.314.1587052409606;
        Thu, 16 Apr 2020 08:53:29 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id o15sm15680232pgj.60.2020.04.16.08.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:53:28 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 9C1A440277; Thu, 16 Apr 2020 15:53:27 +0000 (UTC)
Date:   Thu, 16 Apr 2020 15:53:27 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
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
Subject: Re: [PATCH v2 1/3] kernel/sysctl: support setting sysctl parameters
 from kernel command line
Message-ID: <20200416155327.GT11244@42.do-not-panic.com>
References: <20200414113222.16959-1-vbabka@suse.cz>
 <20200414113222.16959-2-vbabka@suse.cz>
 <20200415180355.00bc828ea726c421638db871@kernel.org>
 <20200416012931.GE11244@42.do-not-panic.com>
 <20200416194955.3448c8526ea3f59e95c506da@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416194955.3448c8526ea3f59e95c506da@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Apr 16, 2020 at 07:49:55PM +0900, Masami Hiramatsu wrote:
> Hi Luis,
> 
> On Thu, 16 Apr 2020 01:29:31 +0000
> Luis Chamberlain <mcgrof@kernel.org> wrote:
> 
> > On Wed, Apr 15, 2020 at 06:03:55PM +0900, Masami Hiramatsu wrote:
> > > On Tue, 14 Apr 2020 13:32:20 +0200
> > > Vlastimil Babka <vbabka@suse.cz> wrote:
> > > > diff --git a/init/main.c b/init/main.c
> > > > index a48617f2e5e5..7b43118215d6 100644
> > > > --- a/init/main.c
> > > > +++ b/init/main.c
> > > > @@ -1372,6 +1372,8 @@ static int __ref kernel_init(void *unused)
> > > >  
> > > >  	rcu_end_inkernel_boot();
> > > >  
> > > > +	do_sysctl_args();
> > > > +
> > > 
> > > Ah, I see. Since the sysctl is designed to be called after all __init calls were
> > > done, it shouldn't use bootconfig directly because bootconfig is full of __init
> > > call.
> > 
> > The idea is bootconfig would be useful in the sense of a library set of
> > helpers which could be modified to remove __init, and then used to
> > instrument the cmdline depending on certain debugging kconfig entries.
> 
> Would you mean making bootconfig (parser and APIs) be more generic so that
> other subsystem can reuse it with their data?
> Or just make it available after boot? (I think this latter one will be
> useful for module initialization)

The later. First use case that comes to mind is debugging cmdline, so
to see if what one adds is what ends up happening at run time after
boot.

> > We currently have no way to purposely extend / break the cmdline for
> > debugging purposes, so, bootconfig's parsers, since it already has a
> > way to extend the cmdlineline, might make it much easier to do this
> > later.
> > 
> > Without bootconfig, if we wanted to add new kconfig to, for example,
> > add new funny cmdline arguments to test they worked or not, we'd have
> > to devise our own set of helpers now. ie, new functionality. bootconfig
> > however already has existing functionality to tweak the cmdline, and so
> > some code could be leveraged there for this purpose.
> 
> Hmm, you can use the bootconfig as a "supplemental" kernel command line,
> but not tweak (like modify/replace) it. Would you like to change the
> kernel command line parameter on-line?

It would be during boot. To augment it as if the user had used certain
parameters on boot. But if only a new path is tested, and we can't
reproduce as if the user had *not* used bootconfig, this idea would
only be useful to test bootconfig parsing, nothing else. The hope was
to do both.

  Luis
