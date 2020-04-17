Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9E61AE2F9
	for <lists+linux-api@lfdr.de>; Fri, 17 Apr 2020 19:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgDQQ7n (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 17 Apr 2020 12:59:43 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39027 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgDQQ7m (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 17 Apr 2020 12:59:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id k18so1179905pll.6;
        Fri, 17 Apr 2020 09:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dC4k5ZLeGtiN4GIhih1iZ1bgexRzNsdtwNaiElYm8Sg=;
        b=f+7xRZJ1zAfQ/YFQAFE8JytxkOAUuALVGitGUpCiFij5U6R4QieAmopNu9W/zJGCIb
         aBq2H13waoip5fVg59E5nceoK1suBszCPN8TDLOxuiRqRoKiJOr75/asQTnfssUfhzgc
         2jySc6SlixNJZuBhs+P3KvIZxPOZoA9UXoVx4o+ULxqdsVhsVsoV0YdOwDHmyU+YyLTi
         nMyUjul6ujVmLEx2IP+bA+rhvtGmT6ZlIW15/ThmDpc5b+FtocNCxmTxkHTj4Ku/DB8T
         kxr9G9cLj6niRl18HiWJnvD3MqcfUSP0wYZ8ZcoYYVTkjqHs4w+/RtbOHH2J0gpblXvd
         8HZQ==
X-Gm-Message-State: AGi0PuaamGkunOR5iMiCzqp3OjgWdrACFV/E6kWt/F0aCOgGavWIc/2E
        LvZTkQk1EjuAbaQliD9g1YE=
X-Google-Smtp-Source: APiQypJyo3WoccLcwNNQ+fwOqBLD9a9lBfmZ6A/DqglFmkq5PqBPr0Do8rh+fLQLEgOYtRUFMM8msg==
X-Received: by 2002:a17:902:7289:: with SMTP id d9mr4273322pll.49.1587142781497;
        Fri, 17 Apr 2020 09:59:41 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id q187sm15490054pfb.131.2020.04.17.09.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 09:59:40 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 52C344028E; Fri, 17 Apr 2020 16:59:39 +0000 (UTC)
Date:   Fri, 17 Apr 2020 16:59:39 +0000
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
Message-ID: <20200417165939.GV11244@42.do-not-panic.com>
References: <20200414113222.16959-1-vbabka@suse.cz>
 <20200414113222.16959-2-vbabka@suse.cz>
 <20200415180355.00bc828ea726c421638db871@kernel.org>
 <20200416012931.GE11244@42.do-not-panic.com>
 <20200416194955.3448c8526ea3f59e95c506da@kernel.org>
 <20200416155327.GT11244@42.do-not-panic.com>
 <20200417193442.b20394dcaac02d5aeef9b5ee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417193442.b20394dcaac02d5aeef9b5ee@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Apr 17, 2020 at 07:34:42PM +0900, Masami Hiramatsu wrote:
> On Thu, 16 Apr 2020 15:53:27 +0000
> Luis Chamberlain <mcgrof@kernel.org> wrote:
> 
> > On Thu, Apr 16, 2020 at 07:49:55PM +0900, Masami Hiramatsu wrote:
> > > Hi Luis,
> > > 
> > > On Thu, 16 Apr 2020 01:29:31 +0000
> > > Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > 
> > > > On Wed, Apr 15, 2020 at 06:03:55PM +0900, Masami Hiramatsu wrote:
> > > > > On Tue, 14 Apr 2020 13:32:20 +0200
> > > > > Vlastimil Babka <vbabka@suse.cz> wrote:
> > > > > > diff --git a/init/main.c b/init/main.c
> > > > > > index a48617f2e5e5..7b43118215d6 100644
> > > > > > --- a/init/main.c
> > > > > > +++ b/init/main.c
> > > > > > @@ -1372,6 +1372,8 @@ static int __ref kernel_init(void *unused)
> > > > > >  
> > > > > >  	rcu_end_inkernel_boot();
> > > > > >  
> > > > > > +	do_sysctl_args();
> > > > > > +
> > > > > 
> > > > > Ah, I see. Since the sysctl is designed to be called after all __init calls were
> > > > > done, it shouldn't use bootconfig directly because bootconfig is full of __init
> > > > > call.
> > > > 
> > > > The idea is bootconfig would be useful in the sense of a library set of
> > > > helpers which could be modified to remove __init, and then used to
> > > > instrument the cmdline depending on certain debugging kconfig entries.
> > > 
> > > Would you mean making bootconfig (parser and APIs) be more generic so that
> > > other subsystem can reuse it with their data?
> > > Or just make it available after boot? (I think this latter one will be
> > > useful for module initialization)
> > 
> > The later. First use case that comes to mind is debugging cmdline, so
> > to see if what one adds is what ends up happening at run time after
> > boot.
> 
> Hmm, I think that's not so easy to debug command line after boot, because
> the kernel command line is parsed (and handlers are executed) already in
> boot time. We can not repeat it after boot.

Unless you put into the command line everything you need to test on one
boot.

> > > > We currently have no way to purposely extend / break the cmdline for
> > > > debugging purposes, so, bootconfig's parsers, since it already has a
> > > > way to extend the cmdlineline, might make it much easier to do this
> > > > later.
> > > > 
> > > > Without bootconfig, if we wanted to add new kconfig to, for example,
> > > > add new funny cmdline arguments to test they worked or not, we'd have
> > > > to devise our own set of helpers now. ie, new functionality. bootconfig
> > > > however already has existing functionality to tweak the cmdline, and so
> > > > some code could be leveraged there for this purpose.
> > > 
> > > Hmm, you can use the bootconfig as a "supplemental" kernel command line,
> > > but not tweak (like modify/replace) it. Would you like to change the
> > > kernel command line parameter on-line?
> > 
> > It would be during boot. To augment it as if the user had used certain
> > parameters on boot. But if only a new path is tested, and we can't
> > reproduce as if the user had *not* used bootconfig, this idea would
> > only be useful to test bootconfig parsing, nothing else. The hope was
> > to do both.
> 
> As you may know, the bootconfig already supports "additional" kernel
> command line. All keys which starts "kernel" is copied into kernel
> command line at early boot timing. So if you want to write a test
> parameter in the bootconfig, you can do it.

There are two bootparams paths now, the old way, and the new bootconfig
path. Extending test coverage to test bootconfig seems rather easier to
consider. However the hope was that there may be some existing code
within bootconfig which would also allow one to test the old cmdline
path, as if the cmdline had certain params present. It doesn't seem
to be the case.

> However, it is not a good idea to execute command line handlers
> twice because it can be destructive or can append all parameters
> (e.g. "console=" .)

I see so bootconfig is mutually exclusive with the old cmdline?

> For the new feature can natively use the bootconfig, for example
> boot-time tracing (kernel/trace/trace_boot.c) is something like
> this sysctl on boot, and natively uses the bootconfig because
> the tracing parameter is too complex for kernel command line :)

Neat.

  Luis
