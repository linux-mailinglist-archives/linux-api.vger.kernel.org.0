Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9313B460545
	for <lists+linux-api@lfdr.de>; Sun, 28 Nov 2021 09:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344752AbhK1ITv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 28 Nov 2021 03:19:51 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44782 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356950AbhK1IRu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 28 Nov 2021 03:17:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EBF6B80B5F;
        Sun, 28 Nov 2021 08:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3F1C004E1;
        Sun, 28 Nov 2021 08:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638087272;
        bh=39xPZMfe1ibuiHjcR8GPwApROOOXNw4PxPfnXkQy+GA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bTVi1qpOMK3snj3/5ngTGJBwNOtzVHs6mmhM7bpLN2Ylw7BStAeJBwg+ljnNqImWZ
         GJF0n6LGABUqLnff6dpEUz3OopAoWIvmyR+6cd/4B3EaStgj6mJ/iqaWRy/CM3Fh7s
         YIqq4s/fj/XxocPyvN10jawk/Ii1e5eiWoNokMBg=
Date:   Sun, 28 Nov 2021 09:14:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH 3/3] blk-crypto: show crypto capabilities in sysfs
Message-ID: <YaM6ZJUByYXaI3/X@kroah.com>
References: <20211126212514.173334-1-ebiggers@kernel.org>
 <20211126212514.173334-4-ebiggers@kernel.org>
 <YaH1CmHClx5WvDWD@kroah.com>
 <YaKZUu0tQc8bblmI@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaKZUu0tQc8bblmI@sol.localdomain>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Nov 27, 2021 at 12:47:14PM -0800, Eric Biggers wrote:
> Hi Greg, thanks for the review!
> 
> On Sat, Nov 27, 2021 at 10:06:18AM +0100, Greg KH wrote:
> > > diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/queue-sysfs.rst
> > > index 3f569d5324857..252939f340459 100644
> > > --- a/Documentation/block/queue-sysfs.rst
> > > +++ b/Documentation/block/queue-sysfs.rst
> > 
> > Why is all of this information not in Documentation/ABI/ like the rest
> > of the kernel's sysfs information?  When it is there it can be
> > automatically tested as well.
> > 
> > Please don't add new entries to the wrong place if at all possible.
> 
> Some of the block queue attributes are documented in
> Documentation/ABI/testing/sysfs-block, but Documentation/block/queue-sysfs.rst
> seems to be the authoritative source in practice.  I checked all QUEUE_*_ENTRY
> in block/blk-sysfs.c, and I got:
> 
> - 16 attributes are documented in both places
> - 23 attributes are documented in Documentation/block/ only
> - 0 attributes are documented in Documentation/ABI/ only
> - 2 attributes ("virt_boundary_mask" and "stable_writes") not documented in
>   either place
> 
> So most block queue attributes are documented only in Documentation/block/.  And
> if I added my new attributes to Documentation/ABI/ only, as you're requesting,
> they would be the only block queue attributes that would be documented in only
> that place.  I think that would make things worse, as then there would be no
> authoritative source anymore.

I agree, it should all move to the proper location in Documentation/ABI/
as that is where all sysfs attributes need to be documented.  Block
queues are not special here.

> If both you and the block people agree that *all* block queue attributes should
> be documented in Documentation/ABI/ only, I'd be glad to send a separate patch
> that adds anything missing to Documentation/ABI/testing/sysfs-block, then
> removes Documentation/block/queue-sysfs.rst.  (BTW, shouldn't it really be in
> Documentation/ABI/stable/?  This ABI has been around a long time, so surely
> users are relying on it.)  But it doesn't seem fair to block this patch on that.

"stable" is fine with me, people abuse "testing" by throwing everything
into it.

> 
> > > +static ssize_t blk_crypto_max_dun_bits_show(struct blk_crypto_profile *profile,
> > > +					    struct blk_crypto_attr *attr,
> > > +					    char *page)
> > > +{
> > > +	return sprintf(page, "%u\n", 8 * profile->max_dun_bytes_supported);
> > 
> > sysfs_emit() please, for this, and all other show functions.
> 
> Sure.  Note that in .show() functions kernel-wide, it appears that sprintf() is
> much more commonly used than sysfs_emit().  Is there any plan to convert these?
> As-is, if people use existing code as a reference, it will be "wrong" most of
> the time, which is unfortunate.

Doing a wholesale replacement across the kernel is a pain and disruptive
and not really needed.  But for all new code, please use the new
functions.  If you want to convert your driver/subsystem to the new
functions, no objection from me!

> > > +}
> > > +
> > > +static ssize_t blk_crypto_num_keyslots_show(struct blk_crypto_profile *profile,
> > > +					    struct blk_crypto_attr *attr,
> > > +					    char *page)
> > > +{
> > > +	return sprintf(page, "%u\n", profile->num_slots);
> > > +}
> > > +
> > > +#define BLK_CRYPTO_RO_ATTR(_name)			\
> > > +static struct blk_crypto_attr blk_crypto_##_name = {	\
> > > +	.attr	= { .name = #_name, .mode = 0444 },	\
> > 
> > __ATTR_RO()?
> 
> Sure.  This would require removing the "blk_crypto_" prefix from the .show()
> functions, which I'd prefer to have, but it doesn't really matter.

Ah, you are right, but I think using the default macros sometimes can be
nicer as they are easier to verify you are doing things correctly.

> > > +static const struct attribute_group *blk_crypto_attr_groups[] = {
> > > +	&blk_crypto_attr_group,
> > > +	&blk_crypto_modes_attr_group,
> > > +	NULL,
> > > +};
> > 
> > ATTRIBUTE_GROUP()?
> > 
> > Hm, maybe not, but I think it could be used here.
> 
> ATTRIBUTE_GROUP() doesn't exist; probably you're referring to
> ATTRIBUTE_GROUPS()?  ATTRIBUTE_GROUPS() is only usable when there is only one
> attribute group.  In this case, there are two attribute groups.

You are right, sorry.

> > > +static int __init blk_crypto_sysfs_init(void)
> > > +{
> > > +	int i;
> > > +
> > > +	BUILD_BUG_ON(BLK_ENCRYPTION_MODE_INVALID != 0);
> > > +	for (i = 1; i < BLK_ENCRYPTION_MODE_MAX; i++) {
> > > +		struct blk_crypto_attr *attr = &__blk_crypto_mode_attrs[i];
> > 
> > sysfs_attr_init() might be needed here, have you run with lockdep
> > enabled?
> 
> It's not needed because __blk_crypto_mode_attrs isn't dynamically allocated
> memory.  Yes, I've run with lockdep enabled.

Ok, good, just checking.

thanks,

greg k-h
