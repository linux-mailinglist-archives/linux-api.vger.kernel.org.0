Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E15B27B355
	for <lists+linux-api@lfdr.de>; Mon, 28 Sep 2020 19:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgI1RfY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Sep 2020 13:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgI1RfX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Sep 2020 13:35:23 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E26C061755;
        Mon, 28 Sep 2020 10:35:23 -0700 (PDT)
Received: from zn.tnic (p200300ec2f072200163fab7f7d674efc.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:2200:163f:ab7f:7d67:4efc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9B0441EC02E6;
        Mon, 28 Sep 2020 19:35:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601314520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WbkRGMcHOzgWAfzMvo2jeQ+oAxhJlxu+eHh38TdzE4E=;
        b=jR8n4DIGYDB0pG2ql/9oa/0Q4IsPzkQ2N0750m+hiVJDkofk7IkYDHDLrzcZh6/1y5voJM
        B9v+bNGym/IdAzjPw5jxOXvK1w3biDCCXbQdLBGoxk1Douctth3BsO6ZC93k+SuXBQ9vqb
        H4blBMdIrfYxSC8D+drDKN80zXuLSfw=
Date:   Mon, 28 Sep 2020 19:35:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
Subject: Re: [PATCH v11 2/6] x86: Support Generic Initiator only proximity
 domains
Message-ID: <20200928173513.GG1685@zn.tnic>
References: <20200928125235.446188-1-Jonathan.Cameron@huawei.com>
 <20200928125235.446188-3-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200928125235.446188-3-Jonathan.Cameron@huawei.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Sep 28, 2020 at 08:52:31PM +0800, Jonathan Cameron wrote:
> In common with memoryless domains we only register GI domains
				   ^^^^

> if the proximity node is not online. If a domain is already
> a memory containing domain, or a memoryless domain there is
> nothing to do just because it also contains a Generic Initiator.

...

> +/*
> + * A node may exist which has one or more Generic Initiators but no CPUs and no
> + * memory.
> + *
> + * This function must be called after init_cpu_to_node() to ensure that we have
									  ^^^

You love that "we". :)

Pls use passive voice in your commit message: no "we" or "I", etc, and
describe your changes in imperative mood.

Also, pls read section "2) Describe your changes" in
Documentation/process/submitting-patches.rst for more details.

Bottom line is: personal pronouns are ambiguous in text, especially with
so many parties/companies/etc developing the kernel so let's avoid them
please.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
