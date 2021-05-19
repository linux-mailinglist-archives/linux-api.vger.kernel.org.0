Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A793E388C6F
	for <lists+linux-api@lfdr.de>; Wed, 19 May 2021 13:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346144AbhESLOC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 19 May 2021 07:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240394AbhESLOC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 19 May 2021 07:14:02 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE62CC06175F
        for <linux-api@vger.kernel.org>; Wed, 19 May 2021 04:12:42 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id 69so6831582plc.5
        for <linux-api@vger.kernel.org>; Wed, 19 May 2021 04:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=kdQAEAu76INNncaho8Bt0bdchs3rDGFoPptw8O5fZ+g=;
        b=tpVWgGTA4m2hNOvhlCU5yRq1j46tosc/esW4axep8ee0UqBruPl/LtBbT0vktDzlb8
         RfAMxKLMvJdbrH0bMfJit6+1ob5zha/3FTdym+4E8DrDm0MdRPtH5ypvMOuSDJqAUOfN
         y6tB9utCHbDDoH253iYXn4t/RJ0Fm+c513E5wrLqxb4bX0OOLABmlbYA1f+3VD+ZQ5BK
         JOQjPL9MVq08k1ysMoed06xeTUbZp9S73KsUN34NhLyeyxI+/Y3DJ7tACVepzNr6r8vX
         c4DsxCR9c5Cqa6+ieRLRT9KT7cI5oMY+/Qf2t30P//dvh8tiAz7WDNYMI0/FrTN7VYBn
         kkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=kdQAEAu76INNncaho8Bt0bdchs3rDGFoPptw8O5fZ+g=;
        b=E4yQ+GuzIb1U+ZiYOZ1AmSYhEEC0sHmB1ZYMpu1qRRRSOtvUsgsO6G35MkCxlMv4gk
         r5aNRi7qEDLxW7o1m/w45XSHHvmf4CoCOElx4RHtFhV/6H/37vI+DH7rzKL3+knXWAJC
         5pQadAsg599k76g9bCLVc7RJvgORkgGJn9bWkWvJqSlObRpB6Mn0QGa0Bfyiwx7GEquF
         yDj70WSLdm+Ibko6oZ4/8Vq50XgCPhc/xRAjb2Ys2vnQSQUOWpb2SP9X9GN6Cuar/7JI
         O1ty8lxdTHPTrJiY7SuSn0QEDovtL/WLdcLPxPpOGeErxDbUfq1JeLoSUrntCYKCZII2
         WQhw==
X-Gm-Message-State: AOAM532PqOK9KXdxYRBvRiZiMRwsRgCWWdQi8ojCCH5vIROq1anN0QuE
        ZPF48fyFXDFFY3rYUyJmeK4=
X-Google-Smtp-Source: ABdhPJw7V3xAbm9WRiDnAy2CSI5boC9catqyT3n26FSZl9aoWuFPkpEQmN7mgJUwOoadbbwf1M7Ojw==
X-Received: by 2002:a17:903:49:b029:f1:75c4:3eb3 with SMTP id l9-20020a1709030049b02900f175c43eb3mr10341165pla.76.1621422762320;
        Wed, 19 May 2021 04:12:42 -0700 (PDT)
Received: from localhost (14-201-155-8.tpgi.com.au. [14.201.155.8])
        by smtp.gmail.com with ESMTPSA id 3sm13956232pff.132.2021.05.19.04.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 04:12:42 -0700 (PDT)
Date:   Wed, 19 May 2021 21:12:36 +1000
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
        <1621413143.oec64jaci5.astroid@bobo.none>
In-Reply-To: <1621413143.oec64jaci5.astroid@bobo.none>
MIME-Version: 1.0
Message-Id: <1621422559.vsmpjhjqzq.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Excerpts from Nicholas Piggin's message of May 19, 2021 6:42 pm:
> Excerpts from Joakim Tjernlund's message of May 19, 2021 6:08 pm:
>> On Wed, 2021-05-19 at 17:55 +1000, Nicholas Piggin wrote:
>>> Excerpts from Joakim Tjernlund's message of May 19, 2021 5:33 pm:
>>> > On Wed, 2021-05-19 at 02:13 +0300, Dmitry V. Levin wrote:
>>> > > Hi,
>>> > >=20
>>> > > On Thu, Jun 11, 2020 at 06:12:01PM +1000, Nicholas Piggin wrote:
>>> > > [...]
>>> > > > - Error handling: The consensus among kernel, glibc, and musl is =
to move to
>>> > > > =C2=A0=C2=A0using negative return values in r3 rather than CR0[SO=
]=3D1 to indicate error,
>>> > > > =C2=A0=C2=A0which matches most other architectures, and is closer=
 to a function call.
>>> >=20
>>> > What about syscalls like times(2) which can return -1 without it bein=
g an error?
>>>=20
>>> They do become errors / indistinguishable and have to be dealt with by=20
>>> libc or userspace. Which does follow what most architectures do (all=20
>>> except ia64, mips, sparc, and powerpc actually).
>>>=20
>>> Interesting question though, it should have been noted.
>>>=20
>>> Thanks,
>>> Nick
>>=20
>> I always figured the ppc way was superior. It begs the question if not t=
he other archs should
>> change instead?
>=20
> It is superior in some ways, not enough to be worth being different.
>=20
> Other archs are unlikely to change because it would be painful for
> not much benefit. New system calls just should be made to not return
> error numbers. If we ever had a big new version of syscall ABI in
> Linux, we can always use another scv vector number for it.

Or... is it possible at syscall entry to peek the address of
the instruction which caused the call and see if that was a
scv instruction? That would be about as reliable as possible
without having that new flag bit.

Thanks,
Nick
