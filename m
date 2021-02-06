Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7EA311BDD
	for <lists+linux-api@lfdr.de>; Sat,  6 Feb 2021 08:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhBFHOl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 6 Feb 2021 02:14:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:50242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229539AbhBFHOj (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sat, 6 Feb 2021 02:14:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C94FB64F9B;
        Sat,  6 Feb 2021 07:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612595638;
        bh=nuSHRF9OudOjXsyAgzF1fbrlfgZwD78OhCatWB6lMhg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bfdy8GGAvV1JvU8U8TipoZKPpm+FV/xETSJFvJVGOnp9jQ04zVIPC7tfY4/0Dtpx5
         rr0Wdc6jhXyMWnS95gt4Wc0D3QTOXQ6LA+4tD0Jc5KvcELwoYJLlEJc70W4iduGJG2
         pyiOCZFOJJcBGG2jUQ+axSw270/h4fj4jq62kGiM=
Date:   Sat, 6 Feb 2021 08:13:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jason Baron <jbaron@akamai.com>,
        Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org
Subject: Re: [PATCH] printk: Userspace format enumeration support
Message-ID: <YB5Bsyk4o3Mqr6Li@kroah.com>
References: <YBwU0G+P0vb9wTwm@chrisdown.name>
 <YB11jybvFCb95S9e@alley>
 <20210205124748.4af2d406@gandalf.local.home>
 <YB3Kf896Zt9O+/Yh@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YB3Kf896Zt9O+/Yh@chrisdown.name>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Feb 05, 2021 at 10:45:19PM +0000, Chris Down wrote:
> Hi Steven,
> 
> Steven Rostedt writes:
> > Interesting, because when I was looking at the original patch (looked at
> > the lore link before reading your reply), I thought to myself "this looks
> > exactly like what I did for trace_printk formats", which the above file is
> > where it is shown. I'm curious if this work was inspired by that?
> 
> The double __builtin_constant_p() trick was suggested by Johannes based on
> prior art in trace_puts() just prior to patch submission. Other than that,
> it seems we came up with basically the same solution independently. :-)
> 
> > > Anyway, there is something wrong at the moment. The output looks fine
> > > with cat. But "less" says that it is a binary format and the output
> > > is a bit messy:
> > 
> > Hmm, that's usually the case when lseek gets messed up. Not sure how that
> > happened.
> 
> It looks as intended to me -- none of the newlines, nulls, or other control
> sequences are escaped currently, since I didn't immediately see a reason to
> do that. If that's a blocker though, I'm happy to change it.
> 
> > > $> less /proc/printk_formats
> > > "/proc/printk_formats" may be a binary file.  See it anyway?
> > > vmlinux,^A3Warning: unable to open an initial console.
> > > ^@vmlinux,^A3Failed to execute %s (error %d)
> > > ^@vmlinux,^A6Kernel memory protection disabled.
> > > ^@vmlinux,^A3Starting init: %s exists but couldn't execute it (error %d)
> > > 
> > > 
> > > That is for now. I still have to think about it. And I am also curious
> > > about what others thing about this idea.
> > > 
> > 
> > I'm not against the idea. I don't think it belongs in /proc. Perhaps
> > debugfs is a better place to put it.
> 
> Any location is fine with me, as long as it gets to userspace. How does
> <debugfs>/printk/formats or <debugfs>/printk/formats/<module> sound to you?

That's fine with me, but I'd like to see the patch with this in it first
before approving it :)

thanks,

greg k-h
