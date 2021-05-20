Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9EF389CF5
	for <lists+linux-api@lfdr.de>; Thu, 20 May 2021 07:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhETFNd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 May 2021 01:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhETFNc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 May 2021 01:13:32 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6673C061574
        for <linux-api@vger.kernel.org>; Wed, 19 May 2021 22:12:09 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id n6-20020a17090ac686b029015d2f7aeea8so4795447pjt.1
        for <linux-api@vger.kernel.org>; Wed, 19 May 2021 22:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=06KbBafvZa4BBa7qjQ5t4Am1mOBvJg6DGbGd+FkhvIo=;
        b=SjwGtmcDH9Dh2Wa3o93Ep2jhjm/8TTVH3xfAVFiHA6HLIlQGDOiUOYPoR9swNmwwWw
         g6Du+E+WtmyC+XMX2QeNWcok8I0Bg+de1cR2bGbKemu5W8oMaa01xnJbtDg1MXQWnZ3v
         2aQzsPgctouIxwwx4Dz90xjR/6o+keoZUfdpSP35DZm2/5t1wcfHxHJ31xXPZ3bBwvef
         1fcmkU7ze/3AdnYCLrFQ+whOzHJaugQ5uJjFmc6t+57ikS88hbUFd1I3LlUZpOPYIDEb
         7zJ9OobpoMMi+DZtlZ1Ba5AHdAike7i8YwmeaDk1Y1Vd8KxARwPJbeMHcLSItvDyqRBX
         ptjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=06KbBafvZa4BBa7qjQ5t4Am1mOBvJg6DGbGd+FkhvIo=;
        b=rzr5q6+Yy2vjs9pG3XyyVqoOsDCmzmCWgQUv0or31aU/7cuTKcEJX5WI4mQErLIh9h
         0LcZdwO/lZIEE7Ta5720gLgkuEiS+CKSnP4sjA2unJCNOofM4qGeun2UC0ipUz2FaTeE
         /7OppaaB4jh8+3GH1UmISlR8yejmeQxBVQ0q/8tMyYx+CuAngPKpka2kQsprGJxDfY7e
         pDxO33RKvGNxDyy7vCSw9x1xmPjhEc88FYjHRfoIITp41t8WnAmgv1G8GnyKdoGg4m5B
         793CXbKGYrb4AXXegY36gk+8mMGAm27PDiB3bqP1lGCwNG2R2iMB5Pa48+FzfpjCfuP/
         6+/Q==
X-Gm-Message-State: AOAM531dwXWrvIXnTa2byevy1r4i8CFpL63RrHy5LDC/lxDyoHs+iA0W
        1NZvnvUdQ4EcVHbJancUraw=
X-Google-Smtp-Source: ABdhPJwolGPVF5FlLMl8HVNpTzFe2D2mSODdHbw80a4ZQL7Y9ldFq6/WktutOjh5f6y7+7kfokjoaA==
X-Received: by 2002:a17:902:db0f:b029:f3:e5f4:87f1 with SMTP id m15-20020a170902db0fb02900f3e5f487f1mr3699593plx.26.1621487529004;
        Wed, 19 May 2021 22:12:09 -0700 (PDT)
Received: from localhost (60-241-27-127.tpgi.com.au. [60.241.27.127])
        by smtp.gmail.com with ESMTPSA id y14sm845730pgl.21.2021.05.19.22.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 22:12:08 -0700 (PDT)
Date:   Thu, 20 May 2021 15:12:03 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: Linux powerpc new system call instruction and ABI
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        libc-alpha@sourceware.org, libc-dev@lists.llvm.org,
        linux-api@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Matheus Castanho <msc@linux.ibm.com>, musl@lists.openwall.com
References: <20210519132656.GA17204@altlinux.org>
        <1621464056.o9t21cquw8.astroid@bobo.none>
        <20210519232726.GA24134@altlinux.org>
        <1621478238.xha1ow4ujh.astroid@bobo.none>
        <20210520030611.GB27081@altlinux.org>
In-Reply-To: <20210520030611.GB27081@altlinux.org>
MIME-Version: 1.0
Message-Id: <1621487263.hkgxyf500s.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Excerpts from Dmitry V. Levin's message of May 20, 2021 1:06 pm:
> On Thu, May 20, 2021 at 12:40:36PM +1000, Nicholas Piggin wrote:
> [...]
>> > Looks like struct pt_regs.trap already contains the information that c=
ould
>> > be used to tell 'sc' from 'scv': if (pt_regs.trap & ~0xf) =3D=3D 0x300=
0, then
>> > it's scv.  Is my reading of arch/powerpc/include/asm/ptrace.h correct?
>>=20
>> Hmm, I think it is. Certainly in the kernel regs struct it is, I had in=20
>> my mind that we put it to 0xc00 when populating the user struct for
>> compatibility, but it seems not. So I guess this would work.
>=20
> OK, can we state that (pt_regs.trap & ~0xf) =3D=3D 0x3000 is a part of th=
e scv
> ABI, so it's not going to change and could be relied upon by userspace?
> Could this be documented in Documentation/powerpc/syscall64-abi.rst,
> please?

Yeah I think we can do that. The kernel doesn't care what is put in the
userspace pt_regs.trap too much so if this is your preferred approach
then I will document it in the ABI.

Thanks,
Nick
