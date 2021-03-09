Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBEA23328A8
	for <lists+linux-api@lfdr.de>; Tue,  9 Mar 2021 15:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbhCIOcT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 9 Mar 2021 09:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhCIObs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 9 Mar 2021 09:31:48 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DD6C06174A;
        Tue,  9 Mar 2021 06:31:47 -0800 (PST)
Received: from zn.tnic (p200300ec2f0d1e00ce22ef39451b66b4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1e00:ce22:ef39:451b:66b4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 43D5A1EC0258;
        Tue,  9 Mar 2021 15:31:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1615300306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4yMmDfex6l/3uuKHORT/h+heZ1g31xJwUPhoiGfiMXU=;
        b=o/B6zf5F47HzYEdAj4BQZZE1lthxUvFBAXglcCXUnDfHLCL1mnAk85g0hb/uWwLhxKJrx6
        aPbZGoSPgBVXsIt9dUx/VkgK2Q7EahqT2sSFGqz3yJk/trsX5b8F7SR5EtZ5DDP8TZkYCP
        7DhwJ3LMYUUyfEnymktu364C8jp4ApU=
Date:   Tue, 9 Mar 2021 15:31:41 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Cc:     linux-man@vger.kernel.org,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 2/2] sigaction.2: wfix - Clarify si_addr description.
Message-ID: <20210309143141.GD699@zn.tnic>
References: <20210226172634.26905-1-yu-cheng.yu@intel.com>
 <20210226172634.26905-3-yu-cheng.yu@intel.com>
 <20210308212936.GD12548@zn.tnic>
 <40c3c4cc-e135-1355-51ee-4d0f16e47e71@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <40c3c4cc-e135-1355-51ee-4d0f16e47e71@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Mar 08, 2021 at 01:46:07PM -0800, Yu, Yu-cheng wrote:
> I think the sentence above is vague, but probably for the reason that each
> arch is different.  Maybe this patch is unnecessary and can be dropped?

Maybe.

If you want to clarify it, you should audit every arch. But what
would that bring? IOW, is it that important to specify when si_addr
is populated and when not...? I don't know of an example but I'm
no userspace programmer anyway, to know when this info would be
beneficial...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
