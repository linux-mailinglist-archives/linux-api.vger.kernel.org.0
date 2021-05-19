Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3A8388C36
	for <lists+linux-api@lfdr.de>; Wed, 19 May 2021 12:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239905AbhESLAc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 19 May 2021 07:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhESLAb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 19 May 2021 07:00:31 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C1DC06175F
        for <linux-api@vger.kernel.org>; Wed, 19 May 2021 03:59:11 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id c17so9623908pfn.6
        for <linux-api@vger.kernel.org>; Wed, 19 May 2021 03:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=qSDquWF5C/3kPSaisv5VvJ1hs65zlvqZ/KYndLXZBHA=;
        b=UTkT1J4sM7q+60Slm44Nc34SGgZppdCky+kG+U0w6IHxdZqOozXUhBnDf634kQsZE9
         stagF2SzjdN6bP1a0sdhTYCyvFmhZrzLDUdTBz6Ddm+lpmnVBanrYxO/3KZwENLBPCc1
         yO0Ys0hlwSwIMmwDKupVUe87eTPQe1IF+BPKUZJtKIHJpb2jOWtZCIUSV1ayH6RU5AZI
         B/+OTymu/jC771VJ7deDGbNi77c3hegXjZU1FXeAX4OtGBfRjrkYTY2GuHXyXi+E2K3i
         +uuYCpchPxOn+EaiU6hyDpwdgBymfQopity5cUs4T3KiB8J5sFPP5jKiqgtOh1JZLgtX
         g1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=qSDquWF5C/3kPSaisv5VvJ1hs65zlvqZ/KYndLXZBHA=;
        b=uOdbKbVehcD7f/k9rHThKssrhsQ0M6Xx5/WmzLToSytwVwzeBxgdyfnrjaGswtug/J
         9B+pxAZ5d2piGrUPmvfRt4brGvZPHqyfqj8b37PZbuu1v7a7K2CCyIRvQLrYsYKgfSKl
         +WckomLz+tlCBB0+/Z4F5udbpbEjCzkmhTD0s5e3eJ8OS7Akroq2uiSqpbplT8sta5fF
         GmuZN63a4+nTBRCsC/BM7GWKJyYcuvQeZ3PGteQ5oU7qH9xKBNNqJcEEgBYnzvbbxZwI
         YvRsE0TxR8uO1+LyePpUS8jBV1BCKNk/A0mPQAU5uupj1El9qWECRS2wbtnHutkiR7U9
         9rBw==
X-Gm-Message-State: AOAM531mHv+7pC8NV3Qr8mIyJsmIpQoqoTGfcbMTTNqjYmxiHK58yq6r
        IN+N0Xn70/qHgdd6OaxRuikBRZh7I0Y=
X-Google-Smtp-Source: ABdhPJzasKvvWtp1iiKJ1oNvcHYkSjfgkycSA7T5giWeXtEipqymW1BGFzU8Y2yuUSLENyMzmOaqLg==
X-Received: by 2002:aa7:8a56:0:b029:27d:957f:5993 with SMTP id n22-20020aa78a560000b029027d957f5993mr9862449pfa.27.1621421950920;
        Wed, 19 May 2021 03:59:10 -0700 (PDT)
Received: from localhost (14-201-155-8.tpgi.com.au. [14.201.155.8])
        by smtp.gmail.com with ESMTPSA id o3sm15095254pgh.22.2021.05.19.03.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 03:59:10 -0700 (PDT)
Date:   Wed, 19 May 2021 20:59:05 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: Linux powerpc new system call instruction and ABI
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     libc-alpha@sourceware.org, libc-dev@lists.llvm.org,
        linux-api@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Matheus Castanho <msc@linux.ibm.com>, musl@lists.openwall.com
References: <20200611081203.995112-1-npiggin@gmail.com>
        <20210518231331.GA8464@altlinux.org>
        <1621385544.nttlk5qugb.astroid@bobo.none>
        <20210519102403.GA15207@altlinux.org>
In-Reply-To: <20210519102403.GA15207@altlinux.org>
MIME-Version: 1.0
Message-Id: <1621421721.r9fefebis8.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Excerpts from Dmitry V. Levin's message of May 19, 2021 8:24 pm:
> On Wed, May 19, 2021 at 12:50:24PM +1000, Nicholas Piggin wrote:
> [...]
>> With this patch, I think the ptrace ABI should mostly be fixed. I think=20
>> a problem remains with applications that look at system call return=20
>> registers directly and have powerpc specific error cases. Those probably
>> will just need to be updated unfortunately. Michael thought it might be
>> possible to return an indication via ptrace somehow that the syscall is
>> using a new ABI, so such apps can be updated to test for it. I don't=20
>> know how that would be done.
>=20
> Is there any sane way for these applications to handle the scv case?
> How can they tell that the scv semantics is being used for the given
> syscall invocation?  Can this information be obtained e.g. from struct
> pt_regs?

Not that I know of. Michael suggested there might be a way to add=20
something. ptrace_syscall_info has some pad bytes, could
we use one for flags bits and set a bit for "new system call ABI"?

As a more hacky thing you could make a syscall with -1 and see how
the error looks, and then assume all syscalls will be the same.

Thanks,
Nick

>=20
> For example, in strace we have the following powerpc-specific code used
> for syscall tampering:
>=20
> $ cat src/linux/powerpc/set_error.c
> /*
>  * Copyright (c) 2016-2021 The strace developers.
>  * All rights reserved.
>  *
>  * SPDX-License-Identifier: LGPL-2.1-or-later
>  */
>=20
> static int
> arch_set_r3_ccr(struct tcb *tcp, const unsigned long r3,
> 		const unsigned long ccr_set, const unsigned long ccr_clear)
> {
> 	if (ptrace_syscall_info_is_valid() &&
> 	    upeek(tcp, sizeof(long) * PT_CCR, &ppc_regs.ccr))
>                 return -1;
> 	const unsigned long old_ccr =3D ppc_regs.ccr;
> 	ppc_regs.gpr[3] =3D r3;
> 	ppc_regs.ccr |=3D ccr_set;
> 	ppc_regs.ccr &=3D ~ccr_clear;
> 	if (ppc_regs.ccr !=3D old_ccr &&
> 	    upoke(tcp, sizeof(long) * PT_CCR, ppc_regs.ccr))
> 		return -1;
> 	return upoke(tcp, sizeof(long) * (PT_R0 + 3), ppc_regs.gpr[3]);
> }
>=20
> static int
> arch_set_error(struct tcb *tcp)
> {
> 	return arch_set_r3_ccr(tcp, tcp->u_error, 0x10000000, 0);
> }
>=20
> static int
> arch_set_success(struct tcb *tcp)
> {
> 	return arch_set_r3_ccr(tcp, tcp->u_rval, 0, 0x10000000);
> }
>=20
>=20
> --=20
> ldv
>=20
