Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E778719106E
	for <lists+linux-api@lfdr.de>; Tue, 24 Mar 2020 14:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgCXN2H (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Mar 2020 09:28:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727323AbgCXN2G (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 24 Mar 2020 09:28:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E829820775;
        Tue, 24 Mar 2020 13:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585056485;
        bh=56ZiM9ngvtgpS2+CpoNQGLLWww2zfE2Ii5Pgd1jL4ik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kIOfe6Br65Xs59Evt70ByRdrV7WuFJOQ6DUWcvyDT7UNBqPiicHp/2fFjVvNEpFkY
         k7JfI8sMjCV7Mb1JHW/54/PZPGCu2puvRHh9STZHIroFdZh1GRHer8ErOufuASvlGT
         i4T/jw2pCZl7Z2jAKUmnbEyXjQikYJu2k3LG03Mo=
Date:   Tue, 24 Mar 2020 14:19:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     leon@kernel.org, vbabka@suse.cz, adobriyan@gmail.com,
        akpm@linux-foundation.org, labbott@redhat.com,
        sumit.semwal@linaro.org, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, kasong@redhat.com,
        bhe@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, linux-api@vger.kernel.org,
        kexec@lists.infradead.org
Subject: Re: [RFC PATCH v2 1/3] meminfo_extra: introduce meminfo extra
Message-ID: <20200324131916.GA2500287@kroah.com>
References: <20200323080503.6224-1-jaewon31.kim@samsung.com>
 <CGME20200323080508epcas1p387c9c19b480da53be40fe5d51e76a477@epcas1p3.samsung.com>
 <20200323080503.6224-2-jaewon31.kim@samsung.com>
 <20200323095344.GB425358@kroah.com>
 <5E79CEB5.8070308@samsung.com>
 <20200324101110.GA2218981@kroah.com>
 <5E79F102.9080405@samsung.com>
 <20200324114645.GA2330984@kroah.com>
 <5E7A02BC.7020803@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5E7A02BC.7020803@samsung.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Mar 24, 2020 at 09:53:16PM +0900, Jaewon Kim wrote:
> 
> 
> On 2020년 03월 24일 20:46, Greg KH wrote:
> > On Tue, Mar 24, 2020 at 08:37:38PM +0900, Jaewon Kim wrote:
> >>
> >> On 2020년 03월 24일 19:11, Greg KH wrote:
> >>> On Tue, Mar 24, 2020 at 06:11:17PM +0900, Jaewon Kim wrote:
> >>>> On 2020년 03월 23일 18:53, Greg KH wrote:
> >>>>>> +int register_meminfo_extra(atomic_long_t *val, int shift, const char *name)
> >>>>>> +{
> >>>>>> +	struct meminfo_extra *meminfo, *memtemp;
> >>>>>> +	int len;
> >>>>>> +	int error = 0;
> >>>>>> +
> >>>>>> +	meminfo = kzalloc(sizeof(*meminfo), GFP_KERNEL);
> >>>>>> +	if (!meminfo) {
> >>>>>> +		error = -ENOMEM;
> >>>>>> +		goto out;
> >>>>>> +	}
> >>>>>> +
> >>>>>> +	meminfo->val = val;
> >>>>>> +	meminfo->shift_for_page = shift;
> >>>>>> +	strncpy(meminfo->name, name, NAME_SIZE);
> >>>>>> +	len = strlen(meminfo->name);
> >>>>>> +	meminfo->name[len] = ':';
> >>>>>> +	strncpy(meminfo->name_pad, meminfo->name, NAME_BUF_SIZE);
> >>>>>> +	while (++len < NAME_BUF_SIZE - 1)
> >>>>>> +		meminfo->name_pad[len] = ' ';
> >>>>>> +
> >>>>>> +	spin_lock(&meminfo_lock);
> >>>>>> +	list_for_each_entry_rcu(memtemp, &meminfo_head, list) {
> >>>>>> +		if (memtemp->val == val) {
> >>>>>> +			error = -EINVAL;
> >>>>>> +			break;
> >>>>>> +		}
> >>>>>> +	}
> >>>>>> +	if (!error)
> >>>>>> +		list_add_tail_rcu(&meminfo->list, &meminfo_head);
> >>>>>> +	spin_unlock(&meminfo_lock);
> >>>>> If you have a lock, why are you needing rcu?
> >>>> I think _rcu should be removed out of list_for_each_entry_rcu.
> >>>> But I'm confused about what you meant.
> >>>> I used rcu_read_lock on __meminfo_extra,
> >>>> and I think spin_lock is also needed for addition and deletion to handle multiple modifiers.
> >>> If that's the case, then that's fine, it just didn't seem like that was
> >>> needed.  Or I might have been reading your rcu logic incorrectly...
> >>>
> >>>>>> +	if (error)
> >>>>>> +		kfree(meminfo);
> >>>>>> +out:
> >>>>>> +
> >>>>>> +	return error;
> >>>>>> +}
> >>>>>> +EXPORT_SYMBOL(register_meminfo_extra);
> >>>>> EXPORT_SYMBOL_GPL()?  I have to ask :)
> >>>> I can use EXPORT_SYMBOL_GPL.
> >>>>> thanks,
> >>>>>
> >>>>> greg k-h
> >>>>>
> >>>>>
> >>>> Hello
> >>>> Thank you for your comment.
> >>>>
> >>>> By the way there was not resolved discussion on v1 patch as I mentioned on cover page.
> >>>> I'd like to hear your opinion on this /proc/meminfo_extra node.
> >>> I think it is the propagation of an old and obsolete interface that you
> >>> will have to support for the next 20+ years and yet not actually be
> >>> useful :)
> >>>
> >>>> Do you think this is meaningful or cannot co-exist with other future
> >>>> sysfs based API.
> >>> What sysfs-based API?
> >> Please refer to mail thread on v1 patch set - https://protect2.fireeye.com/url?k=16e3accc-4b2f6548-16e22783-0cc47aa8f5ba-935fe828ac2f6656&u=https://lkml.org/lkml/fancy/2020/3/10/2102
> >> especially discussion with Leon Romanovsky on https://protect2.fireeye.com/url?k=74208ed9-29ec475d-74210596-0cc47aa8f5ba-0bd4ef48931fec95&u=https://lkml.org/lkml/fancy/2020/3/16/140
> > I really do not understand what you are referring to here, sorry.   I do
> > not see any sysfs-based code in that thread.
> Sorry. I also did not see actual code.
> Hello Leon Romanovsky, could you elaborate your plan regarding sysfs stuff?
> >
> > And try to use lore.kernel.org, lkml.org doesn't always work and we have
> > no control over that :(
> >
> >>> I still don't know _why_ you want this.  The ION stuff is not needed as
> >>> that code is about to be deleted, so who else wants this?  What is the
> >>> use-case for it that is so desperately needed that parsing
> >>> yet-another-proc file is going to solve the problem?
> >> In my Android device, there are graphic driver memory, zsmalloc memory except ION.
> > Ok, so what does Android have to do with this?
> Some driver in Android platform may use my API to show its memory usage.

I do not understand what this means.

> >> I don't know other cases in other platform.
> >> Not desperately needed but I think we need one userspace knob to see overall hidden huge memory.
> > Why?  Who wants that?  What would userspace do with that?  And what
> > exactly do you want to show?
> >
> > Is this just a debugging thing?  Then use debugfs for that, not proc.
> > Isn't that what the DRM developers are starting to do?
> >
> >> Additionally I'd like to see all those hidden memory in OutOfMemory log.
> > How is anything hidden, can't you see it in the slab information?
> >
> Let me explain more.
> 
> 0. slab
> As I said in cover page, this is not for memory allocated by slab.

Great, then have the subsystem that allocates such memory, be the thing
that exports the information.  Drivers "on their own" do not grab any
memory without asking for it from other parts of the kernel.

Modify those "other parts", this isn't a driver-specific thing at all.

So, what "other parts" are involved here?

> I'd like to know where huge memory has gone.
> Those are directly allocated by alloc_pages instead of slab.
> /proc/slabinfo does not show this information.

Why isn't alloc_pages information exported anywhere?  Work on that.

> 1. /proc/meminfo_extra
> /proc/meminfo_extra could be debugging thing to see memory status at a certain time.

If it is debugging, then use debugfs.

> But it, I think, is also basic information rather than just for debugging.

Who would use that information for anything except debugging?

> It is similar with /proc/meminfo which is in procfs instead of debugfs.

meminfo is older than debugfs and sysfs, can't change that today.

> 2. oom log
> oom log in show_mem is more than just debugging.

Why?  Who sees this?

> As existing oom log shows much memory information, I think we need the hidden memory info.
> Without these information, we do NOT know oom reason because other traditional stats are not enough.

Why not?  Kernel users of memory shouldn't be triggering OOM events.


> >> This is useful to get clue to find memory hogger.
> >> i.e.) show_mem on oom
> >> <6>[  420.856428]  Mem-Info:
> >> <6>[  420.856433]  IonSystemHeap:32813kB ZsPages:44114kB GraphicDriver::13091kB
> >> <6>[  420.856450]  active_anon:957205 inactive_anon:159383 isolated_anon:0
> > So what does this show you?  That someone is takign a ton of ION memory
> > for some unknown use?  What can you do with that?  What would you do
> > with that?
> We may not know exact memory owner. But we can narrow down.
> Anyway I think this is meaningful instead of no clue.

Again, work on the subsystems that actually allocate the memory, not
drivers.  And if you want to mess with drivers, do it in a
device-specific way, not a driver-specific way.

> > And memory is almost never assigned to a "driver", it is assigned to a
> > "device" that uses it.  Drivers can handle multiple devices at the same
> > time, so why would you break this down by drivers?  Are you assuming
> > that a driver only talks to one piece of hardware?
> Yes a driver may support several devices. I don't know if it same on an embedded device.

Why wouldn't it be?  Is this new interface somehow only acceptable for
systems with one-device-per-driver?  If so, that's not going to work at
all.

> Anyway I think the idea works even for several devices, although the driver should
> distinguish memory usage for each device and should register each memory stat.

And how would that happen?

thanks,

greg k-h
