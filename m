Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74ADA389B7E
	for <lists+linux-api@lfdr.de>; Thu, 20 May 2021 04:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhETCrX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 19 May 2021 22:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhETCrX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 19 May 2021 22:47:23 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C56C061574
        for <linux-api@vger.kernel.org>; Wed, 19 May 2021 19:46:03 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id f22so9874112pgb.9
        for <linux-api@vger.kernel.org>; Wed, 19 May 2021 19:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=8M1OxdiUM2X6HRQVrD30T5IbKemIPC0lXDlSqpSaszE=;
        b=RBRzO79+q6UeCkV6IpxJraBj4XsWeQB+5AYG6+p65y3z77c6RpLcQylNbCDGFIHVv7
         Ae1gcNnPs4mfAWINBeWY86Rc0HF+Bp1/UdafRrPGmOIc4kSaZlwgiigXoqRoTdkkif9t
         gvMHZV64lDeY7rFSOgF752N2bZHVKJDdzjcvJglfmeejKJY1g+lFS32sufup4VL5ZgXy
         BM5lwphhnr6nC3TZ+PlWUQPuFzF6E/ZnfDqZzFJQI6CPvMWwilX/ll2Orb9hjj1dVy/n
         MFdYLsDJIDTjR7kBwB/FZSaCHw/TMeRLUk235GZCEspc3tm6qGvLbpTlafr3jPM7lVe+
         CzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=8M1OxdiUM2X6HRQVrD30T5IbKemIPC0lXDlSqpSaszE=;
        b=RRH9ilHdxuW5INvMucF1as8zPx6VshIkTWs5odQeiYrb/AYwmR7sP5uI0WmkEcV83M
         0cih46S2MCCSL4PJ81ziG9p6HlcSARLoIKGO3jHB84pSJAIS+PK38Q5wGdn/5ucvTvsZ
         5fvSyEyu7kNLhJhTuNCWhEHgbJ55mM1XBEzpEibKMLYH0cs4+mxiBMfaf9rlbLhaJmdE
         THVrh5uHRmpHtSYIfu61konvOK4DDFYZLNT37HRucOqVvfEIu+8lem7lvodqWt7iAWTX
         kx2nkLMpaQAWWQZu++bFzxyzVcmHduM3S0fplTyDG3ETW5QVbzA4lIUcrFG4QRpvlr4R
         zNMg==
X-Gm-Message-State: AOAM533QtlW8N0I60M46oJme6JzjKCYnz7nLQHWFdI4oKRJorZSqTPBt
        sB3NwFhWdl75bIE6nXOPK3c=
X-Google-Smtp-Source: ABdhPJxPRLYd9U7WwUvIqQ1f2wFxuqNJ9T/QrAgVoan54fa7ROHdL889+khZG/PVxHA1U+QPzuVNXg==
X-Received: by 2002:a05:6a00:26d4:b029:2df:87f2:fcc4 with SMTP id p20-20020a056a0026d4b02902df87f2fcc4mr2233646pfw.20.1621478762558;
        Wed, 19 May 2021 19:46:02 -0700 (PDT)
Received: from localhost (60-241-27-127.tpgi.com.au. [60.241.27.127])
        by smtp.gmail.com with ESMTPSA id bb18sm5276575pjb.44.2021.05.19.19.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 19:46:02 -0700 (PDT)
Date:   Thu, 20 May 2021 12:45:57 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: Linux powerpc new system call instruction and ABI
To:     Rich Felker <dalias@libc.org>, "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        linux-api@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>, musl@lists.openwall.com,
        Segher Boessenkool <segher@kernel.crashing.org>
References: <20210518231331.GA8464@altlinux.org>
        <9b5ea7059c5a5d4e9ccccd7d73ce2c66b2203f52.camel@infinera.com>
        <1621410291.c7si38sa9q.astroid@bobo.none>
        <fb9b6a6099855bd00efc6ffe540ccad14dd9a365.camel@infinera.com>
        <1621413143.oec64jaci5.astroid@bobo.none>
        <20210519143836.GJ10366@gate.crashing.org>
        <11d62aa2488e51ec00fe77f24a1d7cdcc21af0b8.camel@infinera.com>
        <20210519152205.GL10366@gate.crashing.org>
        <adec4377144a44b6f9ddd10c1b5256b80c9ceb50.camel@infinera.com>
        <20210519234846.GS2546@brightrain.aerifal.cx>
        <20210520010612.GA25599@altlinux.org>
In-Reply-To: <20210520010612.GA25599@altlinux.org>
MIME-Version: 1.0
Message-Id: <1621478448.743zqcrxza.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Excerpts from Dmitry V. Levin's message of May 20, 2021 11:06 am:
> On Wed, May 19, 2021 at 07:48:47PM -0400, Rich Felker wrote:
>> On Wed, May 19, 2021 at 06:09:25PM +0000, Joakim Tjernlund wrote:
> [...]
>> > W.r.t breaking ABI, isn't that what PowerPC is trying to do with the n=
ew syscall I/F?=20
>>=20
>> No, it's a new independent interface.
>=20
> Unfortunately, being a new independent interface doesn't mean it isn't
> an ABI break.  In fact, it was a severe ABI break, and this thread is
> an attempt to find a hotfix.

It is an ABI break, that was known. The ptrace info stuff I fixed with=20
the patch earlier was obviously a bug in my initial implementation and=20
not intended (sorry my ptrace testing was not sufficient, and thanks for
reporting it, by the way).

But the register ABI was always a known break. The issue is that rfscv
clobbers LR, so it can not support the old ABI. If the old ABI did not=20
preserve LR, then we may have chosen to not change register ABI at all.

Thanks,
Nick
