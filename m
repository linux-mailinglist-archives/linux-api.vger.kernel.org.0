Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E801AEB98
	for <lists+linux-api@lfdr.de>; Sat, 18 Apr 2020 12:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgDRKM0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 18 Apr 2020 06:12:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbgDRKMZ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sat, 18 Apr 2020 06:12:25 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD5C121D82;
        Sat, 18 Apr 2020 10:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587204744;
        bh=12+OiT5CsSGBAgtccVS9VdWP/G4qiRUN774ikuvhCGY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D8wGgaLJaE2TNVGN3niNHQRrlKbmQJyFxOhEG+VFJMFS+gIRhepW3JoFHFxxOZFaS
         MUCdmir5gjoEUwTmo7qgZtstq8biCS0/5QRVFcAYL/vEYjhd1NV0sl3DgYD/I6AjPL
         RHFP4s7Hp2QPyPQRaEGCZV98gsVaWLqtbswm2G4U=
Date:   Sat, 18 Apr 2020 19:12:18 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
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
Message-Id: <20200418191218.c3fa3b200730a852e9019421@kernel.org>
In-Reply-To: <20200417165939.GV11244@42.do-not-panic.com>
References: <20200414113222.16959-1-vbabka@suse.cz>
        <20200414113222.16959-2-vbabka@suse.cz>
        <20200415180355.00bc828ea726c421638db871@kernel.org>
        <20200416012931.GE11244@42.do-not-panic.com>
        <20200416194955.3448c8526ea3f59e95c506da@kernel.org>
        <20200416155327.GT11244@42.do-not-panic.com>
        <20200417193442.b20394dcaac02d5aeef9b5ee@kernel.org>
        <20200417165939.GV11244@42.do-not-panic.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, 17 Apr 2020 16:59:39 +0000
Luis Chamberlain <mcgrof@kernel.org> wrote:

> > > > > > Ah, I see. Since the sysctl is designed to be called after all __init calls were
> > > > > > done, it shouldn't use bootconfig directly because bootconfig is full of __init
> > > > > > call.
> > > > > 
> > > > > The idea is bootconfig would be useful in the sense of a library set of
> > > > > helpers which could be modified to remove __init, and then used to
> > > > > instrument the cmdline depending on certain debugging kconfig entries.
> > > > 
> > > > Would you mean making bootconfig (parser and APIs) be more generic so that
> > > > other subsystem can reuse it with their data?
> > > > Or just make it available after boot? (I think this latter one will be
> > > > useful for module initialization)
> > > 
> > > The later. First use case that comes to mind is debugging cmdline, so
> > > to see if what one adds is what ends up happening at run time after
> > > boot.
> > 
> > Hmm, I think that's not so easy to debug command line after boot, because
> > the kernel command line is parsed (and handlers are executed) already in
> > boot time. We can not repeat it after boot.
> 
> Unless you put into the command line everything you need to test on one
> boot.

I got it. But it requires completely another thing, because the command line
handlers are __init function, which is also released after boot, and bootconfig
is not designed for update (read only) so that we can remove locks.

> 
> > > > > We currently have no way to purposely extend / break the cmdline for
> > > > > debugging purposes, so, bootconfig's parsers, since it already has a
> > > > > way to extend the cmdlineline, might make it much easier to do this
> > > > > later.
> > > > > 
> > > > > Without bootconfig, if we wanted to add new kconfig to, for example,
> > > > > add new funny cmdline arguments to test they worked or not, we'd have
> > > > > to devise our own set of helpers now. ie, new functionality. bootconfig
> > > > > however already has existing functionality to tweak the cmdline, and so
> > > > > some code could be leveraged there for this purpose.
> > > > 
> > > > Hmm, you can use the bootconfig as a "supplemental" kernel command line,
> > > > but not tweak (like modify/replace) it. Would you like to change the
> > > > kernel command line parameter on-line?
> > > 
> > > It would be during boot. To augment it as if the user had used certain
> > > parameters on boot. But if only a new path is tested, and we can't
> > > reproduce as if the user had *not* used bootconfig, this idea would
> > > only be useful to test bootconfig parsing, nothing else. The hope was
> > > to do both.
> > 
> > As you may know, the bootconfig already supports "additional" kernel
> > command line. All keys which starts "kernel" is copied into kernel
> > command line at early boot timing. So if you want to write a test
> > parameter in the bootconfig, you can do it.
> 
> There are two bootparams paths now, the old way, and the new bootconfig
> path. Extending test coverage to test bootconfig seems rather easier to
> consider. However the hope was that there may be some existing code
> within bootconfig which would also allow one to test the old cmdline
> path, as if the cmdline had certain params present. It doesn't seem
> to be the case.

Hmm, maybe you misunderstand how the bootconfig passes the options
to command line. At the very early timing, it copies the kernel
boot options into the existing legacy kernel command line. See
setup_command_line()@init/main.c. The extra_command_line is what the
bootconfig generated.

This extra_command_line is mixed with the old cmdline parameters
and it is passed to the handlers via parse_args() on each init-level.
(some handlers just set the option to its own variables and
 use those variables in their __init functions)

On the other hand, new code which uses the bootconfig, will use the
bootconfig APIs (xbc_*) to find their related options in its __init
functions.

> > However, it is not a good idea to execute command line handlers
> > twice because it can be destructive or can append all parameters
> > (e.g. "console=" .)
> 
> I see so bootconfig is mutually exclusive with the old cmdline?

If you put options under "kernel" or "init", those are inclusive to the
old cmdline, but other keys are not visible from the old cmdline.

Thank you,

> 
> > For the new feature can natively use the bootconfig, for example
> > boot-time tracing (kernel/trace/trace_boot.c) is something like
> > this sysctl on boot, and natively uses the bootconfig because
> > the tracing parameter is too complex for kernel command line :)
> 
> Neat.
> 
>   Luis


-- 
Masami Hiramatsu <mhiramat@kernel.org>
