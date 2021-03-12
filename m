Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180E933844D
	for <lists+linux-api@lfdr.de>; Fri, 12 Mar 2021 04:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhCLDS1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 11 Mar 2021 22:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbhCLDSH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 11 Mar 2021 22:18:07 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C34C061574;
        Thu, 11 Mar 2021 19:18:07 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id f12so2830661qtq.4;
        Thu, 11 Mar 2021 19:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=6s7aZDqIh5c7QwDOhan9TstA2/Xr1K2QMo7FCDdlyBo=;
        b=T4OQFB66k30ubxSV9gRAG0sZGTambgWeuupbvEr22jNOK7+vK13ZnJzFS338VUwl0g
         JXdWe+1L9IdmWhMSBCzKF5V114ma5sIszr/weI1wT6nmOwDlkYuc+hMD+vw2zGTISm91
         lscDoakYPZJVOVVZdNzQzUaRjBP6lUjLgiPla8k7blFhU1exhOBfn5TRSDrvyzZnVjid
         TNIrPy9RIGI0ASk1rFeMOM8J1Tg0BMVNyZQxvFU11mBGVx6jbw9NH+h4GRHD9Tw0BP/v
         V2Hp4gjijvgcsftsYupz1Drf7gpqHyQAe/lL8e3PX+T6CYnafbTGbMcbmMpyhMM9t/Zp
         X6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=6s7aZDqIh5c7QwDOhan9TstA2/Xr1K2QMo7FCDdlyBo=;
        b=Y+66Y16Olf+R7VDAorcK36bej73y2k+gqg8MQ1dAMV/R6peySKbVCtEZIsrxaQA0+5
         BokcNYQYTznpiK2h79l219ZWCySfShC0ppJoyNlTu8ERM+FUiWeqpzNjNaxRNjzF/jIt
         b0u/A1KNtRfUC31xToKymSKEVkVp0M1s8Yku062N3IwD03UjToQANQ6kiRh4LF/AeyWf
         HoYkVG4sWNlXTz+MOxGyBtzyiPW8a/BQ6LK1L/eOkmcUi9YIuu1m0lHbDwz88WCttXJr
         Imw/6P4rgTD3Q2m5GA0DFSCJKvoOWE/vaRwwGVF34Qpw9I2iNSGGiVykR1bCtm4UYusa
         L4bA==
X-Gm-Message-State: AOAM533t0s/s0JzUwJCfjHUg6wFs7i0EZr/dLiQ9P9ZEzaq4EqjhQ6tt
        RENZ3E9mG162KfqcbuqEOlhHxMYea5g2VyT4
X-Google-Smtp-Source: ABdhPJzRY92UlNkLxUZSslSacXp9ZxxY+woT8JqRC+Bpt6L8dZuV8xz7IXOkkAx5vIAcLDqtBaCpDA==
X-Received: by 2002:ac8:b49:: with SMTP id m9mr10303587qti.182.1615519086608;
        Thu, 11 Mar 2021 19:18:06 -0800 (PST)
Received: from Gentoo ([143.244.44.200])
        by smtp.gmail.com with ESMTPSA id 85sm3696440qkf.58.2021.03.11.19.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 19:18:05 -0800 (PST)
Date:   Fri, 12 Mar 2021 08:47:58 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org
Subject: Re: Why is the bit size different between a syscall and its wrapper?
Message-ID: <YErdZh4QCaRiSV1l@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org
References: <CAK7LNAQYMKqixm8dVbbMvgt+=MEROSg-JG_kHS8T+xmrgeLABg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Tq7vG0cIx+jTMAax"
Content-Disposition: inline
In-Reply-To: <CAK7LNAQYMKqixm8dVbbMvgt+=MEROSg-JG_kHS8T+xmrgeLABg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--Tq7vG0cIx+jTMAax
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 11:48 Fri 12 Mar 2021, Masahiro Yamada wrote:
>Hi.
>
>I think I am missing something, but
>is there any particular reason to
>use a different bit size between
>a syscall and its userspace wrapper?
>
>
>
>For example, for the unshare syscall,
>
>unshare(2) says the parameter is int.
>
>
>SYNOPSIS
>       #define _GNU_SOURCE
>       #include <sched.h>
>
>       int unshare(int flags);
>
>
>
>
>In the kernel, it is unsigned long.
>
>
>SYSCALL_DEFINE1(unshare, unsigned long, unshare_flags)
>{
>        return ksys_unshare(unshare_flags);
>}
>
>
>
>
>I guess the upper 32-bit will be
>zeroed out in the c library when
>sizeof(int) != sizeof(unsigned long)
>(i.e. 64-bit system), but I'd like to know
>why we do it this way.
>
>
Small nit! never mind ...but eye catching, Masahiro :) ...are you typing this
on narrowed device, which allow only this much line length?? It's bloody
narrow...don't you think so?

Sorry, for the deviation.

~Bhaskar
>--
>Best Regards
>Masahiro Yamada

--Tq7vG0cIx+jTMAax
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBK3WMACgkQsjqdtxFL
KRU3nwf/ZL/k1UIFts05kpo+C0zQCoovf4iCPT+Xdx43C6W4t8uk+cYNudnTcs9c
Cfd5MmuZ9smrdglDnx7tFBZ4vuB5jZoze4g3zrz3qcFCJu9IZj3Y0V+ACJ1QpK9l
4qZoRLUoP2LhLxbCQtUuxPy4XTq85VhhDJhqVG3ArizebKjmjOHHWsp8hnrogSOq
mwjdypgrolCMEs45umeA/gPVNchoY4a4k05A/Publz0s++KZtDRGc4SEGYP20HJq
+eLeNg7t1a9uujIKkbf+ESoFIeJgJu15KxBmAmWF8oclpKo7wxvLprgabkq5s3J9
sJEnPseSffefo9qgr3yxIATPzw3etg==
=tJ53
-----END PGP SIGNATURE-----

--Tq7vG0cIx+jTMAax--
