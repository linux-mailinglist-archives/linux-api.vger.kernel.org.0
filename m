Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32CB38899D
	for <lists+linux-api@lfdr.de>; Wed, 19 May 2021 10:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343527AbhESIoG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 19 May 2021 04:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245707AbhESIoF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 19 May 2021 04:44:05 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AE8C06175F
        for <linux-api@vger.kernel.org>; Wed, 19 May 2021 01:42:46 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ne24-20020a17090b3758b029015f2dafecb0so1884767pjb.4
        for <linux-api@vger.kernel.org>; Wed, 19 May 2021 01:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=65fGzdiHYqhXvVbJhIHcIGq1TKdRRhD4v1EI2Qzj/O4=;
        b=bMvtBjabQN3eFsv0N5aOWD4yHdxmHSz2tAvyzebsOfh42lhs0YRzuE9fo2BurrzTy6
         yE5sELMIWjVjxjQQs2IJMy0NtS5JIGMhRdD2QH5zMLH9zFLizEk0zYOVUGxPh64DK/EW
         GAXkCixB0SU3IT3ZoAewXekanzhYWrppbBoDexfyImyL5OqufZhfib3Vz01Wahn3qhBg
         Qv0q0ciR0zlzUorAXTYP2NxVaO/pA5CMWffAMXfu+EIXuQNBI3sGyaLBDPQ/NH5fieVv
         SN0u/0X540RAlmL4nbnFbrD27mY2+Tw/CJhoM1yNFp2y99/0EzrGO3cyUOCea1rlvXZU
         E8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=65fGzdiHYqhXvVbJhIHcIGq1TKdRRhD4v1EI2Qzj/O4=;
        b=CS5VD/pOoT8bmGZvKG/AkOeehPTqeC0XSVwPYQZ1gSdpqgvUnC+2hdRAuxAQPGzP6h
         agRNX3Rfh1J6IanKkfeeQVJeSyv/Rm11qfT5bjKsPPOTV208ldWsbHslbd66y0YXdYjq
         nCqXkZAeG6Mz3FMK/rtDQ32y5l7fHNekuhT5Fsa7eXNKOunT19Lr8mX4U4kKaS+23PQe
         uc+zYuZBD67nxzGNs0mCj+H4DZ/+vn7Bscet3F+RJg13yjfMWVgzImlx6HOL7TVXGRjh
         07IOCSyauRRw9UiZwBIgrDtwj8hFQukVfE74wJim/Vr/uYv/pxG1LRPBh2Pw7/WFPYMx
         keYQ==
X-Gm-Message-State: AOAM531lmzNEtMkVUoX+TP9K9DyNuzlW+ezI/iQmkRixlA32h1N0d/ie
        WVAXLaGxHFb0oMely8kERNA=
X-Google-Smtp-Source: ABdhPJyzdFSda9iEveEfmRNG4skSZvA4vZ1nhegSlYSuhYx5bmD0VkIKrMZjt/hRsVyA5O6u7V3nmA==
X-Received: by 2002:a17:902:8d83:b029:ef:9dd8:4d9 with SMTP id v3-20020a1709028d83b02900ef9dd804d9mr9794872plo.40.1621413766014;
        Wed, 19 May 2021 01:42:46 -0700 (PDT)
Received: from localhost (14-201-155-8.tpgi.com.au. [14.201.155.8])
        by smtp.gmail.com with ESMTPSA id z24sm7310002pfk.150.2021.05.19.01.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 01:42:45 -0700 (PDT)
Date:   Wed, 19 May 2021 18:42:40 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: Linux powerpc new system call instruction and ABI
To:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        "ldv@altlinux.org" <ldv@altlinux.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>
Cc:     "libc-dev@lists.llvm.org" <libc-dev@lists.llvm.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "musl@lists.openwall.com" <musl@lists.openwall.com>
References: <20200611081203.995112-1-npiggin@gmail.com>
        <20210518231331.GA8464@altlinux.org>
        <9b5ea7059c5a5d4e9ccccd7d73ce2c66b2203f52.camel@infinera.com>
        <1621410291.c7si38sa9q.astroid@bobo.none>
        <fb9b6a6099855bd00efc6ffe540ccad14dd9a365.camel@infinera.com>
In-Reply-To: <fb9b6a6099855bd00efc6ffe540ccad14dd9a365.camel@infinera.com>
MIME-Version: 1.0
Message-Id: <1621413143.oec64jaci5.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Excerpts from Joakim Tjernlund's message of May 19, 2021 6:08 pm:
> On Wed, 2021-05-19 at 17:55 +1000, Nicholas Piggin wrote:
>> Excerpts from Joakim Tjernlund's message of May 19, 2021 5:33 pm:
>> > On Wed, 2021-05-19 at 02:13 +0300, Dmitry V. Levin wrote:
>> > > Hi,
>> > >=20
>> > > On Thu, Jun 11, 2020 at 06:12:01PM +1000, Nicholas Piggin wrote:
>> > > [...]
>> > > > - Error handling: The consensus among kernel, glibc, and musl is t=
o move to
>> > > > =C2=A0=C2=A0using negative return values in r3 rather than CR0[SO]=
=3D1 to indicate error,
>> > > > =C2=A0=C2=A0which matches most other architectures, and is closer =
to a function call.
>> >=20
>> > What about syscalls like times(2) which can return -1 without it being=
 an error?
>>=20
>> They do become errors / indistinguishable and have to be dealt with by=20
>> libc or userspace. Which does follow what most architectures do (all=20
>> except ia64, mips, sparc, and powerpc actually).
>>=20
>> Interesting question though, it should have been noted.
>>=20
>> Thanks,
>> Nick
>=20
> I always figured the ppc way was superior. It begs the question if not th=
e other archs should
> change instead?

It is superior in some ways, not enough to be worth being different.

Other archs are unlikely to change because it would be painful for
not much benefit. New system calls just should be made to not return
error numbers. If we ever had a big new version of syscall ABI in
Linux, we can always use another scv vector number for it.

Thanks,
Nick
