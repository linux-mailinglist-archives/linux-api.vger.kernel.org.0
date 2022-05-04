Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F04A51988E
	for <lists+linux-api@lfdr.de>; Wed,  4 May 2022 09:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239790AbiEDHvL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Wed, 4 May 2022 03:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345705AbiEDHvJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 May 2022 03:51:09 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1485513F09
        for <linux-api@vger.kernel.org>; Wed,  4 May 2022 00:47:33 -0700 (PDT)
Received: from mail-wr1-f47.google.com ([209.85.221.47]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MeCYx-1oMJHU2MkR-00bLF8; Wed, 04 May 2022 09:42:23 +0200
Received: by mail-wr1-f47.google.com with SMTP id v12so792859wrv.10;
        Wed, 04 May 2022 00:42:23 -0700 (PDT)
X-Gm-Message-State: AOAM5339KfyBx4t9zIEWu6GpNvC5Kq4f2HRyC4Tk5CcliBYhcaWTLVq8
        x0oyGzNpmyt9AhDj6g+iTS5yi6pLDUbaqRvUJ1A=
X-Google-Smtp-Source: ABdhPJyAtaHJAu4B6FvTyywy89EOYjaADkD1ii+djh63zQRkEMld6M+vJFv/YubU9ANwgQaTox0QURVrOWQbFXWyNvQ=
X-Received: by 2002:a5d:5986:0:b0:20c:5844:820d with SMTP id
 n6-20020a5d5986000000b0020c5844820dmr13214984wri.192.1651650143027; Wed, 04
 May 2022 00:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <2c8c96f-a12f-aadc-18ac-34c1d371929c@linux.intel.com>
In-Reply-To: <2c8c96f-a12f-aadc-18ac-34c1d371929c@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 4 May 2022 09:42:07 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0hy8Ras7pwF9rJADtCAfeV49K7GWkftJnzqeGiQ6j-zA@mail.gmail.com>
Message-ID: <CAK8P3a0hy8Ras7pwF9rJADtCAfeV49K7GWkftJnzqeGiQ6j-zA@mail.gmail.com>
Subject: Re: [PATCH 1/1] termbits: Convert octal defines to hex
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:RUODNSZHrrUAzTMxf4k7aiybT4dr2MHfFmLT9NAVtR9I9Meah9W
 KgobfqjPp3il3rzPHqzh6Xfw1USWESqATgFbx5a8mQaPbWAKxwaL1ev4IsA9m9kzrG7F61N
 nT7pKhNMsqFdRtqW3WRSZywQCCSrzImcjkfMrTibFt/bx+147KtoPttgQvG0o+52O6rvHC+
 KiyVWJUoSxnhB6h4mCJWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FyXgdIfXI3M=:C46I2MiS0kzySV0HUpid79
 uPUbOo1pkLx0wNf6fRsds5ph9KGy0gyKFS2VDHEe6gTyNOCm04rbwOoth6WtHV8nrR/kdSxp/
 pAGtE40f3PKzTsDHTO+TpouP+MZHw3rh9QW2b1WuO2yJdVy64s5I6/JPc119gOp+5Duq8f7JS
 NIbkEaISCv7u0JAisI15Mf2/Hlo3Ra/qkD818rQmgD67PrgRDe6D6oByBMmfwtlQwOKCSo7YB
 o80MnhIpuAPUWwc2DQ8RGxjXsNtG1CR5imyM17IzYSrLe6O4v1RKd9Wk23DOtVUFMT06cq8nf
 2Rh+wvAvRunOLClhwq+y4mtprRygkgNllG+M9j8wnSUq51gcEF0qCiUFDdZnJ7dHajl0qby2p
 fS2i9M+0Ue7+P1wicSOPlA8MaPgmypSr/ZAr6jWPKl8n9ZQmRVNBObK95Wkl9uvPYPNmKZHMI
 aiqVX4vsfYKbztzCANJD3iRlU7X177JZwetmPwDyNcFXPI/PiyN7lyF8ycS+ye7sryWtF55vh
 BRUHfNzlEO3LurtquJgkXMdrACEJo+uwSdVcxW+emCxhY9oonHUp1x/STtT2DqmCc47sKorio
 UKwdKgiyCB4X2oN6lN0og0DbheuTYKQwRgsiyfscaZ/KObVI9EFuQRPYiOwRUu0GeSZmG6l+8
 PrTJMF05t6pYm5fFAhnF1bxgyorugJbjTfvLpmYCE6iSYtdN14pO5KgFOxFVTzTQZ3VQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, May 4, 2022 at 9:20 AM Ilpo Järvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> Many archs have termbits.h as octal numbers. It makes hard for humans
> to parse the magnitude of large numbers correctly and to compare with
> hex ones of the same define.
>
> Convert octal values to hex.
>
> First step is an automated conversion with:
>
> for i in $(git ls-files | grep 'termbits\.h'); do
>         awk --non-decimal-data '/^#define\s+[A-Z][A-Z0-9]*\s+0[0-9]/ {
>                 l=int(((length($3) - 1) * 3 + 3) / 4);
>                 repl = sprintf("0x%0" l "x", $3);
>                 print gensub(/[^[:blank:]]+/, repl, 3);
>                 next} {print}' $i > $i~;
>         mv $i~ $i;
> done
>
> On top of that, some manual processing on alignment and number of zeros.
> In addition, small tweaks to formatting of a few comments on the same
> lines.
>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Good idea!

I assume you already checked if additional file contents can be shared across
architectures? I think I've tried in the past but didn't really get
anywhere with
that.

After applying the patch locally, I still see a bunch of whitespace
differences in the
changed lines if I run

vimdiff arch/*/include/uapi/asm/termbits.h include/uapi/asm-generic/termbits.h

I think this mostly because you left the sparc version alone (it already
uses hex constants), but it may be nice to edit this a little more to
make the actual differences stick out more.

> I prefer this to go in though Greg's tty tree.

Acked-by: Arnd Bergmann <arnd@arndb.de>
