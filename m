Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D326376C3
	for <lists+linux-api@lfdr.de>; Thu, 24 Nov 2022 11:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiKXKrk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 24 Nov 2022 05:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiKXKrj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 24 Nov 2022 05:47:39 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E0917A87
        for <linux-api@vger.kernel.org>; Thu, 24 Nov 2022 02:47:36 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id g12so1855027wrs.10
        for <linux-api@vger.kernel.org>; Thu, 24 Nov 2022 02:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FdtUZWyW9M5SwW4fKcdbfWbLqv835trkT/YigXlBk1w=;
        b=lZRuJhU0PWoWBofvLovP0IppWpFGWN7fWZxhDO9ezc4w5caGcqd7GVbP7bCb7rAx1m
         WQ6CU4A1vpmhvvRv/MQ41imUpzdHYbhwg3dDp0rbi28alBmmwHbyXBwRq3aChs75OSDn
         cRrBdPyiuU7dJYFQtVWFi1LEgVC4mSS2oQjdxundznfY1LJUvxRqILH4ZmHrlPOswPBO
         jEcYKziqFvY3FrZ63yxBO4J0U840aXaQmAc4K6YO6KlrTgIyIecW0EnswrSdUB+3/Jmh
         cj61cpVBa/01MKcxUSm/M8X+zKHd0MycDwttn5w4VYm2g67Pq84aKg+vXL7bGEl/EnSK
         OJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdtUZWyW9M5SwW4fKcdbfWbLqv835trkT/YigXlBk1w=;
        b=4h8ELV1be2obgJ4VeGJpN2v3r5Yz+YYQh1r+N/WlKogF3VXZRlvCW0NfFtoNiOaJ09
         feRlk+XPXXN674x/P+EBIZhtgfhqneowRE9Tq9+b5BPKj5BQi90CUukIoVYyd3gKl5Os
         VrY3yjdj9L+/gLgDS9R6FS9xIb3JTHzi/v9HGH9kQKtFsermdp2GRlNebUqv93bY6Ww3
         SMcW1P9CAbUIyBimNvT6jE9MLmDspKoIndOHgphu08rGLK4g9d7SXLsn7JPpZbqSBdc6
         WYsjw2WyxnEjULCZaj5GzNy1z6Tndo9qdblY0Uorl1tsXM2iOMDomq028duWKob3IY47
         wCHg==
X-Gm-Message-State: ANoB5pmnkwSSLtH0drgiycVIu4vl8gG4VWH5/1+vvtySF0o55hxbQPsj
        t2imjhsUhk86LsylUgwW1Vr7lg==
X-Google-Smtp-Source: AA0mqf7Y1aVWMReyOdtNOIWeuH3AL6Av2lChTeX2TQ4ZCkY3jMlcei8W4RANI/Yp76L7gWGL7TGKGQ==
X-Received: by 2002:adf:ebc6:0:b0:241:c6d8:be83 with SMTP id v6-20020adfebc6000000b00241c6d8be83mr12040852wrn.454.1669286855389;
        Thu, 24 Nov 2022 02:47:35 -0800 (PST)
Received: from vermeer ([145.224.92.100])
        by smtp.gmail.com with ESMTPSA id l35-20020a05600c1d2300b003cf878c4468sm5765534wms.5.2022.11.24.02.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 02:47:34 -0800 (PST)
Date:   Thu, 24 Nov 2022 11:47:30 +0100
From:   Samuel Ortiz <sameo@rivosinc.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     "Hongren (Zenithal) Zheng" <i@zenithal.me>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org, Jiatai He <jiatai2021@iscas.ac.cn>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v3 2/3] RISC-V: uapi: add HWCAP for Bitmanip/Scalar Crypto
Message-ID: <Y39Lwp4rQc3Qkl0i@vermeer>
References: <YqYz+xDsXr/tNaNu@Sun>
 <YqY0i22SdbHjB/MX@Sun>
 <Y385rS/5zDaDJ3Os@vermeer>
 <Y39AXYPFzSiBngwI@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y39AXYPFzSiBngwI@wendy>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Nov 24, 2022 at 09:58:53AM +0000, Conor Dooley wrote:
> On Thu, Nov 24, 2022 at 10:30:21AM +0100, Samuel Ortiz wrote:
> > On Mon, Jun 13, 2022 at 02:46:35AM +0800, Hongren (Zenithal) Zheng wrote:
> > > diff --git a/arch/riscv/include/uapi/asm/hwcap.h b/arch/riscv/include/uapi/asm/hwcap.h
> > > index 46dc3f5ee99f..bfed3e5c338c 100644
> > > --- a/arch/riscv/include/uapi/asm/hwcap.h
> > > +++ b/arch/riscv/include/uapi/asm/hwcap.h
> > > @@ -22,4 +22,26 @@
> > >  #define COMPAT_HWCAP_ISA_D	(1 << ('D' - 'A'))
> > >  #define COMPAT_HWCAP_ISA_C	(1 << ('C' - 'A'))
> > >  
> > > +/*
> > > + * HWCAP2 flags - for elf_hwcap2 (in kernel) and AT_HWCAP2
> > > + *
> > > + * As only 32 bits of elf_hwcap (in kernel) could be used
> > > + * and RISC-V has reserved 26 bits of it, other caps like
> > > + * bitmanip and crypto can not be placed in AT_HWCAP
> > > + */
> > 
> > Have we agreed that multi-letter ISA extensions would use hwcap to be
> > exposed to userspace? With so many potential extensions, we could
> > quickly run out of space on AT_HWCAP2 as well.
> 
> Palmer whipped up a PoC hwprobe interface (during Plumbers I think) that
> Heiko is currently looking into - I think his motivation is misaligned
> access performance. There's a branch but I have no idea if it even
> compiles... I'm mostly waiting for whatever Heiko comes up with ;)
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/log/?h=riscv-hwprobe-v1
> 
> This patchset seems to need a rebase anyway per your other reply, but I
> guess that the new proposed interface would be preferable?
I think so, yes.
Patch #1 is definitely needed regardless of which interface we pick for
exposing the ISA strings to userspace.

Cheers,
Samuel.
