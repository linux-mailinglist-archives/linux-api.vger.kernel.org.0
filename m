Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A727E278DA4
	for <lists+linux-api@lfdr.de>; Fri, 25 Sep 2020 18:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgIYQI2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 25 Sep 2020 12:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbgIYQI2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 25 Sep 2020 12:08:28 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AA8C0613CE;
        Fri, 25 Sep 2020 09:08:27 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0b3a00329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:3a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C49621EC0284;
        Fri, 25 Sep 2020 18:08:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601050104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=eqBo++0bLNLcrE7VXscLCEz7howWeoc6lAOi3PzLORk=;
        b=CRXaAJ/lHqqbjXX2EAfkl4LJ5fcoibyKjIKgvZyIkMi5tDvJcPiYVH4BR4J8TIS5r++kSI
        00rKHSFQJ9i1M1sBEDC3bErbdmdbKqII/es2WtrnoNvfYPOrqlRC4gfCkBiBGmH/cM8VKm
        U8lDy27jIA6cZrQNNLxRAfDl0XzDYQ0=
Date:   Fri, 25 Sep 2020 18:08:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-mm@kvack.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        rafael@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linuxarm@huawei.com, Dan Williams <dan.j.williams@intel.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Sean V Kelley <sean.v.kelley@linux.intel.com>,
        linux-api@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v10 2/6] x86: Support Generic Initiator only proximity
 domains
Message-ID: <20200925160817.GJ16872@zn.tnic>
References: <20200907140307.571932-1-Jonathan.Cameron@huawei.com>
 <20200907140307.571932-3-Jonathan.Cameron@huawei.com>
 <20200923160609.GO28545@zn.tnic>
 <20200925123226.0000636a@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200925123226.0000636a@Huawei.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Sep 25, 2020 at 12:32:26PM +0100, Jonathan Cameron wrote:
> I don't think we can.  This is doing the same operation as
> is done for memoryless cpu nodes in the init_cpu_to_node() call above
> so it would make little sense from a code flow point of view, even if
> it were possible.  However it isn't possible as far as I can see.
> 
> It is called after init_cpu_to_node() because...
> * A GI node may also be a CPU node and / or a Memory Node, but we only
>   have to do anything extra if it has neither of these.
>   Easiest way to do that is use the same logic init_cpu_to_node() 
>   does and rely on ordering wrt to the other two types of nodes that
>   have already been handled.  We could have could just call it at the
>   end of init_cpu_to_node() but I'd not be happy doing so without renaming
>   that function and then we'd end up with a horrible name like
>   init_cpu_to_node_and_gi() as they are rather different things.
> 
> It needs to happen before use is made of the node_data which is allocated
> in init_gi_nodes() / init_memoryless_node() / alloc_node_data()

Let's put the gist of this requirement in the comment above
init_gi_nodes() for future reference.

...

> It might be possible to allocate the zonelists for this special case later
> in the boot flow, but it seems like we would be adding a lot of complexity
> to avoid a single function call.

Nah, probably not worth the hassle.

> How about this?
> 
> +/*
> + * A node may exist which has one or more Generic Initiators but no
> + * CPUs and no memory.
> + * When this function is called, any nodes containing either memory
> + * and/or CPUs will already be online and there is no need to do
> + * anything extra, even if they also contain one or more Generic
> + * Initiators.
> + */

Yes, along with the above gist.

Thx!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
