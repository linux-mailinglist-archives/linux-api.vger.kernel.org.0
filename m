Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63D534F247
	for <lists+linux-api@lfdr.de>; Tue, 30 Mar 2021 22:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhC3UcA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 30 Mar 2021 16:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbhC3Ubr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 30 Mar 2021 16:31:47 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15BE0C061574;
        Tue, 30 Mar 2021 13:31:47 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id A8E7992009C; Tue, 30 Mar 2021 22:31:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id A2CFF92009B;
        Tue, 30 Mar 2021 22:31:45 +0200 (CEST)
Date:   Tue, 30 Mar 2021 22:31:45 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Palmer Dabbelt <palmer@dabbelt.com>
cc:     alex@ghiti.fr, Paul Walmsley <paul.walmsley@sifive.com>,
        dvyukov@google.com, linux-api@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Bump COMMAND_LINE_SIZE value to 1024
In-Reply-To: <mhng-885e3a79-49cf-42fc-8561-a52c7b7e1ac6@palmerdabbelt-glaptop>
Message-ID: <alpine.DEB.2.21.2103302221590.18977@angie.orcam.me.uk>
References: <mhng-885e3a79-49cf-42fc-8561-a52c7b7e1ac6@palmerdabbelt-glaptop>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 29 Mar 2021, Palmer Dabbelt wrote:

> > --- /dev/null
> > +++ b/arch/riscv/include/uapi/asm/setup.h
> > @@ -0,0 +1,8 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> > +
> > +#ifndef _UAPI_ASM_RISCV_SETUP_H
> > +#define _UAPI_ASM_RISCV_SETUP_H
> > +
> > +#define COMMAND_LINE_SIZE	1024
> > +
> > +#endif /* _UAPI_ASM_RISCV_SETUP_H */
> 
> I put this on fixes, but it seemes like this should really be a Kconfig
> enttry.  Either way, ours was quite a bit smaller than most architectures and
> it's great that syzbot has started to find bugs, so I'd rather get this in
> sooner.

 This macro is exported as a part of the user API so it must not depend on 
Kconfig.  Also changing it (rather than say adding COMMAND_LINE_SIZE_V2 or 
switching to an entirely new data object that has its dimension set in a 
different way) requires careful evaluation as external binaries have and 
will have the value it expands to compiled in, so it's a part of the ABI 
too.

  Maciej
