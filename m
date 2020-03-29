Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC622196B9E
	for <lists+linux-api@lfdr.de>; Sun, 29 Mar 2020 09:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgC2HXJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 29 Mar 2020 03:23:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbgC2HXJ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sun, 29 Mar 2020 03:23:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9057320748;
        Sun, 29 Mar 2020 07:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585466588;
        bh=pYRVbuBb5qkU8mIDMvM9P+PnyRnhYJ9Ioj9Q4SdIUHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hhw84d8vq304G7LOdUQ6QR19pDWmynfURj4cOG9t45qWXx4SOoGzVzxayBlFOCnlh
         YH3NtgjpA8FmgQkMtVpKHdT7ji3D5tjWqm8bqJtENK90x44zSDo0BncPyghfsFXJcG
         8F3zGY3mZBTBlCHqp/Hy/u0s28idN2z10A6t0LY0=
Date:   Sun, 29 Mar 2020 09:23:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jaewon Kim <jaewon31.kim@samsung.com>, vbabka@suse.cz,
        adobriyan@gmail.com, akpm@linux-foundation.org, labbott@redhat.com,
        sumit.semwal@linaro.org, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, kasong@redhat.com,
        bhe@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, linux-api@vger.kernel.org,
        kexec@lists.infradead.org
Subject: Re: [RFC PATCH v2 1/3] meminfo_extra: introduce meminfo extra
Message-ID: <20200329072304.GA3909421@kroah.com>
References: <20200323080503.6224-1-jaewon31.kim@samsung.com>
 <CGME20200323080508epcas1p387c9c19b480da53be40fe5d51e76a477@epcas1p3.samsung.com>
 <20200323080503.6224-2-jaewon31.kim@samsung.com>
 <20200323095344.GB425358@kroah.com>
 <5E79CEB5.8070308@samsung.com>
 <20200324101110.GA2218981@kroah.com>
 <5E79F102.9080405@samsung.com>
 <20200324114645.GA2330984@kroah.com>
 <5E7A02BC.7020803@samsung.com>
 <20200329071907.GB2454444@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200329071907.GB2454444@unreal>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Mar 29, 2020 at 10:19:07AM +0300, Leon Romanovsky wrote:
> On Tue, Mar 24, 2020 at 09:53:16PM +0900, Jaewon Kim wrote:
> >
> >
> > On 2020년 03월 24일 20:46, Greg KH wrote:
> > > On Tue, Mar 24, 2020 at 08:37:38PM +0900, Jaewon Kim wrote:
> > >>
> > >> On 2020년 03월 24일 19:11, Greg KH wrote:
> > >>> On Tue, Mar 24, 2020 at 06:11:17PM +0900, Jaewon Kim wrote:
> > >>>> On 2020년 03월 23일 18:53, Greg KH wrote:
> > >>>>>> +int register_meminfo_extra(atomic_long_t *val, int shift, const char *name)
> > >>>>>> +{
> > >>>>>> +	struct meminfo_extra *meminfo, *memtemp;
> > >>>>>> +	int len;
> > >>>>>> +	int error = 0;
> > >>>>>> +
> > >>>>>> +	meminfo = kzalloc(sizeof(*meminfo), GFP_KERNEL);
> > >>>>>> +	if (!meminfo) {
> > >>>>>> +		error = -ENOMEM;
> > >>>>>> +		goto out;
> > >>>>>> +	}
> > >>>>>> +
> > >>>>>> +	meminfo->val = val;
> > >>>>>> +	meminfo->shift_for_page = shift;
> > >>>>>> +	strncpy(meminfo->name, name, NAME_SIZE);
> > >>>>>> +	len = strlen(meminfo->name);
> > >>>>>> +	meminfo->name[len] = ':';
> > >>>>>> +	strncpy(meminfo->name_pad, meminfo->name, NAME_BUF_SIZE);
> > >>>>>> +	while (++len < NAME_BUF_SIZE - 1)
> > >>>>>> +		meminfo->name_pad[len] = ' ';
> > >>>>>> +
> > >>>>>> +	spin_lock(&meminfo_lock);
> > >>>>>> +	list_for_each_entry_rcu(memtemp, &meminfo_head, list) {
> > >>>>>> +		if (memtemp->val == val) {
> > >>>>>> +			error = -EINVAL;
> > >>>>>> +			break;
> > >>>>>> +		}
> > >>>>>> +	}
> > >>>>>> +	if (!error)
> > >>>>>> +		list_add_tail_rcu(&meminfo->list, &meminfo_head);
> > >>>>>> +	spin_unlock(&meminfo_lock);
> > >>>>> If you have a lock, why are you needing rcu?
> > >>>> I think _rcu should be removed out of list_for_each_entry_rcu.
> > >>>> But I'm confused about what you meant.
> > >>>> I used rcu_read_lock on __meminfo_extra,
> > >>>> and I think spin_lock is also needed for addition and deletion to handle multiple modifiers.
> > >>> If that's the case, then that's fine, it just didn't seem like that was
> > >>> needed.  Or I might have been reading your rcu logic incorrectly...
> > >>>
> > >>>>>> +	if (error)
> > >>>>>> +		kfree(meminfo);
> > >>>>>> +out:
> > >>>>>> +
> > >>>>>> +	return error;
> > >>>>>> +}
> > >>>>>> +EXPORT_SYMBOL(register_meminfo_extra);
> > >>>>> EXPORT_SYMBOL_GPL()?  I have to ask :)
> > >>>> I can use EXPORT_SYMBOL_GPL.
> > >>>>> thanks,
> > >>>>>
> > >>>>> greg k-h
> > >>>>>
> > >>>>>
> > >>>> Hello
> > >>>> Thank you for your comment.
> > >>>>
> > >>>> By the way there was not resolved discussion on v1 patch as I mentioned on cover page.
> > >>>> I'd like to hear your opinion on this /proc/meminfo_extra node.
> > >>> I think it is the propagation of an old and obsolete interface that you
> > >>> will have to support for the next 20+ years and yet not actually be
> > >>> useful :)
> > >>>
> > >>>> Do you think this is meaningful or cannot co-exist with other future
> > >>>> sysfs based API.
> > >>> What sysfs-based API?
> > >> Please refer to mail thread on v1 patch set - https://protect2.fireeye.com/url?k=16e3accc-4b2f6548-16e22783-0cc47aa8f5ba-935fe828ac2f6656&u=https://lkml.org/lkml/fancy/2020/3/10/2102
> > >> especially discussion with Leon Romanovsky on https://protect2.fireeye.com/url?k=74208ed9-29ec475d-74210596-0cc47aa8f5ba-0bd4ef48931fec95&u=https://lkml.org/lkml/fancy/2020/3/16/140
> > > I really do not understand what you are referring to here, sorry.   I do
> > > not see any sysfs-based code in that thread.
> > Sorry. I also did not see actual code.
> > Hello Leon Romanovsky, could you elaborate your plan regarding sysfs stuff?
> 
> Sorry for being late, I wasn't in "TO:", so missed the whole discussion.
> 
> Greg,
> 
> We need the exposed information for the memory optimizations (debug, not
> production) of our high speed NICs. Our devices (mlx5) allocates a lot of
> memory, so optimization there can help us to scale in SRIOV mode easier and
> be less constraint by the memory.

Great, then use debugfs and expose what ever you want in what ever way
you want, no restrictions there, you do not need any type of kernel-wide
/proc file for that today.

> I want to emphasize that I don't like idea of extending /proc/* interface
> because it is going to be painful to grep on large machines with many
> devices. And I don't like the idea that every driver will need to register
> into this interface, because it will be abused almost immediately.

I agree.

> My proposal was to create new sysfs file by driver/core and put all
> information automatically there, for example, it can be
> /sys/devices/pci0000:00/0000:00:0c.0/meminfo
>                                      ^^^^^^^

Nope, again, use debugfs, as sysfs is only one-value-per-file.

thanks,

greg k-h
