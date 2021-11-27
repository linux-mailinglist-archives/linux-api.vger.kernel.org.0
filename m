Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1DA460180
	for <lists+linux-api@lfdr.de>; Sat, 27 Nov 2021 21:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356188AbhK0Uwc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 27 Nov 2021 15:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356189AbhK0Uuc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 27 Nov 2021 15:50:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957DAC06173E;
        Sat, 27 Nov 2021 12:47:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2023F60EBA;
        Sat, 27 Nov 2021 20:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5151AC53FBF;
        Sat, 27 Nov 2021 20:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638046036;
        bh=O4AOA3hg7SG1Jg74rGGBd8CqOtGpbieu02r8pImJFdI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uK4xCSwIbwrQGTBi31USheI5kl20x0nVkVULMI4oObB7oTTQ5V43Ywh2ARwQS6aiM
         j75zETBU7LNKTwwd936o5Y7WlY0ecXvW15CEjOjFBtadzt++x0uDbjD3ojo2vs+qhL
         svu60MJeCrMDE2b927nl0xcL8uqKTq3WiRcu9Q3Tdk+JQvS5z/mkJzu1Lr4bjNHbCY
         fYaqnCWEBDrbRMAwQBCqa9iGulNlebclTWFwIX6RXu5yXh/bHmZ/eYwFY3eXK/sBPK
         8yc0Okuvs3WkIi6lNezRp+77StTzbT4q31aONLkabHNtAOHhwEYP7YqO4Tc0cI6T+2
         gp0tq8EmanVyQ==
Date:   Sat, 27 Nov 2021 12:47:14 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH 3/3] blk-crypto: show crypto capabilities in sysfs
Message-ID: <YaKZUu0tQc8bblmI@sol.localdomain>
References: <20211126212514.173334-1-ebiggers@kernel.org>
 <20211126212514.173334-4-ebiggers@kernel.org>
 <YaH1CmHClx5WvDWD@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaH1CmHClx5WvDWD@kroah.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Greg, thanks for the review!

On Sat, Nov 27, 2021 at 10:06:18AM +0100, Greg KH wrote:
> > diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/queue-sysfs.rst
> > index 3f569d5324857..252939f340459 100644
> > --- a/Documentation/block/queue-sysfs.rst
> > +++ b/Documentation/block/queue-sysfs.rst
> 
> Why is all of this information not in Documentation/ABI/ like the rest
> of the kernel's sysfs information?  When it is there it can be
> automatically tested as well.
> 
> Please don't add new entries to the wrong place if at all possible.

Some of the block queue attributes are documented in
Documentation/ABI/testing/sysfs-block, but Documentation/block/queue-sysfs.rst
seems to be the authoritative source in practice.  I checked all QUEUE_*_ENTRY
in block/blk-sysfs.c, and I got:

- 16 attributes are documented in both places
- 23 attributes are documented in Documentation/block/ only
- 0 attributes are documented in Documentation/ABI/ only
- 2 attributes ("virt_boundary_mask" and "stable_writes") not documented in
  either place

So most block queue attributes are documented only in Documentation/block/.  And
if I added my new attributes to Documentation/ABI/ only, as you're requesting,
they would be the only block queue attributes that would be documented in only
that place.  I think that would make things worse, as then there would be no
authoritative source anymore.

If both you and the block people agree that *all* block queue attributes should
be documented in Documentation/ABI/ only, I'd be glad to send a separate patch
that adds anything missing to Documentation/ABI/testing/sysfs-block, then
removes Documentation/block/queue-sysfs.rst.  (BTW, shouldn't it really be in
Documentation/ABI/stable/?  This ABI has been around a long time, so surely
users are relying on it.)  But it doesn't seem fair to block this patch on that.

> > +static ssize_t blk_crypto_max_dun_bits_show(struct blk_crypto_profile *profile,
> > +					    struct blk_crypto_attr *attr,
> > +					    char *page)
> > +{
> > +	return sprintf(page, "%u\n", 8 * profile->max_dun_bytes_supported);
> 
> sysfs_emit() please, for this, and all other show functions.

Sure.  Note that in .show() functions kernel-wide, it appears that sprintf() is
much more commonly used than sysfs_emit().  Is there any plan to convert these?
As-is, if people use existing code as a reference, it will be "wrong" most of
the time, which is unfortunate.

> > +}
> > +
> > +static ssize_t blk_crypto_num_keyslots_show(struct blk_crypto_profile *profile,
> > +					    struct blk_crypto_attr *attr,
> > +					    char *page)
> > +{
> > +	return sprintf(page, "%u\n", profile->num_slots);
> > +}
> > +
> > +#define BLK_CRYPTO_RO_ATTR(_name)			\
> > +static struct blk_crypto_attr blk_crypto_##_name = {	\
> > +	.attr	= { .name = #_name, .mode = 0444 },	\
> 
> __ATTR_RO()?

Sure.  This would require removing the "blk_crypto_" prefix from the .show()
functions, which I'd prefer to have, but it doesn't really matter.

> > +static const struct attribute_group *blk_crypto_attr_groups[] = {
> > +	&blk_crypto_attr_group,
> > +	&blk_crypto_modes_attr_group,
> > +	NULL,
> > +};
> 
> ATTRIBUTE_GROUP()?
> 
> Hm, maybe not, but I think it could be used here.

ATTRIBUTE_GROUP() doesn't exist; probably you're referring to
ATTRIBUTE_GROUPS()?  ATTRIBUTE_GROUPS() is only usable when there is only one
attribute group.  In this case, there are two attribute groups.

> > +static int __init blk_crypto_sysfs_init(void)
> > +{
> > +	int i;
> > +
> > +	BUILD_BUG_ON(BLK_ENCRYPTION_MODE_INVALID != 0);
> > +	for (i = 1; i < BLK_ENCRYPTION_MODE_MAX; i++) {
> > +		struct blk_crypto_attr *attr = &__blk_crypto_mode_attrs[i];
> 
> sysfs_attr_init() might be needed here, have you run with lockdep
> enabled?

It's not needed because __blk_crypto_mode_attrs isn't dynamically allocated
memory.  Yes, I've run with lockdep enabled.

- Eric
