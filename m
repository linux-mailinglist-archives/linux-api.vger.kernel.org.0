Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654CB3124DE
	for <lists+linux-api@lfdr.de>; Sun,  7 Feb 2021 15:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhBGO7N (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 7 Feb 2021 09:59:13 -0500
Received: from smtprelay0006.hostedemail.com ([216.40.44.6]:54892 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229510AbhBGO7N (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 7 Feb 2021 09:59:13 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 8C381182CED28;
        Sun,  7 Feb 2021 14:58:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:2:41:355:379:599:960:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1593:1594:1605:1606:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:2892:3138:3139:3140:3141:3142:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:4117:4250:4321:4470:5007:6119:6691:6742:7652:7875:7903:10004:11026:11232:11473:11658:11783:11914:12296:12297:12438:12740:12895:13161:13163:13229:13439:13869:13894:14659:21063:21080:21324:21325:21433:21524:21611:21627:21740:30005:30012:30054:30070:30075:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: beam97_1802bb2275f6
X-Filterd-Recvd-Size: 6640
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Sun,  7 Feb 2021 14:58:29 +0000 (UTC)
Message-ID: <bd53d894b7bb0fcaa520282a04a6487828282695.camel@perches.com>
Subject: Re: [PATCH] printk: Userspace format enumeration support
From:   Joe Perches <joe@perches.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Baron <jbaron@akamai.com>,
        Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org
Date:   Sun, 07 Feb 2021 06:58:28 -0800
In-Reply-To: <YB/1iHwwTi9dOv38@chrisdown.name>
References: <YBwU0G+P0vb9wTwm@chrisdown.name> <YB11jybvFCb95S9e@alley>
         <YB3Fwh827m0F+y3n@chrisdown.name>
         <49124db60cdc88c4e9fcca1bbc9767432ad5a93b.camel@perches.com>
         <YB8IcCqOJA7vzqiJ@chrisdown.name>
         <dc6cf90d978e012b0d698a698935d526ca4b0a1c.camel@perches.com>
         <YB/1iHwwTi9dOv38@chrisdown.name>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, 2021-02-07 at 14:13 +0000, Chris Down wrote:
> Joe Perches writes:
> > > There are certainly printks which can't be trivially monitored using the printk
> > > format alone, but the vast majority of the ones that are monitored _do_ have
> > > meaningful formats and can be monitored over time. No solution to this is going
> > > to catch every single case, especially when so much of the information can be
> > > generated dyamically, but this patchset still goes a long way to making printk
> > > monitoring more tractable for use cases like the one described in the
> > > changelog.
> > 
> > For the _vast_ majority of printk strings, this can easily be found
> > and compared using a trivial modification to strings.
> 
> There are several issues with your proposed approach that make it unsuitable 
> for use as part of a reliable production environment:
> 
> 1. It misses printk() formats without KERN_SOH
> 
> printk() formats without KERN_SOH are legal and use MESSAGE_LOGLEVEL_DEFAULT.  
> On my test kernel, your proposed patch loses >5% of printk formats -- over 200 
> messages -- due to this, including critical ones like those about hardware or 
> other errors.

There are _very_ few of those printks without KERN_<level> and those
very few are not generally being changed.

> 2. Users don't always have the kernel image available
> 
> Many of our machines and many of the machines of others like us do not boot 
> using local storage, but instead use PXE or other technologies where the kernel 
> may not be stored during runtime.
> 
> As is described in the changelog, it is necessary to be able to vary 
> remediations not only based on what is already in /dev/kmsg, but also to be 
> able to make decisions about our methodology based on what's _supported_ in the 
> running kernel at runtime, and your proposed approach makes this not viable.

Indirection would alway work.

You could load a separate file with output strings along with your
kernel image.

> 3. `KERN_SOH + level' can appear in other places than just printk strings
> 
> KERN_SOH is just ASCII '\001' -- it's not distinctive or unique, even when 
> paired with a check for something that looks like a level after it. For this 
> reason, your proposed patch results in a non-trivial amount of non-printk 
> related garbage in its output. For example:
> 
>      % binutils/strings -k /tmp/vmlinux | head -5
>      3L)s
>      3L)s
>      c,[]A\
>      c(L)c
>      d$pL)d$`u4
> 
> Fundamentally, one cannot use a tool which just determines whether something is 
> printable to determine semantic intent.

$ kernel_strings --kernel --section ".rodata" vmlinux

I got exactly 0.

> 4. strings(1) output cannot differentiate embedded newlines and new formats
> 
> The following has exactly the same output from strings(1), but will manifest 
> completely differently at printk() time:
> 
>      printk(KERN_ERR "line one\nline two\nline three\n");
>      printk("line four\n");

This is not the preferred output style and is only done in old and
unchanging code.

Your use case in your commit log is looking for _changed_ formats.

On Thu, 2021-02-04 at 15:37 +0000, Chris Down wrote:
> This patch provides a solution to the issue of silently changed or
> deleted printks:

Exactly _how_ many of these use cases do you think exist?

The generally preferred style for the example above would be:

	pr_err("line one\n");
	pr_err("line two\n");
	pr_err("line three\n");
	pr_err("line four\n");

> The originally posted patch _does_ differentiate between these cases, using \0 
> as a reliable separator. Its outputs are, respectively:
> 
>      \0013line one\nline two\nline three\0\nline four\n\0
>      \0013line one\nline two\n\0line three\nline four\n\0
> 
> This isn't just a theoretical concern -- there are plenty of places which use 
> multiline printks, and we must be able to distinguish between that and 
> _multiple_ printks.

Just like there are many places that use buffered printks as the
example I gave earlier.  None of which your proposed solution would find.

> 5. strings(1) is not contextually aware, and cannot be made to act as if it is
> 
> strings has no idea about what it is reading, which is why it is more than 
> happy to output the kind of meaningless output shown in #3. There are plenty of 
> places across the kernel where there might be a sequence of bytes which the 
> strings utility happens to interpret as being semantically meaningful, but in 
> reality just happens to be an unrelated sequence of coincidentally printable 
> bytes that just happens to contain a \001.
> 
> I appreciate your willingness to propose other solutions, but for these 
> reasons, the proposed strings(1) patch would not suffice as an interface for 
> printk enumeration.

I think you are on a path to try to make printk output immutable.
I think that's a _very_ bad path.

I also think this is adding needless complexity.

A possible complexity I would like to support would be optionally
compressing printk format strings at compile time and uncompressing
them at use time.


